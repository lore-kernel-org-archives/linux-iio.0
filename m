Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD135F5E5
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736421; cv=none; b=uyO0OdhVgS+DEw6QO3TwQrl2GxlznBGS+Ut4UQxDoCWrtQKdvI8UYnjnBx2dHRoiulLiuYjiP4/0PR8c+fEC7kcXIVOzexJ81tpuhsfArF5DmEqLEUDMgAK744TiickFa6ePV265nxwrbGEQpgnAo2oNIKbgN5rIEGzdE89+iE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736421; c=relaxed/simple;
	bh=NdBv8CH1OyvBd6FHXsWX1J+AfJHEOUFXjblfCrHMQ/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnAa+w9ey8+oXn2Ywueghov1armYigJvD3rWHJ9LYIxZYfbXqshA5SGN47c0L9DvY+aclbRYX/VMnO2oG6Oc64ioqS/jRmCDvmFBB9aQTBMBg50aIlvgvlVdT80x+fI+0yoNNWf6zGeFPJvcPnb9n/W7UEy6x8OnO0CRxTUc2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dBgliTBp; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dBgliTBp"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4863cd278d7so160839b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781736418; x=1782341218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKLKgVwL+aLhwhqEZehXmpj4T1hE0+NeLKRsW/zEUZ0=;
        b=dBgliTBpuwrwTTDIAQA1XIi/nWDPcbKkkNGHV4CX5RPX6VjAw9VSCQqo1sfuTEUVkz
         6iFvzEc95e/IoucgHU5rUoAHG3Q7vl0hLNUnLTdS9MI2nQHmzUjAZUgXKnenzEGxzNFw
         Xss5crU/0sJaQAPc2H9rjD//3mrn67ve4MvdRNoAS3JR6795Y8/cZ9Np91pfIdKVbOvc
         nY99QmH7ucsCa4dRvIHXcYKHoNmV9WHODrAmANmEUsf9XznrSM9YC7lo+o0ycspFSxEo
         2Et+DWXmSso+0a3YyzwRm8B3QUWk5jarkyR5NTBQVh0+2buL0d7elfNrf/XFX7jZBUS4
         S33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781736418; x=1782341218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKLKgVwL+aLhwhqEZehXmpj4T1hE0+NeLKRsW/zEUZ0=;
        b=fwa6bRb2wEpDPNLrqQcmiGP+sgr+wFFk/8ni2pUSsbu5QD4yONKH3UulBQWBVDA4iS
         NQtG/+wrXjatIpI7QLBvaIsFevTSbtMuiW17FBaLzB3E5xjZEyGeTyF4j5msFaYh9QBg
         tTD8wMHLRM3rTU0OjPAxQc4a9o7yVhXF4jF8ON2FTX1DPJAbS9e9cNfDWWMAMpfEcmft
         Mmq9xDVX1Epwt7fLKp+JJjMeSOPSVUp4JBtnJAd5nNDOxDNTZKPivrp3OPqSFROwtoVZ
         k+ylnGx14Gc//PTroD62Eq1avB+wShdNSpckWmt6HoRN693Pkff1iHlikBTXR7Hn5C65
         VLLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BJ66SqVmGnCg55QgUNqAg7aDAETC5Jj1KIrgNGVetFRFb//BUSKcC3BP5f1lNQoVHc7nJSH3Q/JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvX9PA3EzMGcRDqfukMNSnI1xYVHhSFxOB9j7Np5CXdytdEla
	2mtRM9MCuF5iBET3VVddZOLYYonbfZkkxuQfxcX0VK/jyc3UmFihpoCtXsExaL0fsMc=
X-Gm-Gg: Acq92OEK7qbgdRh4hM52OUPy/ZQo0ap3uV/Z58X90/MgBnrOFDRXEukOyImLWjel78S
	7rywxwrqkwGmMBu1D5EOwg2PnkhPTeAnpllkk/JxhEn5bpYE/wDimH2omv4V9/Uz48eF/i0+LGW
	zMMP4cF6aNvkkYhVmYRf26L7R4flS7V1gX1wHnCfce8DrIe7lKXTdPMS9jrka6ogvae3gBBN/YP
	GMbZJ/ICgCmejCNhXL4xFndB5gJsl1Lw0bfsWzUxKpDu1yHM1XGRYh4cB9izmHHIpSBRSwXu1Xl
	XtVcOSf7ot5/cGOv71AuWhoyMyFUiv+7V9uQLy2jX2iXXmTRbHFifUzbPCZR4gmhW5+SE0rfT1V
	2L8p5dg7QkcppWDyvG2EqYJcaY5ZmCaJHHzLFT4/n9T8R8YGI2J2K6xP260Gfl+4S2YdnjogX8h
	Y8/AiHDK30moiohxO1zA1GwVh5LdAblvRIEyipkkJxsq9glL24CbtMzfCOgAO8eg0=
X-Received: by 2002:a05:6808:1707:b0:485:4179:aae3 with SMTP id 5614622812f47-489571173cfmr971671b6e.43.1781736418299;
        Wed, 17 Jun 2026 15:46:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9458:d356:778c:22ac? ([2600:8803:e7e4:500:9458:d356:778c:22ac])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd98e8sm7060538b6e.6.2026.06.17.15.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 15:46:57 -0700 (PDT)
Message-ID: <bf510afd-4009-4908-9bbc-35abdb635dfd@baylibre.com>
Date: Wed, 17 Jun 2026 17:46:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] iio: adc: Add support for LTC2378 and similar ADCs
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pop.ioan-daniel@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cover.1781661028.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 9:02 PM, Marcelo Schmitt wrote:
> This patch series adds support for LTC2378 and similar low noise, low power,
> high speed, successive approximation register (SAR) ADCs. These ADCs are similar
> among each other, varying mainly on the amount of precision bits, maximum sample
> rate, and input configuration (either fully differential or pseudo-differential).
> 
> The first patch adds device tree documentation for LTC2378.
> 
> The second patch enables single-shot sample read with a GPIO connected
> to the LTC2378 CNV pin.
> 
> The third patch extends IIO DMAengine buffer interface to make
> sampling_frequency and sampling_frequency_available buffer attributes.
> 
> The fourth patch enables high-speed data captures with SPI offloading.
> The setup is similar to AD4030, with a specialized PWM generator being used both
> for SPI offload triggering and conversion start signaling.
> 
> The last support patch enables running buffered data captures without SPI offloading.
> 
> Even though these parts are somewhat similar to AD4000, the wiring configuration
> for LTC parts is different as well as the available HDL for high speed sample
> rate mode. Because of that, I propose creating a new device driver for
> supporting LTC2378-like devices.
> 
> Specifications can be found at:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/233818fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/236416fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/236418f.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/236716fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/236718f.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/236816f.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/236818f.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/236918fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237016fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237616fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237618fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237620fb.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237716fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237718fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237720fb.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237816fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237818fa.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237820fb.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/237918fb.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/238016fb.pdf

Putting `Link:` tags like this in the cover letter will cause b4 to apply all of these
to all patches in the series, so we don't want to do that. I think it is enough that
they are already in the code, we don't need to list them again here.

