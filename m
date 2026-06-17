Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597744D01E
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715700; cv=none; b=EL9gdXBSB86NDv5uU4+HU46/ksG+lZtRfGx0+lUYylbr63NlozeGLdTgpbhVlDe17Oy74U11T7yVu9kB5P2E6HaKnu1BJbmwNBfgjzg3HrPjBwK0OL1QKa55e5ncN5E3fy0vL34Feyz12bQfxCeMWyHWqbyJF9FM6QOfzp158BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715700; c=relaxed/simple;
	bh=uOfqVShp4rTgkLodBpM5FSKkN+Lk1utYa89HN0mdnHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GF0lalRFK4ox2BnHMq/A7E1t7AC/xshxIFcX95tFJuk7AZ7PNsq0MB1w54/1VJQOvKXHgptzlxv2GMoxFwZXzHsPge9yCW7DS8lY5cvVIXEV25qfkh3KeQmYQAg2z75vfPcRWZSAchCi8RPCrg0HjvLEEmbHtPQbnoHbOWAeQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=IApJScb7; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="IApJScb7"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43d2c7b5a6aso4943549fac.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781715696; x=1782320496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31EopIUrud4yXVejeJmXhjZ1pvvHw039sKefkDCzacY=;
        b=IApJScb7ELlG5h6TXBlHfcxSaUNZUGWxAlgiMpK2XRAhGN6oSa8JdMG/6W4i2N5EIw
         ZCFQUlPd547mX17OR0K2YwRxHqCgA4SgVCnclNFICBUr67sJT8X8o/XkxyJ2e4sOj6bt
         M1/5ByhdStASqzKW0oL9u0DuzOzkC7Vy9uAzprgcsityAA6yEfbAiSHdIdtRApzRsZP3
         mmsX9Pe7O7fGpopMg+YFHEQb27r2l3rtc/KMTU8xvrrS4OXohqoQGP33/otb/97z4vVO
         4hzaBMpzfmY2+s/5alVAhQuhItUvUmn/jpvVHQRgyuLZwLlsmtd9ynFRiYY//MB0JgTm
         w9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781715696; x=1782320496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31EopIUrud4yXVejeJmXhjZ1pvvHw039sKefkDCzacY=;
        b=qXnzpuMOa7XfhZjnKyJqywU2ikQUXtyJxt4qNUOKFR4jXRPJ13nngUaTmi65+uJndn
         02fx6E41iJuKd3NZe6sjx1xN1dPROUgdVUohu4M03rO0xkRpyxSDFs82OFXp6xqKN+4q
         eHB+OzwkQa23nTvftbHMvdauHQ/DOcPcNB3M3Dn4B+iYhkZpzNfFsduslgQ6/Vwx6lIt
         KvA346G8tGz+ZnlhOTkg67JftL+rFesU6ssLH3MIV7r0lJ2YdFsuOt8qY4c8AaGXB2WV
         xcWyuA1Cta70ah5MIpcRWh+zoI/NyGyGmmcTP4V58YzfUxX7YrBS4ooUpg72QRksZO3d
         SGVA==
X-Gm-Message-State: AOJu0Yw9irMSQadGeCGSGBBEvyL71XNKVXfIsxTmMvzTFnBZ18FoWWzq
	ygyn/SKZuxcZoXdsp96ZmwF7YXHny7+gxaAbaUG6WwRdDOptzCkXAhGELv8/EeXN7oY=
X-Gm-Gg: AfdE7ckKu2ae3jHnsx2DVuee+KrWtEA8jHZTfhSjM0AzlmfO2QHGIxrdw1mInEVREj9
	gyKwFzMYuf1iEZCNs7DrZPBo2Uo8LZR41RdIXOpHGrDmrjofG+2BqiUfelyspWrSKhvDdzGNPON
	bRKDIkiZTeU6E6U9Yoyxvo2/YtXVOT5weuAcIErbpjC5s3dznyqbufLlozZlq8K/p5lf0FNlQDn
	mDgyzxR90kWWxbk3OGwhYJFsdiEJqDCI5j3jOSSZH8DnGty7rsYfCuBUlyA4PV06IiihnOUk0rR
	abyYZ1bot8arXfiyd05rqwR0y5b67o05g/8eViuGcixA0qCu0GhfQlcuxaP3wARvEjO2VbfzNrD
	nkd6runpF2gjPeQu/4kKb8cIzm4nQkbXSEHXDqP5+QDnpSzBQbNwbJWNKBGkZ4gSCeBRHKLFjhM
	wZDucTq17AyjxVQeS/yFwB6KF3IlMFQNGC2PAgH76kWii/kikr0bYY90RQAj4Hm3k=
X-Received: by 2002:a05:6870:b005:b0:441:5ea3:f071 with SMTP id 586e51a60fabf-446df2866d2mr57930fac.12.1781715696170;
        Wed, 17 Jun 2026 10:01:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:28a8:6095:71d2:86eb? ([2600:8803:e7e4:500:28a8:6095:71d2:86eb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308b0149bsm4479478fac.7.2026.06.17.10.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:01:35 -0700 (PDT)
Message-ID: <e053caeb-7292-4c16-9d0f-f344adc41a12@baylibre.com>
Date: Wed, 17 Jun 2026 12:01:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: tsl2591: replace persist switch statements
 with lookup table
To: Caio <caio.groff@usp.br>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: linux-iio@vger.kernel.org
References: <20260617164258.9007-1-caio.groff@usp.br>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260617164258.9007-1-caio.groff@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 11:42 AM, Caio wrote:
> tsl2591_persist_cycle_to_lit() and tsl2591_persist_lit_to_cycle() are
> inverse mappings of the same 15-entry table, duplicating the same
> pairs across two switch statements. Replace both with a shared
> tsl2591_persist_table[] array and simple linear searches, eliminating
> the duplication.
> 
Isn't this the same thing as [1]?

https://lore.kernel.org/linux-iio/20260522182058.199762-1-matheus.feitosa@usp.br/

