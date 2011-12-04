/*
* Author: Sergio Moral Ruiz
* December 2011
* semoru.com
*/

package semoru.crud.dispatcher

import semoru.crud.customer
import stdlib.web.client
import stdlib.core.web.core

/* URL Dispatcher */
start(uri) = (
      match uri with
      | {path = ["edit"] query=[("id", id)] ... } -> Resource.styled_page("CRUD - Edit", [], Customer.edit(id))
      | {path = ["delete"] query=[("id", id)] ... } -> Resource.styled_page("CRUD - Delete", [], Customer.confirmation(id))
      | {path = ["add"] ... } -> Resource.styled_page("CRUD - Add", [], Customer.new())                  
      | {~path ...} -> Resource.styled_page("CRUD - Welcome", [], Customer.start())
)

server = Server.simple_dispatch(start)
