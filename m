Return-Path: <SRS0=pZra=RO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E33C43381
	for <linux-iio@archiver.kernel.org>; Mon, 11 Mar 2019 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC6020643
	for <linux-iio@archiver.kernel.org>; Mon, 11 Mar 2019 08:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqBtjXhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfCKIYK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:24:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47099 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfCKIYK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Mar 2019 04:24:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id i16so3957510wrs.13
        for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2019 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H+xgHycD2CyAQhtKTS04Irvt9lPRBhsx1Ip2NgXpHik=;
        b=KqBtjXhH4KvkCr1z+Ed7NjrSqTdWebqpwLwh62dDOSPrWjhxsoDHn07lgSRgm+S+hq
         ajqJfibqyth0sqtoEerSZ3gKq+naY6Fxe0JpSTHwGji9QKZdjgX0i5SWv84rpqUZLlf6
         MHzCgY1QXsqtKEkKpMzYSdV/aLDkuvUvvoCLUAQ542xK4nwFDZ1gDmaRNRQ62mLf3Pgm
         0UXYcc78AMwGTFhbrYesFCs87yYFF8JOa0j8TVjnrPV1Y8JcbbZutfElUhf/SmRsN3j6
         gelXMNtRWm5LaLWx6YgoLNHDqpkY4oyMM65zOh/ColU1XN77iLRMIiei3dtV6R1BhfXe
         2Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H+xgHycD2CyAQhtKTS04Irvt9lPRBhsx1Ip2NgXpHik=;
        b=APFiADDxUgXhs4OV9Hd27e0PHzWFx6qxr3auGAqRrxehnF6uAaxzhz0YN7EUU9oQS9
         X1P/oqg2kDLmgpZnbAiDc+obawBPFHkE8/s05fX0i9qI1PupR1nN2E3/lSJQjGo9R9ka
         UWrrtyc9gVBxd/vOyrbLc/96mYJoi4efReQJyCj3CJtijB76KZtScLxsWPfrkBls/WSO
         0I+p/+ZGtM666b6/8gHaXblhNj9IAfk8jjlYZI/SUP2wu7FLPfZCS3z79m28S0D7Kuuy
         ogp9qxDPO36hvGVxmjyBUY10gdDUua6g/ZmAb761x3jAP3N82eC9k5HNKzyAVRMLWEEJ
         +UAQ==
X-Gm-Message-State: APjAAAXnhXJEULxJm5ZPHIIcio7/fS4i7smXEEZQKWGyRVA8KjDRVnWO
        TCm4NN+4t3my9LoA/O/uUfnEzw==
X-Google-Smtp-Source: APXvYqwmzZTjxd/o6gpgqnicai2PlvqynVfZlScb+59lEjGsMfNJ5m36pS/yuHWe+Xix8HS10f7Qcw==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr18862932wrs.170.1552292648376;
        Mon, 11 Mar 2019 01:24:08 -0700 (PDT)
Received: from dell ([2.27.35.175])
        by smtp.gmail.com with ESMTPSA id v196sm19384709wmf.15.2019.03.11.01.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 01:24:07 -0700 (PDT)
Date:   Mon, 11 Mar 2019 08:24:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     groeck@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org, lars@metafoo.de, jic23@kernel.org,
        egranata@chromium.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Add lid angle driver
Message-ID: <20190311082405.GB4731@dell>
References: <20190228015005.81232-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228015005.81232-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 Feb 2019, Gwendal Grignou wrote:

> Add a IIO driver that reports the angle between the lid and the base for
> ChromeOS convertible device.
> 
> Tested on eve with ToT EC firmware.
> Check driver is loaded and lid angle is correct.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 +
>  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
>  .../cros_ec_sensors/cros_ec_lid_angle.c       | 164 ++++++++++++++++++

>  drivers/mfd/cros_ec_dev.c                     |  15 +-

It doesn't look like there are build dependencies between the changes
in these different subsystems.  If my assumption is correct, please
pull the MFD changes out into a separate patch.

>  4 files changed, 186 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c

[...]

> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d275deaecb12..11b5b2fd1f33 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -297,13 +297,17 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  
>  	resp = (struct ec_response_motion_sense *)msg->data;
>  	sensor_num = resp->dump.sensor_count;
> -	/* Allocate 1 extra sensors in FIFO are needed */
> -	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
> +	/*
> +	 * Allocate extra sensors if lid angle sensor or FIFO are needed.
> +	 */
> +#define NUM_EXTRA_SENSORS 2

Please refrain from placing #defines in the middle of functions.

Move it to the top of the file.

> +	sensor_cells = kcalloc(sensor_num + NUM_EXTRA_SENSORS,

Actually, this isn't something that needs defining.

Just change the comment to:

  "Allocate 2 extra sensors if lid angle sensor or FIFO are needed."

... and drop the define.

> +			       sizeof(struct mfd_cell),
>  			       GFP_KERNEL);
>  	if (sensor_cells == NULL)
>  		goto error;
>  
> -	sensor_platforms = kcalloc(sensor_num + 1,
> +	sensor_platforms = kcalloc(sensor_num,
>  				   sizeof(struct cros_ec_sensor_platform),
>  				   GFP_KERNEL);
>  	if (sensor_platforms == NULL)
> @@ -363,6 +367,11 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  		sensor_cells[id].name = "cros-ec-ring";
>  		id++;
>  	}
> +	if (cros_ec_check_features(ec,
> +				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
> +		sensor_cells[id].name = "cros-ec-lid-angle";
> +		id++;
> +	}
>  
>  	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
>  			      NULL, 0, NULL);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
