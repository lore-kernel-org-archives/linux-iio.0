Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:57661 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbFZLB5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 26 Jun 2015 07:01:57 -0400
Message-ID: <558D3116.5060906@gmx.de>
Date: Fri, 26 Jun 2015 13:01:42 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: sx9500: optimize power usage
References: <1428858561-27994-1-git-send-email-vlad.dogaru@intel.com> <1428858561-27994-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428858561-27994-2-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Vlad Dogaru schrieb am 12.04.2015 um 19:09:
> In the interest of lowering power usage, we only activate the proximity
> channels and interrupts that we are currently using.
> 
> For raw reads, we activate the corresponding channel and the data ready
> interrupt and wait for the interrupt to trigger.  If no interrupt is
> available, we wait for the documented scan period, as specified in the
> datasheet.
> 

Hi,
I have a question inline, and also spotted a bug.

<...>

> +static int sx9500_read_proximity(struct sx9500_data *data,
> +				 const struct iio_chan_spec *chan,
> +				 int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +
> +	ret = sx9500_inc_chan_users(data, chan->channel);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = sx9500_inc_data_rdy_users(data);
> +	if (ret < 0)
> +		goto out_dec_chan;
> +
> +	mutex_unlock(&data->mutex);
> +
> +	if (data->client->irq > 0)
> +		ret = wait_for_completion_interruptible(&data->completion);
> +	else
> +		ret = sx9500_wait_for_sample(data);
> +
> +	if (ret < 0)
> +		return ret;

If an error is encountered from here on, the device won't be able to enter
a low power mode again, since you don't decrease the chan_users[chan] and
data_rdy_users elements of sx9500_data. Is this intended?

> +
> +	mutex_lock(&data->mutex);
> +
> +	ret = sx9500_read_prox_data(data, chan, val);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = sx9500_dec_chan_users(data, chan->channel);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = sx9500_dec_data_rdy_users(data);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = IIO_VAL_INT;
> +
> +	goto out;
> +
> +out_dec_chan:
> +	sx9500_dec_chan_users(data, chan->channel);
> +out:
> +	mutex_unlock(&data->mutex);
> +	reinit_completion(&data->completion);
> +
> +	return ret;
>  }

<...>

  
> +/* Activate all channels and perform an initial compensation. */
> +static int sx9500_init_compensation(struct iio_dev *indio_dev)
> +{
> +	struct sx9500_data *data = iio_priv(indio_dev);
> +	int i, ret;
> +	unsigned int val;
> +
> +	ret = regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
> +				 GENMASK(SX9500_NUM_CHANNELS, 0),
> +				 GENMASK(SX9500_NUM_CHANNELS, 0));

This mask should just reach until SX9500_NUM_CHANNELS - 1. Right now it 
messes with the lowest bit of SCANPERIOD. Why not define the channel mask
with all other definitions and use a catchy name here?
Thanks,

Hartmut
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 10; i >= 0; i--) {
> +		usleep_range(10000, 20000);
> +		ret = regmap_read(data->regmap, SX9500_REG_STAT, &val);
> +		if (ret < 0)
> +			goto out;
> +		if (!(val & SX9500_COMPSTAT_MASK))
> +			break;
> +	}
> +
> +	if (i < 0) {
> +		dev_err(&data->client->dev, "initial compensation timed out");
> +		ret = -ETIMEDOUT;
> +	}
> +
> +out:
> +	regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
> +			   GENMASK(SX9500_NUM_CHANNELS, 0), 0);
> +	return ret;
> +}
> +


