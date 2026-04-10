Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAE367F31
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860482; cv=none; b=IvEQuEkuSAKH5bXi26QR/+PNNaiUUt5GhLrkGqV3TG4HSpkM5613BrtWShvWZrajNBMyeyY/GXHsiJHp6De7VEniHe2ChFq/et3DC3hjWMetr2Hyq9C6tPHwmc5IFGCS+0vOO4IbYc7htvJymrFtsPe1V7drstoBA3gC2GLY48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860482; c=relaxed/simple;
	bh=UJaY4g0YNybPBear1oWjR2gVqsPP/zwn/rFimkzCa1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4H/FDp8VXmBbGurAnYyY5nXOIBI6Q/0hdf5G69hjEY3z4zQjUVq7V+lmjCq7ht7hTHC5F36dBsgcY0JfGgntgwMwYjmHMTTGABJTDpoidBe2hueS3f8IP12eLLT4U1cKie6c/lviwkyDYEkeITHGGRBp0vy0H43BxtLKXM1Md0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=E8I4Vjhf; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="E8I4Vjhf"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-68beff25252so545081eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775860478; x=1776465278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDsPdLRtHI1fCBtHGILEh/aBIsv8nBQn0xgQGOjBptQ=;
        b=E8I4VjhfFFppAtk5PqD6B8WJP8gMKwiS6SePwRIQoiXKqhnALnMGJqnFZW51wpMX8T
         E2qUdaXfQBl9+B9V4GRjJWcjwH8fvyT+VcBiLglZhBaobWYedYOgJI4qECxFtVir+2Hg
         o5Mg9L6sl8mXF1frkzugoVvDwrwT5Jit3NX7XOY/mH5r2IuIiSDaTSNxjBMLRjczBwRB
         jHOyB0En/S6P0jSU7rl3KNXuPJIYmQtKCgv5yYiX6A7VKddCpU76fYGbsVze+EvUNhjy
         NjXYuCHPnRBA/kR13uGx7/qom6DY6wer9eGoQIFYZAC6S3teDyvBEd0KKsolP+X0ZoOG
         Ky/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860478; x=1776465278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDsPdLRtHI1fCBtHGILEh/aBIsv8nBQn0xgQGOjBptQ=;
        b=XAGQ85y80tYpPijj7JTg9A60rI59LOaJhro4SjXk8Xeal7xYIj0ui20S66OimK7/eH
         RwVLJ8Zm4bpjH5VlLu1nNCDuBy939hY6/OSz2sQIiGikOA82PHro6Hnd5O0KM+rxb/Xu
         iDC3LysiMHZlTMzMQiL6l6tUxP9453l7196hbHXQlG8fVoReBfeynXEeVRmJCYNFC9F/
         kyJTsTFi9jSEr4wQoD1fw3ZVy3nVsIK4bZeQGw6wrtdyIV9uxKjRIQFFC5elRJlShnbx
         UJB9ei+Kylt9ULdGJjX5cp2rF1gHvswS2m/l8+rIybxO0ql8+H+PPiwPV94hsxIM9OXo
         SosQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6zKffcQyqutlzHW0KJESpHzsHYJmJjE79Xlbu/6gD/h2PpBkeJCmyA035RW9W24/o2FACyY/V+SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBYdr3aIHIQeAmwsYQoFRFpFV0QjZDKS8foQKcu/7sMgyUcHo
	CEe/6ZW07mXmUNNHfB0I3PAZnUaZ70iUtI96FGCsu4pXvmzVLpPgEc6dhlX2B32r53o=
X-Gm-Gg: AeBDiesTosLaKHUqB0OxHJjFnHrvCLcn3fnTXbOJC7NkRjewkurKM+AxXhUI/0Fxq9g
	Ah/4M+bYcOZ4TPiw1HTI/vaNNtLL/iYVKaG7Ml0jWu2Kfd728hET1tXGKzBfUqEVEZcQpSTmISU
	/i+UcXXdIlb7IWrkjXFqiPsTIxmOYa9qvojbPVjl8+ooHtdAcFYgtCqZfLb4mnFfxCXk2aiJInl
	ZrJMumueaUQD6DjQcpC3y8AfRlfTbwR648w9DPLstW/JLM62Or+P34vX+LASFxRvYPfAW97qO+M
	bZNuAvabI5bp4WbGsl0o872k2k+mdG4CvMt5wf0ooQB3ZNpCGuWaBL6aTv1zPUsb6xLkJ32DYhX
	oajPNpzLETm/T0LYO8f3GSVQgCw8uLW+iIlD2Ah2XtdwrVFDj8Pwai5cERtzISshSRPPBx01WAa
	7Y4dxsHlFbN5UyrzNncLbUDG7Cvy0eEkuM9aoPsFueCIjd6NsKkL1hxQp1dldtrM4/cibmoad3E
	jzKuao26MSa
X-Received: by 2002:a05:6820:1805:b0:685:7d77:27 with SMTP id 006d021491bc7-68be7de912dmr2179828eaf.33.1775860478203;
        Fri, 10 Apr 2026 15:34:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb23b07sm3366642fac.12.2026.04.10.15.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 15:34:37 -0700 (PDT)
Message-ID: <8b716bc9-1465-4abc-9429-c7e475a01b71@baylibre.com>
Date: Fri, 10 Apr 2026 17:34:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/9] iio: imu: inv_icm42607: Add Temperature Support in
 icm42607
To: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, nuno.sa@analog.com, jic23@kernel.org,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-6-macroalpha82@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260330195853.392877-6-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/30/26 2:58 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add functions for reading temperature sensor data.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  3 +
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 17 ++++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 81 +++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 30 +++++++
>  4 files changed, 131 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 5530fd3bc03f..086848c8fd3b 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -433,6 +433,9 @@ extern const struct dev_pm_ops inv_icm42607_pm_ops;
>  
>  u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
>  
> +int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
> +			       unsigned int *sleep_ms);
> +
>  int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval);
>  
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 344071089042..735a262dc103 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -164,6 +164,23 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
>  	return 0;
>  }
>  
> +int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
> +			       unsigned int *sleep_ms)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	val = INV_ICM42607_TEMP_CONFIG0_FILTER(INV_ICM42607_FILTER_BW_34HZ);
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_TEMP_CONFIG0,
> +				 INV_ICM42607_TEMP_CONFIG0_FILTER_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
> +					  st->conf.accel.mode, enable,
> +					  sleep_ms);
> +}
> +
>  int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval)
>  {
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> new file mode 100644
> index 000000000000..b42eb78cd960
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> +
> +static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	__be16 *raw;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return -ENXIO;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_set_temp_conf(st, true, NULL);
> +	if (ret)
> +		return ret;
> +
> +	raw = (__be16 *)&st->buffer[0];

Can we make buffer __be16 buffer[] to avoid cast and ensure proper alignment?

> +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1, raw, sizeof(*raw));
> +	if (ret)
> +		return ret;
> +
> +	*temp = (s16)be16_to_cpup(raw);

cast is not needed. temp is already s16.

> +	if (*temp == INV_ICM42607_DATA_INVALID)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	s16 temp;
> +	int ret;
> +
> +	if (chan->type != IIO_TEMP)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret = inv_icm42607_temp_read(st, &temp);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		*val = temp;
> +		return IIO_VAL_INT;
> +	/*
> +	 * T°C = (temp / 128) + 25
> +	 * Tm°C = 1000 * ((temp * 100 / 12800) + 25)
> +	 * scale: 100000 / 12800 ~= 7.8125
> +	 * offset: 25000
> +	 */
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 7;
> +		*val2 = 812500;
> +		return IIO_VAL_INT_PLUS_MICRO;

Could use IIO_VAL_INT_PLUS_NANO to get more exact value.

> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 25000;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
