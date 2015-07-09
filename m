Return-Path: <shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1436391502-2604-1-git-send-email-xander.huff@ni.com>
References: <5574633F.7090004@kernel.org>
	<1436391502-2604-1-git-send-email-xander.huff@ni.com>
Date: Thu, 9 Jul 2015 10:33:46 +0530
Message-ID: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Push interrupts into threaded context
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
To: Xander Huff <xander.huff@ni.com>
Cc: jic23@kernel.org, bigeasy@linutronix.de, lars@metafoo.de,
	nathan.sullivan@ni.com, linux-rt-users@vger.kernel.org,
	linux-iio@vger.kernel.org, jaeden.amero@ni.com, joshc@ni.com,
	michal.simek@xilinx.com, linux-kernel@vger.kernel.org, joe.hershberger@ni.com,
	linux-arm-kernel@lists.infradead.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
	soren.brinkmann@xilinx.com
Content-Type: multipart/alternative; boundary=001a11403efa2822a2051a6a2e41
List-ID: <linux-iio@vger.kernel.org>

--001a11403efa2822a2051a6a2e41
Content-Type: text/plain; charset=UTF-8

Hi,
Thanks for the patch.

On Thu, Jul 9, 2015 at 3:08 AM, Xander Huff <xander.huff@ni.com> wrote:

> The driver currently registers a pair of irq handlers using
> request_threaded_irq(), however the synchronization mechanism between the
> hardirq and the threadedirq handler is a regular spinlock.
>
> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
> and is thus not able to be acquired from a hardirq handler. This patch gets
> rid of the hardirq handler and pushes all interrupt handling into the
> threaded context.
>

makes sense.


>
> To validate that this change has no impact on RT performance, here are
> cyclictest values with no processes running:
>
> $ sudo cyclictest -S -m -p 98
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.05 0.04 0.05 1/237 828
> T: 0 ( 1861) P:98 I:1000 C:56925046 Min: 9 Act: 12 Avg: 12 Max: 71
> T: 1 ( 1862) P:98 I:1500 C:37950030 Min: 9 Act: 12 Avg: 13 Max: 74
>
> Then, all xadc raw handles were accessed in a continuous loop via
> /sys/bus/iio/devices/iio:device0:
>
> $ sudo cyclictest -S -m -p 98
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 7.81 7.64 7.541 2/247 5751
> T: 0 ( 1568) P:98 I:1000 C:23845515 Min: 11 Act: 22 Avg: 21 Max: 71
> T: 1 ( 1569) P:98 I:1500 C:15897239 Min: 11 Act: 21 Avg: 22 Max: 68
>
> Signed-off-by: Xander Huff <xander.huff@ni.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 35
> ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c
> b/drivers/iio/adc/xilinx-xadc-core.c
> index ce93bd8..b309ad3 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -279,28 +279,9 @@ static irqreturn_t
> xadc_zynq_threaded_interrupt_handler(int irq, void *devid)
>  {
>         struct iio_dev *indio_dev = devid;
>         struct xadc *xadc = iio_priv(indio_dev);
> -       unsigned int alarm;
> -
> -       spin_lock_irq(&xadc->lock);
> -       alarm = xadc->zynq_alarm;
> -       xadc->zynq_alarm = 0;
> -       spin_unlock_irq(&xadc->lock);
> -
> -       xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(alarm));
> -
> -       /* unmask the required interrupts in timer. */
> -       schedule_delayed_work(&xadc->zynq_unmask_work,
> -                       msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
> -
> -       return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
> -{
> -       struct iio_dev *indio_dev = devid;
> -       struct xadc *xadc = iio_priv(indio_dev);
>         irqreturn_t ret = IRQ_HANDLED;
>         uint32_t status;
> +       unsigned int alarm;
>
>         xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
>
> @@ -312,7 +293,6 @@ static irqreturn_t xadc_zynq_interrupt_handler(int
> irq, void *devid)
>         spin_lock(&xadc->lock);
>
>         xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
> -
>         if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
>                 xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
>                         XADC_ZYNQ_INT_DFIFO_GTH);
> @@ -330,8 +310,18 @@ static irqreturn_t xadc_zynq_interrupt_handler(int
> irq, void *devid)
>                 xadc_zynq_update_intmsk(xadc, 0, 0);
>                 ret = IRQ_WAKE_THREAD;
>         }
> +
> +       alarm = xadc->zynq_alarm;
> +       xadc->zynq_alarm = 0;
> +
>         spin_unlock(&xadc->lock);
>
> +       xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(alarm));
> +
> +       /* unmask the required interrupts in timer. */
> +       schedule_delayed_work(&xadc->zynq_unmask_work,
> +                       msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
> +
>

Now that we are in the threaded context do we need the  work queue stuff.



>         return ret;
>  }
>
> @@ -436,7 +426,6 @@ static const struct xadc_ops xadc_zynq_ops = {
>         .write = xadc_zynq_write_adc_reg,
>         .setup = xadc_zynq_setup,
>         .get_dclk_rate = xadc_zynq_get_dclk_rate,
> -       .interrupt_handler = xadc_zynq_interrupt_handler,
>         .threaded_interrupt_handler = xadc_zynq_threaded_interrupt_handler,
>         .update_alarm = xadc_zynq_update_alarm,
>  };
> @@ -1225,7 +1214,7 @@ static int xadc_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_free_samplerate_trigger;
>
> -       ret = request_threaded_irq(irq, xadc->ops->interrupt_handler,
> +       ret = request_threaded_irq(irq, 0,
>                                 xadc->ops->threaded_interrupt_handler,
>                                 0, dev_name(&pdev->dev), indio_dev);
>         if (ret)
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--001a11403efa2822a2051a6a2e41
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>Thanks for the patch.<br><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Thu, Jul 9, 2015 at 3:08 AM, Xander Huf=
f <span dir=3D"ltr">&lt;<a href=3D"mailto:xander.huff@ni.com" target=3D"_bl=
ank">xander.huff@ni.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">The driver currently registers a pair of irq handlers using<br>
request_threaded_irq(), however the synchronization mechanism between the<b=
r>
hardirq and the threadedirq handler is a regular spinlock.<br>
<br>
Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,<b=
r>
and is thus not able to be acquired from a hardirq handler. This patch gets=
<br>
rid of the hardirq handler and pushes all interrupt handling into the<br>
threaded context.<br></blockquote><div><br></div><div>makes sense.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
To validate that this change has no impact on RT performance, here are<br>
cyclictest values with no processes running:<br>
<br>
$ sudo cyclictest -S -m -p 98<br>
# /dev/cpu_dma_latency set to 0us<br>
policy: fifo: loadavg: 0.05 0.04 0.05 1/237 828<br>
T: 0 ( 1861) P:98 I:1000 C:56925046 Min: 9 Act: 12 Avg: 12 Max: 71<br>
T: 1 ( 1862) P:98 I:1500 C:37950030 Min: 9 Act: 12 Avg: 13 Max: 74<br>
<br>
Then, all xadc raw handles were accessed in a continuous loop via<br>
/sys/bus/iio/devices/iio:device0:<br>
<br>
$ sudo cyclictest -S -m -p 98<br>
# /dev/cpu_dma_latency set to 0us<br>
policy: fifo: loadavg: 7.81 7.64 7.541 2/247 5751<br>
T: 0 ( 1568) P:98 I:1000 C:23845515 Min: 11 Act: 22 Avg: 21 Max: 71<br>
T: 1 ( 1569) P:98 I:1500 C:15897239 Min: 11 Act: 21 Avg: 22 Max: 68<br>
<br>
Signed-off-by: Xander Huff &lt;<a href=3D"mailto:xander.huff@ni.com">xander=
.huff@ni.com</a>&gt;<br>
---<br>
=C2=A0drivers/iio/adc/xilinx-xadc-core.c | 35 ++++++++++++-----------------=
------<br>
=C2=A01 file changed, 12 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xa=
dc-core.c<br>
index ce93bd8..b309ad3 100644<br>
--- a/drivers/iio/adc/xilinx-xadc-core.c<br>
+++ b/drivers/iio/adc/xilinx-xadc-core.c<br>
@@ -279,28 +279,9 @@ static irqreturn_t xadc_zynq_threaded_interrupt_handle=
r(int irq, void *devid)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D devid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct xadc *xadc =3D iio_priv(indio_dev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int alarm;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irq(&amp;xadc-&gt;lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0alarm =3D xadc-&gt;zynq_alarm;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0xadc-&gt;zynq_alarm =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irq(&amp;xadc-&gt;lock);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0xadc_handle_events(indio_dev, xadc_zynq_transfo=
rm_alarm(alarm));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* unmask the required interrupts in timer. */<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_delayed_work(&amp;xadc-&gt;zynq_unmask=
_work,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
-}<br>
-<br>
-static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev =3D devid;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct xadc *xadc =3D iio_priv(indio_dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 irqreturn_t ret =3D IRQ_HANDLED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int alarm;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &amp;=
status);<br>
<br>
@@ -312,7 +293,6 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq,=
 void *devid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;xadc-&gt;lock);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, stat=
us);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status &amp; XADC_ZYNQ_INT_DFIFO_GTH) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xadc_zynq_update_in=
tmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 XADC_ZYNQ_INT_DFIFO_GTH);<br>
@@ -330,8 +310,18 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq=
, void *devid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xadc_zynq_update_in=
tmsk(xadc, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D IRQ_WAKE_TH=
READ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0alarm =3D xadc-&gt;zynq_alarm;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0xadc-&gt;zynq_alarm =3D 0;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;xadc-&gt;lock);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0xadc_handle_events(indio_dev, xadc_zynq_transfo=
rm_alarm(alarm));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* unmask the required interrupts in timer. */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_delayed_work(&amp;xadc-&gt;zynq_unmask=
_work,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));<br>
+<br></blockquote><div>=C2=A0</div><div>Now that we are in the threaded con=
text do we need the =C2=A0work queue stuff.</div><div><br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
@@ -436,7 +426,6 @@ static const struct xadc_ops xadc_zynq_ops =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .write =3D xadc_zynq_write_adc_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D xadc_zynq_setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .get_dclk_rate =3D xadc_zynq_get_dclk_rate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0.interrupt_handler =3D xadc_zynq_interrupt_hand=
ler,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .threaded_interrupt_handler =3D xadc_zynq_threa=
ded_interrupt_handler,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .update_alarm =3D xadc_zynq_update_alarm,<br>
=C2=A0};<br>
@@ -1225,7 +1214,7 @@ static int xadc_probe(struct platform_device *pdev)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_sampl=
erate_trigger;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D request_threaded_irq(irq, xadc-&gt;ops-=
&gt;interrupt_handler,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D request_threaded_irq(irq, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xadc-&gt;ops-&gt;threaded_interrupt_=
handler,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, dev_name(&amp;pdev-&gt;dev), indi=
o_dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
<br>
_______________________________________________<br>
linux-arm-kernel mailing list<br>
<a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kernel@li=
sts.infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/mailman/listi=
nfo/linux-arm-kernel</a><br>
</font></span></blockquote></div><br></div></div></div>

--001a11403efa2822a2051a6a2e41--
