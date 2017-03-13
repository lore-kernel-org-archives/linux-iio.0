Return-Path: <SRS0=TkIA=2W=gmail.com=rvarsha016@kernel.org>
Date: Mon, 13 Mar 2017 07:39:41 -0700 (PDT)
From: Varsha Rao <rvarsha016@gmail.com>
To: outreachy-kernel <outreachy-kernel@googlegroups.com>
Cc: rvarsha016@gmail.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	21cnbao@gmail.com, linux-iio@vger.kernel.org, lars@metafoo.de
Message-Id: <677299aa-1a1c-412c-85cf-b9117be3e4be@googlegroups.com>
In-Reply-To: <45f0ef85-3753-946f-4956-6cba4e8a6859@metafoo.de>
References: <cover.1489395260.git.rvarsha016@gmail.com>
 <58c6652a.467d630a.1c92b.3bea@mx.google.com>
 <45f0ef85-3753-946f-4956-6cba4e8a6859@metafoo.de>
Subject: Re: [PATCH 1/2] staging: iio: adis16240: Replace mlock with driver
 private lock.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9832_29465237.1489415981517"
List-ID: <linux-iio@vger.kernel.org>

------=_Part_9832_29465237.1489415981517
Content-Type: multipart/alternative;
	boundary="----=_Part_9833_855109335.1489415981517"

------=_Part_9833_855109335.1489415981517
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



> > +++ b/drivers/staging/iio/accel/adis16240.c 
> > @@ -229,11 +229,12 @@ static ssize_t adis16240_read_12bit_signed(struct 
> device *dev, 
> >  { 
> >          ssize_t ret; 
> >          struct iio_dev *indio_dev = dev_to_iio_dev(dev); 
> > +        struct adis *st = iio_priv(indio_dev); 
> >   
> >          /* Take the iio_dev status lock */ 
> > -        mutex_lock(&indio_dev->mlock); 
> > +        mutex_lock(&st->txrx_lock); 
>
> This unfortunately wont work. The adis_read_reg()/adis_write_reg() 
> functions 
> take the txrx_lock. So this change causes a deadlock, trying to take a 
> lock 
> that is already locked. 
>
>    Yes, it would cause deadlock. Can the lock be placed within the 
   adis_read_reg() function and removing locks from other place?
 

> But this lock can probably be removed. It should be safe to run the 
> function 
> multiple times in parallel. 
>
> Same for the other changes in this patch. 
>
   
   Then should I remove all the locks in this file?
    
   Thanks,
   Varsha

------=_Part_9833_855109335.1489415981517
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<br><blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex=
;border-left: 1px #ccc solid;padding-left: 1ex;">&gt; +++ b/drivers/staging=
/iio/accel/<wbr>adis16240.c
<br>&gt; @@ -229,11 +229,12 @@ static ssize_t adis16240_read_12bit_signed(<=
wbr>struct device *dev,
<br>&gt; =C2=A0{
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t ret;
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_d=
ev *indio_dev =3D dev_to_iio_dev(dev);
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct adis *st =
=3D iio_priv(indio_dev);
<br>&gt; =C2=A0
<br>&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Take the =
iio_dev status lock */
<br>&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&amp;i=
ndio_<wbr>dev-&gt;mlock);
<br>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&amp;s=
t-&gt;txrx_<wbr>lock);
<br>
<br>This unfortunately wont work. The adis_read_reg()/adis_write_<wbr>reg()=
 functions
<br>take the txrx_lock. So this change causes a deadlock, trying to take a =
lock
<br>that is already locked.
<br>
<br></blockquote><div>=C2=A0=C2=A0 Yes, it would cause deadlock. Can the lo=
ck be placed within the <br>=C2=A0=C2=A0 adis_read_reg() function and remov=
ing locks from other place?<br>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding=
-left: 1ex;">But this lock can probably be removed. It should be safe to ru=
n the function
<br>multiple times in parallel.
<br>
<br>Same for the other changes in this patch.
<br></blockquote><div>=C2=A0=C2=A0 <br>=C2=A0=C2=A0 Then should I remove al=
l the locks in this file?<br>=C2=A0=C2=A0=C2=A0 <br>=C2=A0=C2=A0 Thanks,<br=
>=C2=A0=C2=A0 Varsha<br></div>
------=_Part_9833_855109335.1489415981517--

------=_Part_9832_29465237.1489415981517--
