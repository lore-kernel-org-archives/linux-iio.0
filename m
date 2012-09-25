Return-Path: <denis.ciocca@gmail.com>
MIME-Version: 1.0
In-Reply-To: <be76e072-47c2-4abc-bea1-69081e98abad@email.android.com>
References: <CAEE_umr40Knv-LAYSCYENYXhc4eoaFEirwBzimk5dzgjMzhUkg@mail.gmail.com>
	<be76e072-47c2-4abc-bea1-69081e98abad@email.android.com>
Date: Tue, 25 Sep 2012 23:20:11 +0200
Message-ID: <CAEE_umqJeCPrxDFD8u3mZwkCYa5GGaCZqtcyhE2oQMOhRfe=7g@mail.gmail.com>
Subject: Re: iio_buffer length
From: Denis Ciocca <denis.ciocca@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=bcaec54d42bc7ced7804ca8d451b
List-ID: <linux-iio@vger.kernel.org>

--bcaec54d42bc7ced7804ca8d451b
Content-Type: text/plain; charset=ISO-8859-1

Hi Jon,

> Firstly please confirm you are using a kfifo buffer?

No, I use sw-ring.

> Swring is deprecated but will do precisely what you are seeing I think.
It uses a half full watershead to decide to signal userspace.  If you wait
till the buffer is full, unless your sampling is very slow you will have
data coming in before userspace has read the whole buffer out. Hence you
will loose data.

You are right. I saw exatly what you said.

 Kfifo has a more conventional poll and will fire off userspace whenever
any data is in the buffer. Hence kfifo will work for your usecase.  I would
like to have a fill level capable buffer again in the future as they are
very useful in high speed uses where latency doesn't matter.

Ok, I will change my sw-ring buffer to kfifo!

Thanks,
Denis

--bcaec54d42bc7ced7804ca8d451b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi Jon,</p>
<p>&gt; Firstly please confirm you are using a kfifo buffer? </p>
<p>No, I use sw-ring.<br></p>
<p>&gt; Swring is deprecated but will do precisely what you are seeing I th=
ink. It uses a half full watershead to decide to signal userspace. =A0If yo=
u wait till the buffer is full, unless your sampling is very slow you will =
have data coming in before userspace has read the whole buffer out. Hence y=
ou will loose data.</p>

<p>You are right. I saw exatly what you said.<br></p>
<p>=A0Kfifo has a more conventional poll and will fire off userspace whenev=
er any data is in the buffer. Hence kfifo will work for your usecase. =A0I =
would like to have a fill level capable buffer again in the future as they =
are very useful in high speed uses where latency doesn&#39;t matter.</p>

<p>Ok, I will change my sw-ring buffer to kfifo!<br></p>
<p>Thanks,<br>
Denis</p>

--bcaec54d42bc7ced7804ca8d451b--
