Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F893B3C11
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174429; cv=none; b=BSkwmG2rS/ywUZ6ErSHBQQocerkTH1Z9g8TGclKmQjr0JO7C+vdjIaR4UQaDRAvcEANfcqOX4/8OCaxbrRA8n2HGda9ReZOIuHnkKFJvZ9nyL+Yey2BKWxfahpPQ0iXkTaV2r62iLHSZnvz4VyXI10e2MysPLWdZSL+yF7hyqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174429; c=relaxed/simple;
	bh=BMcuZpgrheTtw8YzlMY85egTpgVnX4SxV15uvlEKhA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKtJKawyyeeiwtheRLoUw5el054Uddo5Yz5wk0U8uw39tERE85QbF8gWbRrXdy6Zjc/PBdlSA/RetX4yKSE3eQkiiYk12mvWxLH4BA0Jj4t2hKkDCjNJS4MZwxrzSf7eOFAO939OCsCbveqD3FtU4gRo81Z0bIy/LnGpgJSgQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHqpetAH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHqpetAH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891b0786beso22119225e9.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 00:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779174425; x=1779779225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyEEvS9/Ik69rxCZnXUKAzpf2s9PN8D1R1Hqx/eCkrg=;
        b=YHqpetAHI1jQxLGxEd1pIGnfIcAU33q5IrPJ1/kHLAhrWFoFRuDeZfd5lu71uwi9FF
         v9NQqdgh/b8r1rASk3LeM3/wuOvzqd9ALgJOJUlBliHVsh8pzZtHtjguRqfUmXaouJV7
         NB5VjA+nzvnb0eeDzBztDqM+7MP8ruC/lebiSWqn0rCMua+YCchXZNQxyBY3PKXBLkSZ
         Iwc4aWhoTuWEClNs3FfPcE4rjGnfbklPBDnh9cMqQN3LK6x32vPHFX1AFaKWmEG4Qkpx
         4AJCx0A/10FWncuG2Ip9sexds/FMr3pdeZwpxQpq8bkuETcPBX8FGm5WKqL2YjgqO1pB
         qDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174425; x=1779779225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyEEvS9/Ik69rxCZnXUKAzpf2s9PN8D1R1Hqx/eCkrg=;
        b=kmCTN4fHLQ6gqiE82KK1RIq7u6rx+nxmfKPbB/+kQB0AQPDc3BxGO9PxpV1+8YFAZB
         Sa8S6lgPm9U4nX76xXT7c9dUwNZAfBilogOOgtUeD5u6p3BpCYfO3JxdZxZR86ZHV0t0
         FRfsiHqHl2H5P5BObN0r571GL9YeWuSUy+3s7yaRFltk2kS4jQKo2moEFl4+HsMVwy8n
         XSrH1mcfCkgIOQCMjVka5q+IKAgtCyWMMNViIezX+PhPd64MRRD3sYAb5U477puiPkS/
         BVkvcYMSHUXmF2LwY/aUwmgG4oDtcZJHHZklqjAeRPuKxJZWBE6Wa/AUF7dB0rCYlVj7
         NClQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lBk7e0QkcnZ+aPofMYdMr8MZKDAP+2BjDbm8n/iK1PZGRGVYeWaH7PccQZ2Z3JDos0SLzIUf3oWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxjAdHi1t7/0A/mcyYDUZHSkNQwPcZumob0aKd7QZAdrU2VFLc
	POy7s11Oofpvc8Q66SKVI5PXHMax37n4+8yUPTFpKpbmxdUZ6BF0kh2v
X-Gm-Gg: Acq92OGRbFy6pwd8DWgVLIOHgpKyOa5lEmr9lk7TbkIZGwUnsbEQQIuiN5UhlLYBpif
	d/UeJLrkpfBtG+6QbgJdUJ//9GzLBRWIFm4X842baSiCg/SABkoAFcvdmOpx4sZsXA8Jj10JK2y
	kuVw5lNEvWji4FNgHkDk/EHev619kx27c+XoDyrpfYtqeeGO99Jp2Ss+1nfLFaH4HlHT1YKW1uF
	Uc2KOt5PBopKcGLcLgvCErtMGv+Xnw+kmkWJwBidrZbmDRBLUSToCjxOUMy1l9D8adnpfoFohBu
	ZlSxM6QBDWDLjF26wHNR44NRe/QY0DVfIyCgdzEgSsWex0NHr/7sayNZW0nFyZn2sz5dzaGOlW9
	iCwP7tvr8oHnjuw3K5AVmGvb84ZjgPYozwk4B/HWq2rtovjV+vqTFVa49YTddCoJU72FB3tJXae
	/AWu/IlEoh6B+X27ZVBopBNtUOJqCP3AeIfHN73/zbUrxvWo2UNfXeGwl+6nfQnrwFUv+7
X-Received: by 2002:a5d:5f45:0:b0:45b:d891:56bb with SMTP id ffacd0b85a97d-45e5c5db696mr28861409f8f.38.1779174424577;
        Tue, 19 May 2026 00:07:04 -0700 (PDT)
Received: from ?IPV6:2a02:3033:6d8:15d8:ec15:f5ad:b85f:a3b8? ([2a02:3033:6d8:15d8:ec15:f5ad:b85f:a3b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm46305257f8f.10.2026.05.19.00.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:07:04 -0700 (PDT)
Message-ID: <233a93d1-1901-440b-902b-f0e482d9a1a4@gmail.com>
Date: Tue, 19 May 2026 09:07:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: dac: Add AD5529R DAC driver support
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
 <20260508-ad5529r-driver-v2-2-e315441685d7@analog.com>
 <20260508143017.28f86551@jic23-huawei>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20260508143017.28f86551@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/8/26 15:30, Jonathan Cameron wrote:
> On Fri, 8 May 2026 13:55:48 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
>
>> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
>>
>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> +/* Register Map */
>> +#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
>> +#define AD5529R_REG_INTERFACE_CONFIG_B		0x01
>> +#define AD5529R_REG_DEVICE_CONFIG		0x02
>> +#define AD5529R_REG_CHIP_TYPE			0x03
>> +#define AD5529R_REG_PRODUCT_ID_L		0x04
>> +#define AD5529R_REG_PRODUCT_ID_H		0x05
>> +#define AD5529R_REG_CHIP_GRADE			0x06
>> +#define AD5529R_REG_SCRATCH_PAD			0x0A
>> +#define AD5529R_REG_SPI_REVISION		0x0B
>> +#define AD5529R_REG_VENDOR_L			0x0C
>> +#define AD5529R_REG_VENDOR_H			0x0D
>> +#define AD5529R_REG_STREAM_MODE			0x0E
>> +#define AD5529R_REG_TRANSFER_CONFIG		0x0F
>> +#define AD5529R_REG_INTERFACE_CONFIG_C		0x10
>> +#define AD5529R_REG_INTERFACE_STATUS_A		0x11
>> +
>> +/* Configuration registers */
>> +#define AD5529R_REG_MULTI_DAC_CH_SEL		(0x14 + 1)
> Feels like this would all be simpler if you used autoincrement rather than
> default value of autdecrement.  What breaks if you do that?
> Superficially feels like all the +1 would go away - though with need
> for a byte swap?  Might be worth that pain for the simpler code.
> Should just be a regmap_config parameter.

Switching to auto increment is feasible. I'll switch to auto increment and
eliminate all the +1 offsets.

>> +
>> +static const struct regmap_range ad5529r_8bit_readable_ranges[] = {
>> +	regmap_reg_range(AD5529R_REG_INTERFACE_CONFIG_A, AD5529R_REG_CHIP_GRADE),
>> +	regmap_reg_range(AD5529R_REG_SCRATCH_PAD, AD5529R_REG_VENDOR_H),
>> +	regmap_reg_range(AD5529R_REG_STREAM_MODE, AD5529R_REG_INTERFACE_STATUS_A),
>> +};
>> +
>> +static const struct regmap_range ad5529r_16bit_readable_ranges[] = {
> Tricky bit here is you are saying it's a 16 bit regmap but then providing
> address ranges including the ones we shouldn't use. We need to hide those
> intermediate addresses.  Various things might work depending on the addresses.
> Can we hide the bottom bit of each address then write it to appropriate value
> under the hood. That is divide addresses by 2?

I'll address this by using reg_stride = 2 in the 16-bit regmap configuration,
which automatically handles the address spacing and eliminates the need for manual
address range exclusion.

>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
>> +		ret = regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
>> +		if (ret)
>> +			return ret;
>> +
>> +		*val = reg_val_h;
>> +
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		/*
>> +		 * Using default 0-5V range: VOUTn = A × D/2^N + B
>> +		 * where A = 5V, B = 0V, D = digital code, N = resolution
>> +		 * Scale = 5000mV / 2^resolution
> See the comment on the dt-binding. I think we need support for
> dt described output ranges from the start. This is a rare multi range
> device where we could set a safe default but to me it makes little sense
> and the driver will be doing something unexpected if a newer DT is
> provided with a different range.

I will add devicetree properties for per channel output range configuration.

>> +
>> +static int ad5529r_probe(struct spi_device *spi)
>> +{
>> +	struct device *dev = &spi->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct ad5529r_state *st;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	st = iio_priv(indio_dev);
>> +
>> +	st->spi = spi;
>> +
>> +	ret = devm_regulator_bulk_get_enable(dev, AD5529R_NUM_SUPPLIES,
>> +					     ad5529r_supply_names);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get and enable regulators\n");
>> +
>> +	st->regmap_8bit = devm_regmap_init_spi(spi, &ad5529r_regmap_8bit_config);
>> +	if (IS_ERR(st->regmap_8bit))
>> +		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
>> +				     "Failed to initialize 8-bit regmap\n");
>> +
>> +	st->regmap_16bit = devm_regmap_init_spi(spi, &ad5529r_regmap_16bit_config);
>> +	if (IS_ERR(st->regmap_16bit))
>> +		return dev_err_probe(dev, PTR_ERR(st->regmap_16bit),
>> +				     "Failed to initialize 16-bit regmap\n");
>> +
>> +	ret = ad5529r_reset(st);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to reset device\n");
>> +
>> +	ret = ad5529r_detect_device(st);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to detect device variant\n");
> No to this. It breaks the use of fallback device tree compatibles.  As such we
> never fail on an ID missmatch. Instead we just believe firmware when it says
> whatever is there is compatible with this device. See below on why I think
> we need to break this into separate compatibles.

I'll create separate compatibles and remove the device ID detection logic.

Best Regards,
Janani Sunil

