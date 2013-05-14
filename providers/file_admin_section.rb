use_inline_resources
require 'fileutils'

action :manage do
	
	ruby_block "manage admin section #{new_resource.section_name} of #{new_resource.filepath}" do
		block do
			#create a backup of the file.. change with ruby code to be platform independent
			::FileUtils.cp(new_resource.filepath,"#{new_resource.filepath}.admin_section_bak")
		
			#header line to indicate beginning of managed content
			header_string="#{new_resource.begin_comment_indicator}begin section #{new_resource.section_name}#{new_resource.end_comment_indicator}\n"
			
			#footer line to indicate end of managed content
			footer_string="#{new_resource.begin_comment_indicator}end section #{new_resource.section_name}#{new_resource.end_comment_indicator}\n"
			
			#complete managed section content including header and footer
			substitution="#{header_string}#{new_resource.content}\n#{footer_string}"

			#load backup file into a string in memory
			backup_file_content=IO.read("#{new_resource.filepath}.admin_section_bak")
			
			if backup_file_content=~/^#{Regexp.escape(header_string)}.*\w*#{Regexp.escape(footer_string)}/m
				new_content=backup_file_content.sub(/^#{Regexp.escape(header_string)}.*\w*#{Regexp.escape(footer_string)}/m,substitution)
			else
				#append
				new_content="#{backup_file_content}\n#{substitution}"
			end
			
			#write content to live file
			::File.open("#{new_resource.filepath}", "w") {|f| f.write(new_content) }
	
		end
	end
	
end #manage action

