Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DA2116F4
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771792345; cv=none; b=sV/k4AlDWHdbZ+LBFvm8z/DxvzfYJhC54jQ3KM5joCs2PjFPTltEcLCjbjsOEccGdunGBisH7zqfje5N2XzZ6ElVLVDrbgTC8pL1hoNNO5OryxwDFsPzE8MCqhP4nftckgfusDTaxmFULrjZcdvhhpiYPknfaBfNmNGeAcyY+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771792345; c=relaxed/simple;
	bh=82WJPVfy9WAqeIaHBtFp/bXSsyZKrM1DrxWnoDfNung=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBPKm+GfLIZ8Mbf/1pj57z3EA8ZpCfVLwi87DkonaOQwBhNqhUPYJD+TH+T44dYn7/5o/C9jpqHscQcQoqRY/n54o8jy/L2DuD2oM3ZDXBcd3VcCwIMz15O0b0lojHrnzAqTDMsuGGMQ2jTZEq6KQU3/diUicNiaZD8+tdImSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RYCwUFaN; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RYCwUFaN"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-463a94f8475so2376004b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 12:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771792343; x=1772397143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3BHd39eqV4yTHa+i/17dJDjEQra8nLgeT8JYDZ2i+c=;
        b=RYCwUFaNgT5Beu+0+QeOscwAjKKtZEGlovxLev5eNbRjveLKieWJgw/NhwAdpNKW7f
         4HTtNS/LV2f4B5qSqK7fbEwIJ2psHfICoEGjIop0u+wv5jK6kw9CSok671lqQPAzvwfV
         /4fikoY6RcnlWybO9J1v7GX+pF7BSBEJa2TaaW+RINv7YhFJYMK1J5o94JFYUB4t2jBb
         BkF1X/Lc738Kpg5T/zN7OQojlRx6ftrxfPTZB9dltWH6a1M60c325aIDcez5RmJ9ynUU
         vdZixGbMhJ5UU0JwT2l/1Ia1jknGMEAfv3ZuWDRKbwGjiVKmZuNF/Sl7lj9f95rMV+l6
         yL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771792343; x=1772397143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3BHd39eqV4yTHa+i/17dJDjEQra8nLgeT8JYDZ2i+c=;
        b=c03NPj8oppddRh7ZvaS6uKVtTaorUdxtg0/6wFRPvlbyUq9Jq1ThMYQ+ypEpoAOe2l
         C3biIz5glv/NJonx0Nu0OD7jwsx/AQhElaQx0c6IKP9gu6k10UP0T786a02Ydm/msAEy
         yan2VWmgBGiWa/3cwuBGFiWxL10jqq5FF3hmnLe0W5zGAxtfny6xFeWty+nCNU8XMTR+
         rWS+nf+QNJDjIUK+po0c1mRIhMLOAqHWsbrRxbZOqlnK3fXge9a6uo6spOnGLmj9QNmJ
         k1D98ed6eKzM62xIZExQ5RP1xbqki3KtEIfp8xK9wdeQdpkgj4BjPsrRYetRiXhbbqSW
         2HVA==
X-Forwarded-Encrypted: i=1; AJvYcCX58azq+m5duoOCvlVWQ3UsgG8aJHSYOorCN4MZ+qR/DC+WQ/UcC9jwjQjGaIx4oAc1Lxmhno8BLTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87N8mn7Gu34HR6tLXNF2elUrfQdgK6M4srULzEGUDkhS2xb1x
	xmovR/BfTqBLvCQG120x5i/2k0H15V2onu+yVFPKdQZOHTfTWiuoc7iU3IJPrd/ZM08=
X-Gm-Gg: AZuq6aJ3jd+VaIzYZIt7qmENZVIWk5yyj8KxjaWOqW2azRsXieJ3Zl2Dd53PqL3403K
	K8sIDvcGl/mXCjD9QAktYwIjoYm0qjJd1OS2ck5u/dquucRayEVrZgTSnu7dDQuE6oMLeKmW12k
	EYyGTD6RSzEbFLQ2MfliqEF2iurPoAeBjGTPUOwSoYOwLt+CLfz88Pp11RkgqI33zYUbmEwsT3N
	yOrtPQ2z+5jrtbyd5mQvAdbULlaFx+gcmR7+OFevMnVXIQsaTyshOyJmUUlNBKvf/tqfmkDwwMR
	hLa5Rss3N5qUzcrLAYP/qY1jmTYCVCz9a9SbzQ07rjO4SSfu/sJ6tsPi8hwSBgc+sYTZzrXIpEb
	uWBVq7rg92fbMSwVSbEEKZiNMZTm2BoF+FygBaOqSSVR98a9b0G4gI+EDCQ20TDfyoPBD1NzP3+
	tIf+5VtXJvy0z1LHy8dtm1rvPjAVUcJ8eZBXBJceQ5sFueuC64JxDTdWzktAJOIow5vGnbR1NVt
	Q==
X-Received: by 2002:a05:6808:1187:b0:45e:f888:695e with SMTP id 5614622812f47-46447075503mr2871671b6e.11.1771792343189;
        Sun, 22 Feb 2026 12:32:23 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:810f:2680:3e30:5a87? ([2600:8803:e7e4:500:810f:2680:3e30:5a87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46449fd5432sm3758172b6e.4.2026.02.22.12.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 12:32:22 -0800 (PST)
Message-ID: <bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
Date: Sun, 22 Feb 2026 14:32:21 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
 <2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/26 4:01 AM, Rodrigo Alencar wrote:
> On 26/02/21 02:16PM, David Lechner wrote:
>> On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:
>>> This patch series adds support for the Analog Devices AD9910 DDS.
>>> This is an RFC so that we can agree/discuss on the design that follows:
>>>

...

>>> represents a distinct signal path into the DDS accumulator, so the driver
>>> models them as separate IIO output channels (all IIO_ALTVOLTAGE type).
>>
>> Generally IIO channels represent the physical input/output, not the
>> internal channels.
> 
> That is part of the reason for this RFC. Dividing those top-level modes
> into channels allows for better organization, as they can operate together,
> i.e., phase or scale can be provided by single-tone profile, while
> frequency is controlled by the digital ramp generator (see Mode Priority
> section in the datasheet). Also, it allows to explore the most of standard
> ABIs like, scale, frequency, phase, sampling_frequency and enable.
> Putting everything into a single channel would make things a lot messy
> to interface with.
> 
>> Ideally we would just have the one channel here with a mode selection
>> attribute. Documentation can tell us which modes use which attributes.
>>
>>> This per-channel separation allows userspace to configure each mode
>>> independently through its own set of sysfs attributes, and to
>>> enable/disable modes individually via IIO_CHAN_INFO_ENABLE, relying on
>>> the hardware's own mode selection architecture.
>>>

Looking at Table 5 in the datasheet really helped me understand this better.
I think this series could benefit from a documentation patch that explains
more about how the driver works with some diagrams.

So really what we have here are a bunch of digital data generators rather
than a bunch of altvotlage output channels. And the same data channels can be
mixed and match as the source for up to 3 different components of the output
(frequency, phase, amplitude) depending on the priority rules defined in
Table 5.

Digital data sources are really more like a buffer in IIO terms than a
channel. And before we added the IIO backend stuff, there wasn't really
any other digital data source/sink that I am aware of other than buffers
(but there are certainly a lot of odd corners of IIO that I haven't explored
yet, so maybe I missed some).

In a recent discussion, the idea of possibly needing a way to provide
some userspace interface to be able to tweak knobs of an IIO backend
was also brought up.

Putting those ideas together, I'm wondering if we need some new channel
type or even a whole new interface (e.g. a new sysfs directory like buffers
and events) for managing these digital data sources/sinks that are not an
IIO buffer.

I think we've seen enough of these already to know that things like a
"tone generator" and a "ramp generator" are going to be common and could
share some standard attributes. 


