import "./login.css";
import { useState } from "react";
import { toast } from "react-toastify";


const Login = () => {

    const [loading, setLoading] = useState(false);

    const handleLogin = async (e) => {
        e.preventDefault();
        setLoading(true);

        const formData = new FormData(e.target);

        const {email,password} = Object.fromEntries(formData);

        try{
            toast.success("Account created! You can login now!")
        }catch(err){
            console.log(err);
            toast.error(err.message);
        }
        finally{
            setLoading(false);
        }
    }

    return (
        <div className="login">
            <div className="item">
                <h2>Welcome to MeowChat</h2>
                <form onSubmit={handleLogin}>
                    <input type="text" placeholder="Username" name="username" />
                    <input type="password" placeholder="Password" name="password" />
                    <button disabled={loading}>{loading ? "Loading" : "Sign in" }</button>
                </form>
            </div>
            <div className="separator">

            </div>
            <div className="item">
                <h2>Create an Account</h2>
                <form>
                    <input type="text" placeholder="Username" name="username" />
                    <input type="password" placeholder="Password" name="password" />
                    <button>Sign Up</button>
                </form>
            </div>
        </div>
    )
}

export default Login;