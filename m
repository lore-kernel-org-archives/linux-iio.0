Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC633689C;
	Sat,  7 Mar 2026 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904759; cv=none; b=Xlmz+ZSzncjUMjrdngo++D6/AdU+oxQEMWyJ00YsVnVMI/a53upUiArN1rY9gMalsEqojK902Dn4iHkaP7Gr47greyOKHD3T61T9tGt9mhlmEiw2FlNKheFoe1hjVH3VWFKOTb2YHQb8L5SNp6vUa+dQ0sef2Aj89IbDt02i6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904759; c=relaxed/simple;
	bh=OU1j2fg8GyOi+Nyo0EUT3pgrx0wAhI9NW0pgF99mmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ps4iH82Iz34yENhFlySApt1bXfwy39KzctA+Jzr/+8PgLpqzp/tUmlxsqodFay/qjveVXon7Q1op7tWwCePIysDtAWdY+MWUKjvBAf2my48jJ+P3/JAzJjE+txxHD3r/ISnDBh3QYwnf+tgvby5LiLnxy5eRbEE2ElKlUoelrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aevTB5wH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aevTB5wH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526B8C19422;
	Sat,  7 Mar 2026 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772904759;
	bh=OU1j2fg8GyOi+Nyo0EUT3pgrx0wAhI9NW0pgF99mmGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aevTB5wHTM6zVZSW4FTDbyGbrPhN/6v6cx5k8ItJq8sdsJDHj3gUPnkdGqbxQjIrI
	 OVzO98Icx/qht+dc3UFSpUmtEPaZWaYY+DiCpluPV41FupNqxhpPo3pSC4XV3yyp7v
	 JGT6YwC70678Z8jTsEVZSTGzgLpg1KhC+4CIJdHq5Js+an4VtuHZL3jJMnx21mkq40
	 3UC2wlFxEFaVMMLFXD2OWSiDsKq5KgAPk56sYsjQAEemy+s8IX6WIhw3/GlIhSXI6n
	 x5dqScveHwPGL8/UucOqxFeWP4l/NN0y6cH2NnKYmTcohLD0ZSq4uRgC39HdoTK5OZ
	 hqaGkZyPunCAQ==
Date: Sat, 7 Mar 2026 17:32:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v2 6/6] iio: common: fix spelling mistakes in comments
Message-ID: <20260307173230.543a9475@jic23-huawei>
In-Reply-To: <20260307104705.49129-7-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
	<20260307104705.49129-7-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 16:17:05 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> fix incorrect spelling in comments
> 
> - exepects -> expects
> - fuction -> function
> - theoritical -> theoretical
> - appopriate -> appropriate
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
This one (and patch 4 that I don't think I replied to) looks good to me
but we aren't in a rush given where we are in the cycle so I'll wait for v3.

Leave it a few days before sending another version though as you may get
reviews from others + they may disagree with me :)

Jonathan

> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 82cef4a12442..af8563fde0a3 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -106,7 +106,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
> 		switch (st->core.type) {
> 		case MOTIONSENSE_TYPE_ACCEL:
> 			/*
> -			 * EC returns data in g, iio exepects m/s^2.
> +			 * EC returns data in g, iio expects m/s^2.
> 			 * Do not use IIO_G_TO_M_S_2 to avoid precision loss.
> 			 */
> 			*val = div_s64(val64 * 980665, 10);
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index a61428bfdce3..c115a72832b2 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -346,7 +346,7 @@ int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st,
>  EXPORT_SYMBOL_NS(hid_sensor_write_raw_hyst_rel_value, "IIO_HID");
> 
>  /*
> - * This fuction applies the unit exponent to the scale.
> + * This function applies the unit exponent to the scale.
>   * For example:
>   * 9.806650000 ->exp:2-> val0[980]val1[665000000]
>   * 9.000806000 ->exp:2-> val0[900]val1[80600000]
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index 97526ba87b93..4e50c03410d9 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -154,7 +154,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
> 		valid = inv_update_chip_period(ts, period);
> 	}
> 
> -	/* no previous data, compute theoritical value from interrupt */
> +	/* no previous data, compute theoretical value from interrupt */
> 	if (ts->timestamp == 0) {
> 		/* elapsed time: sensor period * sensor samples number */
> 		interval = (int64_t)ts->period * (int64_t)sample_nb;
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index 588470863681..1960a2ce82a8 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -96,7 +96,7 @@ EXPORT_SYMBOL_NS(ms_sensors_read_prom_word, "IIO_MEAS_SPEC_SENSORS");
>   *
>   * Generic ADC conversion & read function for Measurement Specialties
>   * devices.
> - * The function will issue conversion command, sleep appopriate delay, and
> + * The function will issue conversion command, sleep appropriate delay, and
>   * issue command to read ADC.
>   *
>   * Return: 0 on success, negative errno otherwise.
> --
> 2.53.0

