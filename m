Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbdFMUUE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Jun 2017 16:20:04 -0400
Date: Tue, 13 Jun 2017 21:20:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: test whoami first and against
 all known values
Message-ID: <20170613212000.02d589fb@kernel.org>
In-Reply-To: <CY4PR1201MB0184D24BB25046C8B2883FB3C4CD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <BLUPR12MB06572FF309979BB42C095E07C4CB0@BLUPR12MB0657.namprd12.prod.outlook.com>
        <20170611135844.7deb0c51@kernel.org>
        <CY4PR1201MB0184D24BB25046C8B2883FB3C4CD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Jun 2017 09:18:11 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> >From: Jonathan Cameron <jic23@kernel.org>
> >Sent: Sunday, June 11, 2017 14:58
> >To: Jean-Baptiste Maneyrol
> >Cc: linux-iio
> >Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: test whoami first and against all known values
> >   
> >On Tue, 6 Jun 2017 10:29:52 +0000
> >Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
> >  
> >> SPI bus is never generating error during transfer, so to check if
> >> a chip is correctly connected on a SPI bus we enforce whoami check
> >> to be correct. In this way we can assure SPI probe is failing if
> >> there is no chip connected.
> >> 
> >> Fixes: cec0154556f8 ("iio: inv_mpu6050: Check WHO_AM_I register on probe")
> >> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> >> Cc: <stable@vger.kernel.org>  
> >Hi Jean-Baptiste.
> >
> >I'm happy with the patch, however it's a fix for an issue with a platform
> >rather than the driver itself. That needs to be explained in the patch
> >description.  In particular do you have some examples we can list to
> >justify the change?
> >
> >Otherwise, I'm thinking this is a 'nice to have' that wants to go via
> >the next merge window rather than going in as a fix.
> >
> >Jonathan  
> Hi Jonathan,
> 
> I think that this is really a driver issue. Having a probe function that doesn't
> return an error when there is no chip responding is more of a driver issue in my
> own opinion. This makes things more difficult to debug it there is any hardware
> issue.
Easy to argue both ways ;)A
a platform that says a chips it there that isn't is a platform issue to me.
Numerous SPI chips are completely impossible to probe for.  Query and ADC and
it returns a value of 0.  Well, maybe the value is zero ;)

> 
> This is affecting our internal test platform which is completely custom. I
> don't know if adding this example is interesting or not.
> 
> In any case, no problem with me to have this going only into the next merge
> window.
I'll queue it up - but will drop the stable tag as I don't really want this
pulled back across stable kernels unless we have boards out there that
actually need it. I've left the fixes tag in, but added a comment to why
I'm not marking it for stable.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
>
> Thanks for your review.
> Jean-Baptiste
> >> ---
> >>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 33 ++++++++++++++++++++++--------
> >>  1 file changed, 24 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c  
> > index 96dabbd..af1b536 100644  
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> >> @@ -770,27 +770,42 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
> >>  {
> >>        int result;
> >>        unsigned int regval;
> >> +     int i;
> >>  
> >>        st->hw  = &hw_info[st->chip_type];
> >>        st->reg = hw_info[st->chip_type].reg;
> >>  
> >> -     /* reset to make sure previous state are not there */
> >> -     result = regmap_write(st->map, st->reg->pwr_mgmt_1,
> >> -                           INV_MPU6050_BIT_H_RESET);
> >> -     if (result)
> >> -             return result;
> >> -     msleep(INV_MPU6050_POWER_UP_TIME);
> >> -
> >>        /* check chip self-identification */
> >>        result = regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
> >>        if (result)
> >>                return result;
> >>        if (regval != st->hw->whoami) {
> >> -             dev_warn(regmap_get_device(st->map),
> >> -                             "whoami mismatch got %#02x expected %#02hhx for %s\n",
> >> +             /* check whoami against all possible values */
> >> +             for (i = 0; i < INV_NUM_PARTS; ++i) {
> >> +                     if (regval == hw_info[i].whoami) {
> >> +                             dev_warn(regmap_get_device(st->map),
> >> +                                     "whoami mismatch got %#02x (%s)"
> >> +                                     "expected %#02hhx (%s)\n",
> >> +                                     regval, hw_info[i].name,
> >> +                                     st->hw->whoami, st->hw->name);
> >> +                             break;
> >> +                     }
> >> +             }
> >> +             if (i >= INV_NUM_PARTS) {
> >> +                     dev_err(regmap_get_device(st->map),
> >> +                             "invalid whoami %#02x expected %#02hhx (%s)\n",
> >>                                regval, st->hw->whoami, st->hw->name);
> >> +                     return -ENODEV;
> >> +             }
> >>        }
> >>  
> >> +     /* reset to make sure previous state are not there */
> >> +     result = regmap_write(st->map, st->reg->pwr_mgmt_1,
> >> +                           INV_MPU6050_BIT_H_RESET);
> >> +     if (result)
> >> +             return result;
> >> +     msleep(INV_MPU6050_POWER_UP_TIME);
> >> +
> >>        /*
> >>         * toggle power state. After reset, the sleep bit could be on
> >>         * or off depending on the OTP settings. Toggling power would  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

