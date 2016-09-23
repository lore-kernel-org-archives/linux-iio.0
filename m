Return-Path: <bankarsandhya512@gmail.com>
MIME-Version: 1.0
Reply-To: bankarsandhya512@gmail.com
In-Reply-To: <cdae23c1-66de-6ad7-6f4a-059a78c652f3@metafoo.de>
References: <20160923061312.GA5050@localhost.localdomain> <cdae23c1-66de-6ad7-6f4a-059a78c652f3@metafoo.de>
From: sandhya bankar <bankarsandhya512@gmail.com>
Date: Sat, 24 Sep 2016 01:18:28 +0530
Message-ID: <CAA3ASz=0rZ7-rJ3muhicfapgNhUHJOmC=7QjWGJJt3cGSCgCxw@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: max1027: Fix sparse warning: "dubious: x | !y"
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Daniel Baluta <Daniel.baluta@gmail.com>, Alison Schofield <amsfield22@gmail.com>
Content-Type: multipart/alternative; boundary=001a1146f078f7d440053d320fe9
List-ID: <linux-iio@vger.kernel.org>

--001a1146f078f7d440053d320fe9
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 23, 2016 at 8:52 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 09/23/2016 08:13 AM, Sandhya Bankar wrote:
> > Fixing below warning:
> > drivers/iio/adc/max1027.c:241:34: warning: dubious: x | !y .
> >
> > Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
>
> Hi,
>
> Thanks for the patch. Looks good in general, just one minor detail
>
>
Thanks for review !

 I will incorporate your suggestion and send new patch.


Thanks,
Sandhya


> > ---
> >  drivers/iio/adc/max1027.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index 712fbd2..b1fee47 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -238,7 +238,9 @@ static int max1027_read_single_value(struct iio_dev
> *indio_dev,
> >
> >       /* Configure conversion register with the requested chan */
> >       st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
> > -               MAX1027_NOSCAN | !!(chan->type == IIO_TEMP);
> > +               MAX1027_NOSCAN;
> > +     if (chan->type == IIO_TEMP)
> > +             st->reg |= 1;
>
> The driver has a symbolic constant defined for this 'MAX1027_TEMP'. Using
> this instead of the number makes it clear what the semantic meaning of the
> value is.
>
>

--001a1146f078f7d440053d320fe9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Sep 23, 2016 at 8:52 PM, Lars-Peter Clausen <span dir=3D"ltr">&=
lt;<a href=3D"mailto:lars@metafoo.de" target=3D"_blank">lars@metafoo.de</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 09=
/23/2016 08:13 AM, Sandhya Bankar wrote:<br>
&gt; Fixing below warning:<br>
&gt; drivers/iio/adc/max1027.c:241:<wbr>34: warning: dubious: x | !y .<br>
&gt;<br>
&gt; Signed-off-by: Sandhya Bankar &lt;<a href=3D"mailto:bankarsandhya512@g=
mail.com">bankarsandhya512@gmail.com</a>&gt;<br>
<br>
</span>Hi,<br>
<br>
Thanks for the patch. Looks good in general, just one minor detail<br>
<span class=3D""><br></span></blockquote><div><br></div><div>Thanks for rev=
iew !<br><br>=C2=A0I will incorporate your suggestion and send new patch.<b=
r><br><br></div><div>Thanks,<br></div><div>Sandhya<br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><span class=3D"">
&gt; ---<br>
&gt;=C2=A0 drivers/iio/adc/max1027.c | 4 +++-<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c<br>
&gt; index 712fbd2..b1fee47 100644<br>
&gt; --- a/drivers/iio/adc/max1027.c<br>
&gt; +++ b/drivers/iio/adc/max1027.c<br>
&gt; @@ -238,7 +238,9 @@ static int max1027_read_single_value(<wbr>struct i=
io_dev *indio_dev,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Configure conversion register with the re=
quested chan */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0st-&gt;reg =3D MAX1027_CONV_REG | MAX1027_CH=
AN(chan-&gt;channel) |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX1027_NOSCAN=
 | !!(chan-&gt;type =3D=3D IIO_TEMP);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAX1027_NOSCAN=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (chan-&gt;type =3D=3D IIO_TEMP)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st-&gt;reg |=3D 1;<br=
>
<br>
</span>The driver has a symbolic constant defined for this &#39;MAX1027_TEM=
P&#39;. Using<br>
this instead of the number makes it clear what the semantic meaning of the<=
br>
value is.<br>
<br>
</blockquote></div><br></div></div>

--001a1146f078f7d440053d320fe9--
