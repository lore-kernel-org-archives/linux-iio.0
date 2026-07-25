Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAA3F329C
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784998359; cv=none; b=RP1N+LNGVODHLbdGLBCQ2/xkU7t4Mz2bhZeF0qAunQoMBNGk8iD5BRMrYYlqjO198tADkrvcEmwYTxlLd8YaoejB/SauaBEsMuAFBhXAyB46S950ku2bfSP91tez2JDpAoND89/z+YCQ8qGXYwa9hOSrntv8quXI4Nx0aDnWnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784998359; c=relaxed/simple;
	bh=DT5yTJrYGmtVdDQhfbNWXp56cdtbcbTycin6CBF/Wzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/TzizNGkDzONUExk1YRldvu0bLJEH51PKnlt2Kce16sY20zThMIF/CuDOGuIH+zjeyWI6ej+LkhvK8CFynkh23zhPYG/VSk0V2NQoMn+jwgKDetNUaXwcLjfDmToOpoAOVEJ0kcyzxU1AshQtSHmai+JDu4/2DFzthpuS6mVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TPyvvRiS; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TPyvvRiS"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso1381536a34.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784998355; x=1785603155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53aSHe40x/zi3T3K//u/DcOqizn6yQPME7XYKWDyEDY=;
        b=TPyvvRiS76z5jbB9xrVL+KBA2+QCUyH+ujjwOjmfAtW7cLJlmr0ysoFhbGQICgQ0o+
         spO7BX6ajf66KW7oWtDFSOrt56+QZDrx7QX5eM16In9y1vR9RrEC9+ZaXXTHc1nAig48
         BW6XCT3XoSeIrs1pAouKnRis+8Ea72Y8sy8+Yfz1BYA1/3xDSnkwDkJR3LhAut3jCPC1
         Ipw1RSrZbTO8xnK5so+Xs3nA0ELP80y+nAuRdj90VFMFfSrUUB43tjowbGevvXF93DF0
         1TqRATX59OxzVXfnfwMU2favsF5NDz4+pN8aMunPRp3hqqnTRt7kg+l2dYywfR8pwu2w
         Y24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784998355; x=1785603155;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53aSHe40x/zi3T3K//u/DcOqizn6yQPME7XYKWDyEDY=;
        b=l1GOT1tmzZn7DiQOxr19y4943flEOnAtPhwnX6jRmmpWfYtoqf7lglNgxhtSkRF5x+
         GH9iTAVX2dNo2CwsAj+q6ppK8oZbb4eb7+33zoIfpVeJPD8MEAcP3xB20I+qL68v8khx
         Vc1GaZVzj/tt2KibKCxfBkWqJj9Ai9mGQ2MSoNUN/6eUjhBXgDdvAxqUzKu0CBzE178D
         5mrbechIVyIt1Lg7uSlAcXZjFiByrYktFFasbjv+FM9dZNZgQsF1UBy9LU6Ssw8EI0AB
         4+6pQxFOBO/Mlyu7KS4ZW+mfSSavQu6/wsBchfdkqdzjd6CpnX0CeLNWUnKAh20hxbsB
         RiMA==
X-Forwarded-Encrypted: i=1; AHgh+RqHc5mhdz9h9MHxjpUwfh4kV5ie7KnR08XCZE1usY+rgH1iR21sLApx4zpFj7jUG2g9QqCvcx96Zxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU4T9GBUeIo5uRnTLML3N0xstrvgh9V07SGr3DN3eytLcbW8jg
	6eCVPOT0XyGxkJU2FOIUfCtEiD0WGicgtIDBGRDsV9KBe0JNOV2vRl3nqFLywqTll78=
X-Gm-Gg: AR+sD13XlZP5nWujOu3oK44FyNyCBZirgsrT5PADYXeDekH99HSz/GtfRtsq+FLRbnb
	esugUJ+vdZlU7Kz/S9NtDqJlamFp4uO9hKEkM7ccBbXb+Mz9MqITszJIQTuLc71ymStNmFkz+A0
	8R8nENnCZHfuEQCAoZ93CquMPc/CLaock0HxmkmZ+K1htZ/EOGkYneqimg3F3YysnGHBviMAyc5
	mWE6kWyzba0gXQ1g2SEz6uMSW4Ke+gOVqu6D8FmPyUk/oXvcCl383Dt6kjCw6lCwHfu22lUid9W
	9vid+9V9tlBFru6tvtUoKWkup6RiE8//uvVM/YroqIm378LehmqZDvC+F3hlGPjUD1E1R9quruZ
	U0J95xkvDSA+FSJJb4N4cTErhLlOXACW2HFN0epAt2KFnnGf3ZRYkfKayhCOclOlEA0hgHQjbP1
	Tkb1nDtiyXZTr2IZFN1MiCcj4hy7b0yIiGz15JHgEjuzKm1SzvNsYg+ALWe5TySTM=
X-Received: by 2002:a05:6830:6af5:b0:7dc:c7aa:22bd with SMTP id 46e09a7af769-7ee78c1b406mr2324932a34.6.1784998355267;
        Sat, 25 Jul 2026 09:52:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:677a:56dd:37eb:cf53? ([2600:8803:e7e4:500:677a:56dd:37eb:cf53])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a1087b3sm8708313a34.25.2026.07.25.09.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 09:52:34 -0700 (PDT)
Message-ID: <b138904a-c095-492d-9c52-cfd5ee10a6e7@baylibre.com>
Date: Sat, 25 Jul 2026 11:52:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: mcp47a1: add support for new device
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
 <20260721-mcp47a1-add-support-v1-2-da045a2567e3@gmail.com>
 <al_a_pbITuYMg0KH@ashevche-desk.local> <20260722083016.000062c4@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260722083016.000062c4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 1:30 AM, Joshua Crofts wrote:
> On Tue, 21 Jul 2026 23:47:58 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Tue, Jul 21, 2026 at 08:24:39PM +0200, Joshua Crofts wrote:
>>> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
>>> which communicates via I2C.  
>>
>>
>> ...
>>
>>> +static const struct regmap_config mcp47a1_regmap_config = {
>>> +	.name = "mcp47a1",
>>> +	.reg_bits = 8,
>>> +	.val_bits = 8,
>>> +	.max_register = MCP47A1_CMD_CODE,
>>> +};  
>>
>> No cache?
> 
> Hmmm, could you elaborate a bit more? I assume you're talking about
> regcache but I'm not sure on how to use it here.
> 
normally one would select the maple regcache type and add a callback
for indicating which registers are volatile and and another config
to indicate the initial register values after reset.

however, it looks like there is only 1 register here, so probably
not much point in that.

