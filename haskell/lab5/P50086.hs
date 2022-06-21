data Queue a = Queue [a] [a]
 deriving (Show)


c = push 3 (push 2 (push 1 create))
c1 = push 4 (pop (push 3 (push 2 (push 1 create))))
c2 = push 4 (push 3 (push 2 create))


create :: Queue a
create = Queue [] []
 
push :: a -> Queue a -> Queue a
push a (Queue l1 l2) = Queue l1 (a:l2)
 
pop :: Queue a -> Queue a
pop (Queue [] l2) = pop $ Queue (reverse l2) []
pop (Queue (x:l1) l2) = Queue l1 l2
 
top :: Queue a -> a
top (Queue [] l2) = last l2
top (Queue (x:_) _) = x
 
empty :: Queue a -> Bool
empty (Queue [] []) = True
empty (Queue _ _) = False
 
instance Eq a => Eq (Queue a)
 where
  Queue x1 x2 == Queue y1 y2 = x1 ++ (reverse x2) == y1 ++ (reverse y2)
  
instance Functor Queue where
 fmap f (Queue l1 l2) = Queue (map f l1) (map f l2)

translation :: Num b => b -> Queue b -> Queue b
translation x queue = fmap (+x) queue

kfilter :: (p -> Bool) -> Queue p -> Queue p
kfilter f queue = do
 q <- queue
 if (f q) then return q
 else (Queue [] [])

q2l :: (Queue a) -> [a]
q2l (Queue as bs) = (as ++ (reverse bs))

instance Applicative Queue
 where
  pure x = (Queue [x] [])
  f <*> queue = (Queue ((q2l f) <*> (q2l queue)) [])

instance Monad Queue
 where
  return x = (Queue [x] [])
  queue >>= f = (Queue l [])
   where
    l = (q2l queue) >>= (q2l . f)







