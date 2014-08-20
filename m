Return-Path: <sanjeevsharmaengg@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53F3A441.1040103@kernel.org>
References: <32522124850adfda5c6cb8a7759d0e3a63893c1e.1407931250.git.michal.simek@xilinx.com>
	<53F3A441.1040103@kernel.org>
Date: Wed, 20 Aug 2014 13:08:35 +0530
Message-ID: <CAGUYZuTgySMqXJQVxDa+oKNMLJmTu4pG3wYEAop=HmpQ4XbhoA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: xilinx: Remove .owner field for driver
From: sanjeev sharma <sanjeevsharmaengg@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel <linux-kernel@vger.kernel.org>,
	monstr@monstr.eu, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary=089e0149c0b017999a05010ab16a
List-ID: <linux-iio@vger.kernel.org>

--089e0149c0b017999a05010ab16a
Content-Type: text/plain; charset=UTF-8

Hi Jonathan & Michael,

There are so many occurrences in IIO directory of this .owner filed and we
need to cleanup everywhere.

Regards
Sanjeev Sharma


On Wed, Aug 20, 2014 at 12:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 13/08/14 13:00, Michal Simek wrote:
> > There is no need to init .owner field.
> >
> > Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> > "mmc: remove .owner field for drivers using module_platform_driver"
> >
> > This patch removes the superflous .owner field for drivers which
> > use the module_platform_driver API, as this is overriden in
> > platform_driver_register anyway."
> >
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Applied to the togreg branch of iio.git
>
> Thanks,
>
> Jonathan
> > ---
> >
> >  drivers/iio/adc/xilinx-xadc-core.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c
> b/drivers/iio/adc/xilinx-xadc-core.c
> > index fd2745c62943..92541a80b041 100644
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -1322,7 +1322,6 @@ static struct platform_driver xadc_driver = {
> >       .remove = xadc_remove,
> >       .driver = {
> >               .name = "xadc",
> > -             .owner = THIS_MODULE,
> >               .of_match_table = xadc_of_match_table,
> >       },
> >  };
> > --
> > 1.8.2.3
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--089e0149c0b017999a05010ab16a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Jonathan &amp; Michael,<br><br></div>There ar=
e so many occurrences in IIO directory of this .owner filed and we need to =
cleanup everywhere.<br><br></div>Regards<br>Sanjeev Sharma<br></div><div cl=
ass=3D"gmail_extra">
<br><br><div class=3D"gmail_quote">On Wed, Aug 20, 2014 at 12:53 AM, Jonath=
an Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.org" target=
=3D"_blank">jic23@kernel.org</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<div class=3D"">On 13/08/14 13:00, Michal Simek wrote:<br>
&gt; There is no need to init .owner field.<br>
&gt;<br>
&gt; Based on the patch from Peter Griffin &lt;<a href=3D"mailto:peter.grif=
fin@linaro.org">peter.griffin@linaro.org</a>&gt;<br>
&gt; &quot;mmc: remove .owner field for drivers using module_platform_drive=
r&quot;<br>
&gt;<br>
&gt; This patch removes the superflous .owner field for drivers which<br>
&gt; use the module_platform_driver API, as this is overriden in<br>
&gt; platform_driver_register anyway.&quot;<br>
&gt;<br>
&gt; Signed-off-by: Michal Simek &lt;<a href=3D"mailto:michal.simek@xilinx.=
com">michal.simek@xilinx.com</a>&gt;<br>
</div>Applied to the togreg branch of iio.git<br>
<br>
Thanks,<br>
<br>
Jonathan<br>
<div class=3D"">&gt; ---<br>
&gt;<br>
&gt;=C2=A0 drivers/iio/adc/xilinx-xadc-core.c | 1 -<br>
&gt;=C2=A0 1 file changed, 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xili=
nx-xadc-core.c<br>
&gt; index fd2745c62943..92541a80b041 100644<br>
&gt; --- a/drivers/iio/adc/xilinx-xadc-core.c<br>
&gt; +++ b/drivers/iio/adc/xilinx-xadc-core.c<br>
&gt; @@ -1322,7 +1322,6 @@ static struct platform_driver xadc_driver =3D {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D xadc_remove,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;=
xadc&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODUL=
E,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =
=3D xadc_of_match_table,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 };<br>
&gt; --<br>
&gt; 1.8.2.3<br>
&gt;<br>
</div>--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at=C2=A0 <a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</blockquote></div><br></div>

--089e0149c0b017999a05010ab16a--
