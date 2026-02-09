Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A762874F5
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661213; cv=none; b=Qba73piCbUWgWRrR9a0TtljG2LF28mz178OOyJmSARJvMCXi7UmCQDGdcFcD1rDWCqw0/TPuMhJam84Zrx3fak9v3B5sJhKHR1M2CwwvdZk4OqzC+CxpWjowlrczCY1C4ZEa0W/ICrKrL5LMDVAuPmJpTFf09E0sKeX6FWyZjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661213; c=relaxed/simple;
	bh=/Z5yt2oWOmU2bfIIiNcrfDmA9qc3h8e+hqkPxC3U1HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4o1mcefm/GHjw0mgsXQorc+i9LqzrueGYlaw5/hPN0UEvtBZRsQ953Ve49cBwNoZwvgSB2QreI4w9pd0/gvX0C2UYARErk4HzCxXV8wMXFwjVmoBGrSLSN+rwyLz3fg6wM8uuOJ3K49YtaEUnM6/Srl283RzNpw4yCqSXPKw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgl5AE0d; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgl5AE0d"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-790992528f6so43972327b3.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770661213; x=1771266013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGFByPnEFRf0LM/uYZGp1EI046vvWPTETytQcURquF0=;
        b=Lgl5AE0dK/pmu+tRGL/wSPK6dGdzc6bb/poFAFlYGS+ljwgD8DAxhnFEUJp5rSVUfH
         ycH4H5EiBn5BbHTHhP/AGrCn2oO0JfjaXpcw9LVt2/HTB6mSHXy5rKXV/EEegx50P2mI
         n94JrirOKC+/bD75svYgwcWX3fPMkNDhtDnlojLUb1FZlJyc6FYL00MJlgoeRjd2dFpB
         GVcJvlOPDoep56rezbcb//dQ9vYGh3UNSv26yxedW1OqIOQmgJUE/IKvKfnf6gBMwZs5
         G4k4cNhN4RgLWLEKHSaUlYYq/vGo8G7vIj//X7JUig0nGpq02Z7KyqsYJPr8t2RLXY7f
         rjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661213; x=1771266013;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGFByPnEFRf0LM/uYZGp1EI046vvWPTETytQcURquF0=;
        b=m4nXKybhmf4yCCWc3zkwYrrJtLozqsPTqBE3wvHR+vn9FSm7pHVOhXxHk8aXKzq8jQ
         ixncTQ/D0jTriBE8SYYHvl4OTrcz8g7J1f5qrYSAEh6vgzcGtoHLm497W5EVephHGsD2
         DVcH3tYn3+iwVQENN2OXDLl+408lgAH57ojoFP6Pi9m1I40dmfT58/NWmEieZANfF8IB
         X3AYUaVC6xq+ju8s0zmOctydTCYEMW9kU0Kl7pQ+G+ak0sBQSf5J9ypC444x9Aw1DPIf
         kSSqNeRQctR0LRyJPvj1kBu2d6qFh6wXAPjAb3BRJ0t3sUoVkSD0wGzA/L5H04wjaOQu
         BweQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ik//NocczWoAOQ1sP0undvSD3TyO/HZ7qkGPZ8OKSifTDsgNyTRSO28I4uoY75AQg/B61eNeo+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtnqWKYP2hTVJeV2JNabyuXczT3E6ymR2jVVTqD+hGikcvP9Z
	/EbQbqNV+wHSdXQJ4J7G62qMK02b18nBJ3Ri+i2kFGFTIbrCtjV1l5uQ
X-Gm-Gg: AZuq6aII3udkkxDCe9f2OfxGEbeHa2N4vcrnUwpJ2bVC+bmTVyZhjScFOoP+7o6WSRK
	YbfjEMG96nfnIbUklKKJVyvH3+xPE/RKvtCXsQC7C4OTWiEW/7iEfsVEO2GNrd1OMCmpYG6XFvX
	0lVu480zRZWt7EUJZgWjQObVIWcCk4wbpwz33YfRnyY2jMe4uYa+NcY67JjByRvmiUsNM2PSub6
	+oZykHs7ErLq2Y0GDkRxoJXdEwkRBPqbJwWg1+SNrzr6FdHfRYuxBTa2GgA/Vv6HL0trdzCimbt
	eDP7lnMH7XUfHnD20+B2BiSKtbEuo9s0ayN/XRQBlPG5/zKZgbA8Pjrh4eyI1MaFa7mMejs0+hu
	lNHvr0jJv7c/mDFNkKRw8iax9Hg7k7siFa1d0hwZ1AhtYWR66JTArY4lUBLviSI9QhnNr7TwdrW
	r4jz1OF2qrYtjRXDCW4IoC0K6s
X-Received: by 2002:a05:690c:6c06:b0:796:5974:2a19 with SMTP id 00721157ae682-79659742b7cmr12456307b3.8.1770661212669;
        Mon, 09 Feb 2026 10:20:12 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7965705d5a1sm12602447b3.46.2026.02.09.10.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 10:20:12 -0800 (PST)
Message-ID: <73ec81de-86f8-477c-a5ca-aae83528dfab@gmail.com>
Date: Mon, 9 Feb 2026 20:20:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
 <aYoBwFW4ZDFhmlvy@smile.fi.intel.com> <aYoCJMlaaPO8auIm@smile.fi.intel.com>
From: Erikas Bitovtas <xerikasxx@gmail.com>
Content-Language: en-US
In-Reply-To: <aYoCJMlaaPO8auIm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/26 5:49 PM, Andy Shevchenko wrote:
> On Mon, Feb 09, 2026 at 05:48:22PM +0200, Andy Shevchenko wrote:
>> On Mon, Feb 09, 2026 at 04:23:40PM +0200, Erikas Bitovtas wrote:
>>> This patch series adds support for Capella cm36686 and cm36672p ambient
>>> light and proximity sensors.
>>>
>>> Capella cm36686 is a combined ambient light and proximity sensor with
>>> adjustable integration time, interrupt and hysteresis support. It has
>>> the slave address of 0x60. cm36672p is fully compatible with cm36686,
>>> except that it is a proximity-only sensor.
>>
>> So, can we share the code (assuming there is a driver and it already
>> uses or may be converted to regmap APIs)?
> 
> Ah, it's being added with the same driver... So, have you checked if there is
> any similar HW with the available driver in upstream?
> 

I checked only for other Capella sensors, I forgot that Vishay acquired Capella
Microsystems. Now that I checked, vcnl4040 uses the same registers and regfields
as cm36686 and can be used instead...
I am sorry for wasting your time. Should I add a fallback to vcnl4040's
devicetree schema and add cm36672p support by excluding the light channels instead?
