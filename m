Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032E2C11E7
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686852; cv=none; b=YbBed+71yVn5fsca9xWVoU0uhpEhfu42zStet8QNibXyZy/wiCZGTl4FPeU0doNPRpUJyODAyKepB9rv4GEl9KpMbXrN0TYiUdCFDVL44OXVDtVSydruCilCWk9ef1+8Ydga2tPNPd21khXpC41Q0QbGQxpRXi18+AbwzKBUnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686852; c=relaxed/simple;
	bh=UBPdsCxr/JCnW5FBHSIVkwAzSjCcMNbdBUUw+0OCw/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8fk2tjnljH5wcZwNmTSI69Fbi6FxtM7Mh7csGSA4Jcza/QSLW0L3f6rO9AeGtT+eaaF/G6AxUAZrCuVstO0Mi6lYMbPd9nIQw17M1Ylv8i9W0FjAQb+fo0x4NDQAmJ2MSwXIWEiZWqbGhETyCtDi+my8mCAYsEK3M+xaEB0Gow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ybo5+GmB; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ybo5+GmB"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6acbf97e9a1so1526121eaf.1
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785686849; x=1786291649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcLf3H2Vtv+WaWlh5trUkd6eQsIi/+7/uByN3DGgnMg=;
        b=Ybo5+GmBNggzFJ0pX2a01TvXwoqio7HzARUy/nduLzWPNjzab6tPusSctdaCuORwcO
         QLjya3SJMrz3F5pvHUpA0Db3CjGpW1vQneqOn3njJmS0qvSGVRgeyg6jeNsYyzmsxMHs
         TdQhvcx5AwvBurxoe9FawxOczX2COXsZvGFjmBr9gHoY/lLB49tecWno+K1DcKUtUUU3
         +YjhC6Fuwv7PA6E+148Y28LqDgzvZWIf81KsyUiQniYUCZIQWMJ62l4iV6hH49NnBQJ7
         7aLlTnHobg5PmTAI4xPZSEgRnr+OWDwnUnqfpiCkzg2aNfuMkCRAHpeotI+GyTcprvLN
         qThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785686849; x=1786291649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcLf3H2Vtv+WaWlh5trUkd6eQsIi/+7/uByN3DGgnMg=;
        b=qXOb1bME8TdrN/7XPbbgnuPuGV6orzJhBaz9ss4OUWUpYRl7Xyf26QY0T3ZsazWTpa
         MlUFxw/1EopckiE4HpnZ9iTkLvyoLQJoI0X4WsDQXH9LdXfNmVntnVkHVidMkEjvbNSR
         cDoPZE4yXKJfahLWQoQEMwQRwaeSM/WGUxMAMfBZBQUYa5AUV0EuBULTKaxBHQbCQWye
         SsqNRyTDzcXJXa4bjakLuRsrQQXR0Twtt/hxxjxwT3RHy74jUcDEqZSbQX+HBSXPkIPx
         Jk2VT0FSS0EPZ40gNwUWORxT7gDdRrNIM2HCdgl0eFoJjj3r8L/PLTrzbhtZQiIyVU26
         wkEA==
X-Gm-Message-State: AOJu0YxDs+ZDTGciqEbEamGOPJH4QxieNjizLAoqcMateI1wSb1/phJY
	NGXt+9Gw8MMkUptuLMlooRfsyR/925U8p/Gl2OXdA4HgUAbKcMDAG/kx48FgplgsOzU=
X-Gm-Gg: AR+sD10XQunxVhTjdSdA3E8ITI+CYRvh7hx9OT8166uu9ePTFWrW3miZzmY2drve0qn
	vDMlnOghTDGo4PaBUg1yHE0Oy3F7kJlqAAl7B9EUlR0HGNP3mh93aHRf11uE7Sw8iBth09h2RB3
	GhUJPX4KTx4mNMOXZa4yBsYw+12QBmtME8kcMo+Em0AOUUB5nWsx7iZ/ALi3QD8zb8ooYlOhtIs
	rn+ULkhnZFGq33Jx+f0+qrquHi8XbARbN3fRuMMEwuvCf51W9Ljobiwz+qNazn0KUx9pL/N8SuJ
	Ixjf/uwMrZVawwkjpQr/hg/i3el1HdnJk8z5j7MnlJtp1jy8TkAy4t1T6Zl/RiYegpFjrRE/OIA
	sVHXx4HSHCwya9BRs0rYm0oJW5xKV4tb51xcpErPSi6ZT8Wq3DM0gJ00fu3YCnjEDvPGwe+l8PM
	yiinhNHB4pGywJ+3fc1VF+9r/IPmbX1/motsco8uPZvAsMC57MlM/evld2DLrWRN1uIpiPmb220
	eFVWUZFrlCbagnGNYygpw+Ou7pXN0MjneAtCQw=
X-Received: by 2002:a05:6820:83c2:10b0:6aa:ddf8:f17f with SMTP id 006d021491bc7-6ae43514968mr8221908eaf.23.1785686849225;
        Sun, 02 Aug 2026 09:07:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae3a0c724fsm4851976eaf.9.2026.08.02.09.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 09:07:28 -0700 (PDT)
Message-ID: <1555adce-4cce-45c5-b3bc-1898d1bab46b@baylibre.com>
Date: Sun, 2 Aug 2026 11:07:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] iio: flow: add Sensirion SLF3S liquid flow sensor
 driver
To: Wadim Mueller <wafgo01@gmail.com>, jonathan.cameron@oss.qualcomm.com,
 krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, maxwell@maxwelld.cc
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com,
 455.rodrigo.alencar@gmail.com
References: <20260728214943.29820-1-wafgo01@gmail.com>
 <20260728214943.29820-5-wafgo01@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728214943.29820-5-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 4:49 PM, Wadim Mueller wrote:
> Add a driver for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  Currently supported variants are
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B; they share the same
> register map and differ only in flow-scale factor and calibrated
> measurement range.  The variant (and therefore the scale) is
> auto-detected from the product-information register at probe time;
> a sensor reporting an unknown sub-type falls back to the variant
> named in the device tree / I2C table, so a drop-in replacement part
> keeps working on a kernel that does not know its sub-type yet.
> 

...

> +static bool slf3s_crc_valid(const struct slf3s_data *sf, const u8 *block)
> +{
> +	return crc8(sf->crc_table, block, 2, SLF3S_CRC8_INIT) == block[2];
> +}
> +
> +/*
> + * Read the product-info block and pick the matching variant.  The
> + * sub-type byte returned by the sensor is the source of truth; a
> + * DT-supplied compatible only seeds an initial guess and is overridden
> + * on mismatch (with an informational message so misconfigured device
> + * trees are easy to spot).

In the past, Jonathan has always argued that the devicetree should be
trusted more than what the device self-reports. This seems a departure
from that. Why are we making an exception here?

We have to trust that the devicetree is correct for everything else
that can't self-detect anyway.

