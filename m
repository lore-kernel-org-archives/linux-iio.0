Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375924;
	b=0R4j8BiAGyMiZqmVI594grzKSZeeStDyQ60xEdyku39XfKHsO+xGRxY/uUpAgCHyvtBV
	 6vnHtE3Pi4K5ajRJgUXktkj30a2minLOVZju+6boTs5zRbEetzLeimEiOkpc6jq4THDhU
	 LRbnniS5LHzIowCzBaJJzgj08Q/9nJj3AEH1DcIXOxRsRthaq8OAe4doKoP2wHad5cCrh
	 hzCLMRt6wImNOjOnuf/W79NG6WaWHtt/0FUSuvKRg4oU7XanvFxiQ5n0AAUHZGa8EYWpO
	 0GMqkABTSiwxyjTO2RlAvHpMFmoXOya1Kh+aYRgcng2HJ8fgmwJAyaS3EdsMu1YoG8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375924;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mokG44W0CBr5Ra9LA6hA3Hh4JvCiiLYWzJGSDXH6PmQ=;
	b=fkY3N0UeN4R9bT5kaiBUFLuuoa7lyfpw4LYPyr9nrtSL8IFXW7WpDf6T0k9ZCYV/Z/sW
	 OITvKg60TYo2tfj5Qygm8CUoL8jihfm84vnJI1rfDx7RbV4X857npPayhbqhRS7V/462R
	 gwlbAKBuYlDYztHYJyu1jGJRZBDZa9vnpVv3cka128gFERQbAxuIn1a8ByCmC9o8WVB3J
	 05aBzFaAb3kyT7Iyr9kiehm0npNW7VMSlkER86K5WJUbYv6ELNoenO2FA82ibDlknuR0t
	 DyZrCn20V144nekmMrbSsgyY/BKLLRMlMQeUKypqXwlL80KfmneejMw1LgEgpBZNUzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cw4DHW23;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981BB606A31A;
	Sun, 22 Nov 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cw4DHW23
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DED41F000C6;
	Sun, 22 Nov 2026 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795375923;
	bh=mokG44W0CBr5Ra9LA6hA3Hh4JvCiiLYWzJGSDXH6PmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cw4DHW23CHeYjkLVjk09LEca6R9H5iafVD7rtfV9HTACBsKGMaJpiVnufw1jNsgX3
	 f5z1zzkpWIudhU28Qdye/CVdBBxvFWQe2fWj+p+bDXH+7OXq1SWPfv9AqHbxuwZbXl
	 MwVOT/FbYUJv4NHS8rKUuD144SEeHgsgfwFyr0BiuooThX/lE+vTmK20lTPV8JZkUT
	 sbIYOeXcuM4rAw7Os7HD+C4lTGbQjxgrSJdclVJFY9cQPn/3nOpDvaVg378nyBcsxV
	 opRMDF7FpM++hHk8Vay/0Nip6xmtP+F30zj7vXns+jfyw0UmgGJU8rPp/omlNJtT7p
	 tnnq3eevBcMJw==
Date: Sun, 22 Nov 2026 19:31:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, conor+dt@kernel.org,
 joshua.crofts1@gmail.com, maxwell@maxwelld.cc,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH 2/2] iio: chemical: acd10: Add driver for ACD10 CO2
 sensor
Message-ID: <20261122192823.6a3430e6@jic23-hlaptop>
In-Reply-To: <07fe3a575ad86493076d5061ed71c15e7b837a10.1795326744.git.akhilesh.patil@linux.dev>
References: <cover.1795326744.git.akhilesh.patil@linux.dev>
	<07fe3a575ad86493076d5061ed71c15e7b837a10.1795326744.git.akhilesh.patil@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Nov 2026 06:32:46 +0000
Akhilesh Patil <akhilesh.patil@linux.dev> wrote:

> Add driver for Aosong ASAIR ACD10 carbon dioxide sensor.
> Use serdev interface to communicate with sensor over UART.
> Implement read co2, get software revision, get instrument number
> commands.
> 
> Tested on TI am62x sk board on UART5 with 1200 baud rate.
> 
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>

A few things from sashiko. I didn't look at whether they were correct or not
https://sashiko.dev/#/patchset/cover.1795326744.git.akhilesh.patil%40linux.dev

Some other comments below.  Given this is a new driver, give it about a week
before sending v2 to allow others time to review.

Thanks,

Jonathan

> diff --git a/drivers/iio/chemical/acd10.c b/drivers/iio/chemical/acd10.c
> new file mode 100644
> index 000000000000..b92f01e7bf4a
> --- /dev/null
> +++ b/drivers/iio/chemical/acd10.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACD10 CO2 gas sensor driver
> + *
> + * Copyright (c) 2026 Akhilesh Patil <akhilesh.patil@linux.dev>
> + *
> + * Datasheet:
> + * https://www.es.co.th/Schemetic/PDF/ACD10.PDF
> + *
> + * TODO additional features:
> + *	1) single-point calibration feature.
> + *	2) Sensor preheat wait feature.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>

I haven't checked for things actually in device.h but make
sure this shouldn't be replaced with more specific headers.

> +#include <linux/errno.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/jiffies.h>
> +#include <linux/mod_devicetable.h>

Not needed any more unless something is wrong in the serdev
header. These are now assumed to always come from the bus header.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/serdev.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

> +
> +enum acd10_cmds {
> +	ACD10_CMD_READ_CO2 = 0,

Where they line up with values on the datasheet, I would always
specify them all. Doesn't matter so much when there are only 4
but for large lists it saves on a lot of counting!

> +	ACD10_CMD_CAL,
> +	ACD10_CMD_READ_SWREV,
> +	ACD10_CMD_READ_INS_NUM,
> +};
> +
> +struct acd10_cmd_info {
> +	u8 cmd_code;
> +	u8 tx_frame_len;
> +	u8 tx_data_len;
> +	u8 rx_frame_len;
> +};


> +
> +/*
> + * Do transfer based on command and fill drv_state->buf with received data.
> + * Caller of this function should use mutex drv_state->lock.

__must_hold() markings can change that documentation to something enforced
but the static analysis tools.

> + */
> +static int acd10_serdev_transfer(struct iio_dev *indio_dev, enum acd10_cmds cmd)
> +{
> +	struct acd10_state *drv_state = iio_priv(indio_dev);
> +	struct serdev_device *serdev = drv_state->serdev;
> +	struct device *dev = &indio_dev->dev;
> +	int ret;
> +
> +	/* Prepare transmit buffer along with checksum */
> +	drv_state->buf[0] = ACD10_FRAME_START;
> +	drv_state->buf[1] = ACD10_FRAME_FIXED_CODE;
> +	drv_state->buf[ACD10_FRAME_DATA_LEN_IDX] = cmd_info[cmd].tx_data_len;

Why do these two get IDX defines whils previous do not?

> +	drv_state->buf[ACD10_FRAME_CMD_CODE_IDX] = cmd_info[cmd].cmd_code;
> +	drv_state->buf[cmd_info[cmd].tx_frame_len - 1] =
> +		acd10_get_checksum(drv_state->buf, cmd_info[cmd].tx_frame_len);

Are there even any entries between this and the previous?  I would kind of
expect to see some zeroing of those prior to CRC given the code here.
If there aren't what is tx_frame_len for?


> +	drv_state->buf_idx = 0;
> +	drv_state->rx_expected_len = cmd_info[cmd].rx_frame_len;
> +	reinit_completion(&drv_state->buf_ready);
> +
> +	/* Transmit the buffer over serdev */
> +	ret = serdev_device_write(serdev, drv_state->buf, cmd_info[cmd].tx_frame_len,
> +				  ACD10_SERDEV_TIMEOUT);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != cmd_info[cmd].tx_frame_len)
> +		return -EIO;
> +
> +	/* Read the received bytes in buffer */
> +	ret = wait_for_completion_interruptible_timeout(&drv_state->buf_ready,
> +							ACD10_SERDEV_TIMEOUT);
> +	if (ret < 0)
> +		return ret;
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	/* validate frame header */
> +	if (drv_state->buf[0] != ACD10_FRAME_START ||
> +	    drv_state->buf[1] != ACD10_FRAME_FIXED_CODE) {
> +		dev_err(dev, "RX frame invalid\n");
> +		return -EIO;
> +	}
> +
> +	/* Maximum data len can be max 11 */
> +	if (drv_state->buf[ACD10_FRAME_DATA_LEN_IDX] > ACD10_FRAME_DATA_LEN_MAX)
> +		return -EIO;
> +
> +	/* Validate command echo */
> +	if (drv_state->buf[ACD10_FRAME_CMD_CODE_IDX] != cmd_info[cmd].cmd_code)
> +		return -EIO;
> +
> +	/* Validate checksum */

That's fairly obvious from the code.  Keep comment for where they add
value over what can be seen without.  Same applies to at least some of the ones above.

> +	if (drv_state->buf[cmd_info[cmd].rx_frame_len - 1] !=
> +	    acd10_get_checksum(drv_state->buf, cmd_info[cmd].rx_frame_len)) {
> +		dev_err(dev, "Checksum error\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int acd10_get_sw_rev(struct iio_dev *indio_dev)
> +{
> +	struct acd10_state *drv_state = iio_priv(indio_dev);
> +	struct device *dev = &indio_dev->dev;
> +	int ret;
> +
> +	ret = acd10_serdev_transfer(indio_dev, ACD10_CMD_READ_SWREV);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(drv_state->sw_rev, &drv_state->buf[ACD10_FRAME_DATA_START], 10);
> +	drv_state->sw_rev[10] = '\0';
> +
> +	dev_info(dev, "Software revision: %s\n", drv_state->sw_rev);

dev_dbg() probably.  

We tend to not print this stuff by default as it leads to ever more bloated
kernel logs.

> +
> +	return 0;
> +}
> +
> +static int acd10_get_instrument_num(struct iio_dev *indio_dev)
> +{
> +	struct acd10_state *drv_state = iio_priv(indio_dev);
> +	struct device *dev = &indio_dev->dev;
> +	int ret;
> +
> +	ret = acd10_serdev_transfer(indio_dev, ACD10_CMD_READ_INS_NUM);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(drv_state->inst_num, &drv_state->buf[ACD10_FRAME_DATA_START], 10);
> +	drv_state->inst_num[10] = '\0';
> +
> +	dev_info(dev, "Instrument number: %s\n", drv_state->inst_num);

Noisy.  I'm not sure what this is. Can it map to serial_number which is
standard ABI?

> +
> +	return 0;
> +}

> +static int acd10_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct acd10_state *drv_state = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +
> +		/* Read CO2 sensor value*/
> +		scoped_guard(mutex, &drv_state->lock) {
Preference where it is applicable is to use scope definition for case blocks that
need a guard.
	case IIO_CHAN_INFO_RAW: {
		int ret;

		guard(mutex)(&drv_state->lock);

		ret = acd10_serdev_transfer(indio_dev, ACD10_CMD_READ_CO2);
		if (ret)
			return ret;

		*val = get_unaligned_be16(&drv_state->buf[ACD10_FRAME_DATA_START]);

		return IIO_VAL_INT;
	}

Mostly because it remove unnecessary indent.
 
> +			ret = acd10_serdev_transfer(indio_dev, ACD10_CMD_READ_CO2);
> +			if (ret)
> +				return ret;
> +
> +			*val = get_unaligned_be16(&drv_state->buf[ACD10_FRAME_DATA_START]);
> +		}
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 100;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int acd10_probe(struct serdev_device *serdev)
> +{
> +	int ret;

Where ordering isn't required due to dependencies mild preference for
reverse xmas tree.

> +	struct device *dev = &serdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct acd10_state *drv_state;
> +	unsigned int baudrate;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct acd10_state));

sizeof(*drv_state)

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->name = "acd10";
> +	indio_dev->channels = acd10_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(acd10_channels);
> +	indio_dev->info = &acd10_info;
> +
> +	serdev_device_set_drvdata(serdev, indio_dev);
> +
> +	drv_state = iio_priv(indio_dev);
> +	drv_state->serdev = serdev;
> +
> +	init_completion(&drv_state->buf_ready);
> +	ret = devm_mutex_init(dev, &drv_state->lock);
> +	if (ret)
> +		return ret;
> +
> +	serdev_device_set_client_ops(serdev, &acd10_ser_ops);
> +	ret = devm_serdev_device_open(dev, serdev);
> +	if (ret) {
> +		dev_err(dev, "ACD10: serial device open failed\n");
> +		return ret;
		return dev_err_probe(dev, ret, ...

It's both shorter and saves any effort by reviewer to figure
out if deferral is possible on a given call.  Use this for every
error print in probe + any in functions only called from probe.

> +	}
> +
> +	baudrate = serdev_device_set_baudrate(serdev, ACD10_SERIAL_BAUDRATE);
> +	dev_info(dev, "baud rate set to: %u\n", baudrate);

Too noisy for a production driver.  dev_dbg() or drop it entirely.

> +	if (baudrate != ACD10_SERIAL_BAUDRATE) {
> +		dev_err(dev, "baud rate expected: %u, got: %u\n",
> +			ACD10_SERIAL_BAUDRATE, baudrate);
> +		return -EIO;
> +	}
> +	serdev_device_set_flow_control(serdev, false);
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret)
> +		return ret;
> +
> +	ret = acd10_get_sw_rev(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = acd10_get_instrument_num(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return devm_iio_device_register();

> +}


