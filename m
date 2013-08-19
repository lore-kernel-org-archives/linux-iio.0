Return-Path: <oleksandr.kozaruk@globallogic.com>
MIME-Version: 1.0
Sender: oleksandr.kozaruk@globallogic.com
In-Reply-To: <520C9FFD.3070102@kernel.org>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
	<1374758813-6539-3-git-send-email-oleksandr.kozaruk@ti.com>
	<520BFFFF.7040904@kernel.org>
	<CAPb7_mthhYXbp0tTKMvV=gwndfaHMxnrXPCgxUk3MSH1R+W9rQ@mail.gmail.com>
	<520C9FFD.3070102@kernel.org>
Date: Mon, 19 Aug 2013 13:26:21 +0300
Message-ID: <CAPb7_mtnP1ZAZF+nMBY=RhGbCXARUd96YTDgK7Agt=_awEVNrQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>,
	"benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "rnayak@ti.com" <rnayak@ti.com>,
	"peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "kishon@ti.com" <kishon@ti.com>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>, Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>, Lars-Peter Clausen <lars@metafoo.de>,
	"sameo@linux.intel.com" <sameo@linux.intel.com>, naveen krishna <ch.naveen@samsung.com>,
	"poeschel@lemonage.de" <poeschel@lemonage.de>, "milo.kim@ti.com" <milo.kim@ti.com>,
	"balajitk@ti.com" <balajitk@ti.com>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=047d7b2e7b02253adf04e44a5fc7
List-ID: <linux-iio@vger.kernel.org>

--047d7b2e7b02253adf04e44a5fc7
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 15, 2013 at 12:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On 08/15/13 06:45, Oleksandr Kozaruk wrote:
> > Hello Jonathan,
> >
> > Thank you for the review and valuable comments.
> >
> >     Multiple authors are done by having multiple MODULE_AUTHOR lines
rather as
> >     one long string.  See include/linux/module.h. I fixed that up and
> >     dealt with some trivial fuzz in the makefile/Kconfig.
> >
> >
> >     You might want to take advantage of devm_iio_allocate_device
> >     which has been introduced in the meantime and greatly simplifies
error
> >     paths in IIO probe functions.
> >
> >
> > Should I make new version of the patch, or just prepare a new patch
that patches the patch?
> I've applied the current one with the MODULE_AUTHOR line broken up.  If
you want to
> do the devm_ patch then that will want to be as an additional patch on
top of the togreg
> branch of
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Hello Jonathan,

This patch was tested on top of d536321df392ee0db6a5e92d98f0303020315f40
commit id

Regards,
Sasha.

>From d7b7a5f1235ef7109f5e9331f4ce60a2f3651f54 Mon Sep 17 00:00:00 2001
From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Date: Mon, 19 Aug 2013 11:22:47 +0300
Subject: [PATCH] iio: adc: twl6030-gpadc: Use devm_* API family

Using devm_iio_device_alloc and devm_request_threaded_irq makes
code simpler.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c
b/drivers/iio/adc/twl6030-gpadc.c
index a80a049..a558516 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -893,11 +893,9 @@ static int twl6030_gpadc_probe(struct platform_device
*pdev)

  pdata = match->data;

- indio_dev = iio_device_alloc(sizeof(*gpadc));
- if (!indio_dev) {
- dev_err(dev, "failed allocating iio device\n");
- ret = -ENOMEM;
- }
+ indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
+ if (!indio_dev)
+ return -ENOMEM;

  gpadc = iio_priv(indio_dev);

@@ -905,7 +903,7 @@ static int twl6030_gpadc_probe(struct platform_device
*pdev)
  sizeof(*gpadc->twl6030_cal_tbl) *
  pdata->nchannels, GFP_KERNEL);
  if (!gpadc->twl6030_cal_tbl)
- goto err_free_device;
+ return -ENOMEM;

  gpadc->dev = dev;
  gpadc->pdata = pdata;
@@ -917,33 +915,30 @@ static int twl6030_gpadc_probe(struct platform_device
*pdev)
  ret = pdata->calibrate(gpadc);
  if (ret < 0) {
  dev_err(&pdev->dev, "failed to read calibration registers\n");
- goto err_free_device;
+ return ret;
  }

  irq = platform_get_irq(pdev, 0);
  if (irq < 0) {
  dev_err(&pdev->dev, "failed to get irq\n");
- goto err_free_device;
+ return irq;
  }

- ret = request_threaded_irq(irq, NULL, twl6030_gpadc_irq_handler,
+ ret = devm_request_threaded_irq(dev, irq, NULL,
+ twl6030_gpadc_irq_handler,
  IRQF_ONESHOT, "twl6030_gpadc", indio_dev);
- if (ret) {
- dev_dbg(&pdev->dev, "could not request irq\n");
- goto err_free_device;
- }

  ret = twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
  if (ret < 0) {
  dev_err(&pdev->dev, "failed to enable GPADC interrupt\n");
- goto err_free_irq;
+ return ret;
  }

  ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
  TWL6030_REG_TOGGLE1);
  if (ret < 0) {
  dev_err(&pdev->dev, "failed to enable GPADC module\n");
- goto err_free_irq;
+ return ret;
  }

  indio_dev->name = DRIVER_NAME;
@@ -954,15 +949,6 @@ static int twl6030_gpadc_probe(struct platform_device
*pdev)
  indio_dev->num_channels = pdata->nchannels;

  ret = iio_device_register(indio_dev);
- if (ret)
- goto err_free_irq;
-
- return ret;
-
-err_free_irq:
- free_irq(irq, indio_dev);
-err_free_device:
- iio_device_free(indio_dev);

  return ret;
 }
@@ -972,9 +958,7 @@ static int twl6030_gpadc_remove(struct platform_device
*pdev)
  struct iio_dev *indio_dev = platform_get_drvdata(pdev);

  twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
- free_irq(platform_get_irq(pdev, 0), indio_dev);
  iio_device_unregister(indio_dev);
- iio_device_free(indio_dev);

  return 0;
 }
-- 
1.8.1.2

--047d7b2e7b02253adf04e44a5fc7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Aug 15, 2013 at 12:31 PM, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org">jic23@kernel.org</a>&gt; wrote:<br>&gt;<br=
>&gt; On 08/15/13 06:45, Oleksandr Kozaruk wrote:<br>&gt; &gt; Hello Jonath=
an,<br>
&gt; &gt;<br>&gt; &gt; Thank you for the review and valuable comments.<br>&=
gt; &gt;<br>&gt; &gt; =A0 =A0 Multiple authors are done by having multiple =
MODULE_AUTHOR lines rather as<br>&gt; &gt; =A0 =A0 one long string. =A0See =
include/linux/module.h. I fixed that up and<br>
&gt; &gt; =A0 =A0 dealt with some trivial fuzz in the makefile/Kconfig.<br>=
&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; =A0 =A0 You might want to take advantag=
e of devm_iio_allocate_device<br>&gt; &gt; =A0 =A0 which has been introduce=
d in the meantime and greatly simplifies error<br>
&gt; &gt; =A0 =A0 paths in IIO probe functions.<br>&gt; &gt;<br>&gt; &gt;<b=
r>&gt; &gt; Should I make new version of the patch, or just prepare a new p=
atch that patches the patch?<br>&gt; I&#39;ve applied the current one with =
the MODULE_AUTHOR line broken up. =A0If you want to<br>
&gt; do the devm_ patch then that will want to be as an additional patch on=
 top of the togreg<br>&gt; branch of<br>&gt;<br>&gt; git://<a href=3D"http:=
//git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git">git.kernel.org/pub=
/scm/linux/kernel/git/jic23/iio.git</a><br>
<br><div>Hello Jonathan,</div><div><br></div><div>This patch was tested on =
top of=A0d536321df392ee0db6a5e92d98f0303020315f40 commit id</div><div><br><=
/div><div>Regards,</div><div>Sasha.<br><div><br><div>From d7b7a5f1235ef7109=
f5e9331f4ce60a2f3651f54 Mon Sep 17 00:00:00 2001</div>
<div>From: Oleksandr Kozaruk &lt;<a href=3D"mailto:oleksandr.kozaruk@ti.com=
">oleksandr.kozaruk@ti.com</a>&gt;</div><div>Date: Mon, 19 Aug 2013 11:22:4=
7 +0300</div><div>Subject: [PATCH] iio: adc: twl6030-gpadc: Use devm_* API =
family</div>
<div><br></div><div>Using devm_iio_device_alloc and devm_request_threaded_i=
rq makes</div><div>code simpler.</div><div><br></div><div>Signed-off-by: Ol=
eksandr Kozaruk &lt;<a href=3D"mailto:oleksandr.kozaruk@ti.com">oleksandr.k=
ozaruk@ti.com</a>&gt;</div>
<div>---</div><div>=A0drivers/iio/adc/twl6030-gpadc.c | 36 ++++++++++------=
--------------------</div><div>=A01 file changed, 10 insertions(+), 26 dele=
tions(-)</div><div><br></div><div>diff --git a/drivers/iio/adc/twl6030-gpad=
c.c b/drivers/iio/adc/twl6030-gpadc.c</div>
<div>index a80a049..a558516 100644</div><div>--- a/drivers/iio/adc/twl6030-=
gpadc.c</div><div>+++ b/drivers/iio/adc/twl6030-gpadc.c</div><div>@@ -893,1=
1 +893,9 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)</d=
iv>
<div>=A0</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</span>pd=
ata =3D match-&gt;data;</div><div>=A0</div><div>-<span class=3D"" style=3D"=
white-space:pre">	</span>indio_dev =3D iio_device_alloc(sizeof(*gpadc));</d=
iv><div>-<span class=3D"" style=3D"white-space:pre">	</span>if (!indio_dev)=
 {</div>
<div>-<span class=3D"" style=3D"white-space:pre">		</span>dev_err(dev, &quo=
t;failed allocating iio device\n&quot;);</div><div>-<span class=3D"" style=
=3D"white-space:pre">		</span>ret =3D -ENOMEM;</div><div>-<span class=3D"" =
style=3D"white-space:pre">	</span>}</div>
<div>+<span class=3D"" style=3D"white-space:pre">	</span>indio_dev =3D devm=
_iio_device_alloc(dev, sizeof(*gpadc));</div><div>+<span class=3D"" style=
=3D"white-space:pre">	</span>if (!indio_dev)</div><div>+<span class=3D"" st=
yle=3D"white-space:pre">		</span>return -ENOMEM;</div>
<div>=A0</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</span>gp=
adc =3D iio_priv(indio_dev);</div><div>=A0</div><div>@@ -905,7 +903,7 @@ st=
atic int twl6030_gpadc_probe(struct platform_device *pdev)</div><div>=A0<sp=
an class=3D"" style=3D"white-space:pre">					</span>sizeof(*gpadc-&gt;twl60=
30_cal_tbl) *</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">					</span>pdata-&gt;nc=
hannels, GFP_KERNEL);</div><div>=A0<span class=3D"" style=3D"white-space:pr=
e">	</span>if (!gpadc-&gt;twl6030_cal_tbl)</div><div>-<span class=3D"" styl=
e=3D"white-space:pre">		</span>goto err_free_device;</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>return -ENOMEM;</=
div><div>=A0</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</spa=
n>gpadc-&gt;dev =3D dev;</div><div>=A0<span class=3D"" style=3D"white-space=
:pre">	</span>gpadc-&gt;pdata =3D pdata;</div>
<div>@@ -917,33 +915,30 @@ static int twl6030_gpadc_probe(struct platform_d=
evice *pdev)</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</spa=
n>ret =3D pdata-&gt;calibrate(gpadc);</div><div>=A0<span class=3D"" style=
=3D"white-space:pre">	</span>if (ret &lt; 0) {</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">		</span>dev_err(&amp;pd=
ev-&gt;dev, &quot;failed to read calibration registers\n&quot;);</div><div>=
-<span class=3D"" style=3D"white-space:pre">		</span>goto err_free_device;<=
/div><div>
+<span class=3D"" style=3D"white-space:pre">		</span>return ret;</div><div>=
=A0<span class=3D"" style=3D"white-space:pre">	</span>}</div><div>=A0</div>=
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>irq =3D platform=
_get_irq(pdev, 0);</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>if (irq &lt; 0) =
{</div><div>=A0<span class=3D"" style=3D"white-space:pre">		</span>dev_err(=
&amp;pdev-&gt;dev, &quot;failed to get irq\n&quot;);</div><div>-<span class=
=3D"" style=3D"white-space:pre">		</span>goto err_free_device;</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>return irq;</div>=
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>}</div><div>=A0<=
/div><div>-<span class=3D"" style=3D"white-space:pre">	</span>ret =3D reque=
st_threaded_irq(irq, NULL, twl6030_gpadc_irq_handler,</div>
<div>+<span class=3D"" style=3D"white-space:pre">	</span>ret =3D devm_reque=
st_threaded_irq(dev, irq, NULL,</div><div>+<span class=3D"" style=3D"white-=
space:pre">				</span>twl6030_gpadc_irq_handler,</div><div>=A0<span class=
=3D"" style=3D"white-space:pre">				</span>IRQF_ONESHOT, &quot;twl6030_gpad=
c&quot;, indio_dev);</div>
<div>-<span class=3D"" style=3D"white-space:pre">	</span>if (ret) {</div><d=
iv>-<span class=3D"" style=3D"white-space:pre">		</span>dev_dbg(&amp;pdev-&=
gt;dev, &quot;could not request irq\n&quot;);</div><div>-<span class=3D"" s=
tyle=3D"white-space:pre">		</span>goto err_free_device;</div>
<div>-<span class=3D"" style=3D"white-space:pre">	</span>}</div><div>=A0</d=
iv><div>=A0<span class=3D"" style=3D"white-space:pre">	</span>ret =3D twl60=
30_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);</div><div>=A0<span clas=
s=3D"" style=3D"white-space:pre">	</span>if (ret &lt; 0) {</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">		</span>dev_err(&amp;pd=
ev-&gt;dev, &quot;failed to enable GPADC interrupt\n&quot;);</div><div>-<sp=
an class=3D"" style=3D"white-space:pre">		</span>goto err_free_irq;</div><d=
iv>+<span class=3D"" style=3D"white-space:pre">		</span>return ret;</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>}</div><div>=A0<=
/div><div>=A0<span class=3D"" style=3D"white-space:pre">	</span>ret =3D twl=
_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,</div><div>=A0<span class=
=3D"" style=3D"white-space:pre">					</span>TWL6030_REG_TOGGLE1);</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>if (ret &lt; 0) =
{</div><div>=A0<span class=3D"" style=3D"white-space:pre">		</span>dev_err(=
&amp;pdev-&gt;dev, &quot;failed to enable GPADC module\n&quot;);</div><div>=
-<span class=3D"" style=3D"white-space:pre">		</span>goto err_free_irq;</di=
v>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>return ret;</div>=
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>}</div><div>=A0<=
/div><div>=A0<span class=3D"" style=3D"white-space:pre">	</span>indio_dev-&=
gt;name =3D DRIVER_NAME;</div>
<div>@@ -954,15 +949,6 @@ static int twl6030_gpadc_probe(struct platform_de=
vice *pdev)</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</span=
>indio_dev-&gt;num_channels =3D pdata-&gt;nchannels;</div><div>=A0</div><di=
v>=A0<span class=3D"" style=3D"white-space:pre">	</span>ret =3D iio_device_=
register(indio_dev);</div>
<div>-<span class=3D"" style=3D"white-space:pre">	</span>if (ret)</div><div=
>-<span class=3D"" style=3D"white-space:pre">		</span>goto err_free_irq;</d=
iv><div>-</div><div>-<span class=3D"" style=3D"white-space:pre">	</span>ret=
urn ret;</div>
<div>-</div><div>-err_free_irq:</div><div>-<span class=3D"" style=3D"white-=
space:pre">	</span>free_irq(irq, indio_dev);</div><div>-err_free_device:</d=
iv><div>-<span class=3D"" style=3D"white-space:pre">	</span>iio_device_free=
(indio_dev);</div>
<div>=A0</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</span>re=
turn ret;</div><div>=A0}</div><div>@@ -972,9 +958,7 @@ static int twl6030_g=
padc_remove(struct platform_device *pdev)</div><div>=A0<span class=3D"" sty=
le=3D"white-space:pre">	</span>struct iio_dev *indio_dev =3D platform_get_d=
rvdata(pdev);</div>
<div>=A0</div><div>=A0<span class=3D"" style=3D"white-space:pre">	</span>tw=
l6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);</div><div>-<span cl=
ass=3D"" style=3D"white-space:pre">	</span>free_irq(platform_get_irq(pdev, =
0), indio_dev);</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">	</span>iio_device_unreg=
ister(indio_dev);</div><div>-<span class=3D"" style=3D"white-space:pre">	</=
span>iio_device_free(indio_dev);</div><div>=A0</div><div>=A0<span class=3D"=
" style=3D"white-space:pre">	</span>return 0;</div>
<div>=A0}</div><div>--=A0</div><div>1.8.1.2</div><div><br></div></div></div=
></div>

--047d7b2e7b02253adf04e44a5fc7--
