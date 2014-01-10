Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:51964 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbaAJLhM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Jan 2014 06:37:12 -0500
Date: Fri, 10 Jan 2014 12:37:06 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add Lite-On ltr501 ambient light / proximity sensor
 driver
In-Reply-To: <52CFBC9D.4070509@metafoo.de>
Message-ID: <alpine.DEB.2.01.1401101221001.9334@pmeerw.net>
References: <1389133660-28024-1-git-send-email-pmeerw@pmeerw.net> <52CFBC9D.4070509@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> > +static int ltr501_read_raw(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int *val, int *val2, long mask)
> > +{
> > +	struct ltr501_data *data = iio_priv(indio_dev);
> > +	__le16 buf[2];
> > +	int ret, i;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (iio_buffer_enabled(indio_dev))
> > +			return -EBUSY;
> > +
> > +		switch (chan->type) {
> > +		case IIO_INTENSITY:
> > +			ret = ltr501_drdy(data, LTR501_STATUS_ALS_RDY);
> > +			if (ret < 0)
> > +				return ret;
> > +			/* always read both ALS channels in given order */
> > +			ret = i2c_smbus_read_i2c_block_data(data->client,
> > +				LTR501_ALS_DATA1, sizeof(buf), (u8 *) buf);
> > +			if (ret < 0)
> > +				return ret;
> > +			*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
> > +				buf[0] : buf[1]);
> > +			return IIO_VAL_INT;
> > +		case IIO_PROXIMITY:
> > +			ret = ltr501_drdy(data, LTR501_STATUS_PS_RDY);
> > +			if (ret < 0)
> > +				return ret;
> > +			ret = i2c_smbus_read_word_data(data->client,
> > +				chan->address);
> > +			if (ret < 0)
> > +				return ret;
> > +			*val = ret & LTR501_PS_DATA_MASK;
> > +			return IIO_VAL_INT;
> 
> Will anything bad happen if two processes concurrently read from the device?

ALS and PS measurements use separate registers and therefore should not 
interfere

at first I'd have said the worst thing would be that the same data is read 
twice... however, the data ready loop can be an issue:

two processes wait for data to become available: one process sees the 
drdy bit and by reading the data resets the drdy, the other process 
does not see the drdy and decrements its retry counter and may eventually
report a failed IO

so, I'll add two separate mutexse for ALS and PS

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
