require 'sinatra'
require 'sinatra/flash'
require 'json'
require 'sqlite3'
require '../models/database.rb'
require '../models/univ.rb'
require '../models/student.rb'
require '../models/teacher.rb'
require 'stripe'
require 'pony'
enable :sessions

set :port, 8000
set :bind, '0.0.0.0'
Stripe.api_key = 'sk_test_VePHdqKTYQjKNInc7u56JBrQ'
set('views', '../views')

get '/' do
    erb :index
end

get '/home' do
    erb :home
end

get '/homest' do
    erb :stNoUni
end

get '/homete' do
    erb :teNouni
end

get '/signup' do
    erb :signup
end

post '/signup' do
    puts params
    students=Student.allStudent
    teachers=Teacher.allTeacher
    if(students!=nil) 
        student=students.filter { |s| s.email==params['email']}.first
    end
    if(teachers!=nil)
        teacher=teachers.filter { |t| t.email==params['email']}.first
    end
    p student
    p teacher
    if(student==nil && teacher==nil)
        session[:user_id]=100
        $email=params['email']
        Student.createStudent(params)
        redirect '/signup' 
    elsif(student!=nil && teacher!=nil)
        flash[:user]= "User already exist"
        redirect '/login'
    end
end

post '/confirm' do
    if(params['password']==params['Rpassword'])
        Student.updateP($email,params['password'])
        redirect '/login'
    else
        flash[:password] = "Please enter correct passwords"
        redirect '/signup'
    end
end

get '/login' do
    erb :login
end

post '/login' do
    p params
    students=Student.allStudent
    p students
    teachers=Teacher.allTeacher
    schools=School.allSchools
    student=students.filter { |user| user.email==params['email'] && user.password==params['password']}.first
    teacher=teachers.filter { |user| user.email==params['email'] && user.password==params['password']}.first
    school=schools.filter { |user| user.email==params['email'] && user.password==params['password']}.first
    p student
    if(student && params['email']!="")
        session[:user_id]=student.id
        $Id=student.id
        $name=student.name
        $year=student.year
        $filiere=student.filiere
        $univ=student.univ
        $password=student.password
        $user=$name.split(" ").slice(0,2).join(" ")
        redirect '/home'
    elsif(teacher && params['email']!="")
        session[:user_id]=teacher.id
        $Id=student.id
        $name=teacher.name
        $password=teacher.password
        $user=$name.split(" ").slice(0,2).join(" ")
        redirect '/home'
    elsif(school && params['email']!="")
        session[:user_id]=school.id
        $sId=school.id
        $name=school.s_name
        $password=school.password
        redirect '/dashboard'
    else
        flash[:invalid] = "wrong username of password"
        redirect '/login'
    end
end

get '/document' do
    erb :document
end

get '/coming' do
    erb :coming
end

get '/test' do
    erb :test
end

get '/register' do
    erb :register
end

post '/register' do
    puts params
    schools=School.allSchools
    if(schools!=nil)
        school=schools.filter { |school| school.email==params['email']}.first
    end
    if(params['password']==params['Rpassword'] && school==nil)
        School.createSchool(params)
        p "School created"
        redirect '/bundle'
    elsif(school!=nil)
        flash[:user]= "User already exist"
        redirect '/register'
    else
        flash[:password] = "Please enter correct passwords"
        redirect '/register'
    end
end

get '/dashboard' do
    erb :dashboard  
end
get '/bundle' do
    erb :bundle
end
get '/checkout' do
    erb :checkout
end
post '/create-payment-intent' do
    content_type 'application/json'
    data = JSON.parse(request.body.read)
  
    # Create a PaymentIntent with amount and currency
    payment_intent = Stripe::PaymentIntent.create(
      amount: 2000,
      currency: 'usd',
      automatic_payment_methods: {
        enabled: true,
      },
    )
  
    {
      clientSecret: payment_intent['client_secret']
    }.to_json
  end

get '/add-professor' do
    erb :addTeacher
end
get '/all-professors' do
    erb :allTeacher
end
get '/edit-professor' do
    erb :editTeacher
end
get '/add-student' do
    erb :addStudent
end
get '/all-students' do
    erb :allStudent
end
get '/edit-student' do
    erb :editStudent
end
get '/all-courses' do
    erb :allCourse
end
get '/add-course' do
    erb :addCourse
end
get '/edit-course' do
    erb :editCourse
end
get '/course-info' do
    erb :courseInfo
end
get '/add-database' do
    erb :database
end
get '/library-assets' do
    erb :allBook
end
get '/add-library-assets' do
    erb :addBook
end
get '/mailbox' do
    erb :inbox
end
get '/mailbox-view' do
    erb :addTeacher
end
get '/add-teacher' do
    erb :viewMail
end
get '/mailbox-compose' do
    erb :compose
end
get '/events' do
    erb :event
end

get '/student-exam' do
    erb :StudentExam
end
=begin
post '/test' do
    Pony.mail(
        subject: "Portfolio page: Message delivery from",
        body: "Wassup guy",
        to: "nuadjedidi@gmail.com",
        from: "ndilanwil237@gmail.com",
        via: :smtp,
        via_options: {
            address: 'smtp.gmail.com',
            port: '587',
            enable_starttls_auto: true,
            user_name: "ndilanwil237@gmail.com",
            password: 'Micro-phone43',
            authentication: :plain
        }
    )
   redirect '/'
end
=end
post '/test' do
   p params 
end