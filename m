Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:52512 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDORHL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Apr 2018 13:07:11 -0400
Date: Sun, 15 Apr 2018 18:07:06 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Martin Kelly <martin@martingkelly.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: do not flush fifo when iio
 buffer is full
Message-ID: <20180415180706.126bcd02@archlinux>
In-Reply-To: <673bbcd1-f2f8-33ca-9920-db2289d10ce0@martingkelly.com>
References: <1523607906-22485-1-git-send-email-jmaneyrol@invensense.com>
        <673bbcd1-f2f8-33ca-9920-db2289d10ce0@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 14 Apr 2018 11:00:07 -0700
Martin Kelly <martin@martingkelly.com> wrote:

> On 04/13/2018 01:25 AM, Jean-Baptiste Maneyrol wrote:
> > There is no need to flush fifo and loose all data when the iio
> > buffer is full. Just drop the data by ignoring the error as
> > commonly done in other drivers.
> > 
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > ---
> >   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > index ff81c6a..27c663c 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > @@ -170,10 +170,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> >   		if (result == 0)
> >   			timestamp = 0;
> >   
> > -		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
> > -							    timestamp);
> > -		if (result)
> > -			goto flush_fifo;
> > +		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> > +
> >   		fifo_count -= bytes_per_datum;
> >   	}
> >   
> >   
> 
> Reviewed-by: Martin Kelly <martin@martingkelly.com>
> 
> I wondered the same thing as I was reading this code :).

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

