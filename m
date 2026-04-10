Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B034A3DF
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852942; cv=none; b=N+o0xS0BZvGl0RCWGl636GYdmjTGiSvqRdeVlReKtU+1TQOAUsVctXKQVLVdH3aaLzF3Dchbv35Ik2DZzNYF8fVcb3gO9OHcwpSeHk2eEZctuxEqIx94kqxv3aspEaD0jT8qYSaKuV/pJEDBUHYgeRJjaRFVp5nleZyckIfhOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852942; c=relaxed/simple;
	bh=1C5skhUYdqUKQTqp5FV0qQHP7HKENw1o8gP0chbQGC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyj9xwuRdAFJ4dJmr2b+REtchlWHFQkXee0IbBy0ps20j9DYY/Fr+m8l8PgPFoqGvbLJFrIw6T0ZdoWNbLCjXf7JCYUA7nujbg5S3hkwVfUiJ1YpgfPF5UGWuJ6sqaN3dTYXLSh3xe0AkkaXRvuI9gZYQ5vjm39ZWn6K7R5fD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=YZaTRr+6; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="YZaTRr+6"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-47018d34159so1971186b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775852939; x=1776457739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBuHUTwaoLlBXB91Jj16S3bt+D/n+yKHbdPkNktZ20o=;
        b=YZaTRr+6KJiEXEqgDicRFHY4lrncziGMkXjZI9kC5tqavdNfzoJWJvM5fSW1BqcNmZ
         K8WXtaud5ES32vtA6GlhdwWJMspvPrGsPWXm56lIJT0uthqdcAqgIk/vnAFOWHAN5Xxs
         D/6yRNzYiwaKzGy08ppep64hydAp1ztWpEUydxc5StrgTU/kK+cDhq1tK7A6WcpB4DcG
         1ZmoBtGTWUe4qGKVdVb8WfcPr+brhBm5HYT9VcN6Bnp3pF21rW2hOse9sfFv56gNPQq4
         FHwpwhvlmD7teZKGebHiriGEpNaCIDdpBzvBRHJ4ZyK27bSnh4n1AOilWlZzFCvhRKzD
         S/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775852939; x=1776457739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBuHUTwaoLlBXB91Jj16S3bt+D/n+yKHbdPkNktZ20o=;
        b=H298oqGztiAyr2JBvkbaVMTu71eNfNx9r6HQEUebT47BPOZ08xn0PmP8u1WQWAEbEz
         qxRrP/x9HMQwsSYKTxqBdHwNaouFwVXOLzEWIJQpZ8kOOmN8XhBMPX7OtpwACoUpKzu6
         UrtBCTB6CXQGiBJ29EszrsUSuFkk9cfoM6vCMPyKDgYrAK6cWDNASIp+KzqSSGR+/zdD
         m2nLsQ4PCg/FMG/P92CnpIywhmQwkq/G3aLpdDkxDyshI3cbtPmOSBNTnfKz2o5Rh0no
         N4tTwD9PJIOaBbzO3UzPcDVaGF1Mw/2ETKt7RzoIloszWybluu8eM69pdxcjm3OyUVRN
         xJQQ==
X-Gm-Message-State: AOJu0YxNtudQVSLPZgXTcxuG65ZUeFFf8aoYKV4P0CEoNQz9bHOAy1Ws
	w3z9Fqg//Ks4KMUF5iUmRg85Ce077O9hXmAv09Ye92BhDQFytfs7arSqubEXKEyVgPg=
X-Gm-Gg: AeBDieuRKbZm5MAEa2sbe/wvwVa87AZs/cJ9UppgqPG01MlPIaAx9+SLHojuRIZAKbZ
	zdKyugNctyV4Cgh1uunpnG31cFJrziDCcfNfJQi+s1qhasaOm8Z/G//byV67jDIjzqgwWe87vjQ
	2qj8bUV3ezQA3mNDWkPW3JcupGI/LAs4KVmZZecQ36DACAxEIMuKDIXvuiY8C/Ia4kSUxE7pwLq
	gc38/nFXrs5xc/CUekz1F8gHm5KwU193CGZQ0rBIGiy0omIr4uOcFh4j4SAp/Zog0WaeT3Ld+4g
	r2yywK5E9945ic5gKoZ/g23jEJa9h6hOihNZdv0tlXs+pHfxKmKhL85sWDZTRVV7u1zKKVEZs46
	F00Pq2eltiGFwMBB8wMUseOrUwQ6IiLRrBjH0h2WlKi6g6Ql0A5kqxNg47qGj5WhHleVQfoZucz
	jxyGv7i3wzA3t1SpGkZds0AbQZRWPJRnw8bPtKQ4gqAv4jpKO+1pdEWs2m8bswIpW36LOCmohUs
	Q==
X-Received: by 2002:a05:6808:c2bf:b0:466:f57b:2ae5 with SMTP id 5614622812f47-4789fa06325mr2772960b6e.47.1775852939137;
        Fri, 10 Apr 2026 13:28:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb26220sm3008303fac.9.2026.04.10.13.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 13:28:58 -0700 (PDT)
Message-ID: <cdfb9deb-2439-413b-8c20-3c6ad6a81ce3@baylibre.com>
Date: Fri, 10 Apr 2026 15:28:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
 <20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 1:48 AM, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 

...

> +static int ad5706r_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct ad5706r_state *st = context;
> +	unsigned int num_bytes, val;
> +	u16 reg;
> +
> +	if (count != 4)
> +		return -EINVAL;
> +
> +	reg = get_unaligned_be16(data);
> +	num_bytes = ad5706r_reg_len(reg);
> +
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.len = num_bytes + 2,
> +	};
> +
> +	val = get_unaligned_be32(data);
> +	put_unaligned_be32(val, &st->tx_buf[0]);

Can't we just do memcpy() instead of swapping the byte order twice?

> +
> +	/* For single byte, copy the data to the correct position */
> +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> +		st->tx_buf[2] = st->tx_buf[3];
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);

There isn't any special paramters in the xfer struct, so spi_write() should
work here and save a bit of code.

	return spi_write(st->spi, data, num_bytes);


> +}
> +
> +static int ad5706r_regmap_read(void *context, const void *reg_buf,
> +			       size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct ad5706r_state *st = context;
> +	unsigned int num_bytes;
> +	u16 reg, cmd, val;
> +	int ret;
> +
> +	if (reg_size != 2 || val_size != 2)
> +		return -EINVAL;
> +
> +	reg = get_unaligned_be16(reg_buf);
> +	num_bytes = ad5706r_reg_len(reg);
> +
> +	/* Full duplex, device responds immediately after command */
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +		.len = 2 + num_bytes,
> +	};
> +
> +	cmd = AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> +	put_unaligned_be16(cmd, &st->tx_buf[0]);
> +	put_unaligned_be16(0, &st->tx_buf[2]);

Do we actually need to write 0s while reading? 

Usually, we would just do a spi_write_then_read for something like
this.

> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +


> +	/* Extract value from response (skip 2-byte command echo) */
> +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> +		val = st->rx_buf[2];
> +	else if (num_bytes == AD5706R_DOUBLE_BYTE_LEN)
> +		val = get_unaligned_be16(&st->rx_buf[2]);
> +	else
> +		return -EINVAL;
> +
> +	put_unaligned_be16(val, val_buf);

Can't this all be simplified to memcpy(val_buf, &st->rx_buf[2], num_bytes); ?

Or the whole thing simplified to:

	return spi_write_then_read(st->spi, reg_buf, 2, val_buf, num_bytes);

> +
> +	return 0;
> +}
> +
