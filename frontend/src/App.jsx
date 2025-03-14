import Chat from "./components/chat/Chat";
import Detail from "./components/detail/Detail";
import List from "./components/list/List";
import Login from "./components/login/Login";
import Notification from "./components/notification/Notification";
import { useUserStore } from "./lib/userStore";

const App = () => {

  const {currentUser, isLoading} = useUserStore();

  if(isLoading) return <div className="loading">Loading...</div>
  
  return (
    <div className='container'>
      {
        currentUser ? (
          <>
            <List/>
            <Chat/>
            <Detail/>
          </>
        ) : (
        <Login/>
      )}
      <Notification/>
    </div>
  )
}

export default App