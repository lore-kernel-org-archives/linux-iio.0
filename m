Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB12352C2D
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111011; cv=none; b=mzb/BnMYioPr6BuCNvy4CtV37RdtpFm8H6IT9kW1gs0hQnYgyTtZo8d0IwELPEutumhdiHYUXLvhVGqCDJ75Nwx4+7ETLKT5SYtkxHHOkRimRKRcV5EM37UMc/mJv79TyPtI04VI9nltFJbFtKQxFjJIT4BvPZvbnDTyQCa1Qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111011; c=relaxed/simple;
	bh=rJ+1W8YqPkQOBs6vB8bm6El4JH8f3PNnPmGxZfgA8u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdKvIO2h2HRxKOUN/lkQD3x0ggGRiYkZgYpoWeBWBmJ8OLTb3r+Enf3PQAIrTcQONC9AKGtHWQ9KL0pM+AHmJkxGabkAekh0sMwWiGEQ/N0RrcSpqhM1irMyZMBfMogAL0prtq6KOJK8N6mVaPfbNk79ApGDAKLYkScnvJ+bOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYNGq2w6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYNGq2w6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9967C116C6;
	Thu, 22 Jan 2026 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769111010;
	bh=rJ+1W8YqPkQOBs6vB8bm6El4JH8f3PNnPmGxZfgA8u8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tYNGq2w6pYb8J/Gsow888Ei+3kvWHFijwtJe6BMbSMD4x8iTtCSswNjm6bW3ymYZU
	 XoBLvY5QjUFCo9p8x6KYe0FQ7uH9V8iIlzKoVZyi+opzAGidmo6aKBl1WH2HgouWDo
	 6VHqVrnEjncVTIl3hVaBsg03U4LPMGYCO3Fw/lH2BWW8PV3duUW+wHtHqoY6UzYM4a
	 LMZ+0MS/t0JORYueWfmt6mJ7O9HRhdPpE3h+A81GzG+7KBBigbtlxbrT4103BaLyUM
	 zZSPZLx+2/p0klOFLNJ8odOZWobiis/O+0dtey9jDX3wfhGaewrmcjjnHuI+eC3ZT4
	 uSeQLFe5t2NIQ==
Date: Thu, 22 Jan 2026 19:43:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: nvaccaro@google.com, tzungbi@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Allow enabling/disabling calibration mode
Message-ID: <20260122194322.62dc4911@jic23-huawei>
In-Reply-To: <20260119074928.1334489-1-gwendal@chromium.org>
References: <20260119074928.1334489-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 23:49:28 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> calibration was a one-shot event sent to the sensor to calibrate itself.
> It is used on Bosch sensors (BMI160, BMA254).
> For light sensor, we need to stay in calibration mode to run tests.
> Accept boolean true and false (not just true) to enter/exit calibration.
> 
> Check "echo 0 > calibrate" is supported.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Nick Vaccaro <nvaccaro@google.com>

Documentation/ABI/testing/sysfs-bus-iio-cros-ec needs an update I think.

Whilst this is an ABI change, given it was useless for light sensors
before it seems unlikely that anyone will notice.

J
> ---
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  6 +++---
>  include/linux/platform_data/cros_ec_commands.h       | 12 +++++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 9ac80e4b7d756..f1cdee2a61cbd 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -444,14 +444,14 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
>  	ret = kstrtobool(buf, &calibrate);
>  	if (ret < 0)
>  		return ret;
> -	if (!calibrate)
> -		return -EINVAL;
>  
>  	mutex_lock(&st->cmd_lock);
>  	st->param.cmd = MOTIONSENSE_CMD_PERFORM_CALIB;
> +	st->param.perform_calib.enable = calibrate;
>  	ret = cros_ec_motion_send_host_cmd(st, 0);
>  	if (ret != 0) {
> -		dev_warn(&indio_dev->dev, "Unable to calibrate sensor\n");
> +		dev_warn(&indio_dev->dev, "Unable to calibrate sensor: %d\n",
> +			 ret);
>  	} else {
>  		/* Save values */
>  		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 69294f79cc88a..d363d60bb8a36 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -2598,13 +2598,19 @@ struct ec_params_motion_sense {
>  
>  		/*
>  		 * Used for MOTIONSENSE_CMD_INFO, MOTIONSENSE_CMD_DATA
> -		 * and MOTIONSENSE_CMD_PERFORM_CALIB.
>  		 */
>  		struct __ec_todo_unpacked {
>  			uint8_t sensor_num;
> -		} info, info_3, data, fifo_flush, perform_calib,
> -				list_activities;
> +		} info, info_3, data, fifo_flush, list_activities;
>  
> +		/*
> +		 * Used for MOTIONSENSE_CMD_PERFORM_CALIB:
> +		 * Allow entering/exiting the calibration mode.
> +		 */
> +		struct __ec_todo_unpacked {
> +			uint8_t sensor_num;
> +			uint8_t enable;
> +		} perform_calib;
>  		/*
>  		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR
>  		 * and MOTIONSENSE_CMD_SENSOR_RANGE.

