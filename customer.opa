/*
* Author: Sergio Moral Ruiz
* December 2011
* semoru.com
*/

package semoru.crud.customer

import stdlib.themes.bootstrap
import stdlib.web.client
import stdlib.core.web.core

/* Database object type definition */
type Customer = 
{
        sid: int
        name : string
        email: string
}
/* Database object creation */
db /customers : intmap(Customer)

/* Class Customer */
Customer = {{

   /* Actions */
   create() = 
        key = Db.fresh_key(@/customers)
        do /customers[key] <- {sid = key; name=Dom.get_value(#name); email=Dom.get_value(#email)}
        Client.goto("/")

   update(id:int) =
        do /customers[id] <- {sid = id name=Dom.get_value(#name) email=Dom.get_value(#email)}
        Client.goto("/")

   delete(id:string)=
      items =  /customers
      do /customers <- IntMap.remove(String.to_int(id), items)
      Client.goto("/")

   /* Front end */

   new() =    
      <div class="container">
           <h1> <a href="http://www.semoru.com">semoru.com</a> CRUD example</h1>
           <table>
                 <tr>
                    <td><h2>Add a new customer</h2></td>
                 </tr>
                 <tr>
                    <td>
                        <div class="clearfix">
                             <label>Name</label>
                             <div class="input">
                                  <input id=#name />
                             </div>
                        </div>
                        <div class="clearfix">
                             <label>Email</label>
                             <div class="input">
                                  <input id=#email/>
                             </div>
                        </div>
                    </td>
                 </tr>
             </table>
           <div class="btn primary" onclick={_ -> create()}>  Create </div>
           <div class="btn default" onclick={_ -> Client.goto("/")}>  Cancel </div>
      </div>

   edit(id: string)=
      customer : Customer = /customers[String.to_int(id)]
      <div class="container">
           <h1> <a href="http://www.semoru.com">semoru.com</a> CRUD example</h1>
           <table>
                 <tr>
                    <td><h2>Edit customer</h2></td>
                 </tr>
                 <tr>
                    <td>
                        <div class="clearfix">
                             <label>Name</label>
                             <div class="input">
                                  <input id=#name value={customer.name} />
                             </div>
                        </div>
                        <div class="clearfix">
                             <label>Email</label>
                             <div class="input">
                                  <input id=#email value={customer.email} />
                             </div>
                        </div>
                    </td>
                 </tr>
             </table>
           <div class="btn primary" onclick={_ -> update(String.to_int(id))}>  Update </div>
           <div class="btn default" onclick={_ -> Client.goto("/")}>  Cancel </div>
      </div>

   confirmation(id:string)=
      customer : Customer = /customers[String.to_int(id)]
      <div class="container">
           <h1> <a href="http://www.semoru.com">semoru.com</a> CRUD example</h1>
           <div class="alert-message block-message error"> <p> Do you want to delete the following information? </p></div>
           <table>
              <tr>
                  <td>
                        <div class="clearfix">
                             <label>Name:</label>
                             <div class="input">
                                  <input value={customer.name} disabled="true"/>
                             </div>
                        </div>
                        <div class="clearfix">
                             <label>Email:</label>
                             <div class="input">
                                  <input value={customer.email} disabled="true"/>
                             </div>
                        </div>
                  </td>
              </tr>
           </table>
           <div class="btn primary" onclick={_ -> delete(id)}>  Delete </div>
           <div class="btn default" onclick={_ -> Client.goto("/")}>  Cancel </div> 
      </div>

   getHTMLTable() = 
        <table id=#tabla class="zebra-striped">
            <tr>
                <td>
                   Actions
                </td>
                <td>
                   Name
                </td>
                <td>
                   Email
                </td>
            </tr>
           {  
              List.map(
                customer ->
                   <tr>
                       <td>
                           <a href="/edit?id={customer.sid}">Edit</a> <b>|</b>
                           <a href="/delete?id={customer.sid}">Delete</a>
                       </td>
                       <td>
                           {customer.name}
                       </td>
                       <td>
                           {customer.email}
                       </td>
                   </tr>,
                IntMap.To.val_list(/customers)
              ) 
           }
        </table>

   start()=
        <div class="container">
             <h1> <a href="http://www.semoru.com">semoru.com</a> CRUD example</h1>
             <table>
                 <tr>
                    <td><h2>Customer list:</h2></td>
                 </tr>
                 <tr>
                    <td><div class="btn primary" onclick={_ -> Client.goto("/add")}>Add new customer</div></td>
                 </tr>
             </table>
             <div>{getHTMLTable()}</div>
        </div>

}}
