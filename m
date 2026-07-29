Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387DB3C3C00
	for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361205; cv=none; b=Py7/k/r6aki4ROofHXiiLlABTAz3a3A6TDwzCVHjR+Nq2G1FH3XtP7XNkWGdtanXta+eube7t5vWbpK6MEx2SX8K/sduG9iGyLzYPHFL9zVmZxxh+J8ssQWz98hCFYmWuzoeXTUVauOJbWZ8WQc7XXv3v1KSwcWhVgQ7G11RXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361205; c=relaxed/simple;
	bh=9DCe5l+RMdzIky2GyIi+0Ksfo59MslthuX/VTCcR/ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAT2amjN/IOFxnDQPqsQ3g7ve16kB7BrwkiT2Nm72PbQujmjT7vJJ6/v9FrQoGocyh0vM5ZS85aNGn0mIwg3B+116z4h4UQhRPXGHJbrCKYhV6mmpjEENo0nN0tSplZVUzP0BaYtnEder7NofwWATzPreDyuQ7fGQYHjheFi9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=T2OrQg2c; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="T2OrQg2c"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43cce34c881so979764fac.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785361202; x=1785966002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1c9/5KPmcV+l1Jp7+hRXQDRlqBfhfCFzAoiMmQn8lR8=;
        b=T2OrQg2cE7xcQxnI0O4BydHj8yXfMQevniBTqiz965PkVMdnFKMb+3sBx5ZgFyllBH
         j/sMG0RimQrlBz9mrda+IWe7NTgyXKlWXT1EMLCbqIu+EvwdjDR4VLJRTzrCwoLwxpQN
         MaHbzeD1VdIjWnOgffDAgc64hYYBoQPqMOOa3mVtdicT8zHvNGRyzzTROP1XYlk0pFmc
         vmiKaTLmzgAK2tShCMxctpNUtQYqtWdq/vOCeB7lnEvdo4CPhhfUmK06sp0Y3J2Wyrke
         In51x6GHtD/J4N4FmVCgLHZfyix8CCUD3T47XMXivhCATBaFuWWwABjkfi4mJwLH9kB+
         bx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361202; x=1785966002;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1c9/5KPmcV+l1Jp7+hRXQDRlqBfhfCFzAoiMmQn8lR8=;
        b=WoQytnMjAI09m//zlj7OOkT22MMHwT6NFdz+k3cGJBznuqoXoqvNWWDzcReEahDW5q
         7yhLnRyPp5auW8xS9z77KqDNkg1+cYpHB0IjWMTArfAL2T9IfamvdQ5hgPsDeFAYAjoT
         PhjyeQb6+cNs1XEOu21gL0GJQzQmNIdrjIa1xT2mACulbactgqjVxCEzbhasGHjkaql4
         6fscnGTue+UGDSC7JEVxdIuz7I/bhSqOh5V+p1Ast1fuVLrRD4KZ6/HJ1v9crMKv1pJh
         XgR2zpxHYLU/wNHX2GHPgnZTb1PNfxNtj6q7ozXQ+KgLehEEdoeGy8BvEQlYzZsDHYVj
         SVoQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPshRvm55LqOZ3qd256c1XtyJbfs7GHuR3eMoxL8eCYOV7Lvhg38kfww4/iY5TsKKJftp1WBYyalc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgS4lpn+bSqYgA9FKfaJ5fj02CvWDpjhI0j/e9Nj6cW2+SE6N
	0NQdo1zDV28c5zRft8uyaMcrMNZHj/8JyCDP3ywRcXq/KnYT8ojAan/T6AsQRq7/iyk=
X-Gm-Gg: AR+sD13zS7sOVbjWJ3zqO6fYvp8d311ujPUiARgV2bDVA/oAZNo1qzuqRP5YwOdIdJk
	5xrOygsfFwpBjXG0nNBO7MXunNB4BdjmhfSWgPSA3KQX4Pep4Z/m5do3xGO6xHLifaGRgUVUCEy
	diiAce4qWDEBk2re5DcIFU7/xGv2uyWW5kVP6B7vxeo5opwZ8HnJF5koPt570i2Bj0fFSzmY0k+
	59wrfmaxAUjM0+sQ47hqrdRdmyePntjREaHedRL4WN7HDsYSH70+EGtAiyDL4+6AOtM1dYR3q8T
	vRKpX7qKmk9rmt3lrqI//t6KLrpRSsNx84VqV0lhbWcDDFhAoioUV/UPM6dIHfb15qXa1Eimgo+
	Al7l+lrwBU/BeUdKFe6a5rgH6hCiDgg1Ke1mu5TQO0CFRj3pN6Xaxo1Ki2I0tcHK5RNhGwcgjWE
	BThA9/tOgVIsOHrT+2jMRwlAHgBnWCqApJaEv0X9oRa0RDby0F4gIJ+QDz/EpfK5HvAF/kRHnvm
	/p6AmZjkNm9THU02/MhJhShsqJ73QH7gxyAqxQ=
X-Received: by 2002:a05:6870:8271:b0:448:9d5b:6393 with SMTP id 586e51a60fabf-458c0dc6a14mr63345fac.14.1785361202134;
        Wed, 29 Jul 2026 14:40:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ea38:c35b:7ec6:8152? ([2600:8803:e7e4:500:ea38:c35b:7ec6:8152])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c0df60fasm79258fac.13.2026.07.29.14.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 14:40:01 -0700 (PDT)
Message-ID: <ea9c043f-27c9-4095-9488-e81e0bbb5273@baylibre.com>
Date: Wed, 29 Jul 2026 16:40:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
To: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
 linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
 <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
 <20260725230739.63ff7000@jic23-huawei>
 <20260728-patronize-thwarting-56fab2e11077@spud>
 <20260728221719.7f668a73@jic23-huawei>
 <20260729-hundredth-suffice-f28afa67bc06@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260729-hundredth-suffice-f28afa67bc06@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 3:47 PM, Conor Dooley wrote:

...

> Only going to reply to this for now, I'll reply to the other thread of
> this conversation later so as not to end up duplicating discussion, but
> I am thinking of things like what if someone puts a mcp3654r and an
> ad5529r on the same chip select? I think that's actually perfectly
> functional on a hardware level, provided the fuses/pins are set up
I'm not sure this works in general since SPI devices aren't going to
have a standard way to specify the address.

For example, ad5529r has the address at bits [14:12] in a 16-bit
"instruction phase" while mcp3654r has the address at [7:6] in the
"command byte".

An ad5529r instruction could inadvertently be interpreted as a
command by mcp3654r. So I don't think they could exist on the
same CS.

> correctly (and if it is not, mixing the microchip devices is possible
> and probably mixing future ADI ones will be too).
> 

Yes, I suppose this could be possible, but I don't think they would
be considered a single logical device in that case. So would be
covered by the device@cs,spi-addr binding that we already discussed.

Example:

adc@0,0 {
    compatible = "adi,adc1";
    ...
};

adc@0,1 {
    compatible = "adi,adc2";
    ...
};
