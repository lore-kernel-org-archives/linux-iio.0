Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB126158B
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934147; cv=none; b=KnEhaJNW8LJjTsea06ZoNmmTMCBl5brS85WA5SnS7HSOTTqQf2FL/mPGgj4QOYR8jXGf/OeQETK7yqFKWhoqDEKZ9Ux0F222GVzECuUrz7jOe1cot2Lv6c3zZHbFOn8cc1cudJjlw0onLNkPA7h/XxcAQNSVfSAUzsB1PBNS9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934147; c=relaxed/simple;
	bh=jQH06ffWjGSG0Uylkv3u9YJTLQGiQkYBU3zu7qUgTPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1sy7uILx5WeUtyd9gYe+kTP2s/HIsc7GYOxhQbcrx6OB7ooQZ6+65YdUVRnyCMe54t85DB1NaCThm0eCArUpkTiIwYOTv4Jdq6AYyar7PIbf7bXvQz2wF29heZHTcY8ns88vOQ0s6lPrr8FoqRVJQmRDwpwezH9OvyWoTq6zIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9zFtwZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9zFtwZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510E1C19425;
	Sat, 16 May 2026 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778934146;
	bh=jQH06ffWjGSG0Uylkv3u9YJTLQGiQkYBU3zu7qUgTPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B9zFtwZDXTgxptV/FHu1/JYuNTNn475UH9N+9k3dfWjD2kzRPftCU1xE8rzxuxToS
	 0nGIKQiLDAF/Ee/SO2Ls00hYP8DpmGpQ8Qw7BOidT05mqO+V9VJI6b5P8ieKsJ1s1G
	 r+DzOdY8DBcFj8PGplNjn9jgrq/rs69S6QJZsbX7+WNP1oVHlA0ZhCQjMT2f8nVVZk
	 ARCnpVITKRcAiWOKM24tQRlJk/yntd2gLlK5raz9V8e7F5briRCBWqJxayTWElTSa8
	 fi1bKCumkjYNWZHP3kRVmz6GIezjrL+sxHay8Qv1bt8HxLqk1rRKd16eFCJ3c6xNup
	 4bHBeQgre6dOg==
Date: Sat, 16 May 2026 13:22:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Aline Ayumi Nakazawa <aline.nakazawa@ime.usp.br>,
 jean-baptiste.maneyrol@tdk.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use guard(mutex) and
 scoped_guard
Message-ID: <20260516132218.073c7548@jic23-huawei>
In-Reply-To: <CAKqfh0FxvJh2VXH_Q0FBZxYBeCmw8r2XTiwErtfSQm-g-YtT9w@mail.gmail.com>
References: <20260512172538.101383-1-aline.nakazawa@ime.usp.br>
	<CAKqfh0FxvJh2VXH_Q0FBZxYBeCmw8r2XTiwErtfSQm-g-YtT9w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 12:46:36 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Hi there Aline,
>=20
> On Tue, May 12, 2026 at 12:37=E2=80=AFPM Aline Ayumi Nakazawa
> <aline.nakazawa@ime.usp.br> wrote:
> >
> > From: Aline Nakazawa <aline.nakazawa@ime.usp.br>
> >
> > Replace manual mutex_lock/unlock calls with guard() and scoped_guard()
> > macros.
> >
> > Signed-off-by: Aline Nakazawa <aline.nakazawa@ime.usp.br>
As I think this wasn't cropped at all, I'l review on top

> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 199 ++++++++++-----------
> >  1 file changed, 92 insertions(+), 107 deletions(-)
> >
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c
> > index 5796896d54cd..154d9086b6e9 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/property.h>
> > +#include <linux/cleanup.h>
> >
> >  #include <linux/iio/common/inv_sensors_timestamp.h>
> >  #include <linux/iio/iio.h>
> > @@ -756,27 +757,27 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> >         case IIO_CHAN_INFO_RAW:
> >                 if (!iio_device_claim_direct(indio_dev))
> >                         return -EBUSY;
> > -               mutex_lock(&st->lock);
> > -               ret =3D inv_mpu6050_read_channel_data(indio_dev, chan, =
val);
> > -               mutex_unlock(&st->lock);
> > +               scoped_guard(mutex, &st->lock) {
> > +                       ret =3D inv_mpu6050_read_channel_data(indio_dev=
, chan, val);
> > +               } =20
>=20
> This doesn't need braces, it's a single line.

Rather than doing just guard() for mutexes, take a look at
IIO_DEV_ACQUIRE_DIRECT_MODE() and IIO_DEV_ACQUIRE_ERR()

By using those in combination with some scope {} and guard(mutex)() this
code can be made more elegant.


>=20
> >                 iio_device_release_direct(indio_dev);
> >                 return ret;
> >         case IIO_CHAN_INFO_SCALE:
> >                 switch (chan->type) {
> > -               case IIO_ANGL_VEL:
> > -                       mutex_lock(&st->lock);
> > +               case IIO_ANGL_VEL: {
> > +                       guard(mutex)(&st->lock); =20
>=20
> Usually Andy prefers if you separate guard()() and other code with a blan=
k line.
>=20
> >                         *val  =3D 0;
> >                         *val2 =3D gyro_scale_6050[st->chip_config.fsr];
> > -                       mutex_unlock(&st->lock);
> >
> >                         return IIO_VAL_INT_PLUS_NANO;
> > -               case IIO_ACCEL:
> > -                       mutex_lock(&st->lock);
> > +               }
> > +               case IIO_ACCEL: {
> > +                       guard(mutex)(&st->lock);
> >                         *val =3D 0;
> >                         *val2 =3D accel_scale[st->chip_config.accl_fs];
> > -                       mutex_unlock(&st->lock);
> >
> >                         return IIO_VAL_INT_PLUS_MICRO;
> > +               }
> >                 case IIO_TEMP:
> >                         *val =3D st->hw->temp.scale / 1000000;
> >                         *val2 =3D st->hw->temp.scale % 1000000;
> > @@ -797,18 +798,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> >         case IIO_CHAN_INFO_CALIBBIAS:
> >                 switch (chan->type) {
> >                 case IIO_ANGL_VEL:
> > -                       mutex_lock(&st->lock);
> > -                       ret =3D inv_mpu6050_sensor_show(st, st->reg->gy=
ro_offset,
> > +                       guard(mutex)(&st->lock);
> > +                       return inv_mpu6050_sensor_show(st, st->reg->gyr=
o_offset,
> >                                                 chan->channel2, val); =
=20
>=20
> Shouldn't this have caused a compiler warning/error? guard()()
> declares a random variable, so you're jumping over variable
> declarations/initializations which isn't allowed.

It's a bit compiler specific on whether it just builds the wrong thing
or bothers to warn you. I think only LLVM produces a consistent warning
currently.

Also note there are other instances of this in the driver that will also
be broken.

>=20
> > -                       mutex_unlock(&st->lock);
> > -                       return ret;
> >                 case IIO_ACCEL:
> > -                       mutex_lock(&st->lock);
> > -                       ret =3D inv_mpu6050_sensor_show(st, st->reg->ac=
cl_offset,
> > +                       guard(mutex)(&st->lock);
> > +                       return inv_mpu6050_sensor_show(st, st->reg->acc=
l_offset,
> >                                                 chan->channel2, val);
> > -                       mutex_unlock(&st->lock);
> > -                       return ret;
> > -
> >                 default:
> >                         return -EINVAL;
> >                 }
> > @@ -896,50 +892,49 @@ static int inv_mpu6050_write_raw(struct iio_dev *=
indio_dev,
> >         if (!iio_device_claim_direct(indio_dev))

Similar to above, there are nicer ways to handle this.

> >                 return -EBUSY;
> >
> > -       mutex_lock(&st->lock);
> > -       result =3D pm_runtime_resume_and_get(pdev);
> > -       if (result)
> > -               goto error_write_raw_unlock;
> > -
> > -       switch (mask) {
> > -       case IIO_CHAN_INFO_SCALE:
> > -               switch (chan->type) {
> > -               case IIO_ANGL_VEL:
> > -                       result =3D inv_mpu6050_write_gyro_scale(st, val=
, val2);
> > -                       break;
> > -               case IIO_ACCEL:
> > -                       result =3D inv_mpu6050_write_accel_scale(st, va=
l, val2);
> > -                       break;
> > -               default:
> > -                       result =3D -EINVAL;
> > +       scoped_guard(mutex, &st->lock) {
> > +               result =3D pm_runtime_resume_and_get(pdev);

more fun - check for ACQUIRE like stuff for runtime PM. It has
some stuff similar to what I suggested above for the IIO mode claiming.

I'm also not sure why it was under the lock in the original code so
see if you can figure out if that is necessary.

> > +               if (result)
> >                         break;
> > -               }
> > -               break;
> > -       case IIO_CHAN_INFO_CALIBBIAS:
> > -               switch (chan->type) {
> > -               case IIO_ANGL_VEL:
> > -                       result =3D inv_mpu6050_sensor_set(st,
> > -                                                       st->reg->gyro_o=
ffset,
> > -                                                       chan->channel2,=
 val);
> > +
> > +               switch (mask) {
> > +               case IIO_CHAN_INFO_SCALE:
> > +                       switch (chan->type) {
> > +                       case IIO_ANGL_VEL:
> > +                               result =3D inv_mpu6050_write_gyro_scale=
(st, val, val2);
> > +                               break;
> > +                       case IIO_ACCEL:
> > +                               result =3D inv_mpu6050_write_accel_scal=
e(st, val, val2);
> > +                               break;
> > +                       default:
> > +                               result =3D -EINVAL;
> > +                               break;
> > +                       }
> >                         break;
> > -               case IIO_ACCEL:
> > -                       result =3D inv_mpu6050_sensor_set(st,
> > -                                                       st->reg->accl_o=
ffset,
> > -                                                       chan->channel2,=
 val);
> > +               case IIO_CHAN_INFO_CALIBBIAS:
> > +                       switch (chan->type) {
> > +                       case IIO_ANGL_VEL:
> > +                               result =3D inv_mpu6050_sensor_set(st,
> > +                                                               st->reg=
->gyro_offset,
> > +                                                               chan->c=
hannel2, val);
> > +                               break;
> > +                       case IIO_ACCEL:
> > +                               result =3D inv_mpu6050_sensor_set(st,
> > +                                                               st->reg=
->accl_offset,
> > +                                                               chan->c=
hannel2, val);
> > +                               break;
> > +                       default:
> > +                               result =3D -EINVAL;
> > +                               break;
> > +                       }
> >                         break;
> >                 default:
> >                         result =3D -EINVAL;
> >                         break;
> >                 } =20
>=20
> Might be worth just making a helper, but ask Jonathan or Andy first.

Indent is indeed becoming too great.  So either a helper or the magic
cleanup.h handling for runtime pm autosuspend I suggest above
which I think would not require any indent changes.
>=20
> > -               break;
> > -       default:
> > -               result =3D -EINVAL;
> > -               break;
> > -       }
> >
> > -       pm_runtime_put_autosuspend(pdev);
> > -error_write_raw_unlock:
> > -       mutex_unlock(&st->lock);
> > +               pm_runtime_put_autosuspend(pdev);
> > +       }
> >         iio_device_release_direct(indio_dev);
> >
> >         return result;
> > @@ -1315,49 +1310,46 @@ inv_mpu6050_fifo_rate_store(struct device *dev,=
 struct device_attribute *attr,
> >         fifo_rate =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(d);
> >         fifo_period =3D NSEC_PER_SEC / fifo_rate;
> >
> > -       mutex_lock(&st->lock);
> > -       if (d =3D=3D st->chip_config.divider) {
> > -               result =3D 0;
> > -               goto fifo_rate_fail_unlock;
> > -       }
> > -
> > -       fifo_on =3D st->chip_config.accl_fifo_enable ||
> > -                 st->chip_config.gyro_fifo_enable ||
> > -                 st->chip_config.magn_fifo_enable;
> > -       result =3D inv_sensors_timestamp_update_odr(&st->timestamp, fif=
o_period, fifo_on);
> > -       if (result)
> > -               goto fifo_rate_fail_unlock;
> > +       scoped_guard(mutex, &st->lock) {
> > +               if (d =3D=3D st->chip_config.divider)
> > +                       return count;
> >
> > -       result =3D pm_runtime_resume_and_get(pdev);
> > -       if (result)
> > -               goto fifo_rate_fail_unlock;
> > +               fifo_on =3D st->chip_config.accl_fifo_enable ||
> > +                       st->chip_config.gyro_fifo_enable ||
> > +                       st->chip_config.magn_fifo_enable;
> > +               result =3D inv_sensors_timestamp_update_odr(&st->timest=
amp, fifo_period, fifo_on);
> > +               if (result)
> > +                       return result;
> >
> > -       result =3D regmap_write(st->map, st->reg->sample_rate_div, d);
> > -       if (result)
> > -               goto fifo_rate_fail_power_off;
> > -       st->chip_config.divider =3D d;
> > +               result =3D pm_runtime_resume_and_get(pdev);
> > +               if (result)
> > +                       return result;
> >
> > -       result =3D inv_mpu6050_set_lpf(st, fifo_rate);
> > -       if (result)
> > -               goto fifo_rate_fail_power_off;
> > +               result =3D regmap_write(st->map, st->reg->sample_rate_d=
iv, d);
> > +               if (!result) {
> > +                       st->chip_config.divider =3D d;
> >
> > -       /* update rate for magn, noop if not present in chip */
> > -       result =3D inv_mpu_magn_set_rate(st, fifo_rate);
> > -       if (result)
> > -               goto fifo_rate_fail_power_off;
> > +                       result =3D inv_mpu6050_set_lpf(st, fifo_rate);
> > +                       if (!result) {
> > +                               /* update rate for magn, noop if not pr=
esent in chip */
> > +                               result =3D inv_mpu_magn_set_rate(st, fi=
fo_rate);
> > +                       }
> >
> > -       /* update wom threshold since roc is dependent on sampling freq=
uency */
> > -       result =3D inv_mpu6050_set_wom_threshold(st, st->chip_config.ro=
c_threshold,
> > -                                              INV_MPU6050_FREQ_DIVIDER=
(st));
> > -       if (result)
> > -               goto fifo_rate_fail_power_off;
> > +                       if (!result) {
> > +                               /*
> > +                                * update wom threshold since roc is de=
pendent on
> > +                                * sampling frequency
> > +                                */
> > +                               result =3D inv_mpu6050_set_wom_threshol=
d(st,
> > +                                               st->chip_config.roc_thr=
eshold,
> > +                                               INV_MPU6050_FREQ_DIVIDE=
R(st));
> > +                       }
> > +               }
> >
> > -fifo_rate_fail_power_off:
> > -       pm_runtime_put_autosuspend(pdev);
> > -fifo_rate_fail_unlock:
> > -       mutex_unlock(&st->lock);
> > -       if (result)
> > -               return result;
> > +               pm_runtime_put_autosuspend(pdev);
> > +               if (result)
> > +                       return result;
> > +       } =20
>=20
> Can't guard()() be used here, or?
>=20
> >
> >         return count;
> >  }
> > @@ -1372,9 +1364,9 @@ inv_fifo_rate_show(struct device *dev, struct dev=
ice_attribute *attr,
> >         struct inv_mpu6050_state *st =3D iio_priv(dev_to_iio_dev(dev));
> >         unsigned fifo_rate;
> >
> > -       mutex_lock(&st->lock);
> > -       fifo_rate =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.=
divider);
> > -       mutex_unlock(&st->lock);
> > +       scoped_guard(mutex, &st->lock) {
> > +               fifo_rate =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip=
_config.divider);
> > +       } =20
>=20
> Don't need {} for a single line.
It's also fine to increase scope a tiny bit if all that gets incorporated
is either some basic maths, or a print.  So just use guard() instead of sco=
ped_guard()


>=20
> best regards,
> max
>=20
>=20
>=20
>=20
> >
> >         return sysfs_emit(buf, "%u\n", fifo_rate);
> >  }
> > @@ -1718,16 +1710,12 @@ static int inv_mpu6050_reg_access(struct iio_de=
v *indio_dev,
> >                                   unsigned int *readval)
> >  {
> >         struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > -       int ret;
> >
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >         if (readval)
> > -               ret =3D regmap_read(st->map, reg, readval);
> > -       else
> > -               ret =3D regmap_write(st->map, reg, writeval);
> > -       mutex_unlock(&st->lock);
> > +               return regmap_read(st->map, reg, readval);
> >
> > -       return ret;
> > +       return regmap_write(st->map, reg, writeval);
> >  }
> >
> >  static const struct iio_info mpu_info =3D {
> > @@ -2227,23 +2215,20 @@ static int inv_mpu_runtime_suspend(struct devic=
e *dev)
> >         unsigned int sensors;
> >         int ret;
> >
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         sensors =3D INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO |
> >                         INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MA=
GN |
> >                         INV_MPU6050_SENSOR_WOM;
> >         ret =3D inv_mpu6050_switch_engine(st, false, sensors);
> >         if (ret)
> > -               goto out_unlock;
> > +               return ret;
> >
> >         ret =3D inv_mpu6050_set_power_itg(st, false);
> >         if (ret)
> > -               goto out_unlock;
> > +               return ret;
> >
> >         inv_mpu_core_disable_regulator_vddio(st);
> > -
> > -out_unlock:
> > -       mutex_unlock(&st->lock);
> >         return ret;
return 0;

It can't be anything else if we get here and it's nice to make it
obvious where the 'good' exit path is.


Jonathan

> >  }
> >
> > --
> > 2.51.0
> >
> > =20

