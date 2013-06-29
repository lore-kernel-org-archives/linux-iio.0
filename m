Return-Path: <ggao@invensense.com>
MIME-Version: 1.0
In-Reply-To: <51CEAE0A.1020800@kernel.org>
References: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
	<1372022900-18670-2-git-send-email-pmeerw@pmeerw.net>
	<51CEAE0A.1020800@kernel.org>
Date: Sat, 29 Jun 2013 16:05:19 -0700
Message-ID: <CAE9_fzmrVYtpK-_1Ew_RohZg8RxRsWeJWmKsjnQaFAt+wV8w4w@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: use I2C_FUNC_SMBUS_I2C_BLOCK macro
From: Ge Gao <ggao@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=047d7bd9218a81767204e0530752
List-ID: <linux-iio@vger.kernel.org>

--047d7bd9218a81767204e0530752
Content-Type: text/plain; charset=ISO-8859-1

It is not needed now. But it is actually needed in my "full" version of
drivers, which involves of using DMP.  But I think it can be removed now.
Do you need a patch for this? Thank you very much.

Ge

On Saturday, June 29, 2013, Jonathan Cameron wrote:

> On 06/23/2013 10:28 PM, Peter Meerwald wrote:
> > I do not see why the driver requires I2C_FUNC_SMBUS_I2C_BLOCK,
> > actually only single bytes or words are transferred
> Applied as is, but Ge, I would like you to answer Peter's question
> about whether this is actually needed at all.
>
> >
> > Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: Ge Gao <ggao@invensense.com>
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index fe4c61e..6a1ff80 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -663,8 +663,8 @@ static int inv_mpu_probe(struct i2c_client *client,
> >       int result;
> >
> >       if (!i2c_check_functionality(client->adapter,
> > -                                     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> > -                                     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> > +             I2C_FUNC_SMBUS_I2C_BLOCK)) {
> > +
> >               result = -ENOSYS;
> >               goto out_no_free;
> >       }
> >
>

--047d7bd9218a81767204e0530752
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It is not needed now. But it is=A0actually needed in my &q=
uot;full&quot; version of drivers, which=A0involves of using DMP.=A0 But I =
think it can be removed now. Do you need a=A0patch for this? Thank you very=
 much.<div>
<br></div><div>Ge=A0<span></span><br><br>On Saturday, June 29, 2013, Jonath=
an Cameron  wrote:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;padding=
-left:1ex;border-left-color:rgb(204,204,204);border-left-width:1px;border-l=
eft-style:solid" class=3D"gmail_quote">


On 06/23/2013 10:28 PM, Peter Meerwald wrote:<br>
&gt; I do not see why the driver requires I2C_FUNC_SMBUS_I2C_BLOCK,<br>
&gt; actually only single bytes or words are transferred<br>
Applied as is, but Ge, I would like you to answer Peter&#39;s question<br>
about whether this is actually needed at all.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Peter Meerwald &lt;<a>pmeerw@pmeerw.net</a>&gt;<br>
&gt; Cc: Ge Gao &lt;<a>ggao@invensense.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--<br>
&gt; =A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_core.c<br>
&gt; index fe4c61e..6a1ff80 100644<br>
&gt; --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c<br>
&gt; +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c<br>
&gt; @@ -663,8 +663,8 @@ static int inv_mpu_probe(struct i2c_client *client=
,<br>
&gt; =A0 =A0 =A0 int result;<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (!i2c_check_functionality(client-&gt;adapter,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 I2C_FUNC_SMBUS_READ_I2C_BLOCK |<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 I2C_FUNC_SMBUS_I2C_BLOCK)) {<br>
&gt; +<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -ENOSYS;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_no_free;<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
</blockquote></div>
</div>

--047d7bd9218a81767204e0530752--
