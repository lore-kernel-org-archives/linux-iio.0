Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20E4A2076
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967114; cv=none; b=iNkR6jYVt9D3TZePkCW1fEmbazr2r2Zx0SG9Tsg9dDH+ygtisbVnRwEDBXqZS7qgd5gAPeLsg32xBUIrcOSNHl4wZd+9JAL3Mn9mjE72GkTCUvoe96H51HFTu5OCqacPBUXSeuFpW/OjvuMWTwRfU6rAWPlKMxBvA5rHf2/WvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967114; c=relaxed/simple;
	bh=JO6SAvRaBMyzIbLTHuTc8USye2wjlop6dNXArjL0X6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SngLSxR1Z5uOVFIxeeiIZbZl1uRkPiibp6PUJPCqHKmOasKjaj7Imb9I/Rk3IgMfddmR7mxvhIclQUTm99Il3shucO+ii9018NW//ZfZAhcnvX3k906cijfnOf8IavRBM7hDR0+RfjnXxR/g0qB/2lx87id7yL+xUQwDwVcW1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NgWkq68t; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgWkq68t"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso5925315e9.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791967111; x=1792571911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMZhnOvjpzHTO71fpTwLw1UDe64T69lDJv2/l1M0xF4=;
        b=NgWkq68t1jRKwC7EdVkxor3rStRJml/QOZnh7hs+JExxqlLdDlo0jO9DzfYzIc1HaY
         ZInVhXIalysp3yo7XAfQOIBLN8oo7cgaJV2GgCVJu3HpZ52svXAitk8c6QN1G6500fZu
         W/jea1bFdTschGADzNwoaS5X4VlUozz9DOceJhG/eap5Bxt51Ft1sEuqgJtzbimgG4QY
         E4AEy9AT7vDIMwOPz1PingGy1I6SNrQh5rBv8kpiyJ8KmgHRLBLCUo2GpINNx1MUFFms
         GHRYSaVDDMgprgXg2vi8Ru7UCiGuydV9xEs6D1QFqb4sDSSKjW9OAGmNH5MdzAfOwnys
         QY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791967111; x=1792571911;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMZhnOvjpzHTO71fpTwLw1UDe64T69lDJv2/l1M0xF4=;
        b=I4W7G9znliaOO/xuSmfqT+kmnc5/OLzREBDuR//p+xkHzU08G1SjXUeeR8mI902P9y
         WZoSWyh3MWKZJWE5u4P49kBCCAeVrTrJgrpzG2VJegHhTWghrwvOnYm186tM9G+oDXyy
         V2yzT/3lplBB9JNAImu2psxAbm/7uaj70unLIlQ1Vrw6sBcW2w8oKx6zcnf4nYDyP2DN
         yYok2qDRUcBEzdxwyU10csfg0CJgcLaO3G2atACh82rvqevYzhPNiz3K3iyZp+MxENaB
         zHmz3fK/FiPMkufr6dLoPMXMawrbtE7X6w+OmqXqL1e5HsZOUWq6naKtUjkho/CDAig4
         nsgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzk1kXUjoWSl0H09slS2c+qmUzj0/oHpOGaLO+fEOZHAUMV9ci8D4a1cv1YKCalwD2nX9LyE0X9kiY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhdL7k80Y0I+26arcmSTSJ4Dqfp08A27/+4X6YApxUPmWmPF3c
	yv/S9bQRVEexWVgveckELhlSJndSsjMS385SK9nNqsaQOZIIkKruGpsFAxy7f0rJ/21m/wT2Ugj
	4UB6O
X-Gm-Gg: AYBFou1e2OpdL0ZOlqGJDarxKOSuTbsf6oGW7Mo/A9dAIFZwbadE5dbBwNa1LQ99L0M
	yATnr8WN/jClIMGEXOqE4I12jc3712sQn3cKseBwYhZxmDdUO4r2WGVv9UiSNrEEp2AYNkSN/1d
	sH7qwrRnQed+7q1U4r8imkKQr5a9iQT/2LGMvSYyl1CWd3dSv0oTQnyl0xxRBG46fGYPAqJHz5N
	xi6IAczn6s8mSJE8CuUpfOUlZgpPZ/cou6DAB3abh/Vw101TJbmWheZIkAv8dhyhx2GYS8Utzfa
	LanQgo1KBrgTY3uG6c1t/rLBQ3K5FW/4GFv4kNKb4cuUGKj4YksYttpP+UTrVueHqgtildTnq4H
	G0BADL2iqbDxHWaA+Od/fMGrP+hqJsm3813FmF5LO6c1T8kb7Q4zAzfsoliO4ZWBQioJnnbk8EX
	yzm+L014WNLm98ez7h22bA7RTxoQM3uuZY+3ba1+asA3qg2M5J4wzBVIH3GOCtWJ5W5CnvOHm42
	p+x8tf1l2eVyy/x2AGVELqUsCO8M8YEpUH04YnjdfpoeC7QpicqJ28=
X-Received: by 2002:a05:600c:8716:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a18e44885dmr308679065e9.2.1791967110636;
        Wed, 14 Oct 2026 01:38:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb? ([2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf3e044sm414310595e9.14.2026.10.14.01.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 01:38:29 -0700 (PDT)
Message-ID: <ba2c6e14-cb4f-47e7-92d6-7c57312daa6b@linaro.org>
Date: Wed, 14 Oct 2026 10:38:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 3/3] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
 <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
 <as5F1uZ3DnOPYoWV@ashevche-desk.local>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <as5F1uZ3DnOPYoWV@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/13/26 16:53, Andy Shevchenko wrote:
> On Tue, Oct 13, 2026 at 04:07:13PM +0200, Neil Armstrong wrote:
>> The MAX34417 is a specialized current and voltage monitor used to
>> determine power consumption of portable systems. The driver support
>> getting the channels voltage, average power and accumulated average
>> power and energy over an I2C/SMBUS serial interface.
>>
>> The MAX34417 datasheet only specified on how to calculate the
>> accumulated average power, but with the Sample Per Second rate
>> we can easily get accumulated Energy in mJ.
>>
>> By default the IIO driver only supports single-shot Voltage
>> and Power sensing, but the accumulation can be enabled by
>> enabling the Energy IIO channel which then enables the
>> Continuous Accumulation Mode.
>>
>> The counter is common to all channels, so when reading a single
>> channel we will copy all accumulators to registers, so in order
>> to permit reading individual channels we must accumulate the
>> other channels in the driver when Continuous Accumulation Mode
>> is enabled.
> 
> ...
> 
>> +#define MAX34417_MIN_RSENSE		(MILLI)	/* 1 milliOhm */
> 
> 1 * MILLI
> 
>> +#define MAX34417_MAX_RSENSE		(100 * MILLI) /* 100 milliOhm */
>> +#define MAX34417_DEFAULT_RSENSE		MAX34417_MIN_RSENSE
> 
> I would rather put the exact value here as well.

This would duplicate the value for no reason, right ?

> 
> ...
> 
>> +struct max34417_data {
>> +	struct iio_dev *indio_dev;
> 
>> +	struct regmap *regmap;
>> +	struct device *dev;
> 
> One of them seems redundant (I suppose the 'dev').

Probably yes

> 
>> +	struct mutex lock;
>> +	u32 input_correction[MAX34417_CHANNEL_COUNT];
>> +	const char *input_label[MAX34417_CHANNEL_COUNT];
>> +	bool cam_mode;
>> +	u64 acc_power[MAX34417_CHANNEL_COUNT];
>> +	u32 acc_count[MAX34417_CHANNEL_COUNT];
>> +};
>> +
>> +static const struct regmap_config max34417_regmap_config = {
>> +	.reg_bits	= 8,
>> +	.val_bits	= 8,
>> +	.max_register	= MAX34417_BULK_VOLTAGE_READOUT_REG,
> 
> No cache? All registers are volatile?
> 
>> +};
> 
> ...
> 
>> +#define MAX34417_CHANNEL(_index, _v_address, _power_address)	\
>> +	{							\
>> +		.type = IIO_VOLTAGE,				\
>> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
>> +					  BIT(IIO_CHAN_INFO_SCALE), \
> 
> Instead of broken indentation at the end, use different style for these type of
> assignments, like
> 
> 		.info_mask_separate =
> 			BIT(IIO_CHAN_INFO_RAW) |		\
> 			BIT(IIO_CHAN_INFO_SCALE),		\
> 
> Also do not use brokenly indented '=', just a space after the field is enough.
> 
> 
>> +		.channel = (_index),				\
>> +		.address = (_v_address),			\
>> +		.indexed = 1,					\
>> +	},							\
>> +	{							\
>> +		.type = IIO_POWER,				\
>> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
>> +					  BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
>> +					  BIT(IIO_CHAN_INFO_SCALE), \
>> +		.channel = (_index),				\
>> +		.address = (_power_address),			\
>> +		.indexed = 1,					\
>> +	},							\
>> +	{							\
>> +		.type = IIO_ENERGY,				\
>> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
>> +					  BIT(IIO_CHAN_INFO_SCALE), \
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_ENABLE), \
>> +		.channel = (_index),				\
>> +		.address = (_power_address),			\
>> +		.indexed = 1,					\
>> +	}
> 
> ...
> 
>> +static int max34417_reset_smm(struct max34417_data *max34417)
>> +{
>> +	u32 control;
>> +	int rc;
>> +
>> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Set SMM=0 to re-init the SMM mode */
>> +	control &= ~(MAX34417_CONTROL_SMM);
>> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
>> +	if (rc)
>> +		return rc;
> 
> regmap_update_bits() / regmap_clear_bits()?
> 
>> +	/* Reset accumulators after setting SMM=0 */
>> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
>> +	if (rc)
>> +		return rc;
> 
> regmap_set_bits() ?
> 
>> +	return 0;
>> +}
> 
> ...
> 
> Also check the rest of the code for the similar RMW cases.
> 
> ...
> 
>> +	/*
>> +	 * UPDATE commands should be no less than 1msec apart for reliable
>> +	 * measurements.
>> +	 */
>> +	fsleep(1000);
> 
> 1 * USEC_PER_MSEC
> 
>> +	u32 acc_count;
>> +	int rc;
>> +
>> +	rc = max34417_read_acc_count(max34417, &acc_count);
>> +	if (rc)
>> +		return rc;
>> +
>> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {
> 
> 'i' is not used outside of the loop AFAICS. Also why pre-increment?

I'm not used defining variables in the for loop, and bad habit...

> 
> 	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++) {
> 
>> +		rc = max34417_read_acc_power(max34417, MAX34417_PWR_ACC_1_REG + i,
>> +					     &acc_power);
>> +		if (rc)
>> +			return rc;
>> +
>> +		max34417->acc_power[i] += acc_power;
>> +		max34417->acc_count[i] += acc_count;
>> +	}
> 
> ...
> 
>> +	/* Check for overflow */
>> +	rc = max34417_check_ovf(max34417);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
> 
> 	return ..._check_ovf(...);
> 
> ...
> 
>> +	/* Ignore byte0 */
>> +	voltage = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]);
>> +	voltage >>= 2;
> 
> The above comment is odd. Please, clarify, ideally with a reference to
> the datasheet table / section / et cetera.

Odd ? I mean it's not, we skip byte 0 and get unaligned big-endian 16bit at offset 1...

> 
> Also can be folded into a single expression:
> 
> 	voltage = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]) >> 2;
> 
> ...
> 
>> +		if (unlikely(acc_count == 0)) {
> 
> Why unlikely()? Is this a hot-path? What is the performance effect will it give?

It's highly unlikely yes, not specifically a hot path, will remove if to controversial.

> 
>> +			dev_warn(max34417->dev, "unexpected zero accumulator count\n");
>> +
>> +			*val = 0;
>> +			*val2 = 0;
>> +
>> +			return IIO_VAL_INT_64;
>> +		}
> 
> ...
> 
>> +	/*
>> +	 * Move the data to the SMBus registers
>> +	 */
> 
> A single line comment.
> 
> ...
> 
>> +static int max34417_setup_cam_mode(struct max34417_data *max34417, int val)
>> +{
>> +	u32 control;
>> +	int rc, i;
>> +
>> +	guard(mutex)(&max34417->lock);
>> +
>> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (max34417->cam_mode && !val) {
>> +		/* SMM and CAM modes should not be enabled at the same time */
>> +		control &= ~(MAX34417_CONTROL_CAM | MAX34417_CONTROL_SMM);
>> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
>> +		if (rc)
>> +			return rc;
>> +
>> +		/*
>> +		 * If CAM mode must be set, the Control byte must be set to
>> +		 * desired values with CAM = 0, then followed by an UPDATE
>> +		 */
>> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
>> +		if (rc)
>> +			return rc;
>> +	} else if (!max34417->cam_mode && val) {
>> +		/*
>> +		 * After this, the CAM mode bit can be set and another
>> +		 * UPDATE must be sent.
>> +		 */
>> +		control |= MAX34417_CONTROL_CAM;
>> +		/* SMM and CAM modes should not be enabled at the same time */
>> +		control &= ~(MAX34417_CONTROL_SMM);
>> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
>> +		if (rc)
>> +			return rc;
>> +
>> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
>> +		if (rc)
>> +			return rc;
>> +
>> +		/* Reset counters and accumulators */
>> +		for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {
> 
> 		for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++) {
> 
>> +			max34417->acc_power[i] = 0;
>> +			max34417->acc_count[i] = 0;
>> +		}
>> +	}
>> +
>> +	max34417->cam_mode = val;
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +static int max34417_read_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int *val, int *val2, long mask)
>> +{
>> +	struct max34417_data *max34417 = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		switch (chan->type) {
>> +		case IIO_VOLTAGE:
>> +			return max34417_read_voltage(max34417, chan, val);
>> +		case IIO_POWER:
>> +			/* In default mode, we return a single measurement */
>> +			if (max34417->cam_mode)
>> +				return -EINVAL;
>> +
>> +			return max34417_read_power(max34417, chan, val, val2);
>> +		case IIO_ENERGY:
>> +			if (!max34417->cam_mode)
>> +				return -EINVAL;
>> +
>> +			return max34417_read_energy(max34417, chan, val, val2);
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_AVERAGE_RAW:
>> +		if (chan->type != IIO_POWER)
>> +			return -EINVAL;
>> +
>> +		/* In CAM mode, we return an average measurement */
>> +		if (!max34417->cam_mode)
>> +			return -EINVAL;
>> +
>> +		return max34417_read_power(max34417, chan, val, val2);
>> +	case IIO_CHAN_INFO_SCALE:
>> +		if (chan->type == IIO_VOLTAGE) {
>> +			/* Scale to mV */
>> +			*val = MAX34417_VOLTAGE_CORRECTION_SCALE * MILLI;
>> +			*val2 = MAX34417_VOLTAGE_FULL_SCALE_BITS;
>> +
>> +			return IIO_VAL_FRACTIONAL_LOG2;
>> +		} else if (chan->type == IIO_POWER) {
>> +			/*
>> +			 * Scale to mW
>> +			 * (1000 * (Power Accumulation / Counter) * Correction) / 2^30
>> +			 */
>> +			*val = max34417->input_correction[chan->channel] * MILLI;
> 
> MILLIWATT_PER_WATT
> 
>> +			*val2 = MAX34417_PWR_AVG_FULL_SCALE_BITS;
>> +
>> +			return IIO_VAL_FRACTIONAL_LOG2;
>> +		} else if (chan->type == IIO_ENERGY) {
>> +			/*
>> +			 * Scale to mJ
>> +			 * P=(1000 * (Power Accumulation / Counter) * Correction) / 2^30
>> +			 * t=(Counter / Samples per Second)
>> +			 * E=(P * t)
>> +			 * Can be simplified to:
>> +			 * (1000 * Power Accumulation * Correction) / (2^30 * SPS)
>> +			 * The denominator doesn't fit in 32bit so scale down both terms.
>> +			 */
>> +			*val = max34417->input_correction[chan->channel];
>> +			*val2 = ((u64)(1 << MAX34417_PWR_AVG_FULL_SCALE_BITS) *
> 
> Why not BIT_ULL() and drop that casting altogether? Also seems that it becomes
> 64-bit division. Does it compile on 32-bit?

Good point, will need to check that

> 
>> +				 MAX34417_FAST_SPS_CAM) / MILLI;
>> +
>> +			return IIO_VAL_FRACTIONAL;
>> +		}
>> +
>> +		return -EINVAL;
>> +	case IIO_CHAN_INFO_ENABLE:
>> +		*val = max34417->cam_mode;
>> +
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
> ...
> 
>> +static int max34417_read_label(struct iio_dev *indio_dev,
>> +			       struct iio_chan_spec const *chan,
>> +			       char *label)
>> +{
>> +	struct max34417_data *max34417 = iio_priv(indio_dev);
>> +	const char *input_label = max34417->input_label[chan->channel];
>> +
>> +	if (chan->type == IIO_VOLTAGE) {
>> +		if (input_label)
>> +			return sysfs_emit(label, "%s-voltage\n", input_label);
>> +
>> +		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
>> +	}
>> +
>> +	if (chan->type == IIO_POWER) {
>> +		if (input_label)
>> +			return sysfs_emit(label, "%s-power\n", input_label);
>> +
>> +		return sysfs_emit(label, "channel%d-power\n", chan->channel);
>> +	}
>> +
>> +	if (chan->type == IIO_ENERGY) {
>> +		if (input_label)
>> +			return sysfs_emit(label, "%s-energy\n", input_label);
>> +
>> +		return sysfs_emit(label, "channel%d-energy\n", chan->channel);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> This can be simplified, right?

I don't find this really simplified TBH, just reorganized

> 
> 	if (input_label) {
> 		switch (chan->type) {
> 		case IIO_VOLTAGE:
> 			return sysfs_emit(label, "%s-voltage\n", input_label);
> 		...
> 		default:
> 			return 0;
> 		}
> 	}
> 
> 	switch (chan->type) {
> 	case IIO_VOLTAGE:
> 		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
> 	...
> 	default:
> 		return 0;
> 	}
> 
> ...
> 
>> +	mutex_init(&max34417->lock);
> 
> Why not devm_mutex_init()?
> 
> ...
> 
>> +	/* Set default input correction for all channels */
>> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i)
> 
> 	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++)
> 
>> +		max34417->input_correction[i] =
>> +			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
> 
> ...
> 
>> +		if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
>> +			rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
>> +						      &rsense);
> 
> Name the variable with units, rsense_mOhm.
> 
>> +			if (rc)
>> +				return dev_err_probe(dev, rc,
>> +						"failure reading shunt property of %pfwP\n",
>> +						node);
>> +
>> +			if (!rsense || rsense < MAX34417_MIN_RSENSE ||
>> +			    rsense > MAX34417_MAX_RSENSE)
> 
> Please, make it logically split
> 
> 			// also == 0 is okay for the actual values
> 			// (which have not a semantic of pointer or error)
> 			if (rsense == 0 ||
> 			    rsense < MAX34417_MIN_RSENSE || rsense > MAX34417_MAX_RSENSE)
> 
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "invalid shunt value %d of %pfwP\n",
>> +						     rsense, node);
>> +
>> +			max34417->input_correction[index] =
>> +				max34417_calc_input_correction(rsense);
>> +		}
>> +	}
> 

Thanks for the review,
Neil
