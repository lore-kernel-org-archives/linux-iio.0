Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD8347BD9
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157112; cv=none; b=auTU5oeQWcFVPEFFClbN5sSbJuxcjTcNGdGK/fhrLcunbn0J7V2TGeGTiVNJJgNK9DAUR84Tp4wf61duXsc1UwGe+tjycWEUUdcSEb16tWD8kjcZYhljzNNBgBVuJ/GK2cVdLVEZiRbpvc90Suk+R1q1qtOnHBBCRD+sVMnpwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157112; c=relaxed/simple;
	bh=lknCrpWSUnG2slkL+WFUZQOuRhKIj1k8zp3ZG8RMUcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ka5k/HyQ0jivCLbykcCuOBNo/HkEOdGHaWS1c8IPFaepd6uFyx4pOq+G5zUv7wxf42FT5WV290E9AY476uTnUaTziOOyefgA5AJ1q301fADXxqG72xFUsyGZ3sTGVqpIm3cLBBzun30/A3nH6Q7rZPjmZVF+VW0KXpC7m0iP7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=K6kAgr2X; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="K6kAgr2X"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e943356247so2309849a34.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782157109; x=1782761909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gax4TQHMEysxfgOcDqf89njSaGBEez8kqfllKRVchko=;
        b=K6kAgr2XLdxQ32UdqV+UyHCvlgX3OWEv1FUHFSgL3gz1GDILKnDBC3N8UYqETwtOvb
         Oc2JLf8OXNVEO9T+iHKWXQ5TZj+W8/I5S5uavtsP6IXIwFxvarjYPcA+YHbEW+wdCGgt
         AQRJqH96KwIctZ5FHFqtIXOMfza25VUOLC9JkVgU6OO8dwiye1lZzcINXjgwGbIImCBH
         ziZ+utpybLSeSl/gARX4Ru2Csv8f36525VGrCzvIK1x1D3zrEsmbR+ttygIDk6WORd4r
         l0hHyoKg2quQJFnYFjHiFKLIozbrFbedb6chG2BxAngnmQenz4Xp/DiPqKheAqZmTVdu
         gchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157109; x=1782761909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gax4TQHMEysxfgOcDqf89njSaGBEez8kqfllKRVchko=;
        b=brGBzZdQPsYrw4nqVlY2fP8zaRqVN7DjyRFo23UtGFSbo9oPrhJGY232w4sdfnCXZE
         OPKs6Sp8ALfheU6vV2w4JuAW8R5HdYHcGWegh4eQoQfPcKPLoAR1fqAoxOENCoLcvSL1
         YXignNYYvkD3my4zB21VPm1l1e0BZwGlauCftAQ9QhD8g3W6dW5zhaAqDavz23PHfFex
         DmHxnSr4VGvNWcc3FMMG4Ze2mkDWhlZmh+shQgi//ZzCY0Q/3NHLF8wzRFC3OU8wXbHm
         lwnnOxpoan8lPHzOO/TmnG4hqMMzijQ95H++u5sVvEvugbv4sHjrodaYgd5BLYfy7nzp
         r62w==
X-Forwarded-Encrypted: i=1; AFNElJ+hyTTpt0F5A1Epk7NQR3aI/yfhcPhY+tpo5hG0h6/d92Y1ltl6VoLY2YQsdNX5MqVoHo5IdkFwF6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9t/trb/LR/QS+W5jT0w1Me79I9eVtK1r7olSWgSh7DyxnUI1
	uIb86pwL7Q1UuZG3Odut9n6tZ3DmHDkqFhFtQQUUC5tCgMVOMU2dH8IhRSB9KvHFXTQ=
X-Gm-Gg: AfdE7cmYRaoa7RiugtmjCsx/utMQ60+6jWKEnKyP0KnpPgfy2tVZg+cx8m5yaCEcV8X
	8VM8P00IrB4l8CLu+3m3yBpfAMs9oz2CzDOonHrZbsZyVGsH5OxIChdZQFL8nZrVmzZSlwEvzGy
	Ilt7TLILx/NcENauY8XjDeGQZlv6uihwj52sVfiauKkF0Clr1I9q4o52AKLHJNDIYJKvu2NLgTf
	YmW39CZe+K++Cl1Os9ubxC+gJVfBGhAVqF/A+jIWX4jQfZd+i/en3XxZtPe5NUBw4FVT+r++Db3
	Ho1AwsF0RY2xx6FlimOK98EtIbRWPfyzQjDv7zxldLPxTZ4qrdDCetH3yqAQS9Vo1uvdYNoy+3A
	/PLuNhHtyYvbxhH0JWK0XGfL82xP4ew2qAESABkl/Zi4HehPzkcuD/ombAcnBIq+AYphiAwnL27
	vPa04327JhzZtWF/dK++gXaozfJOy7i7qhKP55Jjy0Cjk4887UVaw4FO71fcZ8QV8=
X-Received: by 2002:a05:6830:3494:b0:7e6:e162:915 with SMTP id 46e09a7af769-7e92d815dd8mr13819644a34.5.1782157109479;
        Mon, 22 Jun 2026 12:38:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6526:8577:6be9:cb7b? ([2600:8803:e7e4:500:6526:8577:6be9:cb7b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94406d488sm7094981a34.8.2026.06.22.12.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 12:38:29 -0700 (PDT)
Message-ID: <42e544b8-f2da-450b-92bb-99c41f1c72fe@baylibre.com>
Date: Mon, 22 Jun 2026 14:38:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/3] dt-bindings: iio: adc: Add reference,
 excitation and burn-out properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 2:30 PM, Kurt Borja wrote:
> Hi all,
> 
> After submitting a patch series adding support for TI ADS126X ADCs [1],
> I was made aware by David [2] that at least two more chip families,
> ads1220 [3] and ads1x2c14, share very similar features (though these
> chips are not really compatible between them). After that, I found one
> more chip with the same features which is already upstream, the
> AD4170-4.
> 
> As David explained in [2], these chips are intended to be used with
> RTDs, thermocouples or other resistive sensors so they share the
> following per-channel features:
> 
>   - Configurable reference selection
>   - Burn-out Current Sources (BOCS) for diagnostic purpuses
>   - Excitation current sources (usually called IDACs TI) for sensor
>     current biasing
> 
> Given that these three features are present in all four devices and
> three of these drivers are still under review, my proposal is to have
> these features be described in adc.yaml and have this series merged
> before the three others [1] [2] [3].
> 
> This series is sent as RFC because I still don't have much experience
> with dt-bindings and I don't know if this approach or the properties are
> general enough to be described like this.

It will probably be easier if I just include these patches when I do
v2 of my series (if you don't mind me tweaking them a bit).

> 
> No dependencies between properties were provided because not all devices
> may be able to configure each one of them.
> 
> [1] https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/
> [2] https://lore.kernel.org/linux-iio/20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com/
> [3] https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v2:
>   - reference-source is now a string-array and now presents a couple of
>     quick examples
>   - excitation-* properties now do not enforce arbitrary limits
>   - Dropped burn-out-current-polarity because it was not general enough
>   - I kept burn-out-current-microamp because the discussion around it is
>     still ongoing
> 
> v1: https://patch.msgid.link/20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com
> 
> ---
> Kurt Borja (3):
>       dt-bindings: iio: adc: Add reference-source property
>       dt-bindings: iio: adc: Add excitation current sources properties
>       dt-bindings: iio: adc: Add burn-out current properties
> 
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> ---
> base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
> change-id: 20260618-new-channel-props-4fbd52020da2
> 

