Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1A1BD9C9
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312749; cv=none; b=niwpm2C/QbjOwM0TxUuvx+rTl3VYWhIj8WP/MvjBfnuzRVwAqyPBlaf1UqOmkaYOpUp2Mo8E172fmXNzrJZfp8uzZGjWn84xpMbTJJnfR0TJBaCxnRenKjOLUtLUJRczlZtEeEE0Yuf4Nz7V8qnSw9liIYP7P5Xlvu2vfDUeK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312749; c=relaxed/simple;
	bh=YDHQQIkUtIMA5RuVXX+SK+ZopnAIz0IH3aZAqaHI9pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WISKKB+4qqBstVLIOmliDS4gYKxO6iqWZd6AYUTLj5cPhvpBQU2JjGSlDLZYfFq9g96sRXrTm/CGxODu+CbhScOU0siXaqFVFot8jMMc56JTegihmnSb4LkJlfw3Mmmyuc4fFQKVuWyAi/dfcun9SVnv6l176ZlVfefefsVRm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=T+tHPtq/; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="T+tHPtq/"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-46fb6d65c28so338367b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775312745; x=1775917545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DG8ZLzSkLL5KxGbpBt+cYKmm52XpYZesZWRmcIu235A=;
        b=T+tHPtq/ZJmrz/x0hon6ubvef3dyaaHhk1GRRXgW8y8HepFtZGYjfJcUQczd3MEkSt
         2Agviun9Cf5EYKtk9j0IqUraHya5+cWg7jpTqs6odctBlL2Zz+DNQ/uNqQMe9wgH193o
         z3zeYYVklZaMQki3yiMddob47zunpO6AWKU8n5PWDQ6LxULv6X3f1wcyghb+It/+xjWX
         z9PNVkRx7eWxmjJNLwRnRuJlliHjZbQNuYTor2Ij+hbvfTGn47XIa2O2GDia9HEi0TFp
         QBOE28LuVqSi18lbs2VxGAN1lYamyOifHSPJ/JYonO7K4FYFJ/G3E8jlIr/y0xjtfZ+C
         UNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775312745; x=1775917545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DG8ZLzSkLL5KxGbpBt+cYKmm52XpYZesZWRmcIu235A=;
        b=Ryj0Oyd0QhMfZ6nQELmIFW3kfX+CQdBAAAOq+eAA+Y0Iq5Bf57KeQdxeN2UN+6sq63
         UIFMaFqyNH0yqm5D9w1xF7tNpZM2ZneXJTPihbU84iKml5JreC1bWWWYi5ilNTzKDaIr
         VylGUxqSZME+iAIBioSewxl5AkAVggK3xZyxifdtijeiscTKk55RpNb9d942gym1ICMo
         G6VgkT4zwTpPT86ejzHhGiD57aD6ebQjilmWRa49YEfd04zghcTqc7kySIUfMWaafz+b
         ACvGk4qtT06VlgUkgGVLyc6w/XlKT17g0AACJKdwXiYABfwHynTvPYq1TOMnlve3h+3/
         5jHA==
X-Gm-Message-State: AOJu0YyCQplJH4tPYZb7jj1Txbu/0kw+ne8nyk3xUCSyhvjBeAOhpGxl
	gszVpwLVp1Mm1iul2ysKdFQW7lDAcEDhgECN/WY5+N8bpKSfxq3S7Idoyy9UqZ2j3j4=
X-Gm-Gg: AeBDieuMl0cMw45F5BBq+nC0Appkmgx6xO6Dk2w+6JcrIwbDnPtwRgsu6IKyaK5Ugix
	KulGwFLtu5AIpEgwU/nEFD43XmpryXXDHGINl9KE9Xb13MnaJjbH2KdK/1d2ytsSkEhd8Ud/UZh
	PE4FuHuy7skxC4+oyYoL4OkzsNIn6R20cdz0Q5mSTaVSom87jvZmbU2b6XarXq9MCOmROk7ghEx
	K/6VeCHd1Wq4Q0WGDcP5M5yYSnjNyrqzwqRNA0y0aNFfTD2wTP3zpxZAtVocHPgU7ADth7bB5Pk
	JQib4f/vwKSJ8GIqzcBltmSigIhjfX2pK3J8cH+WNZCNj98juP0OEspyG1w0ISeixlgqa/RdqHB
	/nl7e4PzV8RJZAyvUTkNDcZ4tvVNZ3+Qiq4qt0E+Dwli1xUYiYd7u+jemcOVzJJjMjSVw+xKAcI
	LPeRO7zdj0gO5c0eZNqGJVN9wxdTCRPpHXPeaFmi53OR8MIH9fVlSgXsFoQRGW+LVmuVNxqnptm
	A==
X-Received: by 2002:a05:6808:1206:b0:46a:8dd5:3a4f with SMTP id 5614622812f47-46ef5002b8dmr3010289b6e.5.1775312744846;
        Sat, 04 Apr 2026 07:25:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f0f4e16a9sm2936944b6e.4.2026.04.04.07.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 07:25:43 -0700 (PDT)
Message-ID: <e4ddf44e-3189-4d4a-9184-13b0560195dd@baylibre.com>
Date: Sat, 4 Apr 2026 09:25:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-2-fa2a01a57c4e@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403-ad4692-multichannel-sar-adc-driver-v6-2-fa2a01a57c4e@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 6:03 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
> 
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
> 
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
This patch looks in good shape. Although I wouldn't mind using
MEGA/MICRO, etc. more in numbers with more than 3 or 4 zeros.

Reviewed-by: David Lechner <dlechner@baylibre.com>


