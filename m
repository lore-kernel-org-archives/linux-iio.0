Return-Path: <SRS0=2OOR=2I=gmail.com=narcisaanamaria12@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b587366e-dec9-c550-3617-2a6d76200423@metafoo.de>
References: <1488146361-14383-1-git-send-email-narcisaanamaria12@gmail.com> <b587366e-dec9-c550-3617-2a6d76200423@metafoo.de>
From: Narcisa Vasile <narcisaanamaria12@gmail.com>
Date: Mon, 27 Feb 2017 15:41:49 +0200
Message-ID: <CAEdesYZkN4+ZXCycyP71FTEKYC750TtPAQMtF62FyYUp+fZCFA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad9834: Moved contents of header file to
 source file
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, outreachy-kernel@googlegroups.com,
	gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, jic23@kernel.org
Content-Type: multipart/alternative; boundary=001a11370d7cc880fe0549833dd9
List-ID: <linux-iio@vger.kernel.org>

--001a11370d7cc880fe0549833dd9
Content-Type: text/plain; charset=UTF-8

Pe 27 feb. 2017 11:21, "Lars-Peter Clausen" <lars@metafoo.de> a scris:
>
> On 02/26/2017 10:59 PM, Narcisa Ana Maria Vasile wrote:
> > The contents of the header file are used only by this single source file
>
> Same here, platform data should stay in its the header file, everything
else
> can and should be moved.
>
>
I'm attempting to fix this patch and I want to make sure I understood the
right way to do it.
According to the TODO above the platform data struct, this struct should go
to include/linux/iio. So, is it ok to create a new header file with the
original name (ad9834.h), place the platform data struct inside it and put
this header file into include/linux/iio/frequency folder?
Then, in the C file, I will include this new header, remove the platform
data struct, but keep the defines and state struct.
Same for the other file (ad9832).

--001a11370d7cc880fe0549833dd9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">Pe 27 feb. 2017 11:21, &quot;Lars-Peter Clausen&quot; &lt;<a=
 href=3D"mailto:lars@metafoo.de">lars@metafoo.de</a>&gt; a scris:<br>
&gt;<br>
&gt; On 02/26/2017 10:59 PM, Narcisa Ana Maria Vasile wrote:<br>
&gt; &gt; The contents of the header file are used only by this single sour=
ce file<br>
&gt;<br>
&gt; Same here, platform data should stay in its the header file, everythin=
g else<br>
&gt; can and should be moved.<br>
&gt;<br>
&gt;<br>
I&#39;m attempting to fix this patch and I want to make sure I understood t=
he right way to do it.<br>
According to the TODO above the platform data struct, this struct should go=
 to include/linux/iio. So, is it ok to create a new header file with the or=
iginal name (ad9834.h), place the platform data struct inside it and put th=
is header file into include/linux/iio/frequency folder?=C2=A0 <br>
Then, in the C file, I will include this new header, remove the platform da=
ta struct, but keep the defines and state struct.<br>
Same for the other file (ad9832).<br>
</p>

--001a11370d7cc880fe0549833dd9--
