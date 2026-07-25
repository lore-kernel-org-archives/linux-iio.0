Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308D3B6C1E
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784974655; cv=none; b=OpIF4ZHU+/m9oDT4Ja7ffDVwaKTXhcXI9r2N+SY77fJy9EjN+MyWitR2ZwbTAuEWUFnZhoLN446l3oe3l329URDwku1XobwKQdeNIyhup9iGU+p5Sj3esZ0Zoa4tz6TyMDJkrBixJEk2UDB9wz5YQi8o0enn+ELgTPoqPQoqxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784974655; c=relaxed/simple;
	bh=hUTIi7rEN+TKBmQFeMTDf1+g3Nll6U1TsXrepLKO8J4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoSIo6P0gb7rctGGfMoK0B2gWLDz6Emo/wJogyoKdoAzQ9ffGv0ovoB4az9v0lvYZnAx32jiislgGMMOHssD3Wit8p80rE276oZL6iQtG6L0N9Uija9DBFJ5KXuJe+m4VbMh3rWN8qQO07um5zu9D+dNsgooF4K8JpAsIRg4/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0fTqNT9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0fTqNT9"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495590dde14so12961895e9.0
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784974651; x=1785579451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ACsh7R4wzS0nLindz0m3mh8kPJzVM/jAPB4GBMMFA8s=;
        b=B0fTqNT9QyfapWMQztNf/O0DVzbZsZHT75GWEDmi9wrMh1fxujQmk6ZJt9jo55vdpH
         SEVOG7YPGGdQhjO7ItSAj+Bwi/M1GX+0LucOYVRpm3RULAeuO7RQSwGVyml14iGKDU/8
         0/LFzrP6+8GPRTE4+CePPjiQt+XpdCAcltWl9Dcidk4wTOsNDBnvkVnpG1BgAaQ6hlS0
         y1aRIfvpm9hL7xf8aQlLDNjDuuo9yQ5pelZAP31AJKSJsR1i3s4nUlaT09FKVQo40x8S
         olMa+ii4eiVULbgJ0In733tXuVWJfodWTHwLQL45XS86ijsa4OKlm3i6qWHw5QK4Mlxm
         Tj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784974651; x=1785579451;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACsh7R4wzS0nLindz0m3mh8kPJzVM/jAPB4GBMMFA8s=;
        b=IwBENlkqV6DbqU6OhlqFGICeK4i07Uo+mCo0qzLo+EDRZxnbR4n92f9gjgqczue6TT
         BmWTxo6mkO8x3i20tCTqkfYo/p48BIpc0NxPfuFo33e7z+0NlloYcLoceteyPfag0dmF
         P6I/96ehBHarrMcrbY33MeEbhmRWPuYKrEB8nSukvuL1Rcw4evih2BnWQRO0S1kQ23Uk
         PKP2g0RmDS0mK3lcmaJ4VW4QMN2fl2Whi1jmiTZfi8WdJ/qK11pUdun1KIdHb49Cftvo
         JfMN3syHebWmwkts1bFVqFxaFqxKeuAjJQxmPRdHCQSbNBALwXanF7gGsMT3MXs21heX
         etLg==
X-Forwarded-Encrypted: i=1; AHgh+Rph190McoOJcyudQiwJbq5bTykw1P1RT1hGczFc3gYJZdzj/QvajWqqG0Uj70kzcpOBZohy/5UYxXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiDnTy1MUVXrJRNdN1/ML1Wv5ZPJDJS1qZuag1VlVKI2fFZ+o
	7g51u/1nYKzSLh5ksUE7P0hWIIy/pFxg9VvlcRJ2LPAAe+vb1OcdU9aC
X-Gm-Gg: AR+sD10rk63W36mNiSDJCQvdK6eYTLGpPyr9TdzYTiFVOgIasTmLfnxJUpKeHde/e0y
	v/Nl2mc92yELSIeKWApN+hkIeAKaojm3qn4FJkgnwK6bMT5UsRDdecx+nKcUQPZki55JcPskYCz
	rJVfx9+wVhR2lqUSRGuhtiDy7RCo9+F5783nGz3qtp6bDU7d2CfKA9F9J8Tw46+FcXmG4RY+tS+
	kZ1y/FaRtqUaIdp4aXvjyzgglC2NcwTOJ0W0XMQ3Mv18BirZP6vE65/FEwRhVPq25nnx7uzEcLU
	nqAa6U46x8yjj0xl6kSdl6T5vyn6opoSskWJ8VR5j+2GiIwLJddmrGRtOHUUppZnZjVHfad7NAx
	1ANiX+qUYqswxf0ktK6RTajyhZwyvnygyyynGE+7fetP5YKtzraJXsMero8p0zbpq/MfR5i9RQH
	prcimS68vz0f4ojr9KQznKuK2zgqv2nF7QL3xP3lf4uS0r4lgPFToAwmzSCAYcyI8PUX33JQpUr
	K4dRXlG2ZTng4xl9fgYDlN2/9964y5t7Nlw+GPg6LUVALDGKMLOWeyNfbredvj3p0VdV9yoolnt
	67Wvm5+b/187jIrFX22Cie9hwFK9hd5GyAdWaTNOkv+6LEqBUdK2M8LF5elwyfaZz8ACbCvSmHU
	gVPPEcngy6Rs=
X-Received: by 2002:a05:600c:8b75:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-496b56e6efemr25132735e9.2.1784974650564;
        Sat, 25 Jul 2026 03:17:30 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b49a6e17sm57067605e9.13.2026.07.25.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 03:17:30 -0700 (PDT)
Date: Sat, 25 Jul 2026 12:17:28 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: mcp47a1: add support for new device
Message-ID: <20260725121728.17ddbc7a@systembl0wer>
In-Reply-To: <20260725001417.159653b8@jic23-huawei>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
	<20260721-mcp47a1-add-support-v1-2-da045a2567e3@gmail.com>
	<20260725001417.159653b8@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 00:14:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:
> Given the really small number of registers, regmap does seem like
> it might be overkill

My thought was that regmap is preferred over i2c_smbus_* functions,
but that is a simple enough move.

...

> > +	/*
> > +	 * This is a volatile DAC which doesn't have an ID register, instead
> > +	 * the value register is set to 0x20 every Power-on-Reset (table 4-1).
> > +	 * Any other read value at startup could indicate that the device is
> > +	 * damaged etc.  
> 
> or some earlier software wrote it and the all the regulators are stubs
> provided as they can't be turned off by software.
> 
> I'd drop this test - it is a bit too flakey as a way to tell the chip
> is there and working. 

Yeah, fair enough, there's a reason why it just reports it as dev_info().

-- 
Kind regards,
Joshua Crofts
