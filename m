Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662B43C7C5
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542976; cv=none; b=WcCYb3PPPtbS54XwXJaUkkrfwFieEeqbU/X7bVMfSVVr4oExF81VGUIjPYwm+fT0VAUQ2pq1QvORHLrptz0Hud1QCIKejRb2uMWbcxHsWgi80lszHF7IICpnV9lwtBph17nXhBS/fDlN83eF4oFUqHJ2fqc0uODv2Iu7Nih94Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542976; c=relaxed/simple;
	bh=7XwXCEUgLs/ry9XIbKiXILWO0PExOH56Z6lmRpa2MNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f55vGmrb9XRwnLFTidx4qIJQcreetla6e92TUYHqRgCMVEo/T1gbV1OWKiWYAaHum+Bt7DNb793rAdahDzs7ZkNPoin38d5Ecw7E0X1KaBeY0pBmJg1+bhf42pEr4Hu7S7PPFZ+D0sT7AOPXzg7Tpzn29wyKc8DEqc+yBGsi1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Xh5KqE7E; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Xh5KqE7E"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-48a0ca07c38so650817b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786542973; x=1787147773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqtgZPrbTPjWEphaUoJvnp4BZkkjRwOTw5FSn5BjHXc=;
        b=Xh5KqE7EUrMAR1FV5QpEARJ3CC1Ux0I2IsgUQU8OjOmuqMmuzQCaHosqJoIt40UWhQ
         qmsYHcfzKvzQiOmyEWbtInK1NJ+Kk0aXJBmZNi+GzVcWRY6OprhfffGmmicCIXQe9oE9
         KPMfUpBMg1X1vBhsp132RJqTOQCunv2jHL3FTz9Uk3QcnqPLvokvus8hz5LoLYJFSdGL
         KIvY6toP2MPYALQLRTyT+TAmMH6D4ywY1kdNsW8vI3YkDN6MikQ1ryf2iMGPs/CabVwW
         aqxWlvtY1gXDMg2FbyAZajE64C044r5hU1XtXpxjdO27f5bqr02axavt3NIaPNbg8aE3
         wB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542973; x=1787147773;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqtgZPrbTPjWEphaUoJvnp4BZkkjRwOTw5FSn5BjHXc=;
        b=FNdLEfHTBDgRxxyZoUdoOOhr8Y+JsMhoNncx0jPKydkq/VEMpNmmIhpwluThFPt/u4
         3fpGGg5EYuA57wWWeyaHgKWZy5vhlejPAJOD8Zn9irKT/t0bR1kfyZ4Cl/3aRRo+dCfu
         sBueUYVLHrDpW3/25i16BN4NqAcoKiRqXhfQDAFp8k8rkdwgeS4lk3sELEi7jEZTM5Lx
         0+rNjPIsDVTi4w5t3kjNyfRImBAsJxz60U5bmQ1XzQWm+0l3uMIeIGAtQ5H5gJ9kloa8
         nmy+ZtHAJ2xoLfl/AMVdoSoVO9H+GVy1OevJef7/ODc5JbHHkFOHKzag3/ON6y0Jl66b
         Qy3g==
X-Forwarded-Encrypted: i=1; AHgh+RooVx86M9GHEfVKovtEh9AKwDunokg8cwND4hjSzRYDKXFzJ+i3Jc4DqHgGZJx2vsIyEz04BACnSsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5WjKxzdp3iU5ZVfqMG36BbbBq47PaS8kSFQaxBaoOhizcBj/
	uPt6ySz/fIm7dX8SnyGfE26zXwR677oxAO+v+bXklV8A5iS+hQjvUoxghofwQI97Kg0=
X-Gm-Gg: AR+sD10hEkUa6eDRMCLYxuineo1IYeqGsCkNKARHMOfH726u8w3ZXsX6AeHTobd/VPb
	K43ZB9+Jl4RKp77mJJojwiEYNNjBHsKKswGqd5KyLufaU+JnqtY21NBEV97F3VC5VXbinWmfzsH
	JfUp2pJ8+2v7QaQuSVV8wwVr5EbPYSmk5J314vrlEkPiQHVXZcT6AtSTAAHhL28HJMAlfeuGImV
	NkweY5pmZW5wYJaCij2PPOziAXh7f4XA4x5UVNQk4K/3htLq7Dqk01IB2C4+8EJzIRpTMaR38Kv
	GYw4PalTqX6U3ETMhJSEMlSaVGkilX4hEMJPiWW9DTsbohelZDJM/mXFll6lFgRlpDg0snZScNx
	/bxtblLHt6o/bsk9H0dXXs5WxUHoQL6sMJjGwPBIuiod6itrE6tM4J3Li5aSFpms8tF3zcy+4lM
	Q+ZcFJdUM37s4hgVW2PuRHrW3olSISqnxBfvE8I8PC4JVitOQEeNQzBUwfw4+tbP+2zlEomwTSF
	wVX2+XG7Atl7I9cJHqA0ESQVym8OCL4BYaIOFwh0RDCKg4u4Q==
X-Received: by 2002:a05:6808:2396:b0:497:da47:df5f with SMTP id 5614622812f47-4b210bcf8e3mr4696215b6e.17.1786542972928;
        Wed, 12 Aug 2026 06:56:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:76d8:83ff:449f:8518? ([2600:8803:e7e4:500:76d8:83ff:449f:8518])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b200133de5sm3071945b6e.9.2026.08.12.06.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 06:56:12 -0700 (PDT)
Message-ID: <a73ab4e3-520e-4515-adaf-ed5ec644e5f6@baylibre.com>
Date: Wed, 12 Aug 2026 08:56:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add support for PAC1711
To: Ariana.Lazar@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 jic23@kernel.org, nuno.sa@analog.com, conor+dt@kernel.org, andy@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
 <20260728-pac1711-v2-1-609bc026093c@microchip.com>
 <a869acd6-9c77-4495-a581-232ca88ac9e2@baylibre.com>
 <0c0cc5addbb604187335cd534f68a9a7f8ce4ad4.camel@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0c0cc5addbb604187335cd534f68a9a7f8ce4ad4.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/12/26 8:34 AM, Ariana.Lazar@microchip.com wrote:
> Hi David,
> 
> Thank you for the review. Please see my comments below.
> 
>>> +
>>> +  microchip,accumulation-mode:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description: |
>>> +      The Hardware Accumulator may be used to accumulate VPOWER or
>>> VSENSE values
>>> +      for any channel. By setting the accumulator for a channel to
>>> accumulate
>>> +      the VPOWER values gives a measure of accumulated power over
>>> a time period,
>>> +      which is equivalent to energy. Setting the accumulator for a
>>> channel to
>>> +      accumulate VSENSE values gives a measure of accumulated
>>> current, which is
>>> +      equivalent to charge.
>>> +
>>> +      The Hardware Accumulator could be configured as:
>>> +       "vpower" - Accumulator accumulates VPOWER (energy)
>>> +       "vsense" - Accumulator accumulates VSENSE (Coulomb Counter)
>>> +    enum: [vpower, vsense]
>>> +    default: vpower
>>
>> Why does this one have to be a DT property? Can it not be switched
>> at runtime to accumulate one or the other at different times?
> 
> This property aims to specify what kind of hardware is intended to be
> used/available for the user.
> 
> There are two main cases here:
> - the user wants to measure also the current/power consumed before the
> driver insertion (e.g. from the boot to user control) and if this is a
> runtime setting, the hardware accumulator will be reset by the default
> configuration the driver starts with.
> - the driver does not know what type of hardware it's dealing with. In
> case the part is monitoring the charge/discharge current it does not
> make sense in user-space to change the accumulator to calculate energy.
> Same if the hardware is intended to calculate energy it does not make
> sense in user-space to change to Coulomb counter. Changing the setting
> from one mode to another will reset the hardware accumulator inside the
> chip. 

These are good reasons. I would put more of this explanation in the
binding description.

I also wonder if we should try to make the naming a bit more generic
so it can be used with similar devices, like make the enum energy
and charge.

And maybe call the property microchip,accumulator-source. (Unless
mode is describing an input pin, it sounds like configuration rather
than hardware description, which raises eyebrows, while "source" describes
how things are wired or how signals should be routed.)

> 
>>
>> Also datahseet says it can accumulate vbus measurements.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - vdd-supply
>>> +  - shunt-resistor-micro-ohms
>>> +
> 
> In the previous version of this patch series it was recommended to drop
> VBUS accumulation option from the supported functionalities because it
> has no practical usecase (other then maybe long term average) as
> Jonathan suggested in the review for version 1:
> https://lore.kernel.org/all/20251015-pac1711-v1-2-976949e36367@microchip.com/
> 
> I will readd it if it is needed.

No need. The reasoning makes sense to me.

> 
> Best regards,
> Ariana
> 

