Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221494119E1
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926645; cv=none; b=epwxZHNJFtYafxueY3pKRYhIyVXYaRXQ7K1WlHlBvThVuuq6a5+3e+puC5W/gK0YTdjq8rudO4VAsTMWPzcLwjn212aOxljErF0AYQatybaJL5WgoHk2AAv4bQhjneAY/wUdNQLK1yjACB8oIoKOp3ltP9fHX2uWcPS4PTgIyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926645; c=relaxed/simple;
	bh=kOzzU32X9/PNXvPM6fEKQC0SzZXvwYsoB1WTyLjbZto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dok5+H4lmqcyEeSBI0BfAKRs99I+/iC8iH9Jb5qft2PKRN2thYENIdiHcuZ/dqKcciMK8doMcWSbNv6nfK8sYRiu9kJOS0TiP/4rC1s3AUvGXC8K0aV5kGEos0Omk+En1wfyMaND95FX4O8fCdgolz31BQQLdovTmVK4e051dxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7KGAINz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7KGAINz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso2689636f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791926641; x=1792531441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxJ53/ktAmv+NVuDjuFLPoxmZqnRHE1xVlMVYxWYBVY=;
        b=r7KGAINz3nUrm3c42AY/Kivfs5lpiBoNsnXPNykr9L0Xl6V0VloyL3yC4DrdKhgQfM
         c+45CMN4Kl5E0OEEBSfWfxzDwySbD8y7QAEaCLtZI3AUxyNCYdU7j0xWlKJxqvhK97nt
         tYbRzSdIET5h3MTfFg5ePu/zHLPTQeF9vMHZGtv9k/FfpchNRBb2mcf0WCUhTxtX2HcZ
         ACeRcNz3QxuGVuH0lCnnfag8uuof4jSrYsak7LU9s3IPvpxUh6PDCpQjdWHqdaUB15/u
         rLpwjVqdrL7DlRRDfW3UmUlmXo9rXBj3CMmlXnTKFwCaypfYu4xXt8mmeXWaLP+AguZ7
         /jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791926641; x=1792531441;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxJ53/ktAmv+NVuDjuFLPoxmZqnRHE1xVlMVYxWYBVY=;
        b=Qd8BjWnSiNglr7i/EQe+e7WUgcu3oUf1P7mqF9eITWLdvOEM72D0wWIndeVUsJv2sG
         k081Np4fLFjt2gaMbZpkJ6Uw8RJtXsIze4oXkvSe6/FrRM5Uza/kkKuCTnpZXXmd/EjN
         cQVuXgL40/IBX2PXjNLeOgjzYAKu6/I0mSVjgcX/Lm8/KGEZcHLkcBU86Ct2x5SjrbbS
         dW8U/dby2HpHwiEbTgJkCbCtRVaFnc3J0tnG8JvOYvI+55rLX5hsTduqy1vBok6SqmLS
         Ubhzmpf1gdYa2nRmz2brcIVCIpqbQi8bbFTNjGrwy3kJKHxIrMOB1V6w75X9dRGmXwRH
         lnxw==
X-Forwarded-Encrypted: i=1; AKwUvByZRxrjb7VnlSBv6ihdfcSmY6Uz09z41WetfTEEQ570PwFNe9Gct1sUBDcZmdcGu6f6RhCAB4gvaEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9ue/h27KZOb2kNLt3BMsNoKAeo7p8hLaASirYFjVlrgar5Sto
	WrZ4wYypNt5MIQ7RQVhaGKe4Hx8FTuZfEZT1UFqtuMeJ9K0TQ6SmP2E9
X-Gm-Gg: AYBFou25yOMbzmawvL0vK7HB18sxJsAu+RKCMo5yd5n4thKIzwvfr/WsnN6z5nUtNLP
	a2AqoVhwRTSscgpljTbohrfMrdMMJEu73+lkGUAfKs6da5YhCbD7/eiLhIHZS/upf6+m4IsHh+1
	FssGxGSqY0pZyhSD1h3hgjW8iwfWBtYM6IK7MAEh6/1s/KqWR8ZlU4wy5sCLoeEP5FjqiOAwQ6d
	jvp5c3BDxulcvJkvT1h3v0r+4TkMcTlwYyiNrnzXPK9DmmCFPJcpFLFN80lipQ4qGzteLNKtP+7
	5M0UTpjkpVfVZ1rTntQk81ykglUsIUkmBP1s09Y4ME7PTCMxn/bSECblkOYuLknLFf1vz8G5AtF
	7xlDz0eJIKh5GoOiATq3pj+TgbVrrRLsF/npAacgDWX0ySEBVssCe7f6Tv4iXqE/6yF+S2fSSRF
	INLFLxCDaUeZdVRuykfcUfPePOv3IdDn7S2coD/oqTVtCmRH8ymHIc3d+w2SyAcajggg==
X-Received: by 2002:a05:6000:2905:b0:48c:6d9d:9f90 with SMTP id ffacd0b85a97d-48dba9d0b47mr28843597f8f.26.1791926641185;
        Tue, 13 Oct 2026 14:24:01 -0700 (PDT)
Received: from [192.168.1.18] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac5265sm7840541f8f.41.2026.10.13.14.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 14:23:59 -0700 (PDT)
Message-ID: <11150412-3b60-4eef-90a1-ebbb1b6098fc@gmail.com>
Date: Tue, 13 Oct 2026 23:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: light: add as7343
To: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Shi Hao <i.shihao.999@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
 <20261013115639.167433-2-marcus.yu.56@gmail.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261013115639.167433-2-marcus.yu.56@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 1:56 PM, Chang Yu wrote:
[snip]
> +
> +  reg:
> +    description:
> +      I2C address of the device (0x39).
> +    maxItems: 1

on v4 Jonathan said "Might as well specify it as const given it can only
take that value. They you can drop the description as it won't add
anything." v6 still has the old form, looks like that got lost.

[snip]> +
> +  interrupts:
> +    description:
> +      Open drain output active low interrupt pin.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  led-max-microamp:
> +    description:
> +      The driver current for the external LED connected to the LDR pin.

this wording dates from when it was ams,led-current-microamp.
leds/common.yaml defines led-max-microamp as a maximum ("risk of
hardware damage in case an excessive current is set"), i.e. the board
limit for LED_DRIVE, not the current program. please describe it as a
maximum.

-- 
cheers,
jose a. p-a
