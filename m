Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671E312815
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785726; cv=none; b=n1P6gw5M1stCi9nyYmNLRVaFvN75WXy6KGyNOuPKCGk7uAzquHruLncyq97M8zZFVrq9osFl1BHvUOOVcEqz8T18fLIhQ98Fv6KmqitrFcPX+qDTNAgADrP8dzo9wPCcgssc+c2t97PtAl9aXXhjahd1nPZ0Of8zzt9t90Dc1wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785726; c=relaxed/simple;
	bh=VjAnPKkOhrNzBBj74/3IQ5jyXGO7ZA3AmQIZeJkp3YE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5V3RSg3EHGtf7HVuLZqzE+KmIgNlMYVcG6Mbfg1I/jDFAJbxuOboNpWgcDyrxGOuNE8V0vtxzohj/Bi0Y/7VR86/G9+/pi/d04V7wLXUnPXjeazYdXNMvNenCfs6LdISp5MJNsCr4SS7ixTTsZV7qSIi1D2a7Dc+ULa2GbvNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOtd5Iux; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOtd5Iux"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49558ce01afso19472795e9.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785785722; x=1786390522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIsx6zbYaQEdLVAaackOaf7e88l+t3puadax1/1AhNI=;
        b=UOtd5IuxjO+0CawwxJUBWuop0lzlLd5/uZhrltQgg9jIS3N5sre30KR2dsAcsc4ktb
         Ov5KYlNJSnRUmZGMTSiDoLWCe/dYmIFDvE7JlWxd3LpcsoPlxLmBFRz+LItp6Oa2+UqY
         7F7Iufx7c+TMi96uou4UHWerJcRNlMwFuFjdIP6BGheHMSeZVnZ9u5EcOT2R6YfbLEQY
         CCXbgR7NGUxw52lQXuq1JZHeA4ha5fCd2xo5IbuMwdRk4mbeiREkkz4KfKsWqE2I5YvW
         13ZvmhaXLrfJb9r3YMNjeGTpymqzb20UqVL+NkpEzvWlwWnogdrZMe04ntu9hxAIdlIk
         bMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785785722; x=1786390522;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIsx6zbYaQEdLVAaackOaf7e88l+t3puadax1/1AhNI=;
        b=seGkPOH+SJ1wxYg6mzh8ODL1c533xa7FLVFF84RvYL9zOpGUbsETOcKEh3BVl643/5
         uFGEr6ZDvAxbZ6qcWAE7kj3A4CIB31CAHq4cO7WXu7a3qrrglxUmRgXiS9kpz6QgdgQR
         mtoZBUcM0jV2ciSvZI9XU2jI6uZ2RZX7G0+91vSqpoobWaxcxXQ3tU0q978smZWqiHQV
         qCG0RtBb9wPB2upXXKHm1MEwAxbcQ7S81OtQVs/6Of4pPZBvJLkU4doIAbPynZPVU0kd
         Nc6SHiScpGV69FgttMgNRVYHsiHXtYlgzk1UDqMgnogA4N527osEAR3nisPXLXCMUEUd
         OkaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVGfSOyLioMj6tB/ySNfqhmbvaxdkX8htIX9BRFHHfAA2F/UWvRk7L5ek/cpX1cpn36s+Ww8d4EsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MFGo3kYcQo7tPRvPL1OS1SGGdexNcWqnNt/ynjHmj/a6V69v
	7ajo3asuXjxZR9ybaqHeYCxfTzWXVVtc20pB/QWshFMhJl/FErPenPGf
X-Gm-Gg: AR+sD11Ds6ID3WFj7B9pnIsjrCvapjzM71FaE08vGKuxN+eAy0aTblR2dZAqI9Z1ZKa
	yPCGmfA8pPaT6HHcf4qRQGmymjHksX1Pvs7XG+E/orfMrVMdqanHFNnIMIliHv/T6AM43BlKoSO
	/zOBpJcMm+wMFoBXqJ3kJ/qBQaIciibL71R2JT6M1q0uBzzm/YoVoBf1wd9132K4VFlZyu9GeC6
	ylfZCr9Wrag3DWmvgpKCvAQdJdbxD9Yzde+SIiAKI6V+zrOFKruTUFYt4KBBRb86ZZ/YeR6359/
	a+rei7CvjFmaxQR1y/P7yfPjUW1OLfhbYyIcZzprGUG5/mviQgdEl9OaFmQxXATfBCMfDM0hNtS
	mQHbkfM/EFbGxK1Hq8H47DOu/Al4zwEQusSRPcYzPrEMOE0tWvaBmqCnEKSczF69VZaKYawI1hJ
	cJ2Hlp9titXWsNVCqgG1nbf21DB2UjH/JEL9PNEk9YwzW7I07VxynceIh8ydWyqQtyac23dGeha
	7KsibKQN8eG4Lln2wl/N7rPCEa8BbAmf6UW78tV3yaEd+ZNkvoKhEsDqksn6FzYCI3l+7P4RoPb
	IbYfEMr0G2a0yw8J5/nJn/dgdDyTny4lKtHudPYO0btkd5I+GHtQ9ZbqMa7c10SAn7sNPED/b3k
	WQkHbMkhPfAXn5z+JJwRIt3QT7aiyB/GE
X-Received: by 2002:a05:600c:3b99:b0:498:519:e660 with SMTP id 5b1f17b1804b1-4980c66d8b0mr265523695e9.4.1785785721474;
        Mon, 03 Aug 2026 12:35:21 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456220esm36742356f8f.18.2026.08.03.12.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:35:21 -0700 (PDT)
Date: Mon, 3 Aug 2026 21:35:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add support for mcp47a1
Message-ID: <20260803213519.7d3d241e@systembl0wer>
In-Reply-To: <20260803180717.4BE651F000E9@smtp.kernel.org>
References: <20260803-mcp47a1-add-support-v3-0-540e71b4fd2e@gmail.com>
	<20260803-mcp47a1-add-support-v3-1-540e71b4fd2e@gmail.com>
	<20260803180717.4BE651F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Aug 2026 18:07:16 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The I2C addresses specified in the schema and example appear to be 8-bit write addresses instead of the 7-bit addresses required by the DT specification.
> - [Low] The `reg` property schema applies an integer `enum` directly to a matrix array element, which will cause `dt_binding_check` validation to always fail.
> --
> 
> --- Patch [1]: [PATCH v3 1/2] dt-bindings: iio: dac: add support for mcp47a1 ---
> commit 441e840b5a2a3f037c3520c49013a55b7dc4c1bd
> Author: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> dt-bindings: iio: dac: add support for mcp47a1
> 
> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converter
> which communicates via I2C.
> 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
> > new file mode 100644
> > index 0000000000000..b181fe73dce84
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml  
> [ ... ]
> > +properties:
> > +  compatible:
> > +    const: microchip,mcp47a1
> > +
> > +  reg:
> > +    items:
> > +      - enum: [0x2e, 0x3e]  
> 
> [Severity: Low]
> Will this cause dt_binding_check validation to fail?

No, this is a perfectly valid dt-schema which passes dt_binding_check.

> 
> Since dt-schema parses reg values into a uint32-matrix (an array of arrays),
> the items array applied to it defines a tuple schema for the outer array's
> elements. This means the inner array [0x2e] will be matched against the
> integer enum [0x2e, 0x3e], which will mathematically fail since an array
> is not an integer.
> 
> [Severity: Medium]
> Are these 8-bit write addresses instead of the 7-bit addresses required by
> the Device Tree specification?
> 
> If these are indeed 8-bit addresses (as indicated by the 0 LSB and typical
> Microchip datasheet conventions), they must be shifted right by 1. That would
> make the correct 7-bit DT addresses 0x17 and 0x1f.

No clue what Sashiko is on about since these are indeed 7-bit addresses which
do work when tested on the actual hardware.

-- 
Kind regards,
Joshua Crofts
