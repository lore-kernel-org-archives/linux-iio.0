Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201170;
	b=mPGDXZL5IP1aKnenltSKuRP2XX1VPS+LQUQ1tdu1+8hVMd0YN/EBKTUn98cgFR293qH/
	 MK+T0+1SmjeXarJiPKLLj41e2/ZRM5twSyu8o9U9i1dyoMz/7tLUQ7o2AidAOJX6pIURW
	 eIN/y9E7FCT38XXoELdPrI13GLTYSx9BVsX7OD0bsFXFMQklk7WvH2C+nLdjN1G+1TveW
	 gbcXsCyAVUPkbW4vNWsE9iVk0Xk8wm11sTlISPZ+HWV3lBkP05I2YSpdKb6QbahY+Jsew
	 MX0aVbgljwYwk40nTHeSe0YS6bWslPFjlrf+QyER0rHJT6MlOS8lZjLCa/Jo2j9n9dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:Autocrypt:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SzGJeY1XQv7Ti80u9ROK+gf1nVRlsdCP+OcYBFcsbik=;
	b=zMWN9TlC0s+zqn8nHrZGeQiaBoSSb12Qfgjfrwcthb6pIAjyeYBz8M9O5jaXmulmXtEb
	 vYe4qZ/EMf9DbvI+tVFpkcSYYuH/txglPZ9cwYU3cBVYyCrlReOXYpG4IZN9m0vxfQHvC
	 4K8ZMA7DFygTs1+R18WrFJ0LMqorV5VreZwjYFQEkeCvKktzC8dDpso2hwJv23/etcaCB
	 wuVAxE8liCCx4YQUBrGAeWlqwjgSsAvFXPbQLEuezETJiml6bmIeDbZ1H/6+Sss3j6ZgW
	 WLkVpNuxsXwXvJBfKAuYH1jFkA2s0I7OcD+oumWZzJEJdLttYhy2Om3mXLEP82h9JzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7221606A31D
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 15:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7221606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so9986305e9.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793201163; x=1793805963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzGJeY1XQv7Ti80u9ROK+gf1nVRlsdCP+OcYBFcsbik=;
        b=rsq0wtTSaf4iz+wbiJJZgHr9hp6cDYJGgeOP+2Fe9Qo2d1WQnOGaniKHOHs8iD5jWL
         Tihubk/mVvEO/1IpSruBRrV2VdU7RcCU2WEF5fu0AH4bSmwAVmgQvMpjrC/XXFuADryB
         Dpuayw9/IxsWURlpwp7yFfLx+NE+SIG0a5tpWo426ap1Q0pE7R9IEPOcRS5hcsfHV5Lh
         GNT8MDo2Wi2qGdztK+nAKwzLmXIWrsPjTk63aBuuaQ2LTYI4+FlgGeWy5ZT7971pW5VA
         5/OJex/STuawXdak7AgPYS/NTLDY1vlqMMnchFe9iBtHCh8ZasGttBkI2qRMF4b2sCs5
         rSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201163; x=1793805963;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzGJeY1XQv7Ti80u9ROK+gf1nVRlsdCP+OcYBFcsbik=;
        b=cvzE/SalJroPXmD3f88u5rgHwIiOlTjfROBYGvpT6p8XeAHlPPAQzktttiCPVxTXVk
         37GFJi5X+fFd66XFbQZykRBGL5VwT1U7zRmfT5+KVLiopVUx9s7oXkbT01GZ4cTSWyhz
         Zs4JnRH2VI/FvGe00Bi/B05ykCu/aHfALNeqbio24Hvi+QP9xdRmOW80y2cD5FP+ZJmu
         bqGG/iO7vlKD35KFkVFV25cij6ntVxyRyan0FaXmAcqgjg+0MddGvPxWJTHBQPm97NWV
         WQkrhiVyjLs2gCBt54iDRB4K3ItrlGGl/IELAJM0RdPWbaoq3gsB+JvjhtkHgbSeKNJT
         2zLA==
X-Forwarded-Encrypted: i=1; AKwUvByiAiVZifpyYLJB/Vh4EQkE1r9RVVPhdjAkANQX1K91polL4ZuGGjEJBHX8qH/xtnKyMBu5EHXlLts=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyErfvtKSFQzQsMWsc8TvZ9MwsFHLjZi0AM3GOaSUUn0KlS9ss
	SmuAomnhG17zRhczY5AekSQMy9N7hWnW+viUYAIhOq3rjQzrSx9MjlFMFFxrXU3KeDE=
X-Gm-Gg: AYBFou3LMPrJEBuXf+L8E/nUaXBj7SKxJ8SwmM98zQ3A/WAUMx51xUh/0LompIcXZQR
	wf4giwVAss3n4PccM2xMqDPQB6Iy2yALIjy8zrxah5m4YQ+cTDH3FXU3VtWiD0/wSqPKKMqU8pR
	OnZKC+P88dVmU3lXB+jTSR2+vk/VjCTm0GFiWt7xwiTw9xpTlBngYbAeJ7w+xyHnAnCExN3Ko51
	VbNnAMpulSciflj23OfliT/nrziUZkqdupsk5lX8cfyvMTVxjGce1y2+odxtqcMCG9jY70KlDLu
	Pt2uICKazLUM4nSWC2nzSnryOgXexkEDMHx3dvU0UFfFtPsPjFORc570o1F78MRY1lIqWlRGKNy
	9wiS7CVpcTZZ3YJi6hfQrXZoi0YuyIWpHQJfVUYqRI9vBUOCDsnc7rJivMqt9SNISpuUmz8p6cg
	wiqm7+onfPEa94ACXaO5jC/XMkzpG1Vx8khpyZkomUuC7QvVzadP+SbMJ/R8wNghHAoiiS4AflC
	CJ+T9OiRv1WQ3EsxFTe2KUetYpLehd0UBCERIQw3sx/mxW4Oc1JDD3rlQyXlmzwoYKpu18KWIPO
	+MKce4cR9hRvOfbuc7NgOViCFO027rd4No88k00RKJiTiGWMn+VS+90yYdE3BHQb4ElXk4CbvC/
	0uMkkZywIjg==
X-Received: by 2002:a05:600c:848c:b0:4a1:fe26:24f0 with SMTP id 5b1f17b1804b1-4a966b4afc5mr66907105e9.20.1793201162964;
        Wed, 28 Oct 2026 08:26:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b1ca:4456:1276:95ca? ([2a01:e0a:106d:1080:b1ca:4456:1276:95ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9783b7e87sm49789775e9.6.2026.10.28.08.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 08:26:02 -0700 (PDT)
Message-ID: <d2e93ac7-1689-4e06-a694-d0a95d05a400@linaro.org>
Date: Wed, 28 Oct 2026 16:26:01 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/3] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux@analog.com
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
 <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
 <auIPfwQII72aqyWA@ashevche-desk.local>
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
In-Reply-To: <auIPfwQII72aqyWA@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 16:06, Andy Shevchenko wrote:
> On Wed, Oct 28, 2026 at 02:19:06PM +0100, Neil Armstrong wrote:
>> The MAX34417 is a specialized current and voltage monitor used to
>> determine power consumption of portable systems. The driver support
>> getting the channels voltage, average power, accumulated average
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
>> +#define MAX34417_MIN_RSENSE		(1 * MILLI) /* 1000 microOhm */
>> +#define MAX34417_MAX_RSENSE		(100 * MILLI) /* 100000 microOhm */
>> +#define MAX34417_DEFAULT_RSENSE		(1 * MILLI) /* 1000 microOhm */
> 
> Add unit suffix. The comment versus MILLI multiplier is quite confusing.
> What I read, it's milli-Ohms by value.
> 
> ...
> 
>> +struct max34417_data {
>> +	struct iio_dev *indio_dev;
>> +	struct regmap *regmap;
>> +	struct mutex lock;
>> +	u32 input_correction[MAX34417_CHANNEL_COUNT];
>> +	const char *input_label[MAX34417_CHANNEL_COUNT];
>> +	bool cam_mode;
> 
> Don't you have 4-byte gap here in some cases? Can you confirm the layout
> with `pahole`? On top you can check binary size by running `bloat-o-meter`.
> 
>> +	u64 acc_power[MAX34417_CHANNEL_COUNT];
>> +	u64 acc_count[MAX34417_CHANNEL_COUNT];
>> +};
> 
> ...
> 
>> +static bool max34417_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case MAX34417_DID_REG:
>> +		return false;
>> +	default:
>> +	/* MAX34417_CONTROL_REG field OVF is volatile */
> 
> Why not add a case instead of a comment?

The case is handled by the default, the comment is here to
explain why MAX34417_CONTROL_REG is considered as volatile.

> 
>> +		return true;
>> +	}
>> +}
> 
> ...
> 
>> +static int max34417_reset_smm(struct max34417_data *max34417)
>> +{
>> +	int rc;
>> +
>> +	/* Set SMM=0 to re-init the SMM mode */
>> +	rc = regmap_clear_bits(max34417->regmap, MAX34417_CONTROL_REG,
>> +			       MAX34417_CONTROL_SMM);
> 
> With
> 
> 	struct regmap *map = max34417->regmap;
> 
> this becomes a single line
> 
> 	rc = regmap_clear_bits(map, MAX34417_CONTROL_REG, MAX34417_CONTROL_SMM);
> 
> Use this trick elsewhere where appropriate.

Ack

> 
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Reset accumulators after setting SMM=0 */
>> +	return regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
>> +}
> 
> ...
> 
>> +	*val = lower_32_bits(power);
>> +	*val2 = upper_32_bits(power);
> 
> Have you included wordpart.h?

Will add

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
>> +	if (input_label) {
>> +		switch (chan->type) {
>> +		case IIO_VOLTAGE:
>> +			return sysfs_emit(label, "%s-voltage\n", input_label);
> 
> sysfs.h for sysfs_emit().

Will add

> 
>> +		case IIO_POWER:
>> +			return sysfs_emit(label, "%s-power\n", input_label);
>> +		case IIO_ENERGY:
>> +			return sysfs_emit(label, "%s-energy\n", input_label);
>> +		default:
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	switch (chan->type) {
>> +	case IIO_VOLTAGE:
>> +		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
>> +	case IIO_POWER:
>> +		return sysfs_emit(label, "channel%d-power\n", chan->channel);
>> +	case IIO_ENERGY:
>> +		return sysfs_emit(label, "channel%d-energy\n", chan->channel);
>> +	default:
>> +		return 0;
>> +	}
>> +}
> 
> ...
> 
>> +static unsigned int max34417_calc_input_correction(u32 rsense_microOhm)
> 
> rsense_uOhm is shorter

Used that initially, will revert to that

> 
>> +{
>> +	/* (100 milliOhm / rsense) * MAX34417_PWR_CORRECTION_SCALE */
> 
> Comment in this form is almost useless. Rather explain that we except
> the result in the certain units or something like this.

Will try to improve

> 
>> +	return (MAX34417_MAX_RSENSE * MAX34417_PWR_CORRECTION_SCALE) / rsense_microOhm;
>> +}
> 
> ...
> 
>> +static int max34417_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct max34417_data *max34417;
>> +	struct iio_dev *indio_dev;
>> +	struct regmap *regmap;
> 
> *map is shorter

Ok

> 
>> +	int rc;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &max34417_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap_init failed\n");
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34417));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	rc = devm_regulator_get_enable(dev, "vdd");
>> +	if (rc)
>> +		return dev_err_probe(dev, rc, "failed to get vdd regulator\n");
>> +
>> +	rc = devm_regulator_get_enable(dev, "vio");
>> +	if (rc)
>> +		return dev_err_probe(dev, rc, "failed to get vio regulator\n");
>> +
>> +	max34417 = iio_priv(indio_dev);
>> +	max34417->regmap = regmap;
>> +	max34417->indio_dev = indio_dev;
>> +
>> +	rc = devm_mutex_init(dev, &max34417->lock);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Set default input correction for all channels */
>> +	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++)
>> +		max34417->input_correction[i] =
>> +			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
>> +
>> +	device_for_each_child_node_scoped(dev, node) {
>> +		u32 rsense_microOhm, index;
> 
> rsense_uOhm
> 
>> +		rc = fwnode_property_read_u32(node, "reg", &index);
>> +		if (rc)
>> +			return dev_err_probe(dev, rc, "failure reading reg property of %pfwP\n",
>> +					     node);
>> +
>> +		if (index >= MAX34417_CHANNEL_COUNT)
>> +			return dev_err_probe(dev, -EINVAL, "invalid reg %d of %pfwP\n",
> 
> -ECHRNG

Ack

> 
>> +					     index, node);
>> +
>> +		if (fwnode_property_present(node, "label")) {
>> +			rc = fwnode_property_read_string(node, "label",
>> +							 &max34417->input_label[index]);
>> +			if (rc)
>> +				return dev_err_probe(dev, rc,
>> +						"failure reading label property of %pfwP\n",
>> +						node);
>> +		}
>> +
>> +		if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
>> +			rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
>> +						      &rsense_microOhm);
>> +			if (rc)
>> +				return dev_err_probe(dev, rc,
>> +						"failure reading shunt property of %pfwP\n",
>> +						node);
>> +
>> +			if (rsense_microOhm < MAX34417_MIN_RSENSE ||
>> +			    rsense_microOhm > MAX34417_MAX_RSENSE)
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "invalid shunt value %d of %pfwP\n",
>> +						     rsense_microOhm, node);
>> +
>> +			max34417->input_correction[index] =
>> +				max34417_calc_input_correction(rsense_microOhm);
>> +		}
>> +	}
>> +
>> +	indio_dev->channels = max34417_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(max34417_channels);
>> +	indio_dev->name = "max34417";
>> +	indio_dev->info = &max34417_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	/*
>> +	 * Reset mode and set accumulator width to Wide
>> +	 *
>> +	 * The MAX34407 variant could be supported by setting the
>> +	 * MAX34417_CONTROL_MODE field to 0 and handling a smaller
>> +	 * accumulator width.
>> +	 */
>> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_CONTROL_MODE);
> 
> You have local variable for regmap, use it.
> 
>> +	if (rc)
>> +		return dev_err_probe(dev, rc, "Error writing control register\n");
>> +
>> +	/* Reset the accumulators */
>> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
> 

Thanks,
Neil
