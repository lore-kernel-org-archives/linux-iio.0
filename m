Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33393624D9
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328229; cv=none; b=QTWGK253s6ICYATYo3rWkwiTUySNo7lKguTwdn+WfmvzYVwOgGljmhOSJSUeisTN+SZbRuDj1FQ3F6FeNkNBHaCqijnCjeVgnpKhLApHF2iSp4TbZWjEWD/geQydwOQ+kw5BPlOzsDy6D6ylg6rw3sMYe75dNvao3gfwEbaI03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328229; c=relaxed/simple;
	bh=Vy2ZJZNGMyLbLm8dFlgEUCw1Cwow/lz5sQ+qvQJvgcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHKDymBtfnTTZIZWgUvNS+++2rrbEgNOukUo0B2fBcfv5RXvkglbMVqSUccxSLe9hVQNQPrNCPFA67T6gdCquQUR6DFGRwTsB0zbxWcUjr5YQjfekHMu/IH8v+dPxvoKtRtgFHLeUVtJ145UFmrb3tz8rMx9unHx1Dswcpok530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OJ7OmMj+; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OJ7OmMj+"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836c8bdac50so17605267b3.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787328226; x=1787933026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ckvBWrFSwcLwwa+ubcnnacuUkv4EVV++6zpuDA54lvA=;
        b=OJ7OmMj+EAbSu0oTl47nKYBVpapK9/AWe/U1/QD84QD2sWRiKCL+hm6dBPrdGSg7bX
         H+6W/i3bQuq9/om83syVlmGVDRiPTw1yX3SB4p65mPtayK1CILJ/KwRy0PTiItDoxgR1
         F7rr/IkXfr7sPYLC0kEgFcjWhpJL0W4eBL3Jq1fH1gsN4X/hy23BN9vBm+iBT034rEj9
         pR5iRY7ladre+ZWrvYxcv0c1QPSXVMC94A8rkmEU7tnsfKYGZiZBjHVVdsZCxXJ/mRpO
         +gPi2T4ILRU6RtFMvOV43uoESnBV/XHeGVNXcTN0rMvwdq4eiBt0x4Igj+ZZV7nMLrrl
         zwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328226; x=1787933026;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ckvBWrFSwcLwwa+ubcnnacuUkv4EVV++6zpuDA54lvA=;
        b=huX1u5Y6giN2bk0aFlCVneeDr39uCpehG+A3ccBULXMjDE0YyObRkJzEfnZ5qjaCDS
         VcEGuKDn4Me8waBfh7H2eFhp8Ev9OBqNyR9mSwLha+RLkTrCKV/u38XpLVyX+3QoybGX
         Ttt6l8gJcx0b5lHgogBPNOaIZuzyOQ4j5w0WJ5NTHe3UO8/RwGBjxRp/xxCa/o8y/qQS
         zmu1y2S2cTB0IAeD6rWzX89h4Ck58OK9m2okhYYWdDfvkyGXpmX5WSpgTeG91jPtC7vd
         3M5aZto1LyDjTzrHyXkS3gLQemyiNL69Qjif0SYa3ONSP87IJ6i6esJqLNiWyR8aQlu0
         +SjA==
X-Forwarded-Encrypted: i=1; AHgh+RolLBuQ7kt+mjFO0WypEA+l+i5bdhU468/oKdK+788kMPB3eqzbfydofIUf1LRvE8I05CRT/X186Xk=@vger.kernel.org
X-Gm-Message-State: AFuF++nm0IbJjze4Yt8CGXv+kps115E2rKJmn2dyUM2mmQmiPSE4rcg1
	8eZdgOCB6Pij4Tr34goQHTU9+WRvXLBsNnwTQsr+DZP3Z51VhhJcdYWauP2JzsU9tXU=
X-Gm-Gg: AR+sD13sz/HGf0Pd6/Iy2spgEg83S9v/mF7xz8DFB9qVRlsLR0YzMEai7i4kOyRblh5
	ITQXLndSoQDRcpZxSppbrvQ0kk/2OYi6Mx9+OcpqfIcAEUrdbT3cZUpKCe7PckTul0c0YH8MSy7
	bsQGZAdU3f1XE52+SUjxKShks21CTFfkk1pqy/qjLTWrr2lt5RQb3dTAiM1NEQND7kAeEXG+BsI
	Ohv9DpzAYA8Qjb1kufoI+8MWz/YQekbtt3Y8LTNw11faNDd5F1XJLTHhh9RSL4EjEI0si7B61fj
	8Ee5HORmuTqc918mKl2XnpaSoRI7u00/rSo6ombmCLoLblHjtqLXopuCy+NgXFBNL3lyq4HcdK3
	7+DXKVQ1Bv6O5YuDhm0X7DyaIynsAbUmRgHo0RG4qErqlzUfGSwLD3ZePQaniekz0o1cSFBH/0E
	6X3hp/XEMn3O0VVJcxIQ5N5lT24kE9w4XqZocNP4U2rcKVnaDHNfillL8e3KAOvCeVM4bVxEjmp
	Lo1lfUEJknf4/rJCrC7QT8jJrKT9uHwt/iPnV4HJA==
X-Received: by 2002:a05:690c:b96:b0:806:b6ab:a410 with SMTP id 00721157ae682-849ea4fa374mr34419257b3.0.1787328225648;
        Fri, 21 Aug 2026 09:03:45 -0700 (PDT)
Received: from [192.168.1.169] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-845195560e1sm44559037b3.46.2026.08.21.09.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 09:03:45 -0700 (PDT)
Message-ID: <699419a2-31ab-4379-b11f-c77e9e6a750c@baylibre.com>
Date: Fri, 21 Aug 2026 11:03:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] iio: adc: adi-axi-adc: Add support for CRC
To: Janani Sunil <janani.sunil@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-4-bb8fbd06d4eb@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260821-ad7768-driver-v4-4-bb8fbd06d4eb@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/26 9:06 AM, Janani Sunil wrote:
> Add support for enabling and disabling Cyclic Redundancy Check (CRC)
> processing in the AXI ADC backend. CRC provides data integrity verification
> for high-speed ADC data streams, ensuring reliable data transfer between
> the ADC frontend and backend processing systems.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

