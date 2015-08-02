Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-138.synserver.de ([212.40.185.138]:1084 "EHLO
	smtp-out-138.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbbHBJpF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 05:45:05 -0400
Message-ID: <55BDE69D.3010708@metafoo.de>
Date: Sun, 02 Aug 2015 11:45:01 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>, marex@denx.de,
	matt@ohporter.com, pantelis.antoniou@gmail.com, jic23@kernel.org
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: add support for PulsedLight LIDAR
References: <1438401484-22101-1-git-send-email-mranostay@gmail.com> <1438401484-22101-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1438401484-22101-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/2015 05:58 AM, Matt Ranostay wrote:
> +static int lidar_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct lidar_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	if (iio_buffer_enabled(indio_dev) && mask == IIO_CHAN_INFO_RAW)
> +		return -EBUSY;

For this to work without race conditions you need to hold the
indio_dev->mlock while doing the check and until the conversion is done.

> +
> +	mutex_lock(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		u16 reg;
> +
> +		ret = lidar_get_measurement(data, &reg);
> +		if (!ret) {
> +			*val = reg / 100;
> +			*val2 = (reg % 100) * 10000;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		break;
> +	}

