Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F433438FF2
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745473; cv=none; b=HeJxG/V8i4pzEik+UjfAfbP6eFy3KTxCixU8bh6aBx/na6EqwU5d+EmlNiQKrJsvmCd8TTOfxgQGW3QO20K8t7OOcdY7yhgUqML0vIvo4REoIcIWbAePfxOXGIyE+SiKUdwPbo5ax5nDRJTj9I49P9Pa4kl4l3M2oeGzYDwHK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745473; c=relaxed/simple;
	bh=mLbyaEAgqepNN61bWeIhuKu91cbHIs1TgT0DiSEwuG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3cxpFtXEKZQ6KqKvt403v59qwulFgiUOINB1D/UQzkJDalyNUOJkydfwYNntWUEE+btaRbctv3y4rrdPFNva9eo1eF9UisbkgI1xUKyrNvdmo4eStClyKm7Sjc1PVoydIiSjQsKTvVkmQe6Rk4GZlXYP/aWlYdf36r9oTz+4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WTSkdzLW; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WTSkdzLW"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a15ca0d761so1293282eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782745470; x=1783350270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKC86SBllWMC5DazOx7jxMwvHWS3vvb7786WkQz0OjY=;
        b=WTSkdzLWZFj3XvffUCor6PD83mAixGrmyrRS+WHPILF6lvxKDB4/yNU8kWfmrTpVYD
         o694SCilIQO2xrBhE3ZBbwM+ZQWUotrQGGvUtwbu+0fUHD3HwyTbQOFzBq3x7DibI0y9
         ESxSjsJyGs7RPFGRk60kNc0jF1Ar6QOlLCYr9Dq+mPpntxmdjgnNLcRy5eDZ2910F/X2
         8tSuCL43GtR7LgggGvVrweXz55IIV93Vh7FanbIpjtw4g2/p1U3GFSq4ktzNA2Ag9sTd
         dfbrTAQzfDaUnSbB6bm3t9iv7cja12yj+IOPqEuxsNouQu0kDnAOz/ZRKQDNK+J2uQRl
         tJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782745470; x=1783350270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKC86SBllWMC5DazOx7jxMwvHWS3vvb7786WkQz0OjY=;
        b=KUb7kvb8WTs9Rzb+gs+YWTdRsog1Ki3I0FOAbX9TNuRvl5ZhcasNfJoSMHHo7pQTxI
         FjAYOvBEXbqAcflwQXTaGZ8eMkHuQwvo/sv3IL+zb3C53jqPEUVGWRN1abX2He65RVxI
         a9h65RWwJ/6Izg2nb5GYnUISwQL4eD/OEg7gvjOI7g+Q2vVjOW5xmQvu0DOuboxSG/Wm
         tF0Fl2QFVYFX39bwRoFO31HlhjwaJ0iR2BaancRtkplpDEYSQjJspn2U/h8nt++7qcXg
         jDYajDMQ4kS9Pi6GNIkfH0B6qZdMr9h0P5qeRzE3uGxKHLQR1TalgjhFCaC++GQp7rNC
         z1kw==
X-Forwarded-Encrypted: i=1; AFNElJ/jS4PPfQP3N/ApW6WOl3yMP8A/elPFTLo9CCptaF9+3cN0tB/ylsY4eM4BSHbi5fwIIJtWX/G5u/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbORE8B1SK8S/vMeu5o7C3qYAv5XU45YX2jAGS1skZFXbbtN2a
	8mLg0mJTqNVw8Y2XhNQaKfRXuf0806MazetEpMC0WZ5KFFfDowC59jncIl5eB2OV8vA4XZ+qfOI
	F/PII
X-Gm-Gg: AfdE7cmYcD9fjWX1yQAwkt0vmCNsbZLkm33VYMk3Z4DNd8fQ1cJuMVDJX4V+APZr6zQ
	dYZg0BWdrblM+mZOjlHKtqZIv2KxrfsZRLA0IQPTX+R4pMCTYlsl21LLaxQ/8Fz1/sRZF8ySskb
	7XTJ0L4zu/ntsuSd1wr99DZoQmZO69dVkeX7TlJqu4TBDqll/u3ii6tFV/y55P5PAJmnGC8w3EZ
	gRu7b+Qwu1XUwNUiV/45OFweM6WiYWBQjVOhzXQl5hdmnAcMr6dxxdPsovAu/cTb1Ii7xFS7fDE
	gDf1NKfCQnPm3GzW9OWALv62kkBiJVsa5JFCbc7UX6py4wVpsHkPSfYt1BzjcAXn13Sg+eK4x7u
	MT1VLuJkBoQ1yKsTaEwDt+hmZuRkWQib6kfgk5x8Ugc71rX8eHq2slzY7gQ7diMP6cNUpVWe9dl
	SptNvD17PQYAiBlZLv+heTlpv8M9/xC4epH2ajq9GFB0WFPQCdykAtmM5m0Fm4hQ/CsWoL7/BxK
	Q==
X-Received: by 2002:a05:6820:55d0:20b0:6a1:82f5:b009 with SMTP id 006d021491bc7-6a18910d066mr33242eaf.13.1782745470465;
        Mon, 29 Jun 2026 08:04:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3533:aa22:9a69:df1c? ([2600:8803:e7e4:500:3533:aa22:9a69:df1c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-448db92c113sm26526fac.4.2026.06.29.08.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 08:04:29 -0700 (PDT)
Message-ID: <2f01a3a0-3698-41e6-8fee-1d2e1629726c@baylibre.com>
Date: Mon, 29 Jun 2026 10:04:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: Chi-Wen Weng <cwweng.linux@gmail.com>, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-2-cwweng.linux@gmail.com>
 <40485b4e-6585-42a1-9b84-3019328574c5@baylibre.com>
 <7e96cc1a-eb60-4eeb-937d-64e83bc35279@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7e96cc1a-eb60-4eeb-937d-64e83bc35279@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 2:11 AM, Chi-Wen Weng wrote:


>> Should there be a dmas property? Datasheet says it supports PDMA transfer.
> 
> The hardware does support PDMA, but DMA support is intentionally not
> included in this initial upstream version. The initial driver will only
> support interrupt-driven direct raw reads, and the MA35D1 PDMA provider
> is not upstream yet.
> 
> I would prefer to leave dmas/dma-names out of the initial binding and
> add them later together with DMA support. Please let me know if you
> would prefer optional DMA properties to be described now.

We always want the devicetree to be as complete as possible even
if the drier doesn't use all of the information.

So for trivial/well-known bindings like dmas, we should be able to
add it now.

> 
>> I assume 8 is for the internal batter voltage channel? Often, we don't
>> include fixed internal channels like this in the devicetree since they
>> are always the same and don't depend on external wiring.
> 
> Correct. Channels 0 to 7 are the external ADC input pins, while channel
> 8 is the internal VBAT input. I will limit the DT child channel nodes to
> external channels 0 to 7.
> 
> If VBAT support is added later, it can be exposed by the driver as a
> fixed internal channel rather than being described by devicetree.
> 
>> adc.yaml already specifies minItems and maxItems, so we don't need to
>> repeat it.
> 
> Since I plan to simplify v2 and drop differential channel support from
> the initial submission, I will remove diff-channels from the initial
> binding.

Same reasoning as above, we want the binding to be as complete as
possible, so we should not omit diff-channels since we know what
the bindings should look like already.

> 
> Differential input support can be added later once the fixed hardware
> pair constraints and signed output handling are implemented in the
> driver.
> 
