Return-Path: <SRS0=83Rr=26=gmail.com=arushisinghal19971997@kernel.org>
MIME-Version: 1.0
In-Reply-To: <52786ce4-e783-0ea4-c6cb-1deb63e91b53@kernel.org>
References: <20170321150638.9175-1-arushisinghal19971997@gmail.com> <52786ce4-e783-0ea4-c6cb-1deb63e91b53@kernel.org>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Wed, 22 Mar 2017 01:07:35 +0530
Message-ID: <CA+XqjF-be3KN3VYMwdnK8uqc5SvgP6Ue__YhbenCx-nu=MjX4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Remove Typedefs.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, outreachy-kernel@googlegroups.com,
	Michael Hennerich <Michael.Hennerich@analog.com>, Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg KH <gregkh@linuxfoundation.org>, speakup@linux-speakup.org,
	driverdevel <devel@driverdev.osuosl.org>, linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1140379e9e0452054b42c6b7
List-ID: <linux-iio@vger.kernel.org>

--001a1140379e9e0452054b42c6b7
Content-Type: text/plain; charset=UTF-8

On Wed, Mar 22, 2017 at 1:04 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 21/03/17 15:06, Arushi Singhal wrote:
> > Typedefs are removed in sm750fb driver.
> >
> > Arushi Singhal (2):
> >   staging: sm750fb: Remove typedef from "typedef struct
> _mode_parameter_t"
> >   staging: sm750fb: Remove typedef from "typedef enum _spolarity_t"
> >
> >  drivers/staging/sm750fb/ddk750_mode.c |  8 +++++---
> >  drivers/staging/sm750fb/ddk750_mode.h | 19 ++++++++-----------
> >  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
> >  3 files changed, 14 insertions(+), 15 deletions(-)
> >
> Please be careful to only cc linux-iio for patches with an IIO component...
>
Sorry
>From  next I will not repeat the same.
Thanks
Arushi

--001a1140379e9e0452054b42c6b7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Mar 22, 2017 at 1:04 AM, Jonathan Cameron <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 21=
/03/17 15:06, Arushi Singhal wrote:<br>
&gt; Typedefs are removed in sm750fb driver.<br>
&gt;<br>
&gt; Arushi Singhal (2):<br>
&gt;=C2=A0 =C2=A0staging: sm750fb: Remove typedef from &quot;typedef struct=
 _mode_parameter_t&quot;<br>
&gt;=C2=A0 =C2=A0staging: sm750fb: Remove typedef from &quot;typedef enum _=
spolarity_t&quot;<br>
&gt;<br>
&gt;=C2=A0 drivers/staging/sm750fb/<wbr>ddk750_mode.c |=C2=A0 8 +++++---<br=
>
&gt;=C2=A0 drivers/staging/sm750fb/<wbr>ddk750_mode.h | 19 ++++++++--------=
---<br>
&gt;=C2=A0 drivers/staging/sm750fb/sm750_<wbr>hw.c=C2=A0 =C2=A0 |=C2=A0 2 +=
-<br>
&gt;=C2=A0 3 files changed, 14 insertions(+), 15 deletions(-)<br>
&gt;<br>
</span>Please be careful to only cc linux-iio for patches with an IIO compo=
nent...<br></blockquote><div>Sorry<br></div><div>From=C2=A0 next I will not=
 repeat the same.<br></div><div>Thanks<br></div><div>Arushi <br></div></div=
><br></div></div>

--001a1140379e9e0452054b42c6b7--
