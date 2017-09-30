Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58866 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdI3ReO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Sep 2017 13:34:14 -0400
Date: Sat, 30 Sep 2017 18:34:12 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: imu: inv_mpu6050: fix error path not turning
 chip back off
Message-ID: <20170930183412.7396c542@archlinux>
In-Reply-To: <CY4PR1201MB01842CD8EA85B1E528AB3F7DC47B0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB01846D4381783299959BFB64C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
        <20170715124447.3dd65c7e@jic23.retrosnub.co.uk>
        <20170925200110.0d1b3143@archlinux>
        <CY4PR1201MB01842CD8EA85B1E528AB3F7DC47B0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Sep 2017 12:06:09 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello Jonathan,
> 
> I would have liked to tell you that it is coming soon.
> But I don't see it coming before long (several months). If I have some free time somewhere, I will try to have a look to rework at least some patches.

I know the feeling all to well.  Good luck finding some time!

Jonathan

> 
> Jean-Baptiste
> 
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@jic23.retrosnub.co.uk] 
> Sent: lundi 25 septembre 2017 21:01
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Cc: linux-iio <linux-iio@vger.kernel.org>
> Subject: Re: [PATCH 1/5] iio: imu: inv_mpu6050: fix error path not turning chip back off
> 
> On Sat, 15 Jul 2017 12:44:47 +0100
> Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> 
> > On Thu, 13 Jul 2017 13:30:04 +0000
> > Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
> >   
> > > Some functions are turning the chip on and not back off in error 
> > > path. With set_power function using a reference counter this is 
> > > keeping the chip on forever.
> > > 
> > > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
> > Good fix in general, but there is one line that seems to be doing 
> > something else (marking the fifo disabled in a non error path).
> > May well be a good change, but it wants explaining and probably to be 
> > in a separate patch.  
> 
> Hi,
> 
> I see that a new version of this series is still to come.
> Any idea when/if you will get to it?
> 
> Thanks,
> 
> Jonathan
> > 
> > Thanks,
> > 
> > Jonathan  
> > > ---
> > >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 12 ++++++++----
> > >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 23 
> > > +++++++++++++++--------
> > >  2 files changed, 23 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c 
> > > b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > > index 44830bc..b1a8159 100644
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > > @@ -262,27 +262,31 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
> > >  	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
> > >  	result = regmap_write(st->map, st->reg->gyro_config, d);
> > >  	if (result)
> > > -		return result;
> > > +		goto error_power_off;
> > >  
> > >  	result = inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
> > >  	if (result)
> > > -		return result;
> > > +		goto error_power_off;
> > >  
> > >  	d = INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
> > >  	result = regmap_write(st->map, st->reg->sample_rate_div, d);
> > >  	if (result)
> > > -		return result;
> > > +		goto error_power_off;
> > >  
> > >  	d = (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
> > >  	result = regmap_write(st->map, st->reg->accl_config, d);
> > >  	if (result)
> > > -		return result;
> > > +		goto error_power_off;
> > >  
> > >  	memcpy(&st->chip_config, hw_info[st->chip_type].config,
> > >  	       sizeof(struct inv_mpu6050_chip_config));
> > >  	result = inv_mpu6050_set_power_itg(st, false);
> > >  
> > >  	return result;
> > > +
> > > +error_power_off:
> > > +	inv_mpu6050_set_power_itg(st, false);
> > > +	return result;
> > >  }
> > >  
> > >  static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, 
> > > int reg, diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c 
> > > b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > index 540070f..85c2732 100644
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > @@ -53,45 +53,52 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
> > >  			result = inv_mpu6050_switch_engine(st, true,
> > >  					INV_MPU6050_BIT_PWR_GYRO_STBY);
> > >  			if (result)
> > > -				return result;
> > > +				goto error_power_off;
> > >  		}
> > >  		if (st->chip_config.accl_fifo_enable) {
> > >  			result = inv_mpu6050_switch_engine(st, true,
> > >  					INV_MPU6050_BIT_PWR_ACCL_STBY);
> > >  			if (result)
> > > -				return result;
> > > +				goto error_power_off;
> > >  		}
> > >  		result = inv_reset_fifo(indio_dev);
> > >  		if (result)
> > > -			return result;
> > > +			goto error_power_off;
> > >  	} else {
> > >  		result = regmap_write(st->map, st->reg->fifo_en, 0);
> > >  		if (result)
> > > -			return result;
> > > +			goto error_power_off;
> > >  
> > >  		result = regmap_write(st->map, st->reg->int_enable, 0);
> > >  		if (result)
> > > -			return result;
> > > +			goto error_power_off;
> > >  
> > >  		result = regmap_write(st->map, st->reg->user_ctrl, 0);
> > >  		if (result)
> > > -			return result;
> > > +			goto error_power_off;
> > >  
> > >  		result = inv_mpu6050_switch_engine(st, false,
> > >  					INV_MPU6050_BIT_PWR_GYRO_STBY);
> > >  		if (result)
> > > -			return result;
> > > +			goto error_power_off;
> > > +		st->chip_config.gyro_fifo_enable = false;
> > >  
> > >  		result = inv_mpu6050_switch_engine(st, false,
> > >  					INV_MPU6050_BIT_PWR_ACCL_STBY);
> > >  		if (result)
> > > -			return result;
> > > +			goto error_power_off;
> > > +		st->chip_config.accl_fifo_enable = false;  
> > This one line doesn't fit with what the the patch is described as 
> > doing.  Looks like an independent change.
> > 
> > Could you explain why it is here please?
> >   
> > > +
> > >  		result = inv_mpu6050_set_power_itg(st, false);
> > >  		if (result)
> > >  			return result;
> > >  	}
> > >  
> > >  	return 0;
> > > +
> > > +error_power_off:
> > > +	inv_mpu6050_set_power_itg(st, false);
> > > +	return result;
> > >  }
> > >  
> > >  /**  
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

