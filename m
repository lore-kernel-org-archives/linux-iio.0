Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634D3290A5
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264028; cv=none; b=MkZVoQw9o7gUeHOeB79uFqQTYMJTuL4FGBPq/VBLKMlwMw+zlHnshYGwM+3ppgFwWWB6kIkiTsTt2zWtlx/olpBzHmkkPr7KD7M0eYKRqXw7RV29Q+tlZfUmH/bHt5Ji9KJZo4qMrUydM5wM8/eCIwWzy1YtUFtoGTWWeh+gwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264028; c=relaxed/simple;
	bh=F5FT9OwhnJ6YSXO2v4rbSgahxv2Ps6idkBRw2W44LTg=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version:
	 References:In-Reply-To; b=U1QEokB8b93aJ40LO88XcN2IT+CQSNTNvjDMj8UL8w8MijrJpTWYKz6WbdKDEyUVabkEmBngX3eq3JdvC9vhC3YL1wmzAtyQHbZhWjPsy3ii/Du/8oc83+JpzdSRtGK00A171wvjnLXj4SC6xiXx5x2Ze+FCsNuFPdDFeEKkacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myNRbsXo; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myNRbsXo"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-977cf5cae50so112996241.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 01:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786264024; x=1786868824; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SDlibkiHCsiPlgn9bXT0ZRW/tQXXQ2ApH6C6TY57GQc=;
        b=myNRbsXoOo3JnAHDqTYhIQpOp4VVohRSt07qercWR+A0HdfZEGaMLnA+mUn5BpxHk5
         icEJaj2ya7Fh8aZntdr8vJm1InI+bhJNm6OSb8y6OPqD9rmmLuZHsCaENFrjrEQ8oJaN
         89PyjdCQxwI+rEEH2vdwswbgep4Q0Y//CvtTj6e1cU84x7jpDzyQsz0mDRo1UnEin4wV
         eGrdFPe1EiPNWkXeS2OCmkggMsZGuh/SakEdWZID36Zfsqo7bU680qq5EZrxDLVnFg+E
         nVYG3QHX6FY2qj7NPy9CyhvkzGJGjyc1QWAQvd8gsVzB8XDPc04zjF/UakVcN3ewv2xp
         582w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786264024; x=1786868824;
        h=in-reply-to:references:content-transfer-encoding:mime-version
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDlibkiHCsiPlgn9bXT0ZRW/tQXXQ2ApH6C6TY57GQc=;
        b=gapDAUsTUYk7geiedTMaeg3Moq+EJv2nPwgECrZVco/YLpmCGWdQwoW96eNXnXdWh0
         Y8u1taX16JSjI9uKillRqOSzp+wpx67IA4Hcp53CO0AOQlyg7Q6tepGBStZ6GZkcPCmD
         zFbtLdPhpY8OqAvqhYip+rvb/uJ+lY/idRqKw+3powjvwEYxrC0w2ODtyn4C9Pbf6ROB
         d+4igy5efluNE+Z8XvGr7uWWQPV6fz8CqC4YWEMz4GTuo8natCDGv+q7S0APRWnpfMfR
         O2HVEkg49hZlu+yd/LNgTmuhWzmNwrwC+QYeELhpBqVIldNJ8rxm4XjSJJw71c670L/S
         ZafA==
X-Forwarded-Encrypted: i=1; AHgh+RoK58WA6ZJcLriYbpPSo7D3pWxb3yUHv9rY1qv4EWu/8AsmQy7BQ85CdBxFGGdh+ArFxtwcRcwbOK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwcq3gGVfyL9vk6XuQubWHuj0F3zdV3gv0I6gKx9MRPSqluasG
	XeMKonJkl+KFVOQrRLVhGCxX5I4GcUOjMn3J5UIqd+M9uyLL0pie0TN4
X-Gm-Gg: AR+sD10y4NsImSj15JJAfHYd43BjJnNWjIl7p5y4pp3vmVMxDn4mIrqvJUAULLQEJV2
	jCOsci73BfJliykaqhaUq11YwmzuNS+LaMXu2X1QPQGpZ391CZ38H+JXZufZN7mokLxY6uZDsw3
	d+/8y4RciMv030tmZ1umXhaN8gEwrP0bFqneuMFMHJvV5X+OhXQarqsdEomv1/Ri1QCE843IcKH
	vIvuXyD8uTqSjeTlMGaOXUbxh+8rzFIjYTHq5uZ61bTTg0Ahr1F4RqJqLbTL8C395E5Fbf5pTVM
	wfEuzXUxt7HesA6pVbroudSmzyzUxhJsd96sH2SykbkbjywER7NGPm5kWV23usPFbeOhwSaHqo1
	6r6vKjcRn7z/hH9o5IG8Gu7lriydVP7ZLzlJstUFiZVAbCytu1UFwuQod7PEFcYzcLFtGMzSYk7
	6qCckI/RUACSG+br0E3nXKq1iaIueBNwf5lbzp6cRj/f6rGp1jrfE=
X-Received: by 2002:a05:6102:c10:b0:75f:e517:ec96 with SMTP id ada2fe7eead31-760e3194fc4mr8187153137.0.1786264024434;
        Sun, 09 Aug 2026 01:27:04 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b1db997sm2752812e0c.13.2026.08.09.01.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 01:27:04 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 03:26:57 -0500
Message-Id: <DKK9QWYHOBOT.2VD8XMZTE65H4@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-2-f89925d72792@gmail.com>
 <ad95afb4-e667-4290-8878-fdd7067f20fe@baylibre.com>
In-Reply-To: <ad95afb4-e667-4290-8878-fdd7067f20fe@baylibre.com>

On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
> On 8/7/26 10:58 PM, Kurt Borja wrote:
>> Add the ti-ads1262 driver with initial support for the primary ADC
>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
>> and interoperability considerations were taken into account.
>
> Should probably mention here that IIO_CHAN_INFO_SCALE is intentionally
> left out here. (Or just implement it using internal reference voltage
> to start with.)

I'll mention the scale is left out.

>
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---

[...]

>> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c

[...]

>> +static int ads1262_dev_reset(struct ads1262 *st)
>> +{
>> +	int ret;
>> +
>> +	if (st->reset_gpiod) {
>> +		ret =3D gpiod_set_value_cansleep(st->reset_gpiod, 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/*
>> +		 * The RESET pulse timing requirement is 4 clock cycles, at the
>> +		 * minimum clock rate this is 4 microseconds.
>> +		 */
>> +		fsleep(4);
>
> How long do we have to hold reset before the chip powers down?

For power down 65536 clk cycles. Less than that is simple reset.

[...]

>> +static int ads1262_wait_for_conversion(struct ads1262 *st)
>> +{
>> +	u64 max_lat_ms;
>> +	long ret;
>> +
>> +	/*
>> +	 * The first conversion latency is affected by the channel's data rate=
,
>> +	 * filter, the configurable conversion delay and whether chop mode
>> +	 * and/or IDAC rotation mode are enabled.
>> +	 *
>> +	 * The worst possible latency is calculated by taking the lowest data
>> +	 * rate (2.5 SPS) and the sinc4 filter. This gives a latency of 1600 m=
s
>> +	 * (Table 9-13). Then we scale it by the actual clock rate and multipl=
y
>> +	 * by 4 to account for chop and IDAC rotation modes (Equation 20).
>> +	 */
>> +	max_lat_ms =3D 4 * div_u64(mul_u32_u32(1600, 7372800), st->clk_rate);
>
> These are constant values, so don't need mul_u32_u32(). Also, given the w=
ide
> range of possible sampling rates, I would include the current sampling ra=
te
> in the calculation. No need to wate 1.6 seconds for something that should
> take a few 10s of microseconds.

Can we leave it like this until I implement the settlingtime? That way I
can calculate the actual first conversion latency.

[...]

>> +static int ads1262_debugfs_reg_access(struct iio_dev *indio_dev, unsign=
ed int reg,
>> +				      unsigned int writeval, unsigned int *readval)
>> +{
>> +	struct ads1262 *st =3D iio_priv(indio_dev);
>> +
>> +	guard(mutex)(&st->xfer_lock);
>> +
>> +	if (readval)
>> +		return regmap_read_bypassed(st->regmap, reg, readval);
>
> Don't trust the cache? :-)

I don't trust myself :-) This was relevant early in development, I'll go
with the normal version.

[...]

>> +static int ads1262_parse_channels(struct iio_dev *indio_dev)
>> +{
>> +	struct ads1262 *st =3D iio_priv(indio_dev);
>> +	struct device *dev =3D &st->spi->dev;
>> +	struct iio_chan_spec *specs;
>> +	unsigned long used_regs =3D 0;
>> +	int num_specs;
>> +	u32 reg;
>> +	int ret;
>> +
>> +	st->num_channels =3D device_get_named_child_node_count(dev, "channel")=
;
>> +	if (!st->num_channels)
>> +		return dev_err_probe(dev, -ENXIO, "no 'channel' nodes configured\n");
>> +	if (st->num_channels > ADS1262_MAX_CHANNEL_COUNT)
>> +		return dev_err_probe(dev, -EINVAL, "too many channels\n");
>> +
>> +	/* Account for the timestamp channel */
>> +	num_specs =3D st->num_channels + 1;
>> +	specs =3D devm_kcalloc(dev, num_specs, sizeof(*specs), GFP_KERNEL);
>> +	if (!specs)
>> +		return -ENOMEM;
>> +
>> +	device_for_each_named_child_node_scoped(dev, node, "channel") {
>> +		ret =3D fwnode_property_read_u32(node, "reg", &reg);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "%s: failed to read channel reg\n",
>> +					     fwnode_get_name(node));
>> +		if (reg >=3D st->num_channels)
>> +			return dev_err_probe(dev, -EINVAL, "%s: reg out of range\n",
>> +					     fwnode_get_name(node));
>> +
>> +		static_assert(ADS1262_MAX_CHANNEL_COUNT < BITS_PER_LONG);
>> +		if (__test_and_set_bit(reg, &used_regs))
>> +			return dev_err_probe(dev, -EINVAL, "%s: duplicated channel reg\n",
>> +					     fwnode_get_name(node));
>> +
>> +		specs[reg].scan_index =3D reg;
>> +		specs[reg].scan_type =3D (struct iio_scan_type) {
>> +			.format =3D IIO_SCAN_FORMAT_SIGNED_INT,
>> +			.realbits =3D ADS1262_ADC1_RESOLUTION,
>> +			.storagebits =3D 32,
>> +			.endianness =3D IIO_BE,
>> +		};
>> +
>> +		ret =3D ads1262_parse_channel_node(st, &specs[reg], node);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (specs[reg].channel =3D=3D ADS1262_INPMUX_TEMP)
>> +			specs[reg].type =3D IIO_TEMP;
>> +		else
>> +			specs[reg].type =3D IIO_VOLTAGE;
>> +
>> +		if (specs[reg].channel !=3D ADS1262_INPMUX_TEMP)
>> +			specs[reg].indexed =3D true;
>> +
>> +		specs[reg].info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
>> +	}
>
> If we are going to use reg to determine the scan index, we need to
> make sure there are no holes in specs that didn't get filled in.
>
> device_for_each_named_child_node_scoped() will skip `status =3D "disabled=
"`
> channels, so this could be a possibility.

Ah, I didn't know some channels could be skipped. I'll check for holes.

[...]

--=20
Thanks,
 ~ Kurt
