Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9B2DC792
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781473077; cv=none; b=n00XNiwmLhQiOC17jAyqycXKMVOD1U6HljAa+jmpfWBXj/hGVUqL1mHuB75WBwyMCrTqHKT70Aeg4LgPPKS68+Ov6MFfCs88QNJ7RrjMhoVYrfDJFPPYFV6RFBFSZvUk/IU/t0zIavI/lUXyV79jH7IJDu/Sc+kckW4XDwUEruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781473077; c=relaxed/simple;
	bh=rqVjEsB8Ja5AllVHQhk+TNeJtrSgPDgFNJDJJNdH+pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjgYxrlozdIOeVM4ajBGqiElR7qoc9sCk5hec6VfVsCOL5g8t+EC6FDH9nXBaqOfMKnzz6wly+wKseTdHw8vNgrAeAkevfX4p0xaCNQSm5blvIZA1aDVVsx0poFHrhwsfZFRqu1sShXmLMakgVQrzPVmv/g+O4jTcYS0Np7ih30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jO63LKes; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jO63LKes"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6f27619e7so2424245a34.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781473074; x=1782077874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RI7FLQXUm1QCovQtRMi/TraZX5ESjWymioAQD6cyMfo=;
        b=jO63LKesEGYubsj6pIBESC4comjIQyLvIUnGIxEPUsoG9DzvH2KchQttWhLK29zSwq
         sjT4jfSSIPZScoXxp1mPSRXYPMyZ82Sxw0AS3cP1IwyIWJsnYkCAKRrwCcu8vcqX3yLj
         Risy1AUdWrqQBuZns2m8ys3cVnwMsxw9c2BlnAz9JUR8111SinZovsB3N9IZKHn0qZrf
         aoCOtW7Jxk/VuIP25w0vOSywBKuoKvo68gNng/ogkIweuwYLHmjemuEwVZ+aUTJtMmws
         Hyne1crD64FAcjmk88NVrpy787+hFDX03/kAd/Aadi+xozp1USwIq1bqz4Zpgwj9wmc1
         xI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781473074; x=1782077874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RI7FLQXUm1QCovQtRMi/TraZX5ESjWymioAQD6cyMfo=;
        b=ena4fONS0xq3xeCRFI/NMkdpe0lZSnBgK5Oo8AXGRokDPmoSKPLsa6fJwf9BTWRmf2
         1358Tuz0HZMXj3LCZtPOpdlRd3NBSNxBfBCb62Vr/weRZTk2KCg8FxhZu2CnH07WFoqX
         WPiyp3UcdR8FvRKusgvWdj43s4aE4bEwMuukgqBSNDs5klF1Xckk1jo643L1yS9VALBU
         UdBU86aXinoMy09zjO9XxakgYZDj77n11yvaf2xr7K1GZ7KYcKuvvvGhDBaaBEYoYtkS
         lo5lBMwKu3KbU2HN5j90/wzKEmicrkl2C9WLEw98Qyrl7JPEEolH0eKaJSvckKY8caxn
         N7Sw==
X-Forwarded-Encrypted: i=1; AFNElJ9CZZRyHrzHaDRn23lvkQPLbBam8CGXM5Zl/ABaRAiZUaNsUApt0HFerd8/boxbZUUj8kYoSPYOZa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweereqE4XdYfH4uUJuOk0fjnVi2IIeZco7APswGmXbTqdSjgOp
	2GcPbUzzj6SdOsG2XSP7e2MGcTEj3iyLfNAKwhd4NIkiZiwMCJBs4RHV/RxcWG0GFM4=
X-Gm-Gg: Acq92OHdrxxyd2JDZPFDkLp9w/vCJnawSYd+5iL6vuI9HtRr+o9QN84RQEEa013mntL
	b/4IvDhBTsBOgqtAurcOHWuzvPznQG8xvk83nPUuMPXp6xVfoDLHXcYXt2IVQkqyUoRl47Nq3wj
	UOMgW2IrsX2Y1swQdZ26M2UtNYqePIjjnUF/C/0opfI1oMaY3+mvltJZ3c4o7/pY2S0x9uO65uz
	U4+xNeCyCB1GF44nMbxBwPUoA3XWrNp0KO8hP4k6TgfQEBuZdi3VI8hcMvqsv3uD4OKDmiS83eG
	rvdu2BJD3kp+UALtLUNyMbpTff5qvVwgFJrTZQ9sNQhZc+7dyfeR64FBXGBuE94mW0RVDEW9WJn
	29sAEyQK3pPlrspt/T1Nn2HMWZ1mAo8vfTkmujgdOHWT83BI/30WszTeIvbDnPFvFevPcpHZbmp
	kK+MOR4YWwEOGiw5mlAlmDDIRRzPKVwx27QbbJEscJgo+GO+XCi1N22ZZvDoJalNPjQGYoBwwik
	w==
X-Received: by 2002:a05:6830:3816:b0:7e1:f7e9:327e with SMTP id 46e09a7af769-7e7847c2f0amr8471798a34.22.1781473074385;
        Sun, 14 Jun 2026 14:37:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:38f2:457e:e670:19c7? ([2600:8803:e7e4:500:38f2:457e:e670:19c7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6dfae9sm2470025a34.23.2026.06.14.14.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 14:37:54 -0700 (PDT)
Message-ID: <f13b9c55-770e-454c-9bfb-5847ff17813b@baylibre.com>
Date: Sun, 14 Jun 2026 16:37:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: Add TI ADS126x ADC family
To: Kurt Borja <kuurtb@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-1-894c788d03ed@gmail.com>
 <20260613-loyal-azure-goldfish-cf6d54@quoll>
 <DJ92JT0CPSXJ.1113K3KLSRHH4@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJ92JT0CPSXJ.1113K3KLSRHH4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/26 3:53 PM, Kurt Borja wrote:

...

>> Not a separate device node. Fold into the parent... or explain in
>> commit msg. You have entire commit msg to explain odd things.
>>
>> In that binding description you call it "independent", so it should have
>> its own SPI chip select? Why "independent" and part of this binding?
>> Maybe not independent, so basically part of this device?
> 
> It's independent in the sense that it is a proper subdevice on the same
> chip. It shares the serial interface but operates completely in
> parallel.
> 
> I decided to add a subnode because other devices might request their
> io-channels and most importantly a different voltage reference might be
> connected to it.
> 
> I'll clarify this in the commmit message on the next version. Although
> after seeing this submitted bindings [1], I wonder if it's a better
> approach to do something like
> 
> 	spi@0 {
> 		mydevice@0 {
> 			...
> 			adc@0 { ... };
> 			adc@1 { ... };
> 		};
> 	};
> 
> Any thoughts?

I don't see how this relates to the linked patch at all. The linked
patch looks just like a normal DAC binding.

What is the point of the 2nd ADC in this chip? Is it just to be able
to do simultaneous sampling of two different measurements at the same
time? We have other simultaneous sampling ADC chips and just model them
as a single device.

Since everything can be muxed to either ADC at runtime, I don't see
any reason the devicetree should care about it. Forcing certain pins
to be assigned to a certain ADC seems overly restrictive.

And unless you have an application that specifically needs it, I
wouldn't bother trying to implement the 2nd ADC in the IIO driver.
I didn't see any hints in the datasheet as to when it would actually
make sense to use this 2nd ADC. My first thought is that it might
make sense to use the 2nd ADC for a 2nd buffer so that you can do
2 buffered reads at the same time. But without knowing why this chip
was designed this way, I don't know if that is the right idea or not.


> Ack to the rest of comments.
> 
> [1] https://lore.kernel.org/linux-iio/20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com/
> 

