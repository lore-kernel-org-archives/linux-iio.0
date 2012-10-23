Return-Path: <dbasehore@google.com>
MIME-Version: 1.0
In-Reply-To: <5082739E.1000800@kernel.org>
References: <1349394896-4856-1-git-send-email-dbasehore@chromium.org>
	<5082739E.1000800@kernel.org>
Date: Tue, 23 Oct 2012 14:47:32 -0700
Message-ID: <CAGAzgsqN5J7Ot4NGOHW8E=38TjDYUBooJMXVYyd2obXdC5rABQ@mail.gmail.com>
Subject: Re: [PATCH] tsl2563: fixed bug with disabling interrupts
From: Derek Basehore <dbasehore@google.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: jic23@cam.ac.uk, bleung@chromium.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jon Brenner - TAOS <jbrenner@taosinc.com>
Content-Type: multipart/alternative; boundary=f46d04448159d0d91204ccc0eab5
List-ID: <linux-iio@vger.kernel.org>

--f46d04448159d0d91204ccc0eab5
Content-Type: text/plain; charset=ISO-8859-1

Here's the link to the data sheet

http://cfnewsads.thomasnet.com/pnn-pdf/478523.pdf

We don't actually use this functionality for the ambient light sensor, so
it's untested right now. I just happened to notice this while reading
through the driver. The register in question has specifics starting on page
15.

Thanks


On Sat, Oct 20, 2012 at 2:49 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> cc'd iio mailing list and Jon Brenner.
> Being lazy I haven't dug out the datahsheet to check this (my board has a
> broken
> track to the interrupt line so can't easily test this!)
>
> > In tsl_2563_write_interrupt_config and tsl2562_remove, interrupts are not
> > disabled where they should be. This seems to be from a mistake of using
> |=
> > instead of &= in 2 lines of code.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  drivers/staging/iio/light/tsl2563.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/iio/light/tsl2563.c
> b/drivers/staging/iio/light/tsl2563.c
> > index 954ca2c..3f72543 100644
> > --- a/drivers/staging/iio/light/tsl2563.c
> > +++ b/drivers/staging/iio/light/tsl2563.c
> > @@ -652,7 +652,7 @@ static int tsl2563_write_interrupt_config(struct
> iio_dev *indio_dev,
> >       }
> >
> >       if (!state && (chip->intr & 0x30)) {
> > -             chip->intr |= ~0x30;
> > +             chip->intr &= ~0x30;
> >               ret = i2c_smbus_write_byte_data(chip->client,
> >                                               TSL2563_CMD |
> TSL2563_REG_INT,
> >                                               chip->intr);
> > @@ -814,7 +814,7 @@ static int __devexit tsl2563_remove(struct
> i2c_client *client)
> >       if (!chip->int_enabled)
> >               cancel_delayed_work(&chip->poweroff_work);
> >       /* Ensure that interrupts are disabled - then flush any bottom
> halves */
> > -     chip->intr |= ~0x30;
> > +     chip->intr &= ~0x30;
> >       i2c_smbus_write_byte_data(chip->client, TSL2563_CMD |
> TSL2563_REG_INT,
> >                                 chip->intr);
> >       flush_scheduled_work();
> >
>



-- 
Derek

--f46d04448159d0d91204ccc0eab5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here&#39;s the link to the data sheet<div><br></div><div><a href=3D"http://=
cfnewsads.thomasnet.com/pnn-pdf/478523.pdf">http://cfnewsads.thomasnet.com/=
pnn-pdf/478523.pdf</a><br></div><div><br></div><div>We don&#39;t actually u=
se this functionality for the ambient light sensor, so it&#39;s untested ri=
ght now. I just happened to notice this while reading through the driver. T=
he register in question has specifics starting on page 15.</div>
<div><br></div><div>Thanks</div><div class=3D"gmail_extra"><br><br><div cla=
ss=3D"gmail_quote">On Sat, Oct 20, 2012 at 2:49 AM, Jonathan Cameron <span =
dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23=
@kernel.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">cc&#39;d iio mailing list and Jon Brenner.<b=
r>
Being lazy I haven&#39;t dug out the datahsheet to check this (my board has=
 a broken<br>
track to the interrupt line so can&#39;t easily test this!)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; In tsl_2563_write_interrupt_config and tsl2562_remove, interrupts are =
not<br>
&gt; disabled where they should be. This seems to be from a mistake of usin=
g |=3D<br>
&gt; instead of &amp;=3D in 2 lines of code.<br>
&gt;<br>
&gt; Signed-off-by: Derek Basehore &lt;<a href=3D"mailto:dbasehore@chromium=
.org">dbasehore@chromium.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/staging/iio/light/tsl2563.c | =A0 =A04 ++--<br>
&gt; =A01 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio=
/light/tsl2563.c<br>
&gt; index 954ca2c..3f72543 100644<br>
&gt; --- a/drivers/staging/iio/light/tsl2563.c<br>
&gt; +++ b/drivers/staging/iio/light/tsl2563.c<br>
&gt; @@ -652,7 +652,7 @@ static int tsl2563_write_interrupt_config(struct i=
io_dev *indio_dev,<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (!state &amp;&amp; (chip-&gt;intr &amp; 0x30)) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 chip-&gt;intr |=3D ~0x30;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 chip-&gt;intr &amp;=3D ~0x30;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(chip-&gt=
;client,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 TSL2563_CMD | TSL2563_REG_INT,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 chip-&gt;intr);<br>
&gt; @@ -814,7 +814,7 @@ static int __devexit tsl2563_remove(struct i2c_cli=
ent *client)<br>
&gt; =A0 =A0 =A0 if (!chip-&gt;int_enabled)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&amp;chip-&gt;poweroff=
_work);<br>
&gt; =A0 =A0 =A0 /* Ensure that interrupts are disabled - then flush any bo=
ttom halves */<br>
&gt; - =A0 =A0 chip-&gt;intr |=3D ~0x30;<br>
&gt; + =A0 =A0 chip-&gt;intr &amp;=3D ~0x30;<br>
&gt; =A0 =A0 =A0 i2c_smbus_write_byte_data(chip-&gt;client, TSL2563_CMD | T=
SL2563_REG_INT,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip-&=
gt;intr);<br>
&gt; =A0 =A0 =A0 flush_scheduled_work();<br>
&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Derek<br>
</div>

--f46d04448159d0d91204ccc0eab5--
