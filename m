Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917B39D6EF
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854491; cv=none; b=C04qHLddd+RuUokUvqzS3gWysAOyLQJQDsBAYLyVwo13ysn5CzKIRawVr6w+R+fuhDcskmfNx2xojrdB3dkDb4Kd4gchni3dZKKbiK5ZLroks64SQsXNMGOtQ795dSQXFq+BRFsfxrqTA2E4+R3aBv9qq6Ub174WI6rYIU44eBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854491; c=relaxed/simple;
	bh=z623OSOb6uOq/0jf/wjVHRqGtaT8xKUfonIY60W2fx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M74zBh0kKxMq54S3S43oW6XKYUOulojIXgHe/FGbwz5XC1Txpbdg8qfz7opRx5juui89yvzEt488AG5V0zb4uB0U37Ro1AcF2IdjfuprXXFuXFS1ACOmYjPaOZX73uj6beil35T53I1L8K5Gpp+wXiCa0J8hzVCTLlvsfrAmjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAOUHU77; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAOUHU77"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4956869750eso38613375e9.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 01:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788854488; x=1789459288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDQnWL+09MRQg3JHhpcIAGJ0gQMTwutt9tXBZmD4GyU=;
        b=sAOUHU77g8AmRqosJMUKGE6wp56zgS3feonGPeYq1q4FY/1YCdgjZS5gEvJxmufqxJ
         7yd7AVxh4X8GOrnw7+c8/2YcgrFtCIJ8+cnoNrMFp51upPRyR/Yz6skp1azin1z1JiPP
         YpbWNAmD2oG7FXXgcFUZrlMwcHOpr7Rtp8Pa+tSG+Jvwd8wrmGiP08Db39A7fAY5/gRA
         gwTiuRfDK0Eg9UQcfuXD+XubUE6EzgqpHRWjHrywX90YCHsjYAGMRPYKe16RiCWnsUst
         6F3sY8vcstNKstWitiS7eMYoC9zi/JUFBLqv5Z7j9JbGPhxxiN88aKL/rz/wx8F5FCOu
         7JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854488; x=1789459288;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDQnWL+09MRQg3JHhpcIAGJ0gQMTwutt9tXBZmD4GyU=;
        b=Duk8l4wkSrEqmK+MEuZ6Y99BoYADBdSXaJtvlmfl6herZUoFx8hi3ILNuihcmUzHgk
         Luh4YfC+O7q3Jyb5X+ZQwGncHCCJR/jGDk7Xpgj6vLjgoA1Mkla58tJnXf/hBE8AUwXa
         8chjVHrFcMCmMMEMeYM5v0gVdE8/69nPV4xFYZvl2mWYO+dsIk1Yh2X5IiVNr2RukC9m
         Ot2YOuOaCZrMo7FVEExFKjzqdQHQqilS3F6DxWFLuU1xTDGFozBJXcoJ+lFD8L6lx3Lz
         YnAkl0uE9IIubeoeqz1wbGk+eCHS5N/7V2yj6Gjm0zgQehBuhQ4FlTCH/2YWWeGCZ/7+
         hX5A==
X-Forwarded-Encrypted: i=1; AKwUvBwvN/kS5eb4nOokPexgHFsq5Bc8AwIwp+kxLXVxHs/iagR4kiu6+0BEkXYI2GrvHsCLO1GZnR93NqU=@vger.kernel.org
X-Gm-Message-State: AFuF++mFC4rinkm92XIQhyLComlVrDqD7PWM5LtOMXDeca9RfvhtTDf0
	8knb6gzkWHVrXpHNFadKmGPUcL+E4Y7ZjhgL++iR9ifzRwC6agutx+Ud
X-Gm-Gg: AYBFou3UR4N2QDtTzvZN7OKU4zVss8AhDXH1eSbzb5NN+UpFFS7HiBxujWImfdS5pYz
	+jqYAvPYcJt3phXqyrnyxeaQL0ALc1RW8B8USs1fHRqu2SIM6qASveme63MuftsuPNrvNH1ZLFQ
	sa827f2dpDYj9kbKV/2Z9EfENVBDVDHiPX3euJCIK9ArAV4vLhyl7r0Q3/SSceHFL4ARP/GUQLi
	+a/GEwUG5SSxHO5d/euXSZBlH5Yc8GguQb+DH8y/rOasK3KvuZbq1e2CFFXR5eRQNtDixHRElhf
	ce6/PcTG+y1P8zowJcJhLk4z0nV7Hnf3P25/N6MJGPE49wjaAKe5bUJIvb2DAYxLyQmAHSGwU2D
	XGPKvMZhazIfolOa5QWM6M6PmPZrCBJ9TulhkodYItVHK390tyuTNbsENWwUtZTWgLabWMvzl+f
	I1Wq88OUU5DBw+pe8B4KpZLGNU6b6MhxUBg8XlCmRbWOyyBthAJqNj1frAZSGwRq8zxggSqQghC
	bISDSHgcrHvOLe6qsXPR7WcBvXmrG2mVv9tvO1vCHC9BEWcWU9aN0F/AfWhpDntak1oITTjuEtX
	A6N8y7L3+Yf49Lv1JKjcuXWTsojmQii/ApnuZyUHLZYcKyDpWz59Ziv6NvyyvLq2Ehi37NbABuZ
	B9o3JARwXkNAy7CViX4wXbRLbbzruzbNzmVsoTX3EDOf4v/k/+u+bClKxCQKWwKns5O74RUP2nZ
	olDP9s
X-Received: by 2002:a05:600c:3b07:b0:49c:fa20:cbfb with SMTP id 5b1f17b1804b1-49cfa20cd04mr250384235e9.18.1788854487057;
        Tue, 08 Sep 2026 01:01:27 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm641964095e9.1.2026.09.08.01.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:01:26 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:01:23 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shi Hao <i.shihao.999@gmail.com>, "Jose A.
 Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <20260908100123.00005af7@gmail.com>
In-Reply-To: <20260907210042.32552-3-marcus.yu.56@gmail.com>
References: <20260907210042.32552-1-marcus.yu.56@gmail.com>
	<20260907210042.32552-3-marcus.yu.56@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Chang,

Please check out Sashiko's review, there are some PM runtime things that
should be resolved + some comments inline.

https://sashiko.dev/#/patchset/20260907210042.32552-1-marcus.yu.56%40gmail.com

Thanks!

Josh

On Mon,  7 Sep 2026 14:00:42 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>

+ bits.h, types.h, <asm/byteorder.h> (asm headers go separately, as IIO headers).

> +
> +#include <linux/iio/iio.h>
> +

...

> +struct as7343_data {
> +	struct regmap *regmap;
> +};
> +
> +static int as7343_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int unused;
> +	u16 result;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {

The device should resume here, otherwise you'll be reading while suspended.

> +		/*
> +		 * Reading ASTATUS latches all data registers to this read.
> +		 * We don't care about the returned saturation/gain status for
> +		 * now.
> +		 */

Sashiko points out that a mutex here would come in handy. If you're going to add
a mutex, use the guard(mutex) macro for automatic unlocking on scope exit.

> +		ret = regmap_read(data->regmap, AS7343_ASTATUS, &unused);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_bulk_read(data->regmap, chan->address, &result, 2);
> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(result);
> +		return IIO_VAL_INT;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const char *as7343_channel_label(struct iio_chan_spec const *chan)
> +{
> +	switch (chan->channel) {
> +	case AS7343_CHAN_IDX_FZ:
> +		return "FZ";
> +	case AS7343_CHAN_IDX_FY:
> +		return "FY";
> +	case AS7343_CHAN_IDX_FXL:
> +		return "FXL";
> +	case AS7343_CHAN_IDX_NIR:
> +		return "NIR";
> +	case AS7343_CHAN_IDX_F2:
> +		return "F2";
> +	case AS7343_CHAN_IDX_F3:
> +		return "F3";
> +	case AS7343_CHAN_IDX_F4:
> +		return "F4";
> +	case AS7343_CHAN_IDX_F6:
> +		return "F6";
> +	case AS7343_CHAN_IDX_F1:
> +		return "F1";
> +	case AS7343_CHAN_IDX_F7:
> +		return "F7";
> +	case AS7343_CHAN_IDX_F8:
> +		return "F8";
> +	case AS7343_CHAN_IDX_F5:
> +		return "F5";
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static int as7343_read_label(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, char *label)
> +{
> +	const char *name;
> +
> +	name = as7343_channel_label(chan);
> +	if (!name)
> +		return -EINVAL;

A blank line here would be better.

> +	return sysfs_emit(label, "%s\n", name);
> +}
> +
> +static const struct iio_info as7343_info = {
> +	.read_raw = as7343_read_raw,
> +	.read_label = as7343_read_label,
> +};
> +
> +static const struct regmap_config as7343_regmap_config = {
> +	.name = "as7343",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AS7343_MAX,
> +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static int as7343_setup_device(struct device *dev, struct as7343_data *data)
> +{
> +	unsigned int val;
> +	u16 step;

__le16 instead of u16.

> +	int ret;
> +
> +	/* Power on */
> +	ret = regmap_set_bits(data->regmap, AS7343_ENABLE, AS7343_ENABLE_PON);
> +	if (ret)
> +		return ret;
> +
> +	/* Need to set REG_BANK to 1 before we can access ID */
> +	ret = regmap_set_bits(data->regmap, AS7343_CFG0, AS7343_CFG0_REG_BANK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, AS7343_ID, &val);

You should check the value of ret as well in case of a regmap failure.

-- 
Kind regards,
Joshua Crofts
