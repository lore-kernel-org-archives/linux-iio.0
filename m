Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32976 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab3GRSIn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2013 14:08:43 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MQ500LL092DMA50@mailout2.w1.samsung.com> for
 linux-iio@vger.kernel.org; Thu, 18 Jul 2013 19:08:41 +0100 (BST)
Message-id: <51E82F28.7090305@samsung.com>
Date: Thu, 18 Jul 2013 20:08:40 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>,
	linux-iio@vger.kernel.org, s.nawrocki@samsung.com,
	Kyungmin Park <kyungmin.park@samsung.com>, lars@metafoo.de
Subject: Re: [PATCH/RFC v2] iio: gp2ap020a00f: Add a driver for the device
References: <1372258172-10996-1-git-send-email-j.anaszewski@samsung.com>
 <1372258172-10996-2-git-send-email-j.anaszewski@samsung.com>
 <51D9929C.30606@kernel.org>
In-reply-to: <51D9929C.30606@kernel.org>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2013 06:09 PM, Jonathan Cameron wrote:
[..]
 >> +error_ret:
 >> +	mutex_unlock(&data->lock);
 >> +
 >> +	return err<  0 ? err : IIO_VAL_INT;
 >> +}
 >> +
 > Any info available on how to convert these inputs to an illuminance 
value?
 > (e.g. in LUX)

There is info available, but the formula depends on the IR factor
that is read from in_illuminance_ir channel, i.e, it isn't constant and
can vary from conversion to conversion.
Moreover, the other factors in the formula also vary depending on
the lux mode set (I added lux mode configuration in the third
version of the patch).
I wasn't sure how to implement it with IIO, so any hint on how
to handle dynamically changing scale factor is welcomed.

[...]
 >> +
 >> +static int gp2ap020a00f_buffer_preenable(struct iio_dev *indio_dev)
 >> +{
 >> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 >> +	size_t d_size = 0;
 >> +	int i, err = 0;
 >> +
 > Without datasheet I'd like you to talk me through exactly what is 
going on
 > in here...
 >> +	mutex_lock(&data->lock);
 >> +
 >> +	/* Enable triggers according to the scan_mask */
 >> +	for_each_set_bit(i, indio_dev->active_scan_mask,
 >> +		indio_dev->masklength) {
 >> +		switch (i) {
 >> +		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
 >> +			err = gp2ap020a00f_exec_cmd(data,
 >> +					GP2AP020A00F_CMD_TRIGGER_CLEAR_EN);
 > So these triggers correspond to actually capturing the data based on some
 > other signal?  e.g. after these are set we'll get a steady stream
 > of data off the relevant part of the chip?

Actually both LIGHT_CLEAR and LIGHT_IR conversions are started after
setting the device in ALS mode. If the channel is disabled with IIO
its output value is simply ignored.
In order to enable PROXIMITY channel the PS part of the device has to
be enabled. The device can be set in ALS, PS or ALS_AND_PS modes.

 >> +			if (err<  0)
 >> +				goto error_ret;
 >> +			break;
 >> +		case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
 >> +			err = gp2ap020a00f_exec_cmd(data,
 >> +					GP2AP020A00F_CMD_TRIGGER_IR_EN);
 >> +			if (err<  0)
 >> +				goto error_ret;
 >> +			break;
 >> +		case GP2AP020A00F_SCAN_MODE_PROXIMITY:
 >> +			err = gp2ap020a00f_exec_cmd(data,
 >> +					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
 >> +			if (err<  0)
 >> +				goto error_ret;
 >> +			break;
 >> +		}
 >> +		d_size += 2;
 >> +	}
 >> +
 > Is this always guaranteed to be aligned?  Doesn't immediately look like
 > it and quite a bit of the buffer handling assumes it is.

I fixed it in the newest patch by using indio_dev->scan_bytes property.

 >> +	if (indio_dev->scan_timestamp)
 >> +		d_size += sizeof(s64);
 >> +
 >> +	data->buffer = kmalloc(d_size, GFP_KERNEL);
 >> +	if (data->buffer == NULL) {
 >> +		err = -ENOMEM;
 >> +		goto error_ret;
 >> +	}
 > You might to better with the update_scan_mode callback and using generic
 > preenable/postdisable.  Perhaps it is simpler this way, I'm not sure
 > without actually implementing it!

 From what I figured out update_scan_mode callback is called only
while enabling the trigger. How an IIO driver can be informed about
the end of triggered capture in different way than through
the buffer_postdisable callback?

 >> +
 >> +	err = iio_sw_buffer_preenable(indio_dev);
 >> +
 >> +error_ret:
 >> +	mutex_unlock(&data->lock);
 >> +
 >> +	return err;
 >> +}
 >> +
 >> +static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 >> +{
 >> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 >> +	int err;
 >> +
 >> +	mutex_lock(&data->lock);
 >> +
 > The fact you did the enable as a for_each_bit_set and this like this
 > is a little odd.  Actually I think the simple if statements here
 > are a little easier, but either way consistency of code structures
 > definitely makes my life easier, so pick one form or the other.

Fixed.

 >> +	if (test_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER,&data->flags)) {
 >> +		err = gp2ap020a00f_exec_cmd(data,
 >> +					GP2AP020A00F_CMD_TRIGGER_CLEAR_DIS);
 >> +		if (err<  0)
 >> +			goto error_ret;
 >> +	}
 >> +
 >> +	if (test_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER,&data->flags)) {
 >> +		err = gp2ap020a00f_exec_cmd(data,
 >> +					GP2AP020A00F_CMD_TRIGGER_IR_DIS);
 >> +		if (err<  0)
 >> +			goto error_ret;
 >> +	}
 >> +
 >> +	if (test_bit(GP2AP020A00F_FLAG_PS_TRIGGER,&data->flags)) {
 >> +		err = gp2ap020a00f_exec_cmd(data,
 >> +					GP2AP020A00F_CMD_TRIGGER_PROX_DIS);
 >> +		if (err<  0)
 >> +			goto error_ret;
 >> +	}
 > In the interests of symetry I'd expect this generic call to be the
 > first thing called in this function.

Fixed.


 >> +static int gp2ap020a00f_remove(struct i2c_client *client)
 >> +{
 >> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 >> +	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 >> +
 >
 > It's small and probably doesn't actually matter, but I'd expect
 > this release order to be the opposite of what we have in the probe
 > function (and hence to match the ordering in the error handling
 > just above here).  In that the irq is freed beffor the buffer_cleanup.
 >

Fixed.

Thanks,
Jacek

