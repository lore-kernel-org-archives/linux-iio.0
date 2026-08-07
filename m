Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EA377541
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134504; cv=none; b=a9J4h4S4JTLW4+a937+Hh7z/+wgUEZ0cBHNmtXOu6cUYFDr4TazWRoTRHhpBvCcVjTWVZBRNRbIcOogLZzCmoZrznxqTN3HIfVqK4fgFOkMQ7y3csi9KvnUeqVSyJ6tIhRh/xP8/GNf+uCLmE2CbdtmMnJaO41YVSH6Q6+c4Doc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134504; c=relaxed/simple;
	bh=z8tuJw/2y8S5S/LwSCjwic0uw+zShe6nspN74OWp+SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXCn9inkM7K2NOfAy92jlhW7x7+PfFS3InP+eHnSf9BkMD/VSp0vE8QwEbVaxri4LRO47HQMxy8icT13HHc8y4Oo/jgoCUYy5kitIaWlHA2vE2E8DCXZxhEGRMOxs1zkbCW0H8aD/XdKsFUbDKpK3J192C8xX+zaC6HXEfKQXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HvT0/Nk8; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HvT0/Nk8"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-495b98b4f6aso1431267b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786134501; x=1786739301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B17hNVNz2mTOaFga/vR1xcCKv5sx22R9oiNPrYVzrPE=;
        b=HvT0/Nk8xWh8uq+ao/VJfilHQ+7r0pbEoOm4TCU88nntbKlfO1E4H9iWk1+NWLAJPO
         xZktLCbpOvIH5a+Jq/MUho+6Wp1eyKO58XwZk/SyETt4XF+l0QJaar+ISrNX9EoEiu5y
         lacDKagntI8crWAEaATyuCXKV1zFWgv0Onp0QN5PvPeQsB1ttDryrV1eMib06yfNHUAz
         SwHcp1TdzSMpC0SW1e7DCe4hqWljzfMjDVtzfAGojLiuqRvKBEbGFtB+a0zW1HdePHft
         1jcoyYDxm+G97Kbn/oquZWfUgQOfCnESjZhjFatNh0gPKb6ZHHV2fRbHgf+gyU1P1x/r
         zJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786134501; x=1786739301;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B17hNVNz2mTOaFga/vR1xcCKv5sx22R9oiNPrYVzrPE=;
        b=Ap0do03ndCmH6xHGlmE5YKwD74K5fjCt280hWkAeEIV4fEXDhCqJ8N6E9BuGMqrunu
         7Q8iaYSsdHPwIV51HiXTPzswrs7kSeHUBcq9HuB/RbWJ4PPeLQyJ8jPIeTM0dNus6XfC
         WA/wTpfCjRbffaE+bbfd+H/6SOdM8V2fShLsyA7XIEDwsg9l+BV33B3ew2op3ZCQicvW
         1aRCKtijiXPGViKaY3TPwgA+JlKbVUhxc7bTskc/sO2dfxcD8zUGrXmJGY1PFiC0N8mw
         f8OdSZRM59or9aF/Vm9+TChkap3dvtKtakjv1kl31CccVyCR49XUu+sXyqLgLLc+d4l5
         qKvg==
X-Forwarded-Encrypted: i=1; AHgh+RqcfU1Hsy2w5usi2/naTm1KvV8YeaYj33dOM7UHLHDv6OmSF9Lfa4uEPkjMh5xr60DhNOQhW0rMK+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZW92Bv2bHHrmHs8qveYWlKfjFTUMc8wKL/tx9fniDSpx/loyT
	anbZzX3jLa5FjWZGqIuczELOTHiQkLA61BHzlwk1z/3B0eJGeBIkxlToAHPCm0nKe5g=
X-Gm-Gg: AR+sD10sd9hJHinDhT5zUCKd5ngHM7GriapYOHzj7sHVgqFvMoavkX/V/NOb3T01Ol9
	4C8z8tFIfZZpf0ljK1M0190jI+TYwkOzQOZWhY8w4RfqmhEwCaPz/pu2rJ0GI4QNz84viaAh0qu
	JFHtsygNzEbZpxQ24e7HDvK0vNibQoRYjCwU5AQ/rFzSg3H4KCvSp8224AqRfwqBqWayjjla2ae
	b39yWdqAu00sX1Clp2ut72k4HGsmGeX7eWHKIZjGcwOGP6pucditDbhewRqdN3m2RY3U7LuUG51
	UYThh2Qm98fdYdoZsZp+BDhYzNmNqys/O/pzNskb5Ez/NAC5/AQQAbveIJEcB83rAvJgqQGSMl4
	SGP7Dfilvc2sWlglWksV2AuTYX5dtXnfgdFQnsRvik4PORII6vPv8uOD4XOpx6k+3TkXZUE42E9
	r32zueVmuNKd1KS0FZcwEBK5kGjRU7VMg1PrRPh7c6xvxouyP4Adp86JEYHsR9byYlTeFi4mAXC
	CFBkdahV3P99ZnAslkBi50WdFI8FaR8ei1o
X-Received: by 2002:a05:6808:3194:b0:497:e7e2:756e with SMTP id 5614622812f47-4afae0690f5mr13069938b6e.13.1786134501439;
        Fri, 07 Aug 2026 13:28:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2? ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e4fc0sm435744b6e.11.2026.08.07.13.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:28:20 -0700 (PDT)
Message-ID: <05956c9e-7852-424b-bd40-fa61f699151d@baylibre.com>
Date: Fri, 7 Aug 2026 15:28:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iio: adc: Add support for Texas Instruments
 ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
 <4841976e-ca36-45c0-a853-75c647bf8a79@kernel.org>
 <a225f41f-b13d-427a-b0ca-734267a8cc3f@kernel.org>
 <CAF7HswN1JicdLv4DLBV_baELq2heSedsGKvwWb7KvTUm7NkcFQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAF7HswN1JicdLv4DLBV_baELq2heSedsGKvwWb7KvTUm7NkcFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/5/26 2:44 AM, Kyle Hsieh wrote:
> On Wed, Aug 5, 2026 at 2:46 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 05/08/2026 08:43, Krzysztof Kozlowski wrote:
>>> On 05/08/2026 07:38, Kyle Hsieh wrote:
>>>> This patch series introduces support for the Texas Instruments ADS112C04
>>>> Analog-to-Digital Converters.
>>>>
>>>> The ADS112C04 (16-bit) is precision, low-power, delta-sigma ADCs with
>>>> an I2C interface. They feature a flexible input multiplexer supporting
>>>> single-ended and differential measurements, a programmable gain amplifier,
>>>> and an internal voltage reference.
>>>>
>>>> Note: While this chip shares similarities with the ADS112C14 (currently
>>>> being upstreamed by David Lechner), the register maps and feature sets
>>>> are sufficiently different to warrant a separate driver. However, the
>>>> DT bindings and channel parsing logic have been aligned with the
>>>> ADS112C14 conventions.
>>>>
>>>> This initial submission provides a minimal feature set (single-shot
>>>> conversions and basic DRDY interrupt) covering current use cases.
>>>>
>>>> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
>>>> ---
>>>> Changes in v3:
>>>> - dt-bindings: iio: adc: ti,ads112c04:
>>>>   - Resolved dt_binding_check errors by removing redundant $ref for
>>>>     standard unit suffixes and fixing YAML array syntax.
>>> Yet you still decided NOT TO TEST it before sending.
>>
>> Although after further looking this could be using properties added in
>> iio tree, thus bot's report about failure.
>>
>> Well, if that is the case, that's unfortunate because if previous
>> versions were not tested by you, this one cannot be tested by the bot,
>> thus I look at this one as also untested.
>>
>> Best regards,
>> Krzysztof
> Hi Krzysztof,
> 
> Thank you for the review and for following up in your second email.
> I would like to clarify that I did indeed test v3 locally with `make
> dt_binding_check`
> before submitting, and it passed without any warnings on my end.
> 
> As you accurately pointed out in your follow-up, the CI bot failure
> appears to be
> a cross-tree dependency issue.  I apologize for not explicitly noting
> this IIO tree
> dependency in the cover letter to prevent the bot's confusion.
> 
> I have also just updated my local `dtschema` tool directly from the
> devicetree-org
> GitHub master branch, and running `make dt_binding_check` on my tree still
> completes silently with zero errors.
> 
> Best regards,
> Kyle Hsieh

I already replied to the bot message before I saw this thread.

The problem is the base-commit: in the cover letter. I'm guessing that
you did `b4 prep --edit-deps` at some point and pointed it to something
other than the actual tree you are working from.

That would explain why the test passes locally but not with the bot.

