Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8E4E73CE
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676652; cv=none; b=Hy+Ggst18lipEZKx0zJXbG5Rkuw7avuF+xpusuxdrxHX1QS6/y1/pDanQDhvsxKRQB5fV+n3YrMQJbn6iOmDhC1O1Ku/SJxgA2p5yuQ3+rRUVQGSx6Fjv+I2e2hdj7kFvAU9Fd8lxv0zejgRQ+/XEdSQMdIqeyD2DlYvk8ZlVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676652; c=relaxed/simple;
	bh=Yshl8u41lsc1ZIeHhJ2AbGKqFXfjn1ErfK+AnH2JZhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opzvW6PR9IxDCKXkZtk6a0OKfLMgrfNzQ3ExZu/z0AM89Q6by02UgXiuSkJ7/dkNI2EhU7+RnhWx9eUSilbHtwBMWNxBxlSZAPNW4y4buhO4EXeIsCZmA6BP2VMw1VyWLFTLURjpje0bthwCl5GmSClpi6d/82MgUBod+HjY8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlHyg/tC; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlHyg/tC"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-46adea418f3so14719fac.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 13:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789676648; x=1790281448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7itKtlTYX9R4u2oxxBvlnWOsxUd+L61slFivLar7yO0=;
        b=SlHyg/tCnjBT4bNqKfdctuUKg3PNK4VRwtv+XOKJb+p/MiBn9JHL57ngJEyl94zd6W
         SkYQ770KtLFlHptt0zVrylWjVMouOMemyiSlnzx+6E+Xv4emRQWKXfeY9U7IvVEz8g6M
         fMur1/WOEpk88HV3+5OXMUr3LZ5HivlAGRRV4POo9ccopM7YPON0EzscapHZRrBukins
         SIHL0Ac13Dgevq9U8rzWw4OYYKx3s5Wq93dOkSrTUEXBwq9+Z2S4YWpu3BQDaJa4jBCg
         /Y8iUPGJWrjgubjUzpl7I8wVq0U0EHszkk+KPzcJ3I36bG+5qUW5okRPN9IgSbN5UlNw
         QAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789676648; x=1790281448;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7itKtlTYX9R4u2oxxBvlnWOsxUd+L61slFivLar7yO0=;
        b=PnNRmsWeCZjg3Lf+1/DdF871rq5Joyy64O2Y8XuoE4fz8AeaxAeFGOmVzomQ00x3o+
         Wmva6dq1X9Ndux81qbycNhtq376kJEqqyvu0TFz5J+2hBUg8cuhnaPhwRwbGnb283352
         5SEdtrq2UkmYIFXDZ+FzmMvcQ4O1Lheta3vb1/weZakBi0oG1/vTJmXTRhWLSJVNW+1u
         eduqM/pNPncnwtBQe6R58M3HA/BWnR2FPpEP02otPXOIfFMaj2bZw7LXHTnuTOGwsxon
         pDUPbr0tGAjDxCDkW67p913P0mEKcxIK2cOSGrso3z2vroFUsy9nBVpczUCGVyBKr+Vq
         s9XA==
X-Forwarded-Encrypted: i=1; AKwUvBwiGkf6YdReg4q4hGiLd9qvQm1XebIAv4gA7F+SRRxHBlu8A0il4nVZ3utDdb/k4i9QgcMtpuMJeEM=@vger.kernel.org
X-Gm-Message-State: AFuF++mnhQfcQx3TggBGOe8Nrx8R5fAFaHdt//Z0KHSAFviQL+joPDr6
	oe8SYw4SOGF9nlGI005fxK4yFsw7hYXas8akB9h0qYeCTFfbQi19MyxT
X-Gm-Gg: AYBFou20jwW9Nauf4HDMg3GGPlZ3HoBhRPhjHjEMDJVmX/cvPN+A1kJpHQ3EhL0M6Au
	w8Hxatutt+KG5edbIeaiSgD31vP10JuXXmTvlQqk0ZQvMVHy65Y0//GzVw36jJJBMSTL93sgwKO
	7+NgDsC9kQLM6Lntv1mzL1S35jblSmFrjw5fOwmwfOPRmwbivBIhdGg0Prp1K+4t9XRFHJa/XV5
	sIs2ALyLdUYdBdlp0nQXkkDSiMTmAn4QsZe6UnK3oQpHniwInhOdKtxV6qZeSPQCGlZBFh6/7IR
	jGvb059y4FaVCYI4ebiJma1iuFF3FrZQi9SIuh4S0sVoztFQQ8t2B0ACIxe3Wj/X6s0Ux6KlVeZ
	BhAnM2z8XT79+KJa1ol9w1amSS+alXW2QLaBxyu44I9wjLuW6rKGaOotphRjnpAmMVMcYetSymw
	pfXKZVlOYKQjB8DguALp+aLTicS3r9y9pMd1XO7Pk80LyleiSNoet/z8gNKqK7UYboMPwjl1HQS
	tSw1d+PPJyR+vI=
X-Received: by 2002:a05:6820:2219:b0:6b3:5475:4861 with SMTP id 006d021491bc7-6ca9aa3fb5dmr186014eaf.18.1789676648385;
        Thu, 17 Sep 2026 13:24:08 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f5cf48besm3802412eaf.4.2026.09.17.13.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 13:24:07 -0700 (PDT)
Message-ID: <2d1b80f2-53f6-4ed6-81bf-e35c0a9efb26@gmail.com>
Date: Thu, 17 Sep 2026 15:24:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: adc: add mt6397 PMIC AUXADC support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 mfd@lists.linux.dev, Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
References: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
 <aqpmgliQW7FW53o5@ashevche-desk.local>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <aqpmgliQW7FW53o5@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 4:50 AM, Andy Shevchenko wrote:
> On Tue, Sep 15, 2026 at 11:15:25PM -0500, Ryan Brue wrote:
>> The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
>> reach. On boards built around it that ADC is the only path to the battery:
>> the SoC's AUXADC is wired to board thermistors, and the charger ICs these
>> boards use have no ADC at all, so without it there is no pack voltage and
>> no state of charge.
> This doesn't explain why a brand new driver? Perhaps we have existing code that
> may be updated to support this device?
I considered adding mt6397 support to either mt6323-auxadc or 
mt6359-auxadc, and both had problems.

Both mt6323-auxadc and mt6359-auxadc select channels through a request 
register (1 bit per channel), while mt6397 uses a 4-bit numeric field 
CHSEL in CON1 (10:7), and then pulses a START bit (CON1 bit 0). That was 
the biggest reason I made the new driver.

For mt6323-auxadc, which is the closest I could find to the mt6397 
(CON0..CON27), it has 13 more registers than the mt6397 (CON0..CON14). 
It uses CON22 for its request register, and reads the result value from 
the same register as the ready bit. We don't do that - the mt6397 has a 
factory calibrated value for each channel at 0x16 higher than the raw 
value. mt6323 also has a 1800 mV / 15 bit scale / resolution while we 
have 1200 mV / 10 bits. We also have some per-channel preparation that 
we have to do before the burst, that the mt6323 doesn't have to do.

For mt6359-auxadc, it has a more generic framework for describing the 
AUXADC, but it assumes requests are channel-per-bit, and so we would 
have to basically ignore req_idx, req_mask, rdy_idx, and rdy_mask.

We also have our own software sampling, which the vendor does too 
(Amazon Fire OS based on Linux 3.18). We'd have to have our own sampling 
callback to do it.

I drafted two other versions of these patches adding mt6397 support to 
both of those drivers, but the differences meant I had to add a lot of 
extra boilerplate to each driver and to me it didn't make sense.

In v2 I will add the justification to the cover letter and commits for 
why I chose a new driver.

If you'd like me to instead send the exploratory patches I made adapting 
mt6323-auxadc or mt6359-auxadc, let me know. I'm fine if it ends up 
seeming like we should adapt one of the existing drivers, but I think 
the mechanism for controlling this AUXADC is unique and merits its own 
driver.

Thanks again for the review, I am going through each one, and sorry for 
the delay. I'm rather new to kernel development.

Best regards,
Ryan
