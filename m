Return-Path: <sanjeevsharmaengg@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1422866120-10442-1-git-send-email-hofrat@osadl.org>
References: <1422866120-10442-1-git-send-email-hofrat@osadl.org>
Date: Fri, 6 Feb 2015 11:35:50 +0530
Message-ID: <CAGUYZuQ2zoH+EZ1PbwRtoSS_WE7MzqaNe1aSENp50yE0dzW1-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: vf610_adc: cleanup wait_for_completion return handling
From: sanjeev sharma <sanjeevsharmaengg@gmail.com>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Fabio Estevam <fabio.estevam@freescale.com>, Fugang Duan <B38611@freescale.com>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>, Sanchayan Maity <maitysanchayan@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a11c30a0661ac75050e653618
List-ID: <linux-iio@vger.kernel.org>

--001a11c30a0661ac75050e653618
Content-Type: text/plain; charset=UTF-8

On Mon, Feb 2, 2015 at 2:05 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:

> return type of wait_for_completion_timeout is unsigned long not int, this
> patch only fixes up the return handling.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>
Reviewed-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>

> ---
>  drivers/iio/adc/vf610_adc.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> Rather than changing timeout to unsigned long it can be moved into the
> if condition and dropped.
>
> Patch was compile tested only for imx_v6_v7_defconfig + CONFIG_IIO=m,
> CONFIG_VF610_ADC=m
>
> Patch is against 3.19.0-rc6 -next-20150130
>
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 8ec353c..5b72d17 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -259,7 +259,6 @@ static void vf610_adc_cfg_post_set(struct vf610_adc
> *info)
>  static void vf610_adc_calibration(struct vf610_adc *info)
>  {
>         int adc_gc, hc_cfg;
> -       int timeout;
>
>         if (!info->adc_feature.calibration)
>                 return;
> @@ -271,9 +270,7 @@ static void vf610_adc_calibration(struct vf610_adc
> *info)
>         adc_gc = readl(info->regs + VF610_REG_ADC_GC);
>         writel(adc_gc | VF610_ADC_CAL, info->regs + VF610_REG_ADC_GC);
>
> -       timeout = wait_for_completion_timeout
> -                       (&info->completion, VF610_ADC_TIMEOUT);
> -       if (timeout == 0)
> +       if (!wait_for_completion_timeout(&info->completion,
> VF610_ADC_TIMEOUT))
>                 dev_err(info->dev, "Timeout for adc calibration\n");
>
>         adc_gc = readl(info->regs + VF610_REG_ADC_GS);
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--001a11c30a0661ac75050e653618
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, Feb 2, 2015 at 2:05 PM, Nicholas Mc Guire <span di=
r=3D"ltr">&lt;<a href=3D"mailto:hofrat@osadl.org" target=3D"_blank">hofrat@=
osadl.org</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">return type=
 of wait_for_completion_timeout is unsigned long not int, this<br>
patch only fixes up the return handling.<br>
<br>
Signed-off-by: Nicholas Mc Guire &lt;<a href=3D"mailto:hofrat@osadl.org">ho=
frat@osadl.org</a>&gt;<br></blockquote><div>Reviewed-by: Sanjeev Sharma &lt=
;<a href=3D"mailto:sanjeev_sharma@mentor.com">sanjeev_sharma@mentor.com</a>=
&gt; <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0drivers/iio/adc/vf610_adc.c |=C2=A0 =C2=A0 5 +----<br>
=C2=A01 file changed, 1 insertion(+), 4 deletions(-)<br>
<br>
Rather than changing timeout to unsigned long it can be moved into the<br>
if condition and dropped.<br>
<br>
Patch was compile tested only for imx_v6_v7_defconfig + CONFIG_IIO=3Dm,<br>
CONFIG_VF610_ADC=3Dm<br>
<br>
Patch is against 3.19.0-rc6 -next-20150130<br>
<br>
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c<br>
index 8ec353c..5b72d17 100644<br>
--- a/drivers/iio/adc/vf610_adc.c<br>
+++ b/drivers/iio/adc/vf610_adc.c<br>
@@ -259,7 +259,6 @@ static void vf610_adc_cfg_post_set(struct vf610_adc *in=
fo)<br>
=C2=A0static void vf610_adc_calibration(struct vf610_adc *info)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int adc_gc, hc_cfg;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int timeout;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!info-&gt;adc_feature.calibration)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
@@ -271,9 +270,7 @@ static void vf610_adc_calibration(struct vf610_adc *inf=
o)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adc_gc =3D readl(info-&gt;regs + VF610_REG_ADC_=
GC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(adc_gc | VF610_ADC_CAL, info-&gt;regs + =
VF610_REG_ADC_GC);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0timeout =3D wait_for_completion_timeout<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(&amp;info-&gt;completion, VF610_ADC_TIMEOUT);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wait_for_completion_timeout(&amp;info-&gt;=
completion, VF610_ADC_TIMEOUT))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(info-&gt;de=
v, &quot;Timeout for adc calibration\n&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adc_gc =3D readl(info-&gt;regs + VF610_REG_ADC_=
GS);<br>
<span class=3D""><font color=3D"#888888">--<br>
1.7.10.4<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at=C2=A0 <a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</font></span></blockquote></div><br></div></div>

--001a11c30a0661ac75050e653618--
