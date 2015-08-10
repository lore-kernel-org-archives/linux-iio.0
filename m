Return-Path: <adam.yh.lee@gmail.com>
MIME-Version: 1.0
References: <1438712148-27004-1-git-send-email-adam.yh.lee@gmail.com>
 <1438712148-27004-2-git-send-email-adam.yh.lee@gmail.com> <55C61D22.7080604@kernel.org>
In-Reply-To: <55C61D22.7080604@kernel.org>
From: Adam Lee <adam.yh.lee@gmail.com>
Date: Mon, 10 Aug 2015 16:56:27 +0000
Message-ID: <CAFeBWL5JT=+X9SCwRefn8L9Epx_c0yaizS5=1W4eq_O3Fpg7Lg@mail.gmail.com>
Subject: Re: [V4] [TWL4030 MADC] Fix ADC[3:6] readings
To: Jonathan Cameron <jic23@kernel.org>, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: sre@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, j-keerthy@ti.com,
	Sebastian Reichel <sre@debian.org>
Content-Type: multipart/alternative; boundary=94eb2c035a5065c8d2051cf7dec0
List-ID: <linux-iio@vger.kernel.org>

--94eb2c035a5065c8d2051cf7dec0
Content-Type: text/plain; charset=UTF-8

Yes I will do a better job in following the patch submission conventions.
Thanks for your comment Jonathan.

@Sebastian, let me know if you have any concerns with the patch.



On Sat, Aug 8, 2015 at 8:15 AM Jonathan Cameron <jic23@kernel.org> wrote:

> On 04/08/15 19:15, Adam YH Lee wrote:
> > MADC[3:6] reads incorrect values without these two following changes:
> >
> > - enable the 3v1 bias regulator for ADC[3:6]
> > - configure ADC[3:6] lines as input, not as USB
> >
> > Signed-off-by: Adam YH Lee <adam.yh.lee@gmail.com>
> I'd ideally like an ack from the driver author or Sebastian as this isn't
> a driver I'm particular familiar with.
>
> Also, for future reference, patches should be titled something like
> [Patch v4] iio: twl4030 madc: Fix ADC[3:6] readings.
> (the patch bit is standard, the rest is iio convention)
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/twl4030-madc.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/drivers/iio/adc/twl4030-madc.c
> b/drivers/iio/adc/twl4030-madc.c
> > index 94c5f05..8c58498 100644
> > --- a/drivers/iio/adc/twl4030-madc.c
> > +++ b/drivers/iio/adc/twl4030-madc.c
> > @@ -45,13 +45,18 @@
> >  #include <linux/types.h>
> >  #include <linux/gfp.h>
> >  #include <linux/err.h>
> > +#include <linux/regulator/consumer.h>
> >
> >  #include <linux/iio/iio.h>
> >
> > +#define TWL4030_USB_SEL_MADC_MCPC    (1<<3)
> > +#define TWL4030_USB_CARKIT_ANA_CTRL  0xBB
> > +
> >  /**
> >   * struct twl4030_madc_data - a container for madc info
> >   * @dev:             Pointer to device structure for madc
> >   * @lock:            Mutex protecting this data structure
> > + * @regulator:               Pointer to bias regulator for madc
> >   * @requests:                Array of request struct corresponding to
> SW1, SW2 and RT
> >   * @use_second_irq:  IRQ selection (main or co-processor)
> >   * @imr:             Interrupt mask register of MADC
> > @@ -60,6 +65,7 @@
> >  struct twl4030_madc_data {
> >       struct device *dev;
> >       struct mutex lock;      /* mutex protecting this data structure */
> > +     struct regulator *usb3v1;
> >       struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
> >       bool use_second_irq;
> >       u8 imr;
> > @@ -842,6 +848,32 @@ static int twl4030_madc_probe(struct
> platform_device *pdev)
> >       }
> >       twl4030_madc = madc;
> >
> > +     /* Configure MADC[3:6] */
> > +     ret = twl_i2c_read_u8(TWL_MODULE_USB, &regval,
> > +                     TWL4030_USB_CARKIT_ANA_CTRL);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "unable to read reg CARKIT_ANA_CTRL
> 0x%X\n",
> > +                             TWL4030_USB_CARKIT_ANA_CTRL);
> > +             goto err_i2c;
> > +     }
> > +     regval |= TWL4030_USB_SEL_MADC_MCPC;
> > +     ret = twl_i2c_write_u8(TWL_MODULE_USB, regval,
> > +                              TWL4030_USB_CARKIT_ANA_CTRL);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "unable to write reg CARKIT_ANA_CTRL
> 0x%X\n",
> > +                             TWL4030_USB_CARKIT_ANA_CTRL);
> > +             goto err_i2c;
> > +     }
> > +
> > +     /* Enable 3v1 bias regulator for MADC[3:6] */
> > +     madc->usb3v1 = devm_regulator_get(madc->dev, "vusb3v1");
> > +     if (IS_ERR(madc->usb3v1))
> > +             return -ENODEV;
> > +
> > +     ret = regulator_enable(madc->usb3v1);
> > +     if (ret)
> > +             dev_err(madc->dev, "could not enable 3v1 bias
> regulator\n");
> > +
> >       ret = iio_device_register(iio_dev);
> >       if (ret) {
> >               dev_err(&pdev->dev, "could not register iio device\n");
> > @@ -867,6 +899,8 @@ static int twl4030_madc_remove(struct
> platform_device *pdev)
> >       twl4030_madc_set_current_generator(madc, 0, 0);
> >       twl4030_madc_set_power(madc, 0);
> >
> > +     regulator_disable(madc->usb3v1);
> > +
> >       return 0;
> >  }
> >
> >
>
>

--94eb2c035a5065c8d2051cf7dec0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes I will do a better job in following the patch submissi=
on conventions.<div>Thanks for your comment Jonathan.</div><div><br></div><=
div>@Sebastian, let me know if you have any concerns with the patch.<br><di=
v><br><div><br></div></div></div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr">On Sat, Aug 8, 2015 at 8:15 AM Jonathan Cameron &lt;<a href=3D"=
mailto:jic23@kernel.org">jic23@kernel.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On 04/08/15 19:15, Adam YH Lee wrote:<br>
&gt; MADC[3:6] reads incorrect values without these two following changes:<=
br>
&gt;<br>
&gt; - enable the 3v1 bias regulator for ADC[3:6]<br>
&gt; - configure ADC[3:6] lines as input, not as USB<br>
&gt;<br>
&gt; Signed-off-by: Adam YH Lee &lt;<a href=3D"mailto:adam.yh.lee@gmail.com=
" target=3D"_blank">adam.yh.lee@gmail.com</a>&gt;<br>
I&#39;d ideally like an ack from the driver author or Sebastian as this isn=
&#39;t<br>
a driver I&#39;m particular familiar with.<br>
<br>
Also, for future reference, patches should be titled something like<br>
[Patch v4] iio: twl4030 madc: Fix ADC[3:6] readings.<br>
(the patch bit is standard, the rest is iio convention)<br>
<br>
Jonathan<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/iio/adc/twl4030-madc.c | 34 ++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 34 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-=
madc.c<br>
&gt; index 94c5f05..8c58498 100644<br>
&gt; --- a/drivers/iio/adc/twl4030-madc.c<br>
&gt; +++ b/drivers/iio/adc/twl4030-madc.c<br>
&gt; @@ -45,13 +45,18 @@<br>
&gt;=C2=A0 #include &lt;linux/types.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/gfp.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;linux/regulator/consumer.h&gt;<br>
&gt;<br>
&gt;=C2=A0 #include &lt;linux/iio/iio.h&gt;<br>
&gt;<br>
&gt; +#define TWL4030_USB_SEL_MADC_MCPC=C2=A0 =C2=A0 (1&lt;&lt;3)<br>
&gt; +#define TWL4030_USB_CARKIT_ANA_CTRL=C2=A0 0xBB<br>
&gt; +<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* struct twl4030_madc_data - a container for madc info<br>
&gt;=C2=A0 =C2=A0* @dev:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Poi=
nter to device structure for madc<br>
&gt;=C2=A0 =C2=A0* @lock:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Mutex pr=
otecting this data structure<br>
&gt; + * @regulator:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Pointer to bias regulator for madc<br>
&gt;=C2=A0 =C2=A0* @requests:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Array of request struct corresponding to SW1, SW2 and RT<br>
&gt;=C2=A0 =C2=A0* @use_second_irq:=C2=A0 IRQ selection (main or co-process=
or)<br>
&gt;=C2=A0 =C2=A0* @imr:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Int=
errupt mask register of MADC<br>
&gt; @@ -60,6 +65,7 @@<br>
&gt;=C2=A0 struct twl4030_madc_data {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex lock;=C2=A0 =C2=A0 =C2=A0 /* mu=
tex protecting this data structure */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct regulator *usb3v1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct twl4030_madc_request requests[TWL4030=
_MADC_NUM_METHODS];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool use_second_irq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 imr;<br>
&gt; @@ -842,6 +848,32 @@ static int twl4030_madc_probe(struct platform_dev=
ice *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0twl4030_madc =3D madc;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Configure MADC[3:6] */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D twl_i2c_read_u8(TWL_MODULE_USB, &amp;regv=
al,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0TWL4030_USB_CARKIT_ANA_CTRL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;unable to read reg CARKIT_ANA_CTRL=C2=A0 0x%X\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TWL4030_USB_CARKIT_ANA_CTRL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_i2c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regval |=3D TWL4030_USB_SEL_MADC_MCPC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D twl_i2c_write_u8(TWL_MODULE_USB, regval,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TWL4030_USB_CARKIT_ANA_CTRL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;unable to write reg CARKIT_ANA_CTRL 0x%X\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TWL4030_USB_CARKIT_ANA_CTRL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_i2c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Enable 3v1 bias regulator for MADC[3:6] */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0madc-&gt;usb3v1 =3D devm_regulator_get(madc-&gt;d=
ev, &quot;vusb3v1&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(madc-&gt;usb3v1))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D regulator_enable(madc-&gt;usb3v1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(madc-&gt;dev,=
 &quot;could not enable 3v1 bias regulator\n&quot;);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iio_device_register(iio_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pde=
v-&gt;dev, &quot;could not register iio device\n&quot;);<br>
&gt; @@ -867,6 +899,8 @@ static int twl4030_madc_remove(struct platform_dev=
ice *pdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0twl4030_madc_set_current_generator(madc, 0, =
0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0twl4030_madc_set_power(madc, 0);<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regulator_disable(madc-&gt;usb3v1);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div>

--94eb2c035a5065c8d2051cf7dec0--
