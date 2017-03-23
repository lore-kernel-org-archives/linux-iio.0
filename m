Return-Path: <SRS0=3cA0=3A=gmail.com=arushisinghal19971997@kernel.org>
MIME-Version: 1.0
In-Reply-To: <d432970a-ffea-2cce-de3e-db4f30f0201f@metafoo.de>
References: <20170323115357.GA24360@arushi-HP-Pavilion-Notebook> <d432970a-ffea-2cce-de3e-db4f30f0201f@metafoo.de>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Thu, 23 Mar 2017 18:02:48 +0530
Message-ID: <CA+XqjF81VTZFLWQpdLVXNvLcCXzC5E068kPr3y6=GGiANTij=A@mail.gmail.com>
Subject: Re: [PATCH] staging: tsl2x7x: Moved contents of the header to the
 source file.
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, driverdevel <devel@driverdev.osuosl.org>,
	LKML <linux-kernel@vger.kernel.org>, outreachy-kernel@googlegroups.com
Content-Type: multipart/alternative; boundary=001a1140768e36450b054b6513ab
List-ID: <linux-iio@vger.kernel.org>

--001a1140768e36450b054b6513ab
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 23, 2017 at 5:29 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 03/23/2017 12:53 PM, Arushi Singhal wrote:
> > Moved the contents of the header(tsl2x7x.h) into the source file
> > tsl2x7x_core.c with the exception of the platform data struct which is
> > supposed to be used from somewhere else other than the driver.
>
> The platform_data struct uses the other structs though.
>
Hi Lars
Thanks for pointing out the mistake.
Arushi

--001a1140768e36450b054b6513ab
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Mar 23, 2017 at 5:29 PM, Lars-Peter Clausen <span dir=3D"ltr">&=
lt;<a href=3D"mailto:lars@metafoo.de" target=3D"_blank">lars@metafoo.de</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 03=
/23/2017 12:53 PM, Arushi Singhal wrote:<br>
&gt; Moved the contents of the header(tsl2x7x.h) into the source file<br>
&gt; tsl2x7x_core.c with the exception of the platform data struct which is=
<br>
&gt; supposed to be used from somewhere else other than the driver.<br>
<br>
</span>The platform_data struct uses the other structs though.<br></blockqu=
ote><div>Hi Lars<br></div><div>Thanks for pointing out the mistake.<br></di=
v><div>Arushi <br></div></div></div></div>

--001a1140768e36450b054b6513ab--
