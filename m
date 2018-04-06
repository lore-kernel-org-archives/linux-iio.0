Return-Path: <SRS0=adWm=G3=invensense.com=JManeyrol@kernel.org>
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Martin Kelly
	<mkelly@xevo.com>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3] imu: inv_mpu6050: interpolate missing timestamps
Date: Fri, 6 Apr 2018 15:21:05 +0000
Message-ID: <CY4PR1201MB018485BCC65BD470449FFD92C4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <20180328174029.1045-1-mkelly@xevo.com>
	<20180330113606.1eba6011@archlinux>
	<6041491c-811a-8b43-96cf-b19336332ec4@xevo.com>,<20180406161509.0000254a@huawei.com>
In-Reply-To: <20180406161509.0000254a@huawei.com>
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB018485BCC65BD470449FFD92C4BA0CY4PR1201MB0184_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_CY4PR1201MB018485BCC65BD470449FFD92C4BA0CY4PR1201MB0184_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,


there is just a problem if I'm understanding well.


Reading FIFO count register under hard irq handler (when taking the timesta=
mp) is not possible since i2c access is using a mutex. That's why we are us=
ing an irq thread for reading FIFO content.


I've been able to reproduce the issue when doing a long stress-test at high=
 speed (200Hz). Perhaps this is related to the FIFO error handling which lo=
oks really over-complex for me. I am currently investigating this issue.


But I would be happy to test any new solution if proposed.


Best regards,

JB

________________________________
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Sent: Friday, April 6, 2018 5:15:09 PM
To: Martin Kelly
Cc: Jonathan Cameron; linux-iio@vger.kernel.org; Jean-Baptiste Maneyrol
Subject: Re: [PATCH v3] imu: inv_mpu6050: interpolate missing timestamps

On Mon, 2 Apr 2018 10:07:57 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> On 03/30/2018 03:36 AM, Jonathan Cameron wrote:
> > On Wed, 28 Mar 2018 10:40:29 -0700
> > Martin Kelly <mkelly@xevo.com> wrote:
> >
> >> When interrupts are generated at a slower rate than the FIFO fills up,
> >> we will have fewer timestamps than samples. Currently, we fill in 0 fo=
r
> >> any unmatched timestamps. However, this is very confusing for userspac=
e,
> >> which does not expect discontinuities in timestamps and must somehow
> >> work around the issue.
> >>
> >> Improve the situation by interpolating timestamps when we can't map th=
em
> >> 1:1 to data. We do this by assuming the timestamps we have are the mos=
t
> >> recent and interpolating backwards to fill the older data. This makes
> >> sense because inv_mpu6050_read_fifo gets called right after an interru=
pt
> >> is generated, presumably when a datum was generated, so the most recen=
t
> >> timestamp matches up with the most recent datum. In addition, this
> >> assumption is borne out by observation, which shows monotonically
> >> increasing timestamps when interpolating this way but discontinuities
> >> when interpolating in the other direction.
> >>
> >> Although this method is not perfectly accurate, it is probably the bes=
t
> >> we can do if we don't get one interrupt per datum.
> > This patch worries me somewhat - we are basically guessing what the cau=
se
> > of the missed interrupts was.  If for example the fifo read itself
> > takes a long time, the interrupt time we have is actually valid for
> > the first sample and we should in interpolating forwards in time.
> >
>
> I agree with you that if the delay is somewhere after the IRQ fires but
> prior to the FIFO read (or the FIFO read itself), then we'd need forward
> interpolation. That said, if there is more than 1 sample in FIFO when
> the IRQ fires, we need backwards interpolation (since those samples were
> certainly created prior to the IRQ firing and the timestamp being
> generated). I believe the current patch is will accurately handle the
> backwards interpolation case but be wrong for the forwards interpolation
> case (though it will at least guarantee samples to be monotonically
> increasing, as they should be).
>
> I thought about this and I think we can fix both issues. I propose we do
> the following:
>
> - When the IRQ fires, immediately timestamp as we already do. Also,
> immediately check the FIFO length and store it (call this length n).
>
> - Right after reading from the FIFO length (calling regmap_bulk_read()
> at inv_mpu_ring.c:146), take a timestamp again. Call this FIFO length m.
>
> - The first n samples (those present when the IRQ fired) should be
> backwards-interpolated from the timestamp taken when the IRQ fired.
>
> - If the two FIFO lengths taken are different (m - n > 0), then some
> samples were generated between the IRQ firing and the FIFO being read.
> This could be caused by a slow read, a delay firing off the bottom half
> of the IRQ, or some other delay in the inv_mpu6050_read_fifo() function.
> In any case, these m - n samples need to be forward-interpolated between
> the two timestamps we took, since they were generated sometime between
> the two timestamps.
>
> I believe this approach will fix both issues. Although my board is not
> seeing the second issue (where m - n > 0), I can simulate it by adding
> artificial delays.
>
> In addition to fixing my issue, this should make the code more resilient
> to unknown bus and IRQ issues in the future.
>
> Jonathan, how does this approach sound to you?
Great.

>
> > It sounds from discussions like something else is broken on your
> > board.  I like the idea of interpolating interrupts, but would like to
> > conduct the same experiments you did when we are running at high speeds
> > and seeing misses - not on the test case you currently have.
> >
> > The problem then will be estimating how long the interrupt took to
> > be handed vs the read out rate of the fifo.  Chances are our 'correct'
> > timestamp is somewhat after the first reading but well before the last
> > one.
> >
> > Anyhow, let us know once you have the thing running properly at
> > high speed then we can work out how best to address this.
> >
> > Jonathan
> >
>
> Once I get the thing working, I will definitely look again at the
> interpolation and make sure it's still valid. If I see any anomalies,
> I'll let you know.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--_000_CY4PR1201MB018485BCC65BD470449FFD92C4BA0CY4PR1201MB0184_
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
<p style=3D"margin-top:0;margin-bottom:0">there is just a problem if I'm un=
derstanding well.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Reading FIFO count register under=
 hard irq handler (when taking the timestamp) is not possible since i2c acc=
ess is using a mutex. That's why we are using an irq thread for reading FIF=
O content.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I've been able to reproduce the i=
ssue when doing a long stress-test at high speed (200Hz). Perhaps this is r=
elated to the FIFO error handling which looks really over-complex for me. I=
 am currently investigating this issue.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">But I would be happy to test any =
new solution if proposed.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">JB<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jonathan Cameron &lt;=
Jonathan.Cameron@huawei.com&gt;<br>
<b>Sent:</b> Friday, April 6, 2018 5:15:09 PM<br>
<b>To:</b> Martin Kelly<br>
<b>Cc:</b> Jonathan Cameron; linux-iio@vger.kernel.org; Jean-Baptiste Maney=
rol<br>
<b>Subject:</b> Re: [PATCH v3] imu: inv_mpu6050: interpolate missing timest=
amps</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, 2 Apr 2018 10:07:57 -0700<br>
Martin Kelly &lt;mkelly@xevo.com&gt; wrote:<br>
<br>
&gt; On 03/30/2018 03:36 AM, Jonathan Cameron wrote:<br>
&gt; &gt; On Wed, 28 Mar 2018 10:40:29 -0700<br>
&gt; &gt; Martin Kelly &lt;mkelly@xevo.com&gt; wrote:<br>
&gt; &gt;&nbsp;&nbsp; <br>
&gt; &gt;&gt; When interrupts are generated at a slower rate than the FIFO =
fills up,<br>
&gt; &gt;&gt; we will have fewer timestamps than samples. Currently, we fil=
l in 0 for<br>
&gt; &gt;&gt; any unmatched timestamps. However, this is very confusing for=
 userspace,<br>
&gt; &gt;&gt; which does not expect discontinuities in timestamps and must =
somehow<br>
&gt; &gt;&gt; work around the issue.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Improve the situation by interpolating timestamps when we can=
't map them<br>
&gt; &gt;&gt; 1:1 to data. We do this by assuming the timestamps we have ar=
e the most<br>
&gt; &gt;&gt; recent and interpolating backwards to fill the older data. Th=
is makes<br>
&gt; &gt;&gt; sense because inv_mpu6050_read_fifo gets called right after a=
n interrupt<br>
&gt; &gt;&gt; is generated, presumably when a datum was generated, so the m=
ost recent<br>
&gt; &gt;&gt; timestamp matches up with the most recent datum. In addition,=
 this<br>
&gt; &gt;&gt; assumption is borne out by observation, which shows monotonic=
ally<br>
&gt; &gt;&gt; increasing timestamps when interpolating this way but discont=
inuities<br>
&gt; &gt;&gt; when interpolating in the other direction.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Although this method is not perfectly accurate, it is probabl=
y the best<br>
&gt; &gt;&gt; we can do if we don't get one interrupt per datum.&nbsp; <br>
&gt; &gt; This patch worries me somewhat - we are basically guessing what t=
he cause<br>
&gt; &gt; of the missed interrupts was.&nbsp; If for example the fifo read =
itself<br>
&gt; &gt; takes a long time, the interrupt time we have is actually valid f=
or<br>
&gt; &gt; the first sample and we should in interpolating forwards in time.=
<br>
&gt; &gt;&nbsp;&nbsp; <br>
&gt; <br>
&gt; I agree with you that if the delay is somewhere after the IRQ fires bu=
t <br>
&gt; prior to the FIFO read (or the FIFO read itself), then we'd need forwa=
rd <br>
&gt; interpolation. That said, if there is more than 1 sample in FIFO when =
<br>
&gt; the IRQ fires, we need backwards interpolation (since those samples we=
re <br>
&gt; certainly created prior to the IRQ firing and the timestamp being <br>
&gt; generated). I believe the current patch is will accurately handle the =
<br>
&gt; backwards interpolation case but be wrong for the forwards interpolati=
on <br>
&gt; case (though it will at least guarantee samples to be monotonically <b=
r>
&gt; increasing, as they should be).<br>
&gt; <br>
&gt; I thought about this and I think we can fix both issues. I propose we =
do <br>
&gt; the following:<br>
&gt; <br>
&gt; - When the IRQ fires, immediately timestamp as we already do. Also, <b=
r>
&gt; immediately check the FIFO length and store it (call this length n).<b=
r>
&gt; <br>
&gt; - Right after reading from the FIFO length (calling regmap_bulk_read()=
 <br>
&gt; at inv_mpu_ring.c:146), take a timestamp again. Call this FIFO length =
m.<br>
&gt; <br>
&gt; - The first n samples (those present when the IRQ fired) should be <br=
>
&gt; backwards-interpolated from the timestamp taken when the IRQ fired.<br=
>
&gt; <br>
&gt; - If the two FIFO lengths taken are different (m - n &gt; 0), then som=
e <br>
&gt; samples were generated between the IRQ firing and the FIFO being read.=
 <br>
&gt; This could be caused by a slow read, a delay firing off the bottom hal=
f <br>
&gt; of the IRQ, or some other delay in the inv_mpu6050_read_fifo() functio=
n. <br>
&gt; In any case, these m - n samples need to be forward-interpolated betwe=
en <br>
&gt; the two timestamps we took, since they were generated sometime between=
 <br>
&gt; the two timestamps.<br>
&gt; <br>
&gt; I believe this approach will fix both issues. Although my board is not=
 <br>
&gt; seeing the second issue (where m - n &gt; 0), I can simulate it by add=
ing <br>
&gt; artificial delays.<br>
&gt; <br>
&gt; In addition to fixing my issue, this should make the code more resilie=
nt <br>
&gt; to unknown bus and IRQ issues in the future.<br>
&gt; <br>
&gt; Jonathan, how does this approach sound to you?<br>
Great.<br>
<br>
&gt; <br>
&gt; &gt; It sounds from discussions like something else is broken on your<=
br>
&gt; &gt; board.&nbsp; I like the idea of interpolating interrupts, but wou=
ld like to<br>
&gt; &gt; conduct the same experiments you did when we are running at high =
speeds<br>
&gt; &gt; and seeing misses - not on the test case you currently have.<br>
&gt; &gt; <br>
&gt; &gt; The problem then will be estimating how long the interrupt took t=
o<br>
&gt; &gt; be handed vs the read out rate of the fifo.&nbsp; Chances are our=
 'correct'<br>
&gt; &gt; timestamp is somewhat after the first reading but well before the=
 last<br>
&gt; &gt; one.<br>
&gt; &gt; <br>
&gt; &gt; Anyhow, let us know once you have the thing running properly at<b=
r>
&gt; &gt; high speed then we can work out how best to address this.<br>
&gt; &gt; <br>
&gt; &gt; Jonathan<br>
&gt; &gt;&nbsp;&nbsp; <br>
&gt; <br>
&gt; Once I get the thing working, I will definitely look again at the <br>
&gt; interpolation and make sure it's still valid. If I see any anomalies, =
<br>
&gt; I'll let you know.<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-i=
io&quot; in<br>
&gt; the body of a message to majordomo@vger.kernel.org<br>
&gt; More majordomo info at&nbsp; <a href=3D"http://vger.kernel.org/majordo=
mo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR1201MB018485BCC65BD470449FFD92C4BA0CY4PR1201MB0184_--
