Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeKLC3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:29:17 -0500
Date: Sun, 11 Nov 2018 16:40:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/9] iio: imu: st_lsm6dsx: add i2c embedded
 controller support
Message-ID: <20181111164012.47b963b4@archlinux>
In-Reply-To: <c9a134df6858ee2f290c844be18f8c2cef54c559.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
        <c9a134df6858ee2f290c844be18f8c2cef54c559.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 15:15:33 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> i2c controller embedded in lsm6dx series can connect up to four
> slave devices using accelerometer sensor as trigger for i2c
> read/write operations.
> Introduce sensor hub support for lsm6dso sensor. Add register map
> for lis2mdl magnetometer sensor.
> In order to perform single read/write operations st_lsm6dsx driver
> relies on SLV0 channel (hw FIFO is not supported yet)
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Hi Lorenzo.

A build warning came up pointing out an issue with little endian
sizes.

I've 'guessed' that data is actually meant to be __le16 but
please confirm I got that right!

> +static int
> +st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
> +			     struct iio_chan_spec const *ch,
> +			     int *val)
> +{
> +	int err, delay, len = ch->scan_type.realbits >> 3;
> +	__le32 data;
> +
> +	err = st_lsm6dsx_shub_set_enable(sensor, true);
> +	if (err < 0)
> +		return err;
> +
> +	delay = 1000000 / sensor->odr;
> +	usleep_range(delay, 2 * delay);
> +
> +	err = st_lsm6dsx_shub_read(sensor, ch->address, (u8 *)&data, len);
> +	if (err < 0)
> +		return err;
> +
> +	st_lsm6dsx_shub_set_enable(sensor, false);
> +
> +	switch (len) {
> +	case 2:
> +		*val = (s16)le16_to_cpu(data);
This one is odd given data is an __le32?
What's going on here?

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
