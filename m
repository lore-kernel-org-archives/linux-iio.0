Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0067.outbound.protection.outlook.com ([104.47.34.67]:6273
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965484AbdIZMGL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Sep 2017 08:06:11 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/5] iio: imu: inv_mpu6050: fix error path not turning
 chip back off
Date: Tue, 26 Sep 2017 12:06:09 +0000
Message-ID: <CY4PR1201MB01842CD8EA85B1E528AB3F7DC47B0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB01846D4381783299959BFB64C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
        <20170715124447.3dd65c7e@jic23.retrosnub.co.uk>
 <20170925200110.0d1b3143@archlinux>
In-Reply-To: <20170925200110.0d1b3143@archlinux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

I would have liked to tell you that it is coming soon.
But I don't see it coming before long (several months). If I have some free=
 time somewhere, I will try to have a look to rework at least some patches.

Jean-Baptiste

-----Original Message-----
From: Jonathan Cameron [mailto:jic23@jic23.retrosnub.co.uk]=20
Sent: lundi 25 septembre 2017 21:01
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: imu: inv_mpu6050: fix error path not turning =
chip back off

On Sat, 15 Jul 2017 12:44:47 +0100
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> On Thu, 13 Jul 2017 13:30:04 +0000
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
>=20
> > Some functions are turning the chip on and not back off in error=20
> > path. With set_power function using a reference counter this is=20
> > keeping the chip on forever.
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Good fix in general, but there is one line that seems to be doing=20
> something else (marking the fifo disabled in a non error path).
> May well be a good change, but it wants explaining and probably to be=20
> in a separate patch.

Hi,

I see that a new version of this series is still to come.
Any idea when/if you will get to it?

Thanks,

Jonathan
>=20
> Thanks,
>=20
> Jonathan
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 12 ++++++++----
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 23=20
> > +++++++++++++++--------
> >  2 files changed, 23 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=20
> > b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index 44830bc..b1a8159 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -262,27 +262,31 @@ static int inv_mpu6050_init_config(struct iio_dev=
 *indio_dev)
> >  	d =3D (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
> >  	result =3D regmap_write(st->map, st->reg->gyro_config, d);
> >  	if (result)
> > -		return result;
> > +		goto error_power_off;
> > =20
> >  	result =3D inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
> >  	if (result)
> > -		return result;
> > +		goto error_power_off;
> > =20
> >  	d =3D INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
> >  	result =3D regmap_write(st->map, st->reg->sample_rate_div, d);
> >  	if (result)
> > -		return result;
> > +		goto error_power_off;
> > =20
> >  	d =3D (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
> >  	result =3D regmap_write(st->map, st->reg->accl_config, d);
> >  	if (result)
> > -		return result;
> > +		goto error_power_off;
> > =20
> >  	memcpy(&st->chip_config, hw_info[st->chip_type].config,
> >  	       sizeof(struct inv_mpu6050_chip_config));
> >  	result =3D inv_mpu6050_set_power_itg(st, false);
> > =20
> >  	return result;
> > +
> > +error_power_off:
> > +	inv_mpu6050_set_power_itg(st, false);
> > +	return result;
> >  }
> > =20
> >  static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st,=20
> > int reg, diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=20
> > b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > index 540070f..85c2732 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -53,45 +53,52 @@ static int inv_mpu6050_set_enable(struct iio_dev *i=
ndio_dev, bool enable)
> >  			result =3D inv_mpu6050_switch_engine(st, true,
> >  					INV_MPU6050_BIT_PWR_GYRO_STBY);
> >  			if (result)
> > -				return result;
> > +				goto error_power_off;
> >  		}
> >  		if (st->chip_config.accl_fifo_enable) {
> >  			result =3D inv_mpu6050_switch_engine(st, true,
> >  					INV_MPU6050_BIT_PWR_ACCL_STBY);
> >  			if (result)
> > -				return result;
> > +				goto error_power_off;
> >  		}
> >  		result =3D inv_reset_fifo(indio_dev);
> >  		if (result)
> > -			return result;
> > +			goto error_power_off;
> >  	} else {
> >  		result =3D regmap_write(st->map, st->reg->fifo_en, 0);
> >  		if (result)
> > -			return result;
> > +			goto error_power_off;
> > =20
> >  		result =3D regmap_write(st->map, st->reg->int_enable, 0);
> >  		if (result)
> > -			return result;
> > +			goto error_power_off;
> > =20
> >  		result =3D regmap_write(st->map, st->reg->user_ctrl, 0);
> >  		if (result)
> > -			return result;
> > +			goto error_power_off;
> > =20
> >  		result =3D inv_mpu6050_switch_engine(st, false,
> >  					INV_MPU6050_BIT_PWR_GYRO_STBY);
> >  		if (result)
> > -			return result;
> > +			goto error_power_off;
> > +		st->chip_config.gyro_fifo_enable =3D false;
> > =20
> >  		result =3D inv_mpu6050_switch_engine(st, false,
> >  					INV_MPU6050_BIT_PWR_ACCL_STBY);
> >  		if (result)
> > -			return result;
> > +			goto error_power_off;
> > +		st->chip_config.accl_fifo_enable =3D false;
> This one line doesn't fit with what the the patch is described as=20
> doing.  Looks like an independent change.
>=20
> Could you explain why it is here please?
>=20
> > +
> >  		result =3D inv_mpu6050_set_power_itg(st, false);
> >  		if (result)
> >  			return result;
> >  	}
> > =20
> >  	return 0;
> > +
> > +error_power_off:
> > +	inv_mpu6050_set_power_itg(st, false);
> > +	return result;
> >  }
> > =20
> >  /**
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html

