import React from 'react'

function Datatypes() {
  const strVar = "I am a string";
  const numVar = 10;
  const boolVar = false;
  const linkVar = 'https://www.psit.ac.in/';
  const listVar = [1,2,3,4,5]
  const jsonVar = { 'name': 'Arnav' , 'class' : '3rd year elite'  }
  const jsonArrayVar = [{ 'name': 'Arnav' , 'class' : '3rd year elite' ,'imgUrl': 'https://m.media-amazon.com/images/I/71wXQyxCENL._AC_UY327_FMwebp_QL65_.jpg'  },
                        { 'name': 'Kavya' , 'class' : '3rd year elite' ,'imgUrl': 'https://m.media-amazon.com/images/I/71nh1VxLzuL._AC_UY327_FMwebp_QL65_.jpg'  }] 
   const sq = (x) => {return x**2 }
   function cb(x) { return x**3 }
   let result1 = listVar.map(cb);
   let result2 = listVar.map(sq);
   let result3 = listVar.map((x) => {return x**2 });
  return (
    <div className="Datatypes">
        <h1>{strVar} and {numVar}</h1>
        { boolVar ? <div>it is true</div> : <p>it is false</p> }
        <a href={linkVar}>goto PSIT home page</a>
        <p>{Math.random()}</p>
        <h1>{listVar}</h1>
        {/*
        <p>
        { jsonVar }
        </p>
        */}
        {/*<h1>{jsonVar.name} {jsonVar.class}</h1> */}

       {/* <p>{jsonArrayVar}</p> */}

       <h1>
       {console.log(listVar)}
       </h1>

       <h1>
       {console.log(result1)}
       {console.log(result2)}
       {console.log(result3)}
       </h1>
       {jsonArrayVar.map((jsonVar) => <div>
                                            <h1>{jsonVar.name} {jsonVar.class}</h1>
                                            <img src={jsonVar.imgUrl}/>
                                      </div>)}
       

    </div>
  )
}

export default Datatypes