Return-Path: <SRS0=3f18=GQ=invensense.com=JManeyrol@kernel.org>
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>, Martin Kelly <mkelly@xevo.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: How to handle missing timestamps? (was Re: [PATCH] iio: imu:
 inv_mpu6050: improve missing timestamp handling)
Date: Mon, 26 Mar 2018 14:17:47 +0000
Message-ID: <CY4PR1201MB0184E4503B2B1EEA7F24C41DC4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <20180324000240.19519-1-mkelly@xevo.com>,<20180324123519.0acba88e@archlinux>
In-Reply-To: <20180324123519.0acba88e@archlinux>
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0184E4503B2B1EEA7F24C41DC4AD0CY4PR1201MB0184_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_CY4PR1201MB0184E4503B2B1EEA7F24C41DC4AD0CY4PR1201MB0184_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,


we should have 1 interrupt every time a sensor data has been acquired. So i=
n theory this is not something that should happen. But real world is always=
 a different story.


Do you have a case where you saw that happen?


The best way if this happens would be to create the timestamp based on the =
sampling rate since we know it (last timestamp + sampling interval). That w=
ould be very similar to the real value since the only difference is the clo=
ck drift between the chip and the system.


Best regards,

Jean-Baptiste Maneyrol

________________________________
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@kernel.org>
Sent: Saturday, March 24, 2018 1:35:19 PM
To: Martin Kelly
Cc: linux-iio@vger.kernel.org; Jean-Baptiste Maneyrol
Subject: How to handle missing timestamps? (was Re: [PATCH] iio: imu: inv_m=
pu6050: improve missing timestamp handling)

On Fri, 23 Mar 2018 17:02:40 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> When interrupts are generated at a slower rate than the FIFO queue fills
> up, we will have fewer timestamps than samples. Currently, we fill in 0
> for any unmatched timestamps. However, this is very confusing for
> userspace, which does not expect discontinuities in timestamps and
> must somehow work around the issue.
>
> Improve the situation by using the most recent timestamp when a
> timestamp is missing. Although this guess is not perfectly accurate, it
> is still close to the correct timestamp and won't result in the
> confusion caused by using 0.
>
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
Hmm. I would like to see where other peoples opinions on this lie.
The decision to mark it as 0 was deliberately made.  There are a number
of applications where you have to 'know' the timestamps are incorrect
- pretending simply doesn't work.  Arguably it is fine for a system
to detect that it is seeing repeated values and hence 'fix them up.
This is a change in ABI however which is going to be unfortunate
if we have code out there which is doing the right thing - interpolating
timestamps only once we have another known point to build from.

So opinions anyone?

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c
> index ff81c6aa009d..a982037d5dad 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -126,6 +126,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>        int result;
>        u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>        u16 fifo_count;
> +     s64 last_timestamp;
>        s64 timestamp;
>
>        mutex_lock(&st->lock);
> @@ -159,6 +160,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>        if (kfifo_len(&st->timestamps) >
>            fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
>                goto flush_fifo;
> +     last_timestamp =3D 0;
>        while (fifo_count >=3D bytes_per_datum) {
>                result =3D regmap_bulk_read(st->map, st->reg->fifo_r_w,
>                                          data, bytes_per_datum);
> @@ -166,9 +168,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>                        goto flush_fifo;
>
>                result =3D kfifo_out(&st->timestamps, &timestamp, 1);
> -             /* when there is no timestamp, put timestamp as 0 */
> +             /* when there is no timestamp, just use the last one we saw=
 */
>                if (result =3D=3D 0)
> -                     timestamp =3D 0;
> +                     timestamp =3D last_timestamp;
> +             else
> +                     last_timestamp =3D timestamp;
>
>                result =3D iio_push_to_buffers_with_timestamp(indio_dev, d=
ata,
>                                                            timestamp);

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--_000_CY4PR1201MB0184E4503B2B1EEA7F24C41DC4AD0CY4PR1201MB0184_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hello,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">we should have 1 interrupt every =
time a sensor data has been acquired. So in theory this is not something th=
at should happen. But real world is always a different story.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Do you have a case where you saw =
that happen?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">The best way if this happens woul=
d be to create the timestamp based on the sampling rate since we know it (l=
ast timestamp &#43; sampling interval). That would be very similar to the r=
eal value since the only difference is
 the clock drift between the chip and the system.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Jean-Baptiste Maneyrol<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> linux-iio-owner@vger.=
kernel.org &lt;linux-iio-owner@vger.kernel.org&gt; on behalf of Jonathan Ca=
meron &lt;jic23@kernel.org&gt;<br>
<b>Sent:</b> Saturday, March 24, 2018 1:35:19 PM<br>
<b>To:</b> Martin Kelly<br>
<b>Cc:</b> linux-iio@vger.kernel.org; Jean-Baptiste Maneyrol<br>
<b>Subject:</b> How to handle missing timestamps? (was Re: [PATCH] iio: imu=
: inv_mpu6050: improve missing timestamp handling)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, 23 Mar 2018 17:02:40 -0700<br>
Martin Kelly &lt;mkelly@xevo.com&gt; wrote:<br>
<br>
&gt; When interrupts are generated at a slower rate than the FIFO queue fil=
ls<br>
&gt; up, we will have fewer timestamps than samples. Currently, we fill in =
0<br>
&gt; for any unmatched timestamps. However, this is very confusing for<br>
&gt; userspace, which does not expect discontinuities in timestamps and<br>
&gt; must somehow work around the issue.<br>
&gt; <br>
&gt; Improve the situation by using the most recent timestamp when a<br>
&gt; timestamp is missing. Although this guess is not perfectly accurate, i=
t<br>
&gt; is still close to the correct timestamp and won't result in the<br>
&gt; confusion caused by using 0.<br>
&gt; <br>
&gt; Signed-off-by: Martin Kelly &lt;mkelly@xevo.com&gt;<br>
Hmm. I would like to see where other peoples opinions on this lie.<br>
The decision to mark it as 0 was deliberately made.&nbsp; There are a numbe=
r<br>
of applications where you have to 'know' the timestamps are incorrect<br>
- pretending simply doesn't work.&nbsp; Arguably it is fine for a system<br=
>
to detect that it is seeing repeated values and hence 'fix them up.<br>
This is a change in ABI however which is going to be unfortunate<br>
if we have code out there which is doing the right thing - interpolating<br=
>
timestamps only once we have another known point to build from.<br>
<br>
So opinions anyone?<br>
<br>
Jonathan<br>
&gt; ---<br>
&gt;&nbsp; drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 8 &#43;&#43;&#43;&#=
43;&#43;&#43;--<br>
&gt;&nbsp; 1 file changed, 6 insertions(&#43;), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_ring.c<br>
&gt; index ff81c6aa009d..a982037d5dad 100644<br>
&gt; --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c<br>
&gt; &#43;&#43;&#43; b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c<br>
&gt; @@ -126,6 &#43;126,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, voi=
d *p)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 data[INV_MPU6050_OUTPUT_D=
ATA_SIZE];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 fifo_count;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; s64 last_timestamp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s64 timestamp;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;st-&gt;lock)=
;<br>
&gt; @@ -159,6 &#43;160,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, voi=
d *p)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfifo_len(&amp;st-&gt;ti=
mestamps) &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fifo=
_count / bytes_per_datum &#43; INV_MPU6050_TIME_STAMP_TOR)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto flush_fifo;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; last_timestamp =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (fifo_count &gt;=3D by=
tes_per_datum) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D regmap_bulk_read(st-&gt;map, st-&gt;reg-&gt;=
fifo_r_w,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; data, bytes_per_datum);<br>
&gt; @@ -166,9 &#43;168,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, vo=
id *p)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fl=
ush_fifo;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D kfifo_out(&amp;st-&gt;timestamps, &amp;times=
tamp, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* when there is no timestamp, put timestamp as 0 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* when there is no timestamp, just use the last one we saw */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (result =3D=3D 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timestamp =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timestamp =3D last_=
timestamp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_timestamp =3D =
timestamp;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D iio_push_to_buffers_with_timestamp(indio_dev=
, data,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timestamp);<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to majordomo@vger.kernel.org<br>
More majordomo info at&nbsp; <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html">http://vger.kernel.org/majordomo-info.html</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR1201MB0184E4503B2B1EEA7F24C41DC4AD0CY4PR1201MB0184_--
