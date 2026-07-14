Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B4427FB4
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060423; cv=none; b=oDCdSlcL/KQoyDnOFi92jCw4mmRbsq3JJeJ13lONo6zBwUmLEz1PPt1n7eGMXPI0oZGBov6fiEtMhXEd+KcqSd04bvIDuGQlMOAJMOSU4INcrGlo0NNHdITbQkh85QGf3EVMAH42hoc09IZNI4AbBs/GWhN1jIhe8Ynu3Lc5c04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060423; c=relaxed/simple;
	bh=KTLPW7SeK0eHR+5Ne7iDAKcWs9/wlvNXzu4pSKLITdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niI2/y+D1xUWgik24k9L2+06q1nOAVbDJhwtw/qDo9MdEjWCMQ2+8PGFov90HEhxf3SV08mAR5pvGFPwS6dEW/rXQJfRve7M3nq+FaNMXDCE8Mafy1isf8gz8w7BM/LqYF71pC4WHv1/D1O5qWdtmRaXWhPed7VSiDJqBN7ZJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Dc7lcxIL; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Dc7lcxIL"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso1545637a34.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784060421; x=1784665221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHU+hJdy7DYz+ulB1cPA669ik4xQKiISAcTXAq3NZ5A=;
        b=Dc7lcxILxStv6ymMzTOEat4xx3RvhC5fn/YDprx2J6WjmxWtKHp44unEHx58Jem4uO
         2Q2dk11Bf/lcqrFjzIU/ZyV++E8Ct+r2D1O0waj2J/iNMkaxSG08QjpqYSGIbOyx5/cD
         n5k+wb5c4Ub4gqTap6OTK4pbNWnP9AvinZFd5j76Idc131JG9bhOtpWJ7PbbW/4v+f14
         bbPa6b79rqRxcNwCTl3VqtwzbAQyNOGzDwqh7VrKQ6Vvgd7G7wYI56x8Nao/xe1uNZk+
         axd47Ky9pqIFkrBfg9VK/fS4OXmOXOOpd4uox3w2osIY6aUoaHAcuuU0RyHeQpsbDiVH
         pOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784060421; x=1784665221;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHU+hJdy7DYz+ulB1cPA669ik4xQKiISAcTXAq3NZ5A=;
        b=WzfGQYNvNpSuG+OFLqYBqav1mj2XOrxMxrGkenkbbWE7nszxKppKjzrzV5zrsXEhIO
         cnrisaXrw9wFR3tHexM4mBforSbTVInr5GWMLFx2MRyU4phzC42wZv/+zEsnDiTEewqL
         d6AvFDKH2kR1i3iScdWHivsVIRLPE/f+oUk8h98ukNy5hlsjr+yzvVvQh1LDsohSjtW4
         wLGQwkoFAnKWrUdI+QAp4l3c2YJdSHjrdiZbhXoUcgTyW/WtjAvMnt1ZitU+bfTLmckt
         lXeCzl85zqVTz1c4pa9yOKRe4tRWQKRteWsKcjTVi4trj34mkyXLkejWOk0CablQe9X6
         TUqA==
X-Forwarded-Encrypted: i=1; AFNElJ/Re137x30IilHUFdJYrTnw2M/3iTWZ9nnNfy3gm22FwhnNJEcRmiYGlcZYVvsR6jYpHuD/x2YiXnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8YhDQgG0AeRXJM4FgqNVNZxo6PB7jOeCXc/+ZmO32mke/1eu
	rX6GsVXKx7kmlfO1nNiL2DpHsWOTqHG1fygImCXvNc3mMPymaV8ZYRgwt01526LofiE=
X-Gm-Gg: AfdE7ckSvSugJYujGBKfbbM9mMVYFXEdUfh9bblUlpm6aZ88WVAYNrh7wWccYAgjQsv
	uIKU9shLDwIMv1sUDi3XGUWAtUuBwAnB/YnhvrofqT+omGNlIVPa7WsnMKnhllOvgxI2AcrHKCT
	WqQaigt9yQKfb5pxm3dbUV2i0ZmG9DP/50oXPH3jKOhXvN/YWPrdVawshrVlfIDJZR3aQBrfSt4
	F9vIJIQ7xtPk/tV0dArIwMjY/ha7ityBzwRWJF+WDIFIjgYMZC35XUO93eA1AGriwoCWU1+H3ZX
	zimDPjv/nWSJtQVotFx92nYblm97wFEWStLfgkUK2dnfplK8OANe6vS5/NTD5oS2N88dGHjX6hv
	Dp865Y4u0aOQtjRg4mLi5a4yttYB/ZBRea6TVZeNGpjacjOoe1HqplctO7v4C2uWet6gtkufqcK
	oRPVplLYNc3Lmlk/b0XPgGLnpkEp6HsLcsqCM4na3p/b2eNEdZblfuD83s3GwEpBA=
X-Received: by 2002:a05:6830:6ab4:b0:7eb:89e4:8f5c with SMTP id 46e09a7af769-7ec4a79830cmr2047499a34.14.1784060421288;
        Tue, 14 Jul 2026 13:20:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bc0d0sm15910199a34.19.2026.07.14.13.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 13:20:20 -0700 (PDT)
Message-ID: <66b7b01f-0e79-4387-9b68-92858ccc1fe7@baylibre.com>
Date: Tue, 14 Jul 2026 15:20:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] iio: adc: ti-ads1100: Add support for TI ADS1110
 to ti-ads1100 driver
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mike.looijmans@topic.nl, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jorge.marques@analog.com,
 antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
 jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org,
 sakari.ailus@linux.intel.com, linusw@kernel.org
References: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 2:55 PM, Jakub Szczudlo wrote:
> Add support for the TI ADS1110 to the existing ADS1100 ADC IIO driver.
> The ADS1110 is pin-to-pin compatible with the ADS1100 while providing
> higher resolution and an internal voltage reference. This patch series
> extends driver support for ADS1110, updates device tree bindings and
> Kconfig text, and improves the overall hardware description for the
> TI ADS1100 family.
> 
> Tested on: Raspberry pi 3b+ with 7.0 stable kernel

Hopefully this applies on the iio/testing branch? A lot could have changed
since 7.0.

> 
> ---
I made some suggestions for cosmetic improvements, but good enough for

Reviewed-by: David Lechner <dlechner@baylibre.com>

