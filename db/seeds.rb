# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Page.create name:"Home", body:<<-BODY
Welcome to Hero Wiki, edit this page by logging in with an Unlock Code 
(on development, it's 'food and stuff')
BODY

Page.create name:"Welcome", body:<<-BODY
Thanks for logging in!  Poke around and learn about HSD!

h3. Want to edit pages?

If you would like to become an editor, please send an email to the administrator of this site.

h3. Have a passcode?

If you've already talked to them, then you probably have a passcode.  Enter it here.

<form method="post">
<label>Passcode</label>
<input type="password" name="password"/>
<input name="authenticity_token" type="hidden" class="lookup-authenticity-token"><br/>
<input type="submit" value="Send" class="btn btn-primary"/>
</form>
BODY