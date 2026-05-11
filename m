Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E63BD62E
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494682; cv=none; b=EslPT6hG188vYVPSuJezh4Vtgo8+QLkTXcgb0PuRkx0DeRNZ1YGbFRiadYjH+2ciszLr0sSL9B/MP3vGimgQMuOfRUiscmM0GnYivw5p5nazSFASaBvdXmaAwYF9kJ9AiaDEREB5sh57VROsTo81hg6cLjEKOvhxDqLW7jR74BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494682; c=relaxed/simple;
	bh=+8J2C6n+A04w3Rd/yGUDD3ZJHxwBd6bdxC0DnJYoXQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNb6hsYrsWRA6MW4tW0qMOmjMamuz7KIj1VBq9rZ39MKzcwB5hXHNznJLb/9O4JAsKTHLlmgv6OeNo8IrhEMkf+j5Tx6nngozVtc7HtlLVUIdt/20oA1vi2i/zfAsmAZ8gl9X9k2rJgoGCzlxGZCj7OgP23cjzgfJ0i265PrVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+gQLrDb; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+gQLrDb"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39380e79936so51819061fa.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494678; x=1779099478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9+ZyEiC10wt18TTHjapeMAgaGp7DUB6qud1MjVK6mY=;
        b=B+gQLrDbmAWNWvFkKBcnYOdiXrA/IlylBCbB7dI3+Kf6HBfW4PUhWybYxzyWX1+w9a
         IpFLPCktBf8GrUXDEWIZvxpv4gUzxG1jGqV4irPQ5z6Z/3ZoWJLrlbsfAlO0pyF6U4yX
         HUZig080zEbx+aTmtmjJDxOr6iw/Ut7audSu6lSW+bhmSe6ySoMb4ga/C616rbdr29zd
         MjGiE4Tcen1qXS7E+k80oxoZLlZi5LV/l3STaIYRBBnzC6tJPrcaCi1mmhH/WRXmhyIC
         2r3lWz3w0eGnFdVKAiY0KmyoCgdOSxtF0rbFHAJ+bg7qgCfs+obR3KYvzuEdpdediCYw
         E3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494678; x=1779099478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9+ZyEiC10wt18TTHjapeMAgaGp7DUB6qud1MjVK6mY=;
        b=PwaTeo3y+sv8iUMko2CHFG0YjEGT7fKFLFfLJa9aMZZdA/xKGtvAaxNimCWMxMYE/S
         XD9rLUqDHAV96p818KNQaYYNfdKkgvALK4aokwM2gvJIJ6P7nDFZhdTizB8HEZwhHY4L
         TnZsrjD0W1I0NXkAMGzUamoaz2HYCAV3+311oprTadyKKyAlBvdi+oav/6VUbLoLzWOL
         1/m/DlKGrspLbphUALUa/ZGLsnZMFLlQjA0NXN8cqFujGViOkVrdKbu12OOgp8Eaajad
         xS7/F9NUaBGJmVBAv0TWUFcBYtN7TcM/N5aDAi2wsm/dDLErGuVKTnH23XSU37cCjcIA
         X0iw==
X-Gm-Message-State: AOJu0YwDsYrmv//zi6Ykxg59M8rDE/gy8wf5M2mh8T9R90RAXN0vf+c2
	oCNJQsF0jFgU4ih//aP7mRSVub/m3eQbBQaC4DKOooDtjtgIuJrvHBFQXxdroeuivzs=
X-Gm-Gg: Acq92OHRB3GhwOdpzcUTaMCJLwvA/CLnv+JQZa9GvjCmf8ON6W9e2PvIbEeLdoCi4Et
	RDZYcZglnuCmrVXeSTPSZxdgjRML93L0KKBaUV3V7wzsymKehugNfj600VCBIqxy5aCuhnuxm3i
	IjJvPUqsaQj7bJrkSVNwKqiUZ9UeHXFlhLwESarijCC1ZY0Kq1pMGX/JnTkHxTBgEqqpplT1NDF
	o2t2lksiK/TEHVY5Lx0GIqrhERLBByb0pclmeQn1e1gPrOVj/++es8buIBI3XuVwG7tk6aVLKzd
	XTvDeU9oeYVoxUW2aCUQIVYljWNiK4aKFiUT/8XuwMOsciDN4yrLTquYC+63WNBP87ML15Bvw/7
	0VfQXZnwaxOeotEQLVsZQiMpEcO0BiqR2qmTDUnHx0yREmzGoaaXSeA0n8/nhRvKGRju0uo6v21
	rUk0NlMO1FYPvBJIjr0KtVrkK/EYsJMm/echUxhc1wPvh+qZxlJXh3meR+zMwzieetUsMuD0mdZ
	hFWVlL4
X-Received: by 2002:a2e:be0b:0:b0:394:642:c638 with SMTP id 38308e7fff4ca-3940642ca61mr32306121fa.25.1778494677431;
        Mon, 11 May 2026 03:17:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f3a2a2sm25420521fa.11.2026.05.11.03.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 03:17:56 -0700 (PDT)
Message-ID: <5fa8b215-b27b-4168-b4f2-fdad865c9c29@gmail.com>
Date: Mon, 11 May 2026 13:17:55 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: bh1730: Add bh1730 light sensor driver
To: Alexandre Hamamdjian <azkali.limited@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
 <20260511-bh1730-v1-2-e0df1f499135@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260511-bh1730-v1-2-e0df1f499135@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/05/2026 21:09, Alexandre Hamamdjian wrote:
> From: CTCaer <ctcaer@gmail.com>
> 
> Add a driver for the ROHM BH1730FVC ambient light sensor. The device
> is a 16-bit I2C digital sensor with separate visible and infrared
> photodiodes, four selectable gains (1x/2x/64x/128x) and a programmable
> integration time.
> 
> The driver exposes illuminance via IIO, performs runtime gain and
> integration-time tracking to keep the ADC in range, and supports
> optional als-vdd / als-vid regulators. Per-board lux calibration data
> (integration cycles, lux multiplier, optical-window coefficients, and
> gain sensitivity coefficients) can be supplied via device tree;
> sensible defaults are used otherwise.

Thanks for the patch Alexandre :) It looks mostly good to me! It is 
great to see support for this being upstreamed! Overall good work! A few 
questions / comments below.

> 
> Signed-off-by: CTCaer <ctcaer@gmail.com>
> Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
> ---
>   drivers/iio/light/Kconfig  |   9 +
>   drivers/iio/light/Makefile |   1 +
>   drivers/iio/light/bh1730.c | 686 +++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 696 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index eff33e456c70..3869060567dd 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -135,6 +135,15 @@ config AS73211
>   	 This driver can also be built as a module.  If so, the module
>   	 will be called as73211.
>   
> +config BH1730
> +	tristate "ROHM BH1730 ambient light sensor"
> +	depends on I2C
> +	help
> +	  Say Y here to build support for the ROHM BH1730 ambient light sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called bh1730.
> +
>   config BH1745
>   	tristate "ROHM BH1745 colour sensor"
>   	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c0048e0d5ca8..27ef7906a02a 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_APDS9300)		+= apds9300.o
>   obj-$(CONFIG_APDS9306)		+= apds9306.o
>   obj-$(CONFIG_APDS9960)		+= apds9960.o
>   obj-$(CONFIG_AS73211)		+= as73211.o
> +obj-$(CONFIG_BH1730)		+= bh1730.o
>   obj-$(CONFIG_BH1745)		+= bh1745.o
>   obj-$(CONFIG_BH1750)		+= bh1750.o
>   obj-$(CONFIG_BH1780)		+= bh1780.o
> diff --git a/drivers/iio/light/bh1730.c b/drivers/iio/light/bh1730.c
> new file mode 100644
> index 000000000000..c93290ff5661
> --- /dev/null
> +++ b/drivers/iio/light/bh1730.c
> @@ -0,0 +1,686 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ROHM BH1730 ambient light sensor driver
> + *
> + * Copyright (c) 2021 CTCaer <ctcaer@gmail.com>
> + *
> + * Based on previous iio BH1730FVC drivers from:
> + * Copyright (c) 2018 Google, Inc.
> + * Author: Pierre Bourdon <delroth@google.com>
> + *
> + * Copyright (C) 2012 Samsung Electronics. All rights reserved.
> + * Author: Won Huh <won.huh@samsung.com>
> + *
> + * Data sheets:
> + *  http://www.rohm.com/web/global/datasheet/BH1730FVC/bh1730fvc-e
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/time.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define BH1730_NAME	"bh1730fvc"
> +
> +#define BH1730_CMD_BIT BIT(7)
> +
> +#define BH1730_REG_CONTROL	0x00
> +#define BH1730_REG_TIMING	0x01
> +#define BH1730_REG_INTERRUPT	0x02
> +#define BH1730_REG_THLLOW	0x03
> +#define BH1730_REG_THLHIGH	0x04
> +#define BH1730_REG_THHLOW	0x05
> +#define BH1730_REG_THHHIGH	0x06

I don't see all these registers used. Do you plan to add events for the 
thresholds? If not, then maybe ditch the unused defines? (Unless you 
think they should be kept for some documentation purposes).

> +#define BH1730_REG_GAIN		0x07
> +#define BH1730_REG_ID		0x12
> +#define BH1730_REG_DATA0LOW	0x14
> +#define BH1730_REG_DATA0HIGH	0x15
> +#define BH1730_REG_DATA1LOW	0x16
> +#define BH1730_REG_DATA1HIGH	0x17
> +
> +#define BH1730_CONTROL_POWER		BIT(0)
> +#define BH1730_CONTROL_ADC_EN		BIT(1)
> +#define BH1730_CONTROL_DATA0_ONLY	BIT(2)
> +#define BH1730_CONTROL_ONE_TIME		BIT(3)
> +#define BH1730_CONTROL_ADC_VALID	BIT(4)
> +#define BH1730_CONTROL_INTR		BIT(5)
> +
> +#define BH1730_INTERNAL_CLOCK_NS	2800
> +/* BH1730_INTERNAL_CLOCK_MS * 714 */
> +#define BH1730_ADC_CALC_DELAY_US	2000

I don't quite follow this. If BH1730_INTERNAL_CLOCK_NS is 2800, then:
BH1730_INTERNAL_CLOCK_US should be 2,800 and
BH1730_INTERNAL_CLOCK_MS should be 0,002800, right?

0,002800 * 714 => 1.9992, not 2000.

Furthermore, if the BH1730_ADC_CALC_DELAY_US results from the 
BH1730_INTERNAL_CLOCK_NS - why not compute it in the macro instead of 
using a comment?

> +/* BH1730_INTERNAL_CLOCK_MS * 964 */
> +#define BH1730_ITIME_TO_US		2700
> +
> +#define BH1730_DEFAULT_INTEG_CYCLE	38
> +#define BH1730_DEFAULT_ITIME_MS		100
> +
> +#define BH1730_POWER_ON_DELAY_US	10000
> +
> +#define BH1730_MAX_MEASURED_LUX		100000
> +
> +enum bh1730_gain {
> +	BH1730_GAIN_1X = 0,
> +	BH1730_GAIN_2X,
> +	BH1730_GAIN_64X,
> +	BH1730_GAIN_128X,
> +};
> +#define BH1730_MAX_GAIN_MULTIPLIER 128
> +
> +struct gain_coeff_t {
> +	u32 cl;
> +	u32 fl;
> +};
> +
> +struct opt_win_coeff_t {
> +	u32 rc;
> +	u32 cv;
> +	u32 ci;
> +};
> +
> +struct lux_cal_data_t {
> +	struct gain_coeff_t *gain_coeff;
> +	struct opt_win_coeff_t *opt_win_coeff;
> +	u32 opt_win_coeff_count;
> +	u32 itime_cycle;
> +	u32 mul;
> +};
> +
> +/*
> + * No optical window or optical window that has flat transmittance
> + * from visible light to infrared light.
> + */
> +static struct opt_win_coeff_t def_lux_coeff[] = {
> +	{  260, 1290, 2733 },
> +	{  550,  795,  859 },
> +	{ 1090,  510,  345 },
> +	{ 2130,  276,  130 }
> +};
> +
> +static struct gain_coeff_t def_gain_coeff[] = {
> +	{ 3000,    -1 }, /* 1x */
> +	{ 2000,  9800 }, /* 2x */
> +	{   15, 60000 }, /* 64x */
> +	{    0,  1300 }  /* 128x */
> +};
> +
> +static struct lux_cal_data_t def_lux_data = {
> +	.gain_coeff = def_gain_coeff,
> +	.opt_win_coeff = def_lux_coeff,
> +	.opt_win_coeff_count = ARRAY_SIZE(def_lux_coeff),
> +	.itime_cycle = BH1730_DEFAULT_INTEG_CYCLE,
> +	.mul = 1000
> +};
> +
> +struct bh1730_data {
> +	struct i2c_client *client;
> +	struct lux_cal_data_t cal;
> +	struct regulator *reg_vdd;
> +	struct regulator *reg_vid;
> +	enum bh1730_gain gain;
> +	u32 itime_us;
> +	u32 tmt_us;
> +};
> +
> +static int bh1730_read_word(struct bh1730_data *bh1730, u8 reg)
> +{
> +	int ret = i2c_smbus_read_word_data(bh1730->client,
> +					   BH1730_CMD_BIT | reg);
> +	if (ret < 0)
> +		dev_err(&bh1730->client->dev,
> +			"i2c read failed error %d, register %01x\n",
> +			ret, reg);
> +
> +	return ret;
> +}
> +
> +static int bh1730_write(struct bh1730_data *bh1730, u8 reg, u8 val)
> +{
> +	int ret = i2c_smbus_write_byte_data(bh1730->client,
> +					    BH1730_CMD_BIT | reg,
> +					    val);
> +	if (ret < 0)
> +		dev_err(&bh1730->client->dev,
> +			"i2c write failed error %d, register %01x\n",
> +			ret, reg);
> +
> +	return ret;
> +}

Have you considered using the regmap? I personally prefer it as it gives 
a few nice interfaces like the regmap_update bits(). It also implements 
register caching - which typically allows us to drop cached stuff from 
the driver private data. I think most of the upstream ROHM IC-drivers 
use it so it might also make things look more familiar to some contributors.

Well, seeing you don't use too many control registers, I will leave this 
to you and other reviewers to decide.

> +static int bh1730_gain_multiplier(struct bh1730_data *bh1730)
> +{
> +	int multiplier;
> +
> +	switch (bh1730->gain) {
> +	case BH1730_GAIN_1X:
> +		multiplier = 1;
> +		break;
> +	case BH1730_GAIN_2X:
> +		multiplier = 2;
> +		break;
> +	case BH1730_GAIN_64X:
> +		multiplier = 64;
> +		break;
> +	case BH1730_GAIN_128X:
> +		multiplier = 128;
> +		break;
> +	default:
> +		multiplier = -EINVAL;
> +		break;
> +	}
> +
> +	if (multiplier < 0) {
> +		dev_warn(&bh1730->client->dev,
> +			 "invalid gain multiplier settings: %d\n",
> +			 bh1730->gain);
> +		bh1730->gain = BH1730_GAIN_1X;
> +		multiplier = 1;
> +	}
> +
> +	return multiplier;
> +}
> +
> +static int bh1730_set_gain(struct bh1730_data *bh1730, enum bh1730_gain gain)
> +{
> +	int ret = bh1730_write(bh1730, BH1730_REG_GAIN, gain);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	bh1730->gain = gain;
> +
> +	return 0;
> +}
> +
> +static int bh1730_itime_us(struct bh1730_data *bh1730, int cycle)
> +{
> +	return (BH1730_ITIME_TO_US * cycle);
> +}
> +
> +
> +static int bh1730_set_integration_time_cycle(struct bh1730_data *bh1730,
> +					  u32 cycle)
> +{
> +	int ret, itime;
> +
> +	itime = 256 - cycle;
> +
> +	/* ITIME == 0 is reserved for manual integration mode. */
> +	if (itime <= 0 || itime > 255) {
> +		dev_warn(&bh1730->client->dev,
> +		"integration time out of range: %d cycles\n",
> +		 cycle);
> +
> +		return -ERANGE;
> +	}
> +
> +	ret = bh1730_write(bh1730, BH1730_REG_TIMING, itime);
> +	if (ret < 0)
> +		return ret;
> +
> +	bh1730->itime_us = bh1730_itime_us(bh1730, cycle);
> +	bh1730->tmt_us = bh1730->itime_us + BH1730_ADC_CALC_DELAY_US;
> +
> +	return 0;
> +}
> +
> +static int bh1730_adjust_gain(struct bh1730_data *bh1730)
> +{
> +	int visible, ir, highest, gain, ret;
> +
> +	visible = bh1730_read_word(bh1730, BH1730_REG_DATA0LOW);
> +	if (visible < 0)
> +		return visible;
> +
> +	ir = bh1730_read_word(bh1730, BH1730_REG_DATA1LOW);
> +	if (ir < 0)
> +		return ir;
> +
> +	highest = max(visible, ir);
> +
> +	/* Adjust gain based on sensitivity calibration */
> +	gain = bh1730->gain;
> +	if (highest > bh1730->cal.gain_coeff[gain].fl &&
> +	    gain != BH1730_GAIN_1X) {
> +		gain--; /* Decrease sensitivity */
> +	} else if (highest < bh1730->cal.gain_coeff[gain].cl &&
> +		   gain != BH1730_GAIN_128X) {
> +		gain++; /* Increase sensitivity */
> +	}
> +
> +	/* Clamp to proper gain values */
> +	if (gain < 0)
> +		gain = BH1730_GAIN_1X;
> +	else if (gain > BH1730_GAIN_128X)
> +		gain = BH1730_GAIN_128X;
> +
> +	if (gain != bh1730->gain) {
> +		ret = bh1730_set_gain(bh1730, gain);
> +		if (ret < 0)
> +			return ret;
> +
> +		usleep_range(bh1730->tmt_us, bh1730->tmt_us + 1000);
> +	}
> +
> +	return 0;
> +}

Hm. Is it usual thing to do this type of "automatic gain control" 
in-kernel? I kind of expected seeing scale-setting exposed to the 
user-space via the standard attributes, and assumed user-space would the 
do the required tricks to tune the scale, (integration-time or the gain 
as decided by the driver), if channel is saturated or accuracy drops too 
much.

Anyways, the only "improvement" I can think of, would be adjusting also 
the integrating time if data gets saturated with 1X gain - or if more 
accuracy is needed. That might, or might not, make sense on some systems 
using this component. If you decide to pursue this approach, then you 
may want to check the gts-helpers code which should provide you some 
tools for handling the gains and integration times.

Well, if you only use the Nintendo Switch, and if it does not need 
anything fancier, then I am not complaining!

Finally, I am unsure if the default gain_coefficients need to be ever 
overridden? I am not sure I understand why they would? Wouldn't simple 
hard-coded limits work just fine? Anyways, as I wrote, I am not 
complaining. ;) This looks clean-enough to me - let's see what wiser 
people say!

> +static int bh1730_get_lux(struct bh1730_data *bh1730)
> +{
> +	int i, visible, ir;
> +	struct opt_win_coeff_t *opt_win_coeff;
> +	u64 lux = 0;
> +
> +	visible = bh1730_read_word(bh1730, BH1730_REG_DATA0LOW);
> +
> +	/* If visible is 0, skip calculations */
> +	if (visible <= 0)
> +		return visible;
> +
> +	ir = bh1730_read_word(bh1730, BH1730_REG_DATA1LOW);
> +	if (ir < 0)
> +		return ir;
> +
> +	/* Calibrate based on optical window */
> +	for (i = 0; i < bh1730->cal.opt_win_coeff_count; i++) {
> +		opt_win_coeff = &bh1730->cal.opt_win_coeff[i];
> +		if (1000 * ir / visible < opt_win_coeff->rc) {
> +			lux = ((u64)opt_win_coeff->cv * visible) -
> +				   (opt_win_coeff->ci * ir);
> +			break;
> +		}
> +	}
> +
> +	/* Calculate lux */
> +	lux *= BH1730_DEFAULT_ITIME_MS;
> +	lux /= bh1730_gain_multiplier(bh1730) * bh1730->itime_us;
> +	lux = (lux * bh1730->cal.mul) / 1000;
> +
> +	if (lux > BH1730_MAX_MEASURED_LUX)
> +		lux = BH1730_MAX_MEASURED_LUX;
> +
> +	return (int)lux;
> +}
> +
> +static int bh1730_power_ctrl(struct bh1730_data *bh1730, bool enable)
> +{
> +	struct device *dev = &bh1730->client->dev;
> +	static bool enabled;
> +	int ret = 0;
> +
> +	if (enabled == enable)
> +		return ret;
This flag smells racy. Does this require protection?

> +
> +	if (enable) {
> +		if (!IS_ERR_OR_NULL(bh1730->reg_vdd)) {
> +			ret = regulator_enable(bh1730->reg_vdd);
> +			if (ret) {
> +				dev_err(dev, "%s: Failed to enable vdd: %d\n",
> +					__func__, ret);

I think you should be able to drop the __func__ from all the prints.

> +				return ret;
> +			}
> +		}
> +
> +		if (!IS_ERR_OR_NULL(bh1730->reg_vid)) {
> +			ret = regulator_enable(bh1730->reg_vid);
> +			if (ret) {
> +				dev_err(dev, "%s: Failed to enable vid: %d\n",
> +					__func__, ret);
> +				return ret;
> +			}
> +		}
> +
> +		usleep_range(BH1730_POWER_ON_DELAY_US, BH1730_POWER_ON_DELAY_US + 1000);
> +	} else {
> +		if (!IS_ERR_OR_NULL(bh1730->reg_vdd)) {
> +			ret = regulator_disable(bh1730->reg_vdd);
> +			if (ret) {
> +				dev_err(dev, "%s: Failed to disable vdd: %d\n",
> +					__func__, ret);
> +				return ret;
> +			}
> +		}
> +
> +		if (!IS_ERR_OR_NULL(bh1730->reg_vid)) {
> +			ret = regulator_disable(bh1730->reg_vid);
> +			if (ret) {
> +				dev_err(dev, "%s: Failed to disable vid: %d\n",
> +					__func__, ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	enabled = enable;
> +
> +	return ret;
> +}
> +
> +static int bh1730_power_on(struct bh1730_data *bh1730)
> +{
> +	int ret = bh1730_power_ctrl(bh1730, true);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return bh1730_write(bh1730, BH1730_REG_CONTROL,
> +			    BH1730_CONTROL_POWER | BH1730_CONTROL_ADC_EN);
> +}
> +
> +static int bh1730_init_config(struct bh1730_data *bh1730)
> +{
> +	int ret;
> +
> +	ret = bh1730_set_gain(bh1730, BH1730_GAIN_64X);
> +	if (ret < 0)
> +		return ret;
> +
> +	return bh1730_set_integration_time_cycle(bh1730,
> +						bh1730->cal.itime_cycle);
> +}
> +
> +static int bh1730_power_off(struct bh1730_data *bh1730)
> +{
> +	int ret = bh1730_write(bh1730, BH1730_REG_CONTROL, 0);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return bh1730_power_ctrl(bh1730, false);
> +}
> +
> +static int bh1730_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bh1730_data *bh1730 = iio_priv(indio_dev);
> +	int data_reg, ret;
> +
> +	ret = bh1730_adjust_gain(bh1730);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = bh1730_get_lux(bh1730);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->channel2) {
> +		case IIO_MOD_LIGHT_CLEAR:
> +			data_reg = BH1730_REG_DATA0LOW;
> +			break;
> +		case IIO_MOD_LIGHT_IR:
> +			data_reg = BH1730_REG_DATA1LOW;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		ret = bh1730_read_word(bh1730, data_reg);
> +		if (ret < 0)
> +			return ret;
> +		ret = ret * 1000 / bh1730_gain_multiplier(bh1730);

Again, I am not sure if this is the usual way. For me it would look 
"more raw", if the raw data was provided as it is in the channel, and 
the used gain/integration time was exposed via scale. Well, I suppose it 
wouldn't work with the 'automatic, id-driver gain correction' as reading 
gain and data would be racy. Oh well... I'll leave this to others as well :)

> +		*val = ret / 1000;
> +		*val2 = (ret % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = bh1730->itime_us;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1730_parse_dt(struct bh1730_data *bh1730, struct device_node *dn)
> +{
> +	struct device *dev = &bh1730->client->dev;
> +	int ret;
> +	u32 *opt_win_coeff = NULL;
> +	u32 *gain_coeff = NULL;
> +	int opt_win_coeff_count = 0, gain_coeff_count = 0, cycle = 0, mul = 0;
> +
> +	memcpy(&bh1730->cal, &def_lux_data, sizeof(struct lux_cal_data_t));
> +
> +	if (dn) {
> +		/* Get regulators */
> +		bh1730->reg_vdd = regulator_get(dev, "als-vdd");
> +		if (IS_ERR_OR_NULL(bh1730->reg_vdd)) {
> +			bh1730->reg_vdd = NULL;
> +			dev_warn(dev, "failed to get als-vdd");
> +		}
> +
> +		bh1730->reg_vid = regulator_get(dev, "als-vid");
> +		if (IS_ERR_OR_NULL(bh1730->reg_vid)) {
> +			bh1730->reg_vid = NULL;
> +			dev_warn(dev, "failed to get als-vid");
> +		}
> +
> +		/* Get calibration */
> +		ret = of_property_read_u32(dn,
> +				"rohm,integration-cycle", &cycle);
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = of_property_read_u32(dn,
> +				"rohm,lux-multiplier", &mul);
> +		if (ret < 0)
> +			goto out;
> +
> +		if (cycle == 0 || mul == 0)
> +			goto out;
> +
> +		/* Get optical window coefficients */
> +		opt_win_coeff_count = of_property_count_elems_of_size(dn,
> +					"rohm,opt-win-coeff", sizeof(u32));
> +		if (opt_win_coeff_count > 0) {
> +			opt_win_coeff = devm_kzalloc(dev,
> +						sizeof(u32) * opt_win_coeff_count,
> +						GFP_KERNEL);
> +			if (!opt_win_coeff) {
> +				dev_err(dev, "failed to allocate mem for opt_win_coeff");
> +				return -ENOMEM;
> +			}
> +
> +			ret = of_property_read_u32_array(dn, "rohm,opt-win-coeff",
> +					opt_win_coeff, opt_win_coeff_count);
> +
> +			if (ret) {
> +				devm_kfree(dev, opt_win_coeff);
> +				goto out;
> +			}
> +		}
> +
> +		/* Get gain sensitivity coefficients */
> +		gain_coeff_count = of_property_count_elems_of_size(dn,
> +					"rohm,gain-coeff", sizeof(u32));
> +
> +		if (gain_coeff_count == 8) { /* 2 for each gain supported */
> +			gain_coeff = devm_kzalloc(dev,
> +					sizeof(u32) * gain_coeff_count,
> +					GFP_KERNEL);
> +			if (!gain_coeff) {
> +				dev_err(dev, "failed to allocate mem for gain_coeff");
> +				return -ENOMEM;
> +			}
> +
> +			ret = of_property_read_u32_array(dn, "rohm,gain-coeff",
> +					gain_coeff, gain_coeff_count);
> +			if (ret) {
> +				if (opt_win_coeff)
> +					devm_kfree(dev, opt_win_coeff);
> +				devm_kfree(dev, gain_coeff);
> +				goto out;
> +			}
> +		}
> +
> +		if (opt_win_coeff) {
> +			bh1730->cal.opt_win_coeff =
> +					(struct opt_win_coeff_t *)opt_win_coeff;
> +			bh1730->cal.opt_win_coeff_count =
> +					opt_win_coeff_count /
> +					(sizeof(struct opt_win_coeff_t) /
> +					sizeof(u32));
> +		}
> +
> +		if (gain_coeff)
> +			bh1730->cal.gain_coeff = (struct gain_coeff_t *)gain_coeff;
> +
> +		bh1730->cal.itime_cycle = cycle;
> +		bh1730->cal.mul = mul;
> +
> +		return 0;
> +	}
> +
> +out:
> +	dev_info(&bh1730->client->dev, "using default calibration");

Is this really required info? I might consider making this debug (if 
defaults really work well), or a warn (if defaults aren't working well). 
Not sure having this as 'info' at every boot makes sense.

> +
> +	return 0;
> +}
> +
> +static const struct iio_info bh1730_info = {
> +	.read_raw = bh1730_read_raw,
> +};
> +
> +static const struct iio_chan_spec bh1730_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +};
> +
> +static int bh1730_probe(struct i2c_client *client)
> +{
> +	struct bh1730_data *bh1730;
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> +		return -EIO;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bh1730));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	bh1730 = iio_priv(indio_dev);
> +	bh1730->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = bh1730_parse_dt(bh1730, client->dev.of_node);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = bh1730_power_on(bh1730);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = bh1730_init_config(bh1730);
> +	if (ret < 0)
> +		return ret;

This does not (try) power-off BH1730? but - see "devm" comment below...

> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &bh1730_info;
> +	indio_dev->name = "bh1730";
> +	indio_dev->channels = bh1730_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(bh1730_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto out_power_off;

Why not the devm -variant? I think that if you used devm here, and added 
an action for the power-off, then you might be able to ditch the remove()?

> +
> +	return 0;
> +
> +out_power_off:
> +	dev_info(&client->dev, "%s: failed\n", __func__);
> +	bh1730_power_off(bh1730);
> +	return ret;
> +}
> +


Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
