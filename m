Return-Path: <SRS0=d+vi=5K=google.com=raltherr@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170603095018.0d0f680b@kernel.org>
References: <4d7cbfdca6b7e89a312a08dad6c49b3289299bd8.1496041572.git.arvind.yadav.cs@gmail.com>
 <20170603095018.0d0f680b@kernel.org>
From: Rick Altherr <raltherr@google.com>
Date: Mon, 5 Jun 2017 09:56:25 -0700
Message-ID: <CAPLgG=ntKrR=fvQKa=Z+CE0Ey3ELnGckfyWm4z_UpVN3h=dvcw@mail.gmail.com>
Subject: Re: [PATCH] iio: Aspeed ADC - Handle return value of clk_prepare_enable
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="001a1144fc822fee2f055139625f"
List-ID: <linux-iio@vger.kernel.org>

--001a1144fc822fee2f055139625f
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Rick Altherr <raltherr@google.com>

On Sat, Jun 3, 2017 at 1:50 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 29 May 2017 13:12:12 +0530
> Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>
> > clk_prepare_enable() can fail here and we must check its return value.
> >
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Please make sure to cc the driver author.  This is a fairly new
> driver, so chances are Rick will still be answering this email
> address.
>
> Patch looks fine to me, but I would like to give Rick the opportunity
> to respond.
>
> Jonathan
> > ---
> >  drivers/iio/adc/aspeed_adc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> > index 62670cb..e0ea411 100644
> > --- a/drivers/iio/adc/aspeed_adc.c
> > +++ b/drivers/iio/adc/aspeed_adc.c
> > @@ -212,7 +212,10 @@ static int aspeed_adc_probe(struct platform_device
> *pdev)
> >       }
> >
> >       /* Start all channels in normal mode. */
> > -     clk_prepare_enable(data->clk_scaler->clk);
> > +     ret = clk_prepare_enable(data->clk_scaler->clk);
> > +     if (ret)
> > +             goto clk_enable_error;
> > +
> >       adc_engine_control_reg_val = GENMASK(31, 16) |
> >               ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
> >       writel(adc_engine_control_reg_val,
> > @@ -236,6 +239,7 @@ static int aspeed_adc_probe(struct platform_device
> *pdev)
> >       writel(ASPEED_OPERATION_MODE_POWER_DOWN,
> >               data->base + ASPEED_REG_ENGINE_CONTROL);
> >       clk_disable_unprepare(data->clk_scaler->clk);
> > +clk_enable_error:
> >       clk_hw_unregister_divider(data->clk_scaler);
> >
> >  scaler_error:
>
>

--001a1144fc822fee2f055139625f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Rick Altherr &lt;<a href=3D"mailto:raltherr@g=
oogle.com">raltherr@google.com</a>&gt;</div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Sat, Jun 3, 2017 at 1:50 AM, Jonathan Cameron=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank=
">jic23@kernel.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Mon, 29 May 2017 13:12:12 +0530<br>
Arvind Yadav &lt;<a href=3D"mailto:arvind.yadav.cs@gmail.com">arvind.yadav.=
cs@gmail.com</a>&gt; wrote:<br>
<br>
&gt; clk_prepare_enable() can fail here and we must check its return value.=
<br>
&gt;<br>
&gt; Signed-off-by: Arvind Yadav &lt;<a href=3D"mailto:arvind.yadav.cs@gmai=
l.com">arvind.yadav.cs@gmail.com</a>&gt;<br>
Please make sure to cc the driver author.=C2=A0 This is a fairly new<br>
driver, so chances are Rick will still be answering this email<br>
address.<br>
<br>
Patch looks fine to me, but I would like to give Rick the opportunity<br>
to respond.<br>
<br>
Jonathan<br>
&gt; ---<br>
&gt;=C2=A0 drivers/iio/adc/aspeed_adc.c | 6 +++++-<br>
&gt;=C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc=
.c<br>
&gt; index 62670cb..e0ea411 100644<br>
&gt; --- a/drivers/iio/adc/aspeed_adc.c<br>
&gt; +++ b/drivers/iio/adc/aspeed_adc.c<br>
&gt; @@ -212,7 +212,10 @@ static int aspeed_adc_probe(struct platform_devic=
e *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Start all channels in normal mode. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0clk_prepare_enable(data-&gt;clk_<wbr>scaler-&gt;c=
lk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(data-&gt;clk_<wbr>scal=
er-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto clk_enable_error=
;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adc_engine_control_reg_val =3D GENMASK(31, 1=
6) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ASPEED_OPERATION=
_MODE_NORMAL | ASPEED_ENGINE_ENABLE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(adc_engine_control_reg_<wbr>val,<br>
&gt; @@ -236,6 +239,7 @@ static int aspeed_adc_probe(struct platform_device=
 *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(ASPEED_OPERATION_MODE_<wbr>POWER_DOWN=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;base + =
ASPEED_REG_ENGINE_CONTROL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(data-&gt;<wbr>clk_scal=
er-&gt;clk);<br>
&gt; +clk_enable_error:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_hw_unregister_divider(<wbr>data-&gt;clk_=
scaler);<br>
&gt;<br>
&gt;=C2=A0 scaler_error:<br>
<br>
</blockquote></div><br></div>

--001a1144fc822fee2f055139625f--
