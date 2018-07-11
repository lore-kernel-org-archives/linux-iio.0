Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34760 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbeGKPbb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jul 2018 11:31:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id s13-v6so15476133wmc.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jul 2018 08:26:38 -0700 (PDT)
Date: Wed, 11 Jul 2018 17:26:35 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: irq not handled unless data pushed
 to buffers
Message-ID: <20180711152634.GB12995@localhost.localdomain>
References: <1531297928-3824-1-git-send-email-jramirez@baylibre.com>
 <20180711122953.GC3871@localhost.localdomain>
 <2d1f0810-a6d0-3785-6692-003bb3f817e0@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d1f0810-a6d0-3785-6692-003bb3f817e0@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Jul 11, Jorge Ramirez-Ortiz wrote:
> On 07/11/2018 02:29 PM, Lorenzo Bianconi wrote:
> > > Currently IRQ_NONE is returned only when there is no data on the fifo.
> > > 
> > > When there is no data on the fifo the driver can not push to the
> > > buffers and therefore user space readers polling for data available
> > > will not be awoken and continue to wait.
> > > 
> > > This commit just extends the same semantics to fifo read errors.
> > Hi Jorge,
> > 
> > IRQ_NONE is used to indicate this interrupt is not intended for this driver
> > (this could happen if the irq line is in open-drain). If the interrupt is for
> > st_lsm6dsx I would prefer to return IRQ_HANDLED even in case of error.
> 
> yes I understand.
> 
> This was just a trivial attempt (I guess a really bad idea) to get some
> debug info (via /proc/irq/.../spurious) any time the driver read (spi/i2c)
> fails when processing the data ready irq.
> do you think it would make sense to add a dev_err to
> st_lsm6dsx_i2c_read/st_lsm6dsx_spi_read? at the moment the driver would fail
> silently

do you mean something like (just compiled, not tested):

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -298,8 +298,11 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	err = regmap_bulk_read(hw->regmap,
 			       hw->settings->fifo_ops.fifo_diff.addr,
 			       &fifo_status, sizeof(fifo_status));
-	if (err < 0)
+	if (err < 0) {
+		dev_err(hw->dev, "failed to read fifo status reg (err=%d)\n",
+			err);
 		return err;
+	}
 
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
@@ -313,8 +316,12 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw, hw->buff, pattern_len);
-		if (err < 0)
+		if (err < 0) {
+			dev_err(hw->dev,
+				"failed to read pattern from fifo (err=%d)\n",
+				err);
 			return err;
+		}
 
 		/*
 		 * Data are written to the FIFO with a specific pattern
@@ -385,8 +392,11 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 
 	if (unlikely(reset_ts)) {
 		err = st_lsm6dsx_reset_hw_ts(hw);
-		if (err < 0)
+		if (err < 0) {
+			dev_err(hw->dev, "failed to reset hw ts (err=%d)\n",
+				err);
 			return err;
+		}
 	}
 	return read_len;
 }

Regards,
Lorenzo

> 
> thanks for coming back to me despite the bad patch
> 
> > 
> > Regards,
> > Lorenzo
> > 
> > > Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
> > > ---
> > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index 4994f92..4959923 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > @@ -472,7 +472,7 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> > >   	count = st_lsm6dsx_read_fifo(hw);
> > >   	mutex_unlock(&hw->fifo_lock);
> > > -	return !count ? IRQ_NONE : IRQ_HANDLED;
> > > +	return (!count || count < 0) ? IRQ_NONE : IRQ_HANDLED;
> > >   }
> > >   static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
> > > -- 
> > > 2.7.4
> > > 
> 
