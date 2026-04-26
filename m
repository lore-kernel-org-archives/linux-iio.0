Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E58EEC0
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777220907; cv=none; b=IYSXnUYmmGoECftrz2gi8tOcuYb0KaVPpdQsnmSu/AhRWPOBrNoWztilO5KwAC9MIabBd5s/Y1OeIQj039N3gWRgJWpEobdlwfDqvLuEr04G5oIUfYLEyXke+9WcPlvaJF4OK1+/26tP/Gak9QzfXfVb8W3iQz+fpK8QX+HEB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777220907; c=relaxed/simple;
	bh=2KQ6yAkhhoo89EXa6FHNEhTJ1HeUSHJLWXWhUzB1cy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5b54kMDJ0AOZNgpiX0WQjqyVCyJhIXrH6pnLYIPpiUwhfqpXc3WtgKAoaokJR4YzlzD0WeEo5p60JziVdcknAXhXQzGx80wY+3ctetUQMdTJnuH2fr9zImnvhiPfc+wDNeakMcodKtxA2GqJzITJz/5BqXZNSAEKTxeVzwwQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=l+VdvHV5; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="l+VdvHV5"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479d37e7d7fso2244090b6e.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777220904; x=1777825704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzopt2jCiz/zJ9WJxFMTXHhvJ2SCEeZiL7oHCE6Ie/Y=;
        b=l+VdvHV5qn/2K12d7kjXlCfoXkUqq9X/74YhBFbWbxzvDl/bk8zzKqRYCyKGna1j2U
         N3Z3lJD+J1ISsRJMQXxWmNUVJH1QdiRiyr8Eeu8vM/eTvLfAxbcB4Oi3fpUIDwOo1d16
         NfiUkg6o9cYf3cP6NFh/IuGT0rUwjzD2XjbgfbNedzZI4XvvBiOfhgEfBqRC4uj3s0Nk
         a8IwwCYMJiXGh7hHzZHwlYtWct4zw7U3XpuzMBn/18SG2H8ME7eMELJHM3dFXcFOAdmr
         Jbpl5ypaZUhvxwas2AdsgURyWjradMNC5kccFUpeMgc3crk8yf96Kzsjo5XMEoxXgWg5
         oyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777220904; x=1777825704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzopt2jCiz/zJ9WJxFMTXHhvJ2SCEeZiL7oHCE6Ie/Y=;
        b=WA3qXU5wMRHV8BammqFg6Vfc2l+IuFaWi1ziGDIRfKc5mMIomAjFEGhePg1eyreP9w
         mI6aHmYaLe0Ale5lCa1FuJLzJ7He4f7AU76IapLffzcuTO7fBktjWa6laX0UUwEcEKgH
         Y3aUtD07BAyudPIk8KhY9DS2Z6B4KqMCoxKCVCpV83uKBYxz44ruaDitU0G1e4B8STgc
         IrN54zItzGvlFRSTAOCXHPJ8ArSG+YmCI6PjvlV1xyaS/HFaLouQhelTEN+XkVYnz+Iy
         uGnYE2l5vKfSx2y2UFAlbwp4ZtiCqqq0uSRbc+g2fBGM7aokuwq1IUPKH1RTxSglYWKn
         UdWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9R4a+e2Cd4SvFH++1HLpohsPvxWhoyw5SC0P9YhE6enSiOPacI/Ise/w1Wx0/Zd6sGELIGJu+F8ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ODUlktvrEcwjMI7y6nFFn0GhKW55GBboLVXXzVCOeIm4Isga
	+DDeN0rh28n29z6D2b8jmE6Dp8tvgA+VXQ7t6bCVTDppG2hLHYnTQ/Sd70CbC5UKm4Q=
X-Gm-Gg: AeBDiev8O4jd6htqKR1v/bwgCgZLVMGZrGXBc36g0VpZjoo6WdZS9jk0kTYa3jlKZL2
	3TQalK9/xFMxn0lekp3z6o8gJzS+TdczBOO6Mcm1CkyE8ydaQkejBKWcI8GLEA1lJufW8Lizuiz
	54M00b+Azpzih4GVCSueNZmuFfneQ1yN1p1p0qAN4HMBUyjSSeiGYW5CTDuYJwxxSZ/zoKsqcN9
	2zCWKnbTBpUXhyDoqnYUteQ+0B5PUultrIdNL9Z7cbW6R7eDhpJ3X8VBVLJ7Men/bdvdCvx1trD
	hhNH6WMk2hWo/hUD8Tk8DDPHXHquMb9sIccBlMiSA3d4qOOArg+eRX4C5thmRJ8zqDdbjFyQEpZ
	Gp+Smvwi/YMKt4m6jV7D6Y4dWl1I8+j3nVNmy8tgJVpTfqKBKT/xuikKOtzXYVzsNAVLflZ/C0I
	+yKGvvECtxeRSZAqbzebFRg7LcwFCF5gW5oDsmJ5/TmF6Vm3G43qg8dP9xPGk3NCfEZE8ToqZEs
	GuVEOUC/yrS
X-Received: by 2002:a05:6808:2013:20b0:479:ae1d:fff7 with SMTP id 5614622812f47-479ae1e08e2mr12603387b6e.4.1777220903677;
        Sun, 26 Apr 2026 09:28:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:81f8:ef7d:a711:d99a? ([2600:8803:e7e4:500:81f8:ef7d:a711:d99a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799feaabf2sm19106674b6e.4.2026.04.26.09.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 09:28:22 -0700 (PDT)
Message-ID: <78aa1551-2dc6-432d-9d44-ecef0198e1d3@baylibre.com>
Date: Sun, 26 Apr 2026 11:28:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: avia-hx711: add avia,hx710b
 compatible
To: Piyush Patle <piyushpatle228@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
 <20260422175910.1258579-2-piyushpatle228@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260422175910.1258579-2-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 12:59 PM, Piyush Patle wrote:
> The HX710B shares the same two-wire interface as the HX711 but differs
> in its channel and gain model: gain is fixed at 128 and the number of
> trailing PD_SCK pulses selects the input channel rather than the gain.
> 
> Add avia,hx710b to the compatible enum. Document the chip differences
> in the description and add chip-specific supply properties (dvdd-supply,
> vsup-supply) for the HX711, a rate-gpios property for the HX711 RATE
> pin, and an allOf constraint that forbids HX711-only properties on
> HX710B nodes. Clarify the clock-frequency description to reflect its
> actual purpose: controlling the SCK bit-bang timing.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
> Changes in v3:
> - Drop the vref-supply mention from avdd-supply; no such binding
>   property exists.

Why is there no vref-supply? 

HX710B has a VREF pin for a reference voltage input.

