Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B03B5857
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676296; cv=none; b=ooj4J/BnLmQTiKX3jrq0E0Y/mYhsk2M46//E0noV0LHg2swutR6ApX0UWLud5pgkfFO5ykwQ53HMLxB8yuxyMUFfGhmw2GQ/Z3m9C5wsWLU6D3co45LBHRmMLsrAIpkJmJNVMEpNa/uimJEFULNX3jSbuHJo8i4uzIZCDIs3B+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676296; c=relaxed/simple;
	bh=WmA/mQ/FtUJiMLUjvX4M1ZltuhP28hpRwCRYbc+ykds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lh8yxCvDYh8eUxCzdRm4udtOXxKrjtss5dkwnC7ipK+15Bzr9uR0143hX28duh9+qm3qnVNdczPGxHyJiOrFZeZWvv51ZEIPwGSVyEupNe0uQl2TWddtRVl+S9UGlFPBcWXAkJ1TCBtrYZTYA0Kr+6lkrB1WaSMRd+Z5dlhOf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DsgGvvyP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DsgGvvyP"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d750eeaec3so1642313a34.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773676290; x=1774281090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wrf1e/4chWRk/7lC1qMCkY49QaRNAQGjpYanWNmT+Gk=;
        b=DsgGvvyP0BPT7s5GssDXAFdQW1cm0KNby50MIvMCdKos2Gi0CeosXJfOmkJjbcil+d
         BmYU0V2BVHRzubOzfARESvbziCDmBSlR8Iz2K1965iOgIb3fQYbb3KSDwsV+z2cmmx9j
         s6/FpEGOj2mjOVzUb/01+p+RRZYGZGUI52Y4mBKrBmilBPguosVN2d5XCFxyE7JFI2Qw
         K7396MkB9XBEsM1Sh9vgdXuZgThBh+QTSydul1cKWiR98FQdvHOM0My4szs/jds4yUcA
         R8K3wWlFgTEC/3yXmjyLKdVH63G/j+0JtyJHvY0TfTo8nYbCV8lZ6ggeHRGlMXzyH7yd
         M6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773676290; x=1774281090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrf1e/4chWRk/7lC1qMCkY49QaRNAQGjpYanWNmT+Gk=;
        b=W3hquCJ3nqGq60PZtKkjUYOOi9PEU5W+dFa0PJv+g9fza4SJWJBb6I+0BZioGyuohj
         y5l8eZkpRxwIdGDa06nql1+Jixk94AMSfD5gYfu55a9VOTrh+ulLWFQrJT+ynQBSPTHy
         JZjmnUzBZJxU0SzgFxov1/Zqtp3EosUotAeD/WTeZTRJFbumpEGx+n0tKnBo/F8Tj+kR
         aoKrvbbQ3b/xiAS8vastOvyuOKNP3EjJA35KxyOBLKhxpbeI41XVEAHNmtZcDtCl2gHi
         /AdWLfdxhrZG8/gm1n4X+HFhvLdE/AezolZq2Dy66Zpz/yW5wKJy5QQNCwfV9Pjr0FG0
         R/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVSpgV/WV4QETqQl3+RmJsYexcIkGVNTlPRyRCYF5dqptf9/q1Yrdwdd+uxg2GIe6cSXcOUFvFL4jI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3vMZhrLopnx2SCNKC/aJh3jNlxctXC6EWV7HpTZN0vr4hafq
	ENG0gM14hPN593qle4JWu3snLPmUVUfArrUCmVdXQYTJtSA1bBRw7PYLyDNgE5JvIbc=
X-Gm-Gg: ATEYQzyvhWYn2dbnNINozE5ydpOG6XCMaS0iqguJYq+tEEeUz7sWRCQ2rqpGzqkvDv8
	IixdjVtDkUXmgrPc0GEHFqJEAl91m9jYJyOVBQgkxoT+FzU1oBLnAabQRiQEGmjlPra55lVI0xW
	+CwQI8H1Mp8u2a7mZb3kNI3t4SGC+k3VPMnEUEFyd1nOsvHn9OHLJp84CJ/i9+8i0muDGa4TLSD
	5LZSK4/ngas4piZ5Vd3vCtLd4fMyya6sNLR8ehDEf+aOl+HdvFTNo32myTx3iyx45/VXJ+c5IMn
	GTN7buKpgbLN7MeLEBfo9/H/jk76RmHU/UaISjTAXHBj2MK4PNqvakEvKH69gfxZ39IFWEvJNE7
	wDzx3p/rhw1wW1Qa/wtSHaichBdcBhDKgwdZfGhs5LGP2ZsoD6sP89Hpg92XIQVAHytKRNvBotp
	KZPee20V5B4G0aUgV4ODK+jYM/shGp3S5cwmF36RuXT7chzwOcu200RISIfIs7hWiL3Trg53ql0
	w==
X-Received: by 2002:a05:6830:67ca:b0:7d7:b85f:36c6 with SMTP id 46e09a7af769-7d7b85f3daamr721606a34.28.1773676289823;
        Mon, 16 Mar 2026 08:51:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aeccd73sm12749664a34.27.2026.03.16.08.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:51:29 -0700 (PDT)
Message-ID: <e33b0096-c7b6-45e5-a9d1-8da11714ac8e@baylibre.com>
Date: Mon, 16 Mar 2026 10:51:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
 <abPtv0Y_QWYoMuAO@ashevche-desk.local>
 <LV9PR03MB84148A9A0A7F6544CF370B7DF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84148A9A0A7F6544CF370B7DF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 10:29 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Sent: Friday, March 13, 2026 12:58 PM
>> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>
>>
>>> +	u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };
>>
>> This looks quite wrong. Is it for sure like two 32-bit stances per each mask
>> byte? If not, this should be __le16 acc_mask = cpu_to_le16(~BIT(...));
>>
> 
> Hi Andy,
> 
> Each acc_mask has its own register, therefore the u32 acc_mask[2] is
> intentional - since the regmap is configured with val_bits=32 - the 4-byte
> stride matches what regmap reads. However, I understand how this
> can be confusing for anyone reading the code, therefore I propose
> two ways for this :
> 
> 1. Keep regmap_bulk_write and add a comment above acc_mask explaining
> why u32 is used, although these register values are 8 bits.
> 2. Switch to regmap_multi_reg_write, which takes explicit (reg, value) pairs
> and sidesteps the ambiguity entirely.
> 
> Do you have a preference?

Since we already have a custom read/write functions to handle different
register sizes and the chip can read more than one consecutive register
at once, can we just call this a single register and add a special case
to ad4691_reg_read/write() to handle it? Then we can just do a regular
regmap_read/write() functions to access it as a single 16-bit value.

