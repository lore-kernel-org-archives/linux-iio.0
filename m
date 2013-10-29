Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from etezian.org ([198.101.225.253]:47208 "EHLO mail.etezian.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895Ab3J2NND (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 29 Oct 2013 09:13:03 -0400
Date: Tue, 29 Oct 2013 14:04:06 +0100
From: Andi Shyti <andi@etezian.org>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add Freescale MPL3115A2 pressure / temperature
 sensor driver
Message-ID: <20131029130406.GB3957@jack.whiskey>
References: <1383008486-10424-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383008486-10424-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> +static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	u8 buf[16]; /* 24-bit channel + 16-bit channel + padding + ts */
> +	int ret, pos = 0;
> +
> +	mutex_lock(&data->lock);
> +	ret = mpl3115_request(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		goto done;
> +	}
> +
> +	if (test_bit(0, indio_dev->active_scan_mask)) {
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +			MPL3115_OUT_PRESS, 3, &buf[pos]);
> +		if (ret < 0)
> +			goto done;
> +		pos += 3;
> +	}
> +
> +	if (test_bit(1, indio_dev->active_scan_mask)) {
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +			MPL3115_OUT_TEMP, 2, &buf[pos]);
> +		if (ret < 0)
> +			goto done;

Are you forgetting here to unlock?

Andi

> +	}
> +	mutex_unlock(&data->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +		iio_get_time_ns());
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
