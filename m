Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140646AF1B
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189612; cv=none; b=gfl18CTqUfmtkluuRo8WEfdpFsFbd9LVdGpM0/jFAY+1qpKV/ferJWuuszMG1BQuSnp7+tkm/qHFdcQ0kkh9S95Us4kcd8urGqkaAhmm7IgznhphD4hK020//Qp3Fo34ViYTgo9vvTChWIZc1KI7PdU65IMoUyrUm2Ibo15iIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189612; c=relaxed/simple;
	bh=aKL2AnuUWy6NivLQVu0g6qzxjQP5ZgZ8oxvyWfYnvWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBPiUJZUXFW/qZ8KQtRulnDpxEm+l34J/rdMoWmZ/eI7tp6vDDwpVY3QkDvKGe5VRSCARX8RWzds6PZr0jUD3QrlnpNUtBU0nuVg4n1MMcVoFkFnQzSfYKNRFmLK2Uxc9cyf049JvjGf9+6ltpoi2fDjnI94+bM5tFzu2BIQTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrtTvPIv; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrtTvPIv"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5301a453186so6647531cf.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189610; x=1788794410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jvlu4I6x6DgkdrqSjLTVRzmVnrzpHDN9Z4Ca053R9hk=;
        b=HrtTvPIv6fUHWJA7yVYTxl+Hn9wtp4i1LdgHm9nfvs6C3wY2z8LKNk988nbxyBqh4e
         8mGisPivi22JOC82ZlnxL0Yfn76RoipDrAz1EbyISiVHppRQvUS39oGRag7HgjkvVRvL
         q5OWmT4iSajCaGKGNmqqDO9ROfmVdInvT4gS4PiAAbOtQziSGK0E7M4ZstKl9slc570+
         vjzNRfWKwgKKx3Ki8LJws78GGROdrbBcjEXTldEix8cWPgfa942+JCTk8OfAexC41eUh
         tB2L2fNSK8x9ClrsPEl4GpS/Qm+NdZgJQBc4xJfZxTJ5U43WOig4haqcToR3jOsOb20y
         bQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189610; x=1788794410;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvlu4I6x6DgkdrqSjLTVRzmVnrzpHDN9Z4Ca053R9hk=;
        b=oWmqfO3u7M0096GJB9YrZ4otPDfiP1eF8HdlL9f8O7h61N3+5Rt+W9MxKpCTSORDP+
         jmQUAk3eqMOBUiIGtkPoRcmP+Ltv+lFD7jY3fm6+6CpLIY+b4DL7XYzykTPEq4dzjM0+
         sOPM/ePy7par61T+CR4a/x/iDKZqttqLrrRLktiTNZf3dV/ueu/U8jBklr0+aM38x7+0
         7bBzppk46KB5C77dk8A7akcLxUrtlJYYOCq174Heg6iOD42IJ6vFO/zpyCLFEydOHtp8
         yurUYtVA8GGTleSt7wSLOxTUM1NKfqxGpWlFXNUBJiEWB4E2Al8HGCAKcCay3W+Xbu7V
         N2Lg==
X-Forwarded-Encrypted: i=1; AHgh+Rqse59ELO87T3zPgFJ2qaENrbnP5b4V5Ps0IKmuR7SQ9Kyh+2KD/bDDwoH18vidDDDzmYZ90jcvPk0=@vger.kernel.org
X-Gm-Message-State: AFuF++nmExyE0OrS46AgSlYUu7wv1q+3cN3U6K9+MxL7cV1zI0miIQUx
	EHFVfA6t9JkmfMyWA5sZjEHscBxq0TAZVOigHiMg410d3Ghn2w/ysGmR
X-Gm-Gg: AR+sD13+cFnCikZLINL+nay6gbZIFC1qlL8izX3x/+7XYoAzEE7WhWE2XhLjtLknaAc
	N6XMHo2BgRdscfs7vfVlQic8udc7Vv7BA3yV4xN3MbjunEcqAGuEWGUX1/xkS5+qEDjCIQ1aCj4
	D4UGIhKzXbWc6+gxB/O+wgs2L+fQxSqAGe1/JM9hxu5YQE9mXnVgFYf0UlFzcoMVLw6moTJoc9T
	ZINzfvw+eedfgMgy5846WbjsFvzIOTBvG0TSZoDFylE2a3Afpe+DaiFEeLqPmz94pNEN399MfJZ
	EOmumnYrZjiOmaiZ+KVJ5u7ukyWJVbXKXe7jmI5gRYS5+wXHtV5ZGT6qEGy86/3Mk7BWcklCX+w
	lNHMiCnIHkb0pNHvSaI/JUckt2DbD3jSZnhWcC1irb9qj1uVMuZwaryoCkBJsSxycvXE2MRK9aO
	PbmQ7s3tWcNB/tiREqv5xbLRRKSOv70FfNri9aXKbVUYWDiOMwSzaw6WMSGTxl+o7stT3JKDSEd
	YaGqaIABL4yxloe35cZQznN6KIiDlZiHmouZZDihGiZiA2hDP46FuMzPCkGQ7EVEuTKqy9Mnh9U
X-Received: by 2002:a05:622a:4818:b0:52f:9f8d:915 with SMTP id d75a77b69052e-53021c760d5mr22862211cf.26.1788189609876;
        Mon, 31 Aug 2026 08:20:09 -0700 (PDT)
Received: from [172.24.138.145] (ipservice-092-208-247-184.092.208.pools.vodafone-ip.de. [92.208.247.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe850864sm73241871cf.26.2026.08.31.08.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 08:20:09 -0700 (PDT)
Message-ID: <b2f430a4-a43c-409f-9bdf-ffb0f70b1538@gmail.com>
Date: Mon, 31 Aug 2026 17:20:04 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/20] iio: adc: Add AD7768 and AD7768-4 core support
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-5-e33ca6f841a2@analog.com>
 <apVDm1O_NtD07-rw@ashevche-desk.local>
Content-Language: en-US
From: Janani Sunil <jananisunil.dev@gmail.com>
In-Reply-To: <apVDm1O_NtD07-rw@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/31/26 11:04, Andy Shevchenko wrote:
> On Fri, Aug 28, 2026 at 05:30:28PM +0200, Janani Sunil wrote:
>> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
>> Configure supplies, clock and reset, use a custom regmap bus for the SPI
>> protocol, and parse the enabled channels and input buffer settings from
>> devicetree.
>>
>> Connect the converter to an IIO backend for buffered capture with CRC,
>> provide a fixed safe wideband sampling configuration and add runtime
>> power management.
> ...
>
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
> +				 AD7768_CH_MODE_FILTER_TYPE_MSK |
> +				 AD7768_CH_MODE_DEC_RATE_MSK,
> +				 mode_config);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
> +	if (ret)
> +		return ret;
> +
> +	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
> Does 8 represent BITS_PER_BYTE? Can BITS_TO_BYTES() be used?

8 is not BITS_PER_BYTE.
With fast mode (fMOD = MCLK / 4) and ×64 decimation, this gives: MCLK / DCLK = (4 × 64 / 32) × data lines / channels
Therefore, the factor is 8. I will add a comment explaining this.

Best Regards,
Jan

