Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487596;
	b=t+pTtkebje08HqNRhItCesBRbow+JT0TUE42NU1bXlbi2SUlMu8H3gkspvzT1AQLy/Ae
	 NhieWs9ZFgSLx7x6d17Mo2I1AC80W90U7AAHRLl6RnPfCPS3nd4fDRWrNqJx1bC1yynvt
	 jRFpqvicl+as+rn7qfNRxW2o9QflfDfVwElpMhS3zGgG+/g/efHE/HCJBS9M5YETFf14U
	 tj4lndc6qk74TqzhJ1yymLKY7iNSd6gpCldbjqV0yTztTX2IVZLVme5weEfNBB1VcGXEw
	 KVIqRkxjA9dqZBbQRGipFbtvvZ0sZ8ZLpYWfxnmKHL0lEHpOQ0KfwQqtpiIVnPkNW7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UpTb3tb5vUpx1h4uzHZtWBKoFQfw93PEG9+vK9k2idU=;
	b=XDAcd3nrxc3CfuCSjsPppIWyVRx6CxCpXZxSuzQUeXZbMjDs43xoZhmKbbFGN4qBp1SJ
	 cD/jDOvPIhXecctnWd3b2K77WDbeE97tu5p/MqknTNDhBLtq+/vFX4hhguALbRNdxSs2n
	 HW5WvHBGwOedT5uiWRanbv5KEnAJEsv6pYDGjJi9r2fm4tAf7wgf6VL+9c1ty5GxfX7m9
	 cbLRlY/goNZmOTdgbbUBNTmCV8bvDFv9oXzTsQhfSouscC7mpIrERnzq/iJ5yVLTCi9lA
	 7ctoTcmghzoBNi4EvNbLwKouDovP3VWS2+36drVxc+bIJLfOw51dDsl4NYIm7ylLVFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O11GHG1I;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15446606A319
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 09:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15446606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O11GHG1I
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso23829145e9.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792487594; x=1793092394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UpTb3tb5vUpx1h4uzHZtWBKoFQfw93PEG9+vK9k2idU=;
        b=O11GHG1IEoNCa4pX4ex4MmUK4rZxjHtzo5TMI/mfwjb7KXyfk6cqJjp+LlCJ2e1csR
         MC+IV4GYkmKZgxilyE01Zt38KELmkrBQFRHTehMT5ZmOS94ectqDTpIbNyMkFeED/jL4
         seRvNb8aTp//W4Hv1nfIElhL9+N3T9qDjNJRuR4qiB8B9w8eY0QOABMXjFnlQG8X4jRj
         71aa0g05Zca5KGXIElfJDR41EdHHNdfJIL01DZg9zdcwpHXXWcrNMKFF/H7mlAC4fC0h
         +P10xpQM9Jxj+wLPrw3soytXJt7zk8uRmUM5MjOHBWiP51YLfNKsUDrHZakEhHtKVnmi
         e9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792487594; x=1793092394;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UpTb3tb5vUpx1h4uzHZtWBKoFQfw93PEG9+vK9k2idU=;
        b=RDXUTQxb5j8++Tmd0wVzivgLzYptuQz6npTpfoJq2QmAmk/UocN2frtAPyN2rmiV8D
         AGhlBmSqTubTyeW2aYhNZStVygy3kjXN1kes9/4qvqM5JgiVKPlLJN5rNpYOPAyXHRh2
         9/hclT5O3piZsFb/LspMuygWKILINGl1ueTbwuISy/PmMuijtVkul/uyMGzqVWKZrvAG
         0P4rWwdo0vNZ7RnczN8uPAgmgUBJDJHgYg+Dj6vel9NhyuGGDsHJchtJ2ZBsdbByf8vq
         TdP5RQ3WH9FHpYogLK8FSGeaekNAhQQ++B72X6825pralGvASiMuA4HpdHeO1i9tukrz
         TBzg==
X-Forwarded-Encrypted: i=1; AKwUvBz4hZkWeP2GK51S5z4IHnVOensQUJn0iDmvvTBzWd9QcuUdG/+m9VyWBbJFbw/PYsBtMMfSVVUn514=@vger.kernel.org
X-Gm-Message-State: AFq9FYLomSwX58tEf5NUZX92fkn8Im6pz71zHjeiQPvpb2aJI2NBaUdN
	+RjXbABjwzTd7s+Kcq3sAm53zFX74JcgFAon0DrK3oFiNfzHWWpnepti
X-Gm-Gg: AYBFou15ER4/bllWdyzHPqdmfscCFA1K6hTuTq6gTsqlIf5QJDLQ/hKSDajSmaMyjkp
	ytZ4Mk9clU7JC1ddloz8aIanFX/8ovh/IimXZMaazN7zk3BfR+oslGM+7PcWFeIIcxU+Q5rd8As
	s+Gwin7ntjC/DJ/Xq4xzRUys85Z4ODgFq9ANkSdWgid+XVFSCprPiNMM0A/srOeu2axYQs30zsS
	C0By2xRMFR9JzOuJkfFx+UOzb+kxDRLkXNu+rksLZP1nqCDbBphYLZgzDjfyXcAYiE7M/f+NXHY
	G4UGugPyMLG4Hm9jULNuJbwWu1UDTI1w/kxukNCKvUruQRD6ebXhfPmtQZ3I93R2fw4dsLthO+0
	DkkY76ze9ybUQfDv96ejWijriHvY881GGVM71FrfQD6yfXiGZ7S9UJe2BG1hhBemVdp9aAoEshX
	F5KGnzAYTInnrNaDOTqsE75d7yozvNgSHL3DIT/PiE4Z+xQYRmH3Zyr1nBEK/ILXWZzSksmP/Ht
	fHlPNbPIsgOtNvVBtxf9ziOZduKRIaBkmI=
X-Received: by 2002:a05:600c:1392:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1d75aa87cmr237394785e9.2.1792487594144;
        Tue, 20 Oct 2026 02:13:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d699dasm61649665e9.12.2026.10.20.02.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:13:13 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:13:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261020101312.47d2eaf0@pumpkin>
In-Reply-To: <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
	<20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 16:07:13 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage, average power and accumulated average
> power and energy over an I2C/SMBUS serial interface.
> 
> The MAX34417 datasheet only specified on how to calculate the
> accumulated average power, but with the Sample Per Second rate
> we can easily get accumulated Energy in mJ.
> 
> By default the IIO driver only supports single-shot Voltage
> and Power sensing, but the accumulation can be enabled by
> enabling the Energy IIO channel which then enables the
> Continuous Accumulation Mode.
> 
> The counter is common to all channels, so when reading a single
> channel we will copy all accumulators to registers, so in order
> to permit reading individual channels we must accumulate the
> other channels in the driver when Continuous Accumulation Mode
> is enabled.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
...
> +#define MAX34417_POWER_READ_LENGTH	8
> +#define MAX34417_POWER_READ_OFFSET	1
...
> +static int max34417_read_acc_power(struct max34417_data *max34417, unsigned int address,
> +				   u64 *acc_power)
> +{
> +	u8 buf[MAX34417_POWER_READ_LENGTH];
> +	int rc;
> +
> +	rc = regmap_noinc_read(max34417->regmap, address, &buf, sizeof(buf));
> +	if (rc)
> +		return rc;
> +
> +	/* Ignore byte0 */
> +	*acc_power = get_unaligned_be56(&buf[MAX34417_POWER_READ_OFFSET]);
> +
> +	return 0;
> +}

I was thinking:
	struct { u64 pad:8; val:56 } buf;
then using bswap64(buf.val) >> 8 on LE.
But why not just:
	u64 buf;
and be64toh(buf) & (BITULL(56) - 1)

David
