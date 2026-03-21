Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA7264617
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115212; cv=none; b=bKM/C8rSTZ3zDEBpty4DIKIRJYR6zH4MvotFyPFNDUT58+cvAh44Cc7t7O4cz5yDp2Y1YxfaDmBSH/a6dBshIaU5UW/ouJhuuH88NL2EdfkCs5bkgbTRPqRqao8PHOO8fjd0ikl25XCqzDNTZ+FZltzUsS0ati9VbjDOOhw0MVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115212; c=relaxed/simple;
	bh=2pUYa2NyWRvR/cMfA3Cfi3/ny92RQqkncw8DaxVzLsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E4SFTTXqKxY7740Id4ZIGnP2bkLYEVVDL29D8KX0V8f8x9DyJHA3ifX995biQmIu/e6aXaIQyF7E/sEnxLrzfSuskGpJEp/EapFEzAXFWDLHd5aJ4aZEViCBfT/9YEY60HeK71q/PGfIT35q/SqSP5GOC4ZUhAu28lCCmw0Pldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RkQ9C1Ii; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RkQ9C1Ii"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4043b909ed4so1612020fac.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774115210; x=1774720010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DF6z+/2qlclo4K9Gg6bUxGA2s/l+QX2e40GqcNK4lpE=;
        b=RkQ9C1IiDZHbtQA5hfhuUrYG3mV80i7qNOy6i+SyGjGRIEF4UeNaydGRMznzkE51Jq
         t00mOMCviPSSmWOVkUW8QTgm4utV5sbUpZi7A3GxBDkB4IqxAww4tSpVcOIyCmxTSdwJ
         LdqMjuwMMR6LItMfUPVRoPMKWL0Asf7UL6giavYpQkjNyPiHAipjbbtt7+uQMC7oyniY
         x6JDQPFVBPI16oiYWLaeBJPaMt0HBRJ3MICDfcprSt/NU8PdOGS+u4mz0emXRxowq/15
         u/uaucOvIE51twlHwANugZUCdONUmUEAFTUE2K+5NHUsV1C0lIUCDM4Pauy1o53WsN2l
         23rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774115210; x=1774720010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DF6z+/2qlclo4K9Gg6bUxGA2s/l+QX2e40GqcNK4lpE=;
        b=DOfeTH3RweCFhpaDQ2ELPqcDidZjZ7FYG2t6IRxEEDMBqlv/SOwL0SWFv25vJTS6l0
         GRqSukC5zirZB2p2HonPNLpmVNzltLuIkx570YJhRxa8w3IRDgoejaEBesud0jeqP4ED
         +wt5N2CkVqpi/iw5bRgkcxkTtlhhvJhFhNfJ82feshGFyXNa9CwiUiJG+SV3ldr6MTL4
         ZFcgbS8kTa8roPvKASGn3Gjawo7AeWuf/aXwpNV5i2+1nf4MgwX1UdK8iaM3FAnLSBB9
         BKobRp84RVV5Vz73lIHCMkpwyFLOvPRyTLKwjI32RudJDh7P+rIfbRMje/yZQFNyXn+W
         TKrg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4IAOLhXwJyzcVM4k17yJiDFz9g47XbWFzQ1O6AUX6HrO/29ex/b+v0NNNjzRC6Lw6JkCy2+VPVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKD3mr1ChE29aSVZfkwsl9LDLwkRkZN+5MerKIAoBxm65L5UDd
	cYISMP6Q9fc6z2EEMpsC1WgBypG8Yitm2f77YO6zc9IgWG3YJVLcAQCXp1n0ZKDohZ4=
X-Gm-Gg: ATEYQzwwKs1LZLP1xQcvPoNVN7pCmjeylw+yv4XoMLR8xcxfY6Fy0FpSOPybowTR3rQ
	sID9oyngLKm+fMyyKL+lE8u2rIBmlB0Sg+j5Xeg3ooNq2GXCxmpLwFaNVFqTvoExOV0CzsHBAog
	/ZvI48s8TdNXA12UuNYeg5g2EsrUoVKdWEyUoz+gJihAWFOLT18bVsDTmJLO24Ia17stMY+6/7L
	t4BkMJtmvxUj3oZQZF1nhl0Ze7uI/aB7pYCpPbhp89YNGdnyAV1r17vk+an/LQaomKJSp7fGmva
	6N/FhtFq2Pss+WkgBTVFZr4VUE9S/ahSJW4Qeu0ZlFcfTGt+aH41+UgL3GNIeSRU0B1st8Jj2aZ
	0PiUW48FQ7HuYK/Z2d+PMR9ME3/tKNdahm/sKI4qiMo53xdmlCRWg2rxv4UKe1V8ZflYJqbdRD6
	NzpHuydXY1wGu2cvORSY5Qpvd/KlukB5ZQ0vtv2kmXOYDu/N2h0MNeRlN8KAJtuxic3JfPRudMg
	YZBQ5RTydbf
X-Received: by 2002:a05:6871:6c0f:b0:417:6041:7740 with SMTP id 586e51a60fabf-41c112c69ddmr4203245fac.49.1774115209875;
        Sat, 21 Mar 2026 10:46:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8e89:f58e:e4e6:5567? ([2600:8803:e7e4:500:8e89:f58e:e4e6:5567])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddbca8sm5700458fac.15.2026.03.21.10.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 10:46:48 -0700 (PDT)
Message-ID: <e1b3e1e5-6073-4ddc-a0f4-2834ce6c29f7@baylibre.com>
Date: Sat, 21 Mar 2026 12:46:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
To: Francesco Lavra <flavra@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260317150316.3878107-1-flavra@baylibre.com>
 <20260317150427.3878450-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260317150427.3878450-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 10:04 AM, Francesco Lavra wrote:
> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
> 
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_fusion_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding this
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
> 
> Tested on LSMDSV16X.
> 
We should mention that this depends on [1] to get the correct sizing
of the buffer in userspace.

[1]: https://lore.kernel.org/linux-iio/20260307-iio-fix-timestamp-alignment-v2-4-d1d48fbadbbf@baylibre.com/
