actions :manage

#this is the character used at the beginning of the line to indicate that the line is a comment
attribute :begin_comment_indicator, {:kind_of => String, :default=> '#'}

#this is the character used at the end of the line to indicate that the line is a comment, probably a closing tag
attribute :end_comment_indicator, {:kind_of => String, :default=> ''}

#string to uniquely identify the admin section... this must be explicitly specified
attribute :section_name, {:kind_of => String, :required=> true}

#content to be managed by the admin section
attribute :content, {:kind_of => String, :required=> true}

#file name
attribute :filepath, {:kind_of => String, :required=> true}