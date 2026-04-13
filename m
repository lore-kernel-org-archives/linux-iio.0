Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3503E1CE4;
	Mon, 13 Apr 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108247; cv=none; b=p2a3NyO2bnueW7naTSFK/0ivbBkDSpCjH4UkXBYF3fzcn8okfVUxaFbmDKzafXlCQGeXveFrPVfUbGKwUKTTB7UNCTF3cJqL6jdKIigg2vQPSrbuAU94tMmlMRKKBX6utugcH5cSexVR+TKdkJU5QgOwG92Q2Lr+CgT6TdhLICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108247; c=relaxed/simple;
	bh=8KRDSTf0HhUXanWQxJnM/XPPYz1LpFytWo8+xt8KtaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2EMs1Nhp2fAs21UTv1EdRSIpgTDh2kUxT8eii377TAXMuXnrAnXWmmweR6LlBISM5zG7EpYvtKKyDBqA9ja0QffA6G/6kxWwx1FBpEHKcSJ6v8PTCepWEj+loB0Zq6gk8i6/tSw87P7KZIX46usVB6NEhGjl0U6huEMKYAwuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKJ8BJRM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKJ8BJRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B7FC2BCB0;
	Mon, 13 Apr 2026 19:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776108246;
	bh=8KRDSTf0HhUXanWQxJnM/XPPYz1LpFytWo8+xt8KtaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QKJ8BJRMIk/MY+JQFaFy5ITnNH1++UGk+PmoHYsgm1cxoR1KAe+s5D/w7x/lAjxwt
	 vtrcQCSXOn/S7pXDgJi7rK2nBpMFZ7+fT4qrdJq6G3pUfTeDYodH5tJChdKq4rMBpx
	 mEa8/vtm5qGsfZGg1dwWx79GChM1y4dU3zolueaw5SJZnzSti2pnniZAYUj0VDAUPr
	 M0ebI+oNOL9S1b6/O5ueyBhhVmPrlYzmSS4uEoz19XGqnlL4iCLrkNt/NMpTIPy1uh
	 4J0ppdluBnBQjYROlK4EVkwKGyQmnRvtCFWHx5lGFTr1fR3w0GQhbGN0cvF+/j9AEb
	 xIZs3Tx+a1HGQ==
Date: Mon, 13 Apr 2026 20:23:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 4/9] iio: imu: inv_icm42607: Add Buffer support
 functions to icm42607
Message-ID: <20260413202356.1afb4b8f@jic23-huawei>
In-Reply-To: <20260330195853.392877-5-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
	<20260330195853.392877-5-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 14:58:48 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add all FIFO parsing and reading functions to support
> inv_icm42607 hardware.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
A few minor things inline.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |   4 +
>  .../imu/inv_icm42607/inv_icm42607_buffer.c    | 496 ++++++++++++++++++
>  .../imu/inv_icm42607/inv_icm42607_buffer.h    |  98 ++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  25 +
>  4 files changed, 623 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 7d13091aa8df..5530fd3bc03f 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> new file mode 100644
> index 000000000000..4f5f199586fc
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> @@ -0,0 +1,496 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/minmax.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/delay.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>

Alphabetical order (+ a block for IIO) for headers.

> +
> +static unsigned int inv_icm42607_wm_truncate(unsigned int watermark,
> +					     size_t packet_size)
> +{
> +	size_t wm_size;
> +	unsigned int wm;
> +
> +	wm_size = watermark * packet_size;
> +	if (wm_size > INV_ICM42607_FIFO_WATERMARK_MAX)
> +		wm_size = INV_ICM42607_FIFO_WATERMARK_MAX;
> +
> +	wm = wm_size / packet_size;
> +
> +	return wm;

Why not

	return wm_size / packet_size;

> +}


> +int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
> +				     unsigned int count)
> +{
> +	s64 gyro_ts, accel_ts;
> +	int ret;
> +
> +	gyro_ts = iio_get_time_ns(st->indio_gyro);
> +	accel_ts = iio_get_time_ns(st->indio_accel);
> +
> +	ret = inv_icm42607_buffer_fifo_read(st, count);
> +
> +	return ret;
Either
	return inv_...
or
	ret = 
	if (ret)
		return ret;

	return 0;

2nd one only if this is going to get more complex in later patches.

> +}
> +
> +int inv_icm42607_buffer_init(struct inv_icm42607_state *st)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	st->fifo.watermark.eff_gyro = 1;
> +	st->fifo.watermark.eff_accel = 1;
> +
> +	/* Configure FIFO_COUNT format in bytes and big endian */
> +	val = INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_ENDIAN;
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +				 val, val);
regmap_set_bits();


> +	if (ret)
> +		return ret;
> +
> +	/* Initialize FIFO in bypass mode */
> +	return regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
> +			    INV_ICM42607_FIFO_CONFIG1_BYPASS);
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> new file mode 100644
> index 000000000000..64a66c00a861
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
...

> +/* FIFO data packet */
> +struct inv_icm42607_fifo_sensor_data {
> +	__be16 x;
> +	__be16 y;
> +	__be16 z;
> +} __packed;

Why packed? It will be anyway unless I'm missing something.

> +#define INV_ICM42607_FIFO_DATA_INVALID		-32768

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index da04c820dab2..344071089042 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

...

> @@ -436,6 +449,8 @@ static int inv_icm42607_suspend(struct device *dev)
>  static int inv_icm42607_resume(struct device *dev)
>  {
>  	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> +	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
>  	struct device *accel_dev;
>  	bool wakeup;
>  	int ret;
> @@ -462,6 +477,16 @@ static int inv_icm42607_resume(struct device *dev)
>  	ret = inv_icm42607_set_pwr_mgmt0(st, st->suspended.gyro,
>  					 st->suspended.accel,
>  					 st->suspended.temp, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (st->fifo.on) {
I've not checked, but if this doesn't get more complex you can do
	if (!st->fifo.on)
		return 0;

	inv_....

	return regmap_write();

> +		inv_sensors_timestamp_reset(&gyro_st->ts);
> +		inv_sensors_timestamp_reset(&accel_st->ts);
> +		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
> +				   INV_ICM42607_FIFO_CONFIG1_MODE);
> +	}
> +
>  	return ret;
>  }
>  

