import logo from "../image/logo.png"

export default function Navbar() {
    return (
        <nav className="nav">
            <img src={logo} alt="logo" className="nav--logo" />
            <div className="nav--right">
                <h3 className="nav--profile">Nome-Cognome</h3>
                <button className="nav--button">Logout</button>
            </div>
        </nav>
    )
}