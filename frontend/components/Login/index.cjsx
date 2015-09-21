api = require '../api'
module.exports = React.createClass
  displayName: 'Login'
  getInitialState: ->
    error: false
  componentDidMount: ->
    api.on 'login', @loginResponse

  loginResponse: (res) ->
    @setState error: true if not res.success
  login: (e) ->
    e.preventDefault()
    api.send 'login', $('#password').val()


  render: ->
    <li id="login">
      <div className="collapsible-header">
        <i className="material-icons">settings</i>
        Administration
      </div>
      <div className="collapsible-body">
        <form onSubmit={@login}>
          <div className="input-field">
            <input id="password" type="password" className={"validate"+(if @state.error then ' invalid' else '')} />
            <label for="password">Passwort</label>
          </div>
          <button className="waves-effect waves-light btn"><i className="mdi mdi-send"></i>Einloggen</button>
        </form>
      </div>
    </li>
