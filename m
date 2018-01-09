Return-Path: <SRS0=JWWH=EE=gmail.com=mastichi@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALieaecOxkh+SCnYA_ScoaKeRbYTdbKy7PH0=SuxcT3GEn3-Hw@mail.gmail.com>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
 <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com>
 <20171229175449.760e734d@archlinux> <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
 <20180101095342.4d4d5325@archlinux> <CALieaecknYWjOvUuD_Qhaepj0fwGBCPX0pcT3pgNTnLQ17WMSA@mail.gmail.com>
 <20180106131434.550e8e42@archlinux> <CALieaefJ-dPNMydGZD-jCC66gRs1SGqFNNs__y9BWyC05g5bqQ@mail.gmail.com>
 <20180107160820.05660804@archlinux> <CALieaecOxkh+SCnYA_ScoaKeRbYTdbKy7PH0=SuxcT3GEn3-Hw@mail.gmail.com>
From: Dmitry Mastykin <mastichi@gmail.com>
Date: Tue, 9 Jan 2018 23:46:14 +0300
Message-ID: <CALieaee0+2M34p=1FdSeBnz78G1xDMORKGTFu13irATsNpA+NA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: max9611: fix module auto-loading
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>, Dan Carpenter <dan.carpenter@oracle.com>,
	Rob Herring <robh@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="001a1148e4fc85ea6d05625e0131"
List-ID: <linux-iio@vger.kernel.org>

--001a1148e4fc85ea6d05625e0131
Content-Type: text/plain; charset="UTF-8"

Hello Johnatan,
I think the issue is the same as Javier Martinez Canillas wrote:
"What is not correct is to require OF-only drivers to have an I2C
device ID table just as a workaround to have their modules auto-loading
working."
Please see: http://lkml.iu.edu/hypermail/linux/kernel/1712.0/01779.html
So the problem is not in driver, but in auto-loading procedure.

Kind regards,
Dmitry



>> >> >> >> > Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
>
> >> >> >> >> > ---
> >> >> >> >> >  drivers/iio/adc/max9611.c | 5 ++---
> >> >> >> >> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >> >> >> >> >
> >> >> >> >> > diff --git a/drivers/iio/adc/max9611.c
> b/drivers/iio/adc/max9611.c
> >> >> >> >> > index b1dd17c..ce0115a 100644
> >> >> >> >> > --- a/drivers/iio/adc/max9611.c
> >> >> >> >> > +++ b/drivers/iio/adc/max9611.c
> >> >> >> >> > @@ -523,8 +523,7 @@ static const struct of_device_id
> max9611_of_table[] = {
> >> >> >> >> >  };
> >> >> >> >> >
> >> >> >> >> >  MODULE_DEVICE_TABLE(of, max9611_of_table);
> >> >> >> >> > -static int max9611_probe(struct i2c_client *client,
> >> >> >> >> > -                        const struct i2c_device_id *id)
> >> >> >> >> > +static int max9611_probe(struct i2c_client *client)
> >> >> >> >> >  {
> >> >> >> >> >         const char * const shunt_res_prop =
> "shunt-resistor-micro-ohms";
> >> >> >> >> >         const struct device_node *of_node =
> client->dev.of_node;
> >> >> >> >> > @@ -576,7 +575,7 @@ static struct i2c_driver max9611_driver
> = {
> >> >> >> >> >                    .owner = THIS_MODULE,
> >> >> >> >> >                    .of_match_table = max9611_of_table,
> >> >> >> >> >         },
> >> >> >> >> > -       .probe = max9611_probe,
> >> >> >> >> > +       .probe_new = max9611_probe,
> >> >> >> >> >  };
> >> >> >> >> >  module_i2c_driver(max9611_driver);
> >> >> >> >> >
> >> >> >> >> > --
> >> >> >> >> > 2.7.4
> >> >> >> >> >
> >> >> >
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>

--001a1148e4fc85ea6d05625e0131
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Johnatan,<div>I think the issue is the same as Javier Martinez Canill=
as wrote:</div><div><div>&quot;What is not correct is to require OF-only dr=
ivers to have an I2C</div><div>device ID table just as a workaround to have=
 their modules auto-loading working.&quot;</div>Please see: <a href=3D"http=
://lkml.iu.edu/hypermail/linux/kernel/1712.0/01779.html">http://lkml.iu.edu=
/hypermail/linux/kernel/1712.0/01779.html</a></div><div>So the problem is n=
ot in driver, but in auto-loading procedure.</div><div><br></div><div>Kind =
regards,</div><div>Dmitry</div><div><br></div><div><span style=3D"font-size=
:15px"><br></span></div><div><span style=3D"font-size:15px"><br></span></di=
v><div><span style=3D"font-size:15px">&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &=
gt; Signed-off-by: Dmitry Mastykin &lt;</span><a href=3D"mailto:mastichi@gm=
ail.com" style=3D"font-size:15px">mastichi@gmail.com</a><span style=3D"font=
-size:15px">&gt;</span><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; ---<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 drivers/iio/adc/max9611.c | =
5 ++---<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 1 file changed, 2 insertions=
(+), 3 deletions(-)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; diff --git a/drivers/iio/adc/max96=
11.c b/drivers/iio/adc/max9611.c<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; index b1dd17c..ce0115a 100644<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; --- a/drivers/iio/adc/max9611.c<br=
>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; +++ b/drivers/iio/adc/max9611.c<br=
>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; @@ -523,8 +523,7 @@ static const s=
truct of_device_id max9611_of_table[] =3D {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 MODULE_DEVICE_TABLE(of, max9=
611_of_table);<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; -static int max9611_probe(struct i=
2c_client *client,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct i2c_devic=
e_id *id)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; +static int max9611_probe(struct i=
2c_client *client)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
onst char * const shunt_res_prop =3D &quot;shunt-resistor-micro-ohms&quot;;=
<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
onst struct device_node *of_node =3D client-&gt;dev.of_node;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; @@ -576,7 +575,7 @@ static struct =
i2c_driver max9611_driver =3D {<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODULE,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D max9611_of_table,<br=
>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe=
 =3D max9611_probe,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe=
_new =3D max9611_probe,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 };<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;=C2=A0 module_i2c_driver(max9611_<w=
br>driver);<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; --<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt; 2.7.4<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; --<br>
&gt;&gt; To unsubscribe from this list: send the line &quot;unsubscribe lin=
ux-iio&quot; in<br>
&gt;&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.o=
rg">majordomo@vger.kernel.org</a><br>
&gt;&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/maj=
ordomo-info.html" target=3D"_blank">http://vger.kernel.org/<wbr>majordomo-i=
nfo.html</a><br>
&gt;<br>
</blockquote></div>

--001a1148e4fc85ea6d05625e0131--
