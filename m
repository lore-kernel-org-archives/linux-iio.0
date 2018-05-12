Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56000 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELJiw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 May 2018 05:38:52 -0400
Date: Sat, 12 May 2018 10:38:49 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: imu: inv_mpu6050: skip first sample when gyro
 is on
Message-ID: <20180512103849.55ddcb16@archlinux>
In-Reply-To: <50eccb4a-3a3c-2cd8-83ca-a304e71390a3@invensense.com>
References: <1525083251-8368-1-git-send-email-jmaneyrol@invensense.com>
        <1525083251-8368-3-git-send-email-jmaneyrol@invensense.com>
        <20180506180015.52902895@archlinux>
        <50eccb4a-3a3c-2cd8-83ca-a304e71390a3@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 8 May 2018 16:40:13 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> On 06/05/2018 19:00, Jonathan Cameron wrote:
> > On Mon, 30 Apr 2018 12:14:10 +0200
> > Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
> >   
> >> Implement generic skip first samples mechanism and use it to
> >> filter out first sample when gyro is on.
> >>
> >> The problem for these chips is that the first sample of the gyro
> >> is out of specs, because gyro is not completely stabilized. To
> >> ensure all data are within sensor specs, we just skip the first
> >> sample when turning gyro on.
> >>
> >> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
> > Neat and tidy solution so good.
> > Is there a similar issue in the read_raw path which seems to just
> > flick the gyro on then read from it immediately?
> > 
> > I may be missing a delay there which is preventing the data being
> > bad though.
> > 
> > Jonathan  
> Hello,
> 
> effectively raw reading should be affected. Since it is using direct 
> sensor register reading, it should requires adding a correct sleep time. 
> But direct reading like this is really not very reliable (turn chip and 
> sensor on/off everytime, which is very bad for stability).
> 
> Is it possible to send later an additional patch for fixing this issue 
> and accept this one? The fix for the 2 are completely unrelated since it 
> doesn't use the same mechanism (FIFO reading vs register reading).
Sure, that is fine. I think I just forgot to say I had applied this.
Sorry about that.

Jonathan

> 
> Thanks.
> JB
> >> ---
> >>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 1 +
> >>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 7 ++++++-
> >>   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 3 +++
> >>   3 files changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> >> index 142a835..dfb9e4e 100644
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> >> @@ -148,6 +148,7 @@ struct inv_mpu6050_state {
> >>   	struct regmap *map;
> >>   	int irq;
> >>   	u8 irq_mask;
> >> +	unsigned skip_samples;
> >>   };
> >>   
> >>   /*register and associated bit definition*/
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> >> index e51404f..1b57354 100644
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> >> @@ -185,7 +185,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> >>   		if (result == 0)
> >>   			timestamp = 0;
> >>   
> >> -		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> >> +		/* skip first samples if needed */
> >> +		if (st->skip_samples)
> >> +			st->skip_samples--;
> >> +		else
> >> +			iio_push_to_buffers_with_timestamp(indio_dev, data,
> >> +							   timestamp);
> >>   
> >>   		fifo_count -= bytes_per_datum;
> >>   	}
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> >> index 8a9f869..0d7db27 100644
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> >> @@ -49,11 +49,14 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
> >>   		if (result)
> >>   			return result;
> >>   		inv_scan_query(indio_dev);
> >> +		st->skip_samples = 0;
> >>   		if (st->chip_config.gyro_fifo_enable) {
> >>   			result = inv_mpu6050_switch_engine(st, true,
> >>   					INV_MPU6050_BIT_PWR_GYRO_STBY);
> >>   			if (result)
> >>   				goto error_power_off;
> >> +			/* gyro first sample is out of specs, skip it */
> >> +			st->skip_samples = 1;
> >>   		}
> >>   		if (st->chip_config.accl_fifo_enable) {
> >>   			result = inv_mpu6050_switch_engine(st, true,  
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >   

