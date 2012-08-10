Return-Path: <sangwook.lee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F41EEF1F7@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F41EEF1F7@DQHE02.ent.ti.com>
Date: Fri, 10 Aug 2012 10:09:15 +0100
Message-ID: <CADPsn1afN-_67P08=4zwj-MX3z_98ftwF2XdSC1nVT9+D_uNgg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: add new lp8788 adc driver
From: Sangwook Lee <sangwook.lee@linaro.org>
To: "Kim, Milo" <Milo.Kim@ti.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "jic23@kernel.org" <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>
Content-Type: multipart/alternative; boundary=bcaec5299febc52efe04c6e5b21a
List-ID: <linux-iio@vger.kernel.org>

--bcaec5299febc52efe04c6e5b21a
Content-Type: text/plain; charset=ISO-8859-1

Hi Milo

Just nitpick.

On 10 August 2012 08:06, Kim, Milo <Milo.Kim@ti.com> wrote:

> Patch v2.
> (a) Use iio_priv() for private data rather than allocating data
> (b) Support raw and scale inferface for iio consumer
> (c) Make inline function for lp8788_adc_read_raw()
> (d) For better readability, use fixed number for shift and mask
>     rather than getting bits from channel scan type
> (e) Clean up the iio channel spec macro and use LP8788_CHAN(id, type) macro
>
>
[snip]


> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/mfd/lp8788.h>
>

How about sorting include files in alphabetical order ?



> +
> +/* register address */
> +#define LP8788_ADC_CONF                        0x60
> +#define LP8788_ADC_RAW                 0x61
> +#define LP8788_ADC_DONE                        0x63
> +
>

[snip]


> +#define START_ADC_CHANNEL              LPADC_VBATT_5P5
> +#define END_ADC_CHANNEL                        LPADC_MAX
> +#define ADC_CONV_START                 1
> +#define ADC_CONV_DELAY_US              100
> +
> +       /* retry until adc conversion is done */
> +       data = 0;
> +       while (retry--) {
> +               udelay(ADC_CONV_DELAY_US);
>

How about using usleep_range instead of udelay ?


Thanks
Sangwook



> +
> +               if (lp8788_read_byte(adc->lp, LP8788_ADC_DONE, &data))
> +                       goto err;
> +
> +               /* conversion done */
> +               if (data)
> +                       break;
> +       }
> +
> +
> +MODULE_DESCRIPTION("Texas Instruments LP8788 ADC Driver");
> +MODULE_AUTHOR("Milo Kim");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:lp8788-adc");
> --
> 1.7.2.5
>
> Best Regards,
> Milo
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--bcaec5299febc52efe04c6e5b21a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Milo<br><br>Just nitpick.<div><br><div class=3D"gmail_quote">On 10 Augus=
t 2012 08:06, Kim, Milo <span dir=3D"ltr">&lt;<a href=3D"mailto:Milo.Kim@ti=
.com" target=3D"_blank">Milo.Kim@ti.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
Patch v2.<br>
(a) Use iio_priv() for private data rather than allocating data<br>
(b) Support raw and scale inferface for iio consumer<br>
(c) Make inline function for lp8788_adc_read_raw()<br>
(d) For better readability, use fixed number for shift and mask<br>
=A0 =A0 rather than getting bits from channel scan type<br>
(e) Clean up the iio channel spec macro and use LP8788_CHAN(id, type) macro=
<br><br></blockquote><div><br></div><div>[snip]</div><div>=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">

+<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/slab.h&gt;<br>
+#include &lt;linux/err.h&gt;<br>
+#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/delay.h&gt;<br>
+#include &lt;linux/iio/iio.h&gt;<br>
+#include &lt;linux/iio/driver.h&gt;<br>
+#include &lt;linux/mfd/lp8788.h&gt;<br>
</blockquote><div><br></div><div>How about sorting include files in alphabe=
tical order ?</div><div>=A0</div><div>=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
+<br>
+/* register address */<br>
+#define LP8788_ADC_CONF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6=
0<br>
+#define LP8788_ADC_RAW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x61<br>
+#define LP8788_ADC_DONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x6=
3<br>
+<br></blockquote><div><br></div><div>[snip]</div><div>=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
+#define START_ADC_CHANNEL =A0 =A0 =A0 =A0 =A0 =A0 =A0LPADC_VBATT_5P5<br>
+#define END_ADC_CHANNEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LPA=
DC_MAX<br>
+#define ADC_CONV_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1<br>
+#define ADC_CONV_DELAY_US =A0 =A0 =A0 =A0 =A0 =A0 =A0100<br>+<br>
+ =A0 =A0 =A0 /* retry until adc conversion is done */<br>
+ =A0 =A0 =A0 data =3D 0;<br>
+ =A0 =A0 =A0 while (retry--) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(ADC_CONV_DELAY_US);<br>
</blockquote><div><br></div><div>How about using usleep_range instead of ud=
elay ?</div><div><br></div><div><br></div><div>Thanks</div><div>Sangwook</d=
iv><div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lp8788_read_byte(adc-&gt;lp, LP8788_ADC_D=
ONE, &amp;data))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* conversion done */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+<br>+<br>
+MODULE_DESCRIPTION(&quot;Texas Instruments LP8788 ADC Driver&quot;);<br>
+MODULE_AUTHOR(&quot;Milo Kim&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
+MODULE_ALIAS(&quot;platform:lp8788-adc&quot;);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.2.5<br>
<br>
Best Regards,<br>
Milo<br>
<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</font></span></blockquote></div><br></div>

--bcaec5299febc52efe04c6e5b21a--
