Return-Path: <SRS0=sf9n=J4=redhat.com=lorenzo.bianconi@kernel.org>
Date: Thu, 12 Jul 2018 09:59:34 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: irq not handled unless data pushed
 to buffers
Message-ID: <20180712075933.GA3982@localhost.localdomain>
References: <1531297928-3824-1-git-send-email-jramirez@baylibre.com>
 <20180711122953.GC3871@localhost.localdomain>
 <2d1f0810-a6d0-3785-6692-003bb3f817e0@baylibre.com>
 <20180711152634.GB12995@localhost.localdomain>
 <6ba8103f-acd4-9964-bcec-e858e61851ad@baylibre.com>
 <20180711163427.GC12995@localhost.localdomain>
 <7f921bb7-3488-f1b7-3f43-be4c370b303d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7f921bb7-3488-f1b7-3f43-be4c370b303d@baylibre.com>
List-ID: <linux-iio@vger.kernel.org>

> On 07/11/2018 06:34 PM, Lorenzo Bianconi wrote:
> > > On 07/11/2018 05:26 PM, Lorenzo Bianconi wrote:
> > > > On Jul 11, Jorge Ramirez-Ortiz wrote:
> > > > > On 07/11/2018 02:29 PM, Lorenzo Bianconi wrote:
> > > > > > > Currently IRQ_NONE is returned only when there is no data on the fifo.
> > > > > > > 
> > > > > > > When there is no data on the fifo the driver can not push to the
> > > > > > > buffers and therefore user space readers polling for data available
> > > > > > > will not be awoken and continue to wait.
> > > > > > > 
> > > > > > > This commit just extends the same semantics to fifo read errors.
> > > > > > Hi Jorge,
> > > > > > 
> > > > > > IRQ_NONE is used to indicate this interrupt is not intended for this driver
> > > > > > (this could happen if the irq line is in open-drain). If the interrupt is for
> > > > > > st_lsm6dsx I would prefer to return IRQ_HANDLED even in case of error.
> > > > > yes I understand.
> > > > > 
> > > > > This was just a trivial attempt (I guess a really bad idea) to get some
> > > > > debug info (via /proc/irq/.../spurious) any time the driver read (spi/i2c)
> > > > > fails when processing the data ready irq.
> > > > > do you think it would make sense to add a dev_err to
> > > > > st_lsm6dsx_i2c_read/st_lsm6dsx_spi_read? at the moment the driver would fail
> > > > > silently
> > > > do you mean something like (just compiled, not tested):
> > > > 
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > @@ -298,8 +298,11 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> > > >    	err = regmap_bulk_read(hw->regmap,
> > > >    			       hw->settings->fifo_ops.fifo_diff.addr,
> > > >    			       &fifo_status, sizeof(fifo_status));
> > > > -	if (err < 0)
> > > > +	if (err < 0) {
> > > > +		dev_err(hw->dev, "failed to read fifo status reg (err=%d)\n",
> > > > +			err);
> > > >    		return err;
> > > > +	}
> > > >    	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
> > > >    		return 0;
> > > > @@ -313,8 +316,12 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> > > >    	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
> > > >    		err = st_lsm6dsx_read_block(hw, hw->buff, pattern_len);
> > > > -		if (err < 0)
> > > > +		if (err < 0) {
> > > > +			dev_err(hw->dev,
> > > > +				"failed to read pattern from fifo (err=%d)\n",
> > > > +				err);
> > > >    			return err;
> > > > +		}
> > > >    		/*
> > > >    		 * Data are written to the FIFO with a specific pattern
> > > > @@ -385,8 +392,11 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> > > >    	if (unlikely(reset_ts)) {
> > > >    		err = st_lsm6dsx_reset_hw_ts(hw);
> > > > -		if (err < 0)
> > > > +		if (err < 0) {
> > > > +			dev_err(hw->dev, "failed to reset hw ts (err=%d)\n",
> > > > +				err);
> > > >    			return err;
> > > > +		}
> > > >    	}
> > > >    	return read_len;
> > > >    }
> > > > 
> > > > Regards,
> > > > Lorenzo
> > > 
> > > yes, you beat me to it but yes, that is what I was thinking about.
> > > 
> > Ops, it was not intended as a race :). Feel free to send your patch since you
> > proposed the idea.
> 
> hey of course not :) please go ahead with your change! got to start packing
> for my summer break anyways :)
> 
> I was working this morning validating the driver on the LSM6DS33TR with
> libiio and it is all good btw.

According to the wai, LSM6DS33TR should be compatible with LSM6DS3/LSM6DS3H
(I just looked at wai val, not all ds). If so I guess you can add explicit
support for it (after your vacation :))

Regards,
Lorenzo

> 
> 
> 
> 
