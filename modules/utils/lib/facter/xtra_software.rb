# frozen_string_literal: true

 

REGISTRY = ['Software\Microsoft\Windows\CurrentVersion\Uninstall',

      'Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'].freeze

 

# Inspired from the following blog post & example https://tenfoursquid.com/getting-a-list-of-installed-software-in-windows-with-puppet/

Facter.add('installed_packages') do

 confine kernel: 'windows'

 setcode do

  require 'win32/registry'

 

  # Generate empty array to store hashes

  installed_packages = {}

 

  # Check if reg path exist, return true / false

  def key_exists?(path, _scope)

   Win32::Registry.scope.open(path, ::Win32::Registry::KEY_READ)

   true

  rescue StandardError

   false

  end

 

  REGISTRY.each_entry do |registry|

   # Loop through all uninstall keys

   Win32::Registry::HKEY_LOCAL_MACHINE.open(registry) do |reg|

    reg.each_key do |key|

     k = reg.open(key)

     displayname = begin

      k['DisplayName'].gsub(%r{[^[:print:]]}, '')

     rescue StandardError

      nil

     end

     version = begin

      k['DisplayVersion'].gsub(%r{[^[:print:]]}, '')

     rescue StandardError

      nil

     end

     uninstallpath = begin

      k['UninstallString'].gsub(%r{[^[:print:]]}, '')

     rescue StandardError

      nil

     end

     systemcomponent = begin

      k['SystemComponent'].gsub(%r{[^[:print:]]}, '')

     rescue StandardError

      nil

     end

     installdate = begin

      k['InstallDate'].gsub(%r{[^[:print:]]}, '')

     rescue StandardError

      nil

     end

 

     next unless displayname && uninstallpath

 

     next if systemcomponent == 1

 

     installed_packages[displayname] = {

      'version' => version,

      'installdate' => installdate,

     }

    end

   end

  end

 

  # Loop through all uninstall keys for user applications.

  Win32::Registry::HKEY_USERS.open('\\') do |reg|

   reg.each_key do |sid|

    next if sid.include?('_Classes')

 

    path = "#{sid}\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall"

    scope = 'HKEY_USERS'

    next unless key_exists?(path, scope)

 

    Win32::Registry.scope.open(path) do |userreg|

     userreg.each_key do |key|

      k = userreg.open(key)

      displayname = begin

       k['DisplayName'].gsub(%r{[^[:print:]]}, '')

      rescue StandardError

       nil

      end

      version = begin

       k['DisplayVersion'].gsub(%r{[^[:print:]]}, '')

      rescue StandardError

       nil

      end

      uninstallpath = begin

       k['UninstallString'].gsub(%r{[^[:print:]]}, '')

      rescue StandardError

       nil

      end

      installdate = begin

       k['InstallDate'].gsub(%r{[^[:print:]]}, '')

      rescue StandardError

       nil

      end

 

      next unless displayname && uninstallpath

 

      installed_packages[displayname] = {

       'version' => version,

       'installdate' => installdate,

      }

     end

    end

   end

  end

  installed_packages

 end

end
