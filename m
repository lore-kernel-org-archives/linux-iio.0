Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17267 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbbJSObo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 Oct 2015 10:31:44 -0400
Date: Mon, 19 Oct 2015 17:30:50 +0300
From: Teodora Baluta <teodora.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, dan.carpenter@oracle.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: add support for Memsic MXC6255XC sensor
Message-ID: <20151019143050.GB18952@hard-bop>
References: <1444991368-14609-1-git-send-email-teodora.baluta@intel.com>
 <5624CB82.4000600@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5624CB82.4000600@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 19, 2015 at 12:52:50PM +0200, Lars-Peter Clausen wrote:
> On 10/16/2015 12:29 PM, Teodora Baluta wrote:
> > This patch adds a minimal implementation for the Memsic MXC6255XC
> > orientation sensing accelerometer. The supported operations are reading
> > raw acceleration values for X/Y axis that can be scaled using the
> > exposed scale.
> > 
> > Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
> 
> Looks quite good in general, a few minor things inline.

Thanks for the review. I'll send a v2 as soon as possible.

> 
> [...]
> > +/* scale value for +/- 2G measurement range */
> > +static const int mxc6255_scale = 153829;
> > +
> > +static IIO_CONST_ATTR(in_accel_scale_available, MXC6255_SCALE_AVAIL);
> 
> If there is only one scale available it does not make too much sense to have
> a scale_available attribute.
> 
> [..]
> > +static int mxc6255_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct mxc6255_data *data = iio_priv(indio_dev);
> > +	unsigned int reg;
> > +	int axis = chan->channel2 - 1;
> 
> 1 is a bit of a magic constant here. Use IIO_MOD_X instead. Or even better
> use chan->address.
> 
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = regmap_read(data->regmap,
> > +				  MXC6255_AXIS_TO_REG(axis), &reg);
> > +		if (ret < 0) {
> > +			dev_err(&data->client->dev,
> > +				"Error reading axis %d\n", axis);
> > +			return ret;
> > +		}
> > +
> > +		*val = sign_extend32(reg, 7);
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 0;
> > +		*val2 = mxc6255_scale;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> [...]
> > +static int mxc6255_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> [...]
> > +	ret = regmap_read(data->regmap, MXC6255_REG_CHIP_ID, &chip_id);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Error reading chip id %d\n", ret);
> > +		return ret;
> > +	}
> 
> Does it make sense to check whether chip ID matches the expected value, to
> catch mistakes where the I2C address is incorrect?
> 
> > +
> > +	dev_dbg(&client->dev, "Chip id %x\n", chip_id);
> > +
> > +	ret = devm_iio_device_register(&client->dev, indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Could not register IIO device\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> [...]
