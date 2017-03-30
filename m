Return-Path: <SRS0=FWgg=3H=gmail.com=arushisinghal19971997@kernel.org>
MIME-Version: 1.0
In-Reply-To: <8151b453-3ae7-7321-8294-c5c8e1cf7a29@kernel.org>
References: <20170330124121.GA29095@arushi-HP-Pavilion-Notebook> <8151b453-3ae7-7321-8294-c5c8e1cf7a29@kernel.org>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Fri, 31 Mar 2017 00:04:47 +0530
Message-ID: <CA+XqjF-04r46bVD0OpH_TJC+AyMh0SPAkWKCcAnhBuhsqCZ4Qw@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: replace comma with a semicolon
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, outreachy-kernel@googlegroups.com
Content-Type: multipart/alternative; boundary=001a113f89e296cf30054bf6f287
List-ID: <linux-iio@vger.kernel.org>

--001a113f89e296cf30054bf6f287
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 30, 2017 at 11:46 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 30/03/17 13:41, Arushi Singhal wrote:
> > Replace a comma between expression statements by a semicolon. This
> > changes the semantics of the code, but given the current indentation
> > appears to be what is intended.
> > A simplified version of the Coccinelle semantic patch that performs this
> > transformation is as follows:
> >
> > // <smpl>
> > @r@
> > expression e1,e2;
> > @@
> >
> >  e1
> > -,
> > +;
> >  e2;
> > // </smpl>
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> As per the discussion about the other one.  This is perfectly
> correct, but weird enough that I think we'll clear it out.
>
>
Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
> I did add chemical to the title though to make it clearer what
> this was covering.
>
Thanks Jonathan
Do I need to resend it with revised  patch subject.
Arushi

>
> Thanks,
>
> Jonathan
> > ---
> >  drivers/iio/chemical/ams-iaq-core.c | 2 +-
> >  drivers/iio/chemical/vz89x.c        | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/ams-iaq-core.c
> b/drivers/iio/chemical/ams-iaq-core.c
> > index 41a8e6f2e31d..c948ad2ee9ad 100644
> > --- a/drivers/iio/chemical/ams-iaq-core.c
> > +++ b/drivers/iio/chemical/ams-iaq-core.c
> > @@ -163,7 +163,7 @@ static int ams_iaqcore_probe(struct i2c_client
> *client,
> >       mutex_init(&data->lock);
> >
> >       indio_dev->dev.parent = &client->dev;
> > -     indio_dev->info = &ams_iaqcore_info,
> > +     indio_dev->info = &ams_iaqcore_info;
> >       indio_dev->name = dev_name(&client->dev);
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >
> > diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> > index 8e0e4415c161..f75eea6822f2 100644
> > --- a/drivers/iio/chemical/vz89x.c
> > +++ b/drivers/iio/chemical/vz89x.c
> > @@ -393,7 +393,7 @@ static int vz89x_probe(struct i2c_client *client,
> >       mutex_init(&data->lock);
> >
> >       indio_dev->dev.parent = &client->dev;
> > -     indio_dev->info = &vz89x_info,
> > +     indio_dev->info = &vz89x_info;
> >       indio_dev->name = dev_name(&client->dev);
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >
> >
>
>

--001a113f89e296cf30054bf6f287
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Mar 30, 2017 at 11:46 PM, Jonathan Cameron <span dir=3D"ltr">&l=
t;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 3=
0/03/17 13:41, Arushi Singhal wrote:<br>
&gt; Replace a comma between expression statements by a semicolon. This<br>
&gt; changes the semantics of the code, but given the current indentation<b=
r>
&gt; appears to be what is intended.<br>
&gt; A simplified version of the Coccinelle semantic patch that performs th=
is<br>
&gt; transformation is as follows:<br>
&gt;<br>
&gt; // &lt;smpl&gt;<br>
&gt; @r@<br>
&gt; expression e1,e2;<br>
&gt; @@<br>
&gt;<br>
&gt;=C2=A0 e1<br>
&gt; -,<br>
&gt; +;<br>
&gt;=C2=A0 e2;<br>
&gt; // &lt;/smpl&gt;<br>
&gt;<br>
&gt; Signed-off-by: Arushi Singhal &lt;<a href=3D"mailto:arushisinghal19971=
997@gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt;<br>
</span>As per the discussion about the other one.=C2=A0 This is perfectly<b=
r>
correct, but weird enough that I think we&#39;ll clear it out.<br>=C2=A0
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
Applied to the togreg branch of iio.git and pushed out as testing<br>
for the autobuilders to play with it.<br>
<br>
I did add chemical to the title though to make it clearer what<br>
this was covering.<br></blockquote><div>Thanks Jonathan<br></div><div>Do I =
need to resend it with revised=C2=A0 patch subject.<br></div><div>Arushi<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
<br>
Jonathan<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; ---<br>
&gt;=C2=A0 drivers/iio/chemical/ams-iaq-<wbr>core.c | 2 +-<br>
&gt;=C2=A0 drivers/iio/chemical/vz89x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<b=
r>
&gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/chemical/ams-<wbr>iaq-core.c b/drivers/iio/ch=
emical/ams-<wbr>iaq-core.c<br>
&gt; index 41a8e6f2e31d..c948ad2ee9ad 100644<br>
&gt; --- a/drivers/iio/chemical/ams-<wbr>iaq-core.c<br>
&gt; +++ b/drivers/iio/chemical/ams-<wbr>iaq-core.c<br>
&gt; @@ -163,7 +163,7 @@ static int ams_iaqcore_probe(struct i2c_client *cl=
ient,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&amp;data-&gt;lock);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;dev.parent =3D &amp;client-&gt=
;dev;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;ams_iaqcore_info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;ams_iaqcore_info;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;name =3D dev_name(&amp;client-=
&gt;dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<b=
r>
&gt;<br>
&gt; diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x=
.c<br>
&gt; index 8e0e4415c161..f75eea6822f2 100644<br>
&gt; --- a/drivers/iio/chemical/vz89x.c<br>
&gt; +++ b/drivers/iio/chemical/vz89x.c<br>
&gt; @@ -393,7 +393,7 @@ static int vz89x_probe(struct i2c_client *client,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&amp;data-&gt;lock);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;dev.parent =3D &amp;client-&gt=
;dev;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;vz89x_info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;vz89x_info;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;name =3D dev_name(&amp;client-=
&gt;dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<b=
r>
&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a113f89e296cf30054bf6f287--
