Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCC30566A
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014336; cv=pass; b=Om9tUfIPoP2uROMmdVo5kPMxNBZgk+9XRif9AVJIqZZypRHx7zzyF78SYtO99nPgS+sbJ/NpmsWKG445jo4EH0wGNReVgcPEm3JkfJOnoi+xgBGXJSz4D7MXRcxMEl2TqNjJnU4D3HgbUBQBApTKZj4k4QdBnuW3fO6B+Gs8oNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014336; c=relaxed/simple;
	bh=n1P6YmaNGFDv2p6ZmM9LdiN1uTG6FS0M90BEV8DnX6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVtv4ezd55f/+aYV5z24UL9UXaGIoIFAz0KBQ5tgmKGABDkei77mkGkY0cneD13SsZ5fS6nIhSQxjzkZrSmp5oLQD65h3I8pdBC/QZOK1WyiwZFlKyJ0QkzFm8zQiqZWY2970+ptGMB8WwmXDDt7bZS3JkFNgrEXgu5u/Oe5lQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+fjeSaH; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+fjeSaH"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44e5624c053so610560f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 03:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779014333; cv=none;
        d=google.com; s=arc-20240605;
        b=BkvtSD/kmVziaCSq54X/wCwsLC/2Rw8PR0Izu4q34w8rUYlHuQgwnHwJmSyuBza9sx
         XyMcWHaOyoiNDxJt+s46cvdp5RexhNSiYWkanHWh/WK8F3QpvD96N8eDu3/1TjUXPQBU
         evY0QwMo1XS0APiFB+Yb7wo/tfe/DUcb8kT2rQ7QlQd0cc2VfcKX0XlpWJdyu51bhxmF
         VhNmhRWTjNPlWIFp0/ZMI2Eb84SqvDo1V760BccuFkqE88IGhoQLLnQT1Q2mhDtpPzwA
         oNsYJTIYYdoNyGHLflI/VKHnSupdEa48Bq5DJckOxPdRx7qK+RgmqKjCvWVfMqGmQlnn
         ifcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z060BpUY7G8SJfI+//kf48WLZodqLy9HAJiIXPtpuwo=;
        fh=ZznfJeFdQeOkaEa+9rKyQvHAiCzw7/SabJ+SipLJhHk=;
        b=OG3OBZPqdtGmOFlq3XvU7wCXw8jnAAZg8qgd1lbXKNtlnLzK+rZBwkqOahxFlrMjzb
         S6EdPKhyVWi1ZXbA5At2hj0zPAfdN7EHOp8naI/Pj6eMizxoplZskx6eO1jSLJ6w4TO1
         lINhOyDVqTIMbI8z0XHVR4+0paWeABlBnPdTydrQkETuAbilQYVTcSmn4rgz4Cqk44RA
         y+BNkrTS9c+8C/e/iGrbbRCGL/n9f4jpFCVsXvrSuUpDyq3ZBxjl82SiIM7SQ3N9b8jm
         kDMS41Dr2mwrTqW0LbL9PUw1dkU4NoGEAe9yGqGuYo0zme25AjUweJhaAqsdp0CDiveg
         PJ9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779014333; x=1779619133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z060BpUY7G8SJfI+//kf48WLZodqLy9HAJiIXPtpuwo=;
        b=W+fjeSaHXNGv7UMZ961qAjXkrePqdLamQPy2vEcVW/JKKfLQDkNvvwOiy2k2zmzHAR
         4Vw2J3RbNULXxu9vEl4PzCl58rX77+LvSD4nHqmVz9Tbrum+OJjMK0Y36dO8S07IJUyZ
         tDcT3OmQ0mC5WLU6vPNgvHh2X9WqLKPDyZ/r9OZFoYA1LelJ4PYRb8DeE8EW8hAb/JC4
         W8/r13jISSRttfozleBjKSveKIpqjxd0T7Zjb0rSo4QwQH4HLFM3vAOtEVvqo/EXk8az
         j/KgR/VeMrSn5LTx1oUSyXfCvSkZk0Jh6deDMqQC4UUAvb6vJZWHtgCyrVuUHbPoKSxj
         537A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779014333; x=1779619133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z060BpUY7G8SJfI+//kf48WLZodqLy9HAJiIXPtpuwo=;
        b=ij6F3tY46iSzaNBPd7Jt3ymdgnGqOD3mJzdwH5qpK5OXGM54wcOesNXTdheQrnusQF
         T6senm/T591a/X3x5IgUbffW0g5dw2tBbrUCv0yRhFUjq57CZcR8kMBxWMiKWebhG8fF
         a30pC8DCm8JSQ4InUZHtxgZkUC6XIWhWo89PgW9IoPcVnsCspJSKqB2sY2QxKu+717MP
         f5riR/nPBy0gYnUF22EDGCIiY2gR3ge9v7zKaMahNVyPsREeACnSKKvK3PRrbK4n3CiU
         Mp28Soo9QZuFqbkGuWcFa2Sdem7oaanRymYlAvMOVnMpmCImGCaf13F/Q+cSfd9g+fen
         qsZw==
X-Forwarded-Encrypted: i=1; AFNElJ++aASCN2HLeCH62hOATKSqXRL4/owbAYDwL8LKX4Fp4XI9Ocy6sdW2tFL1UP6/f1ff9OOxpVTdkjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMCxv/ECbYJYakfi5ZQzLUXuNEkxjcNfGH37hR0/sIvLAq9g1
	IIPuECn86UP3alPkshXaxn86tNsan+LMaztqRLMGAJMUjPcskDLkBDA3bVnLL2V5ChBgRtNLi59
	5t09QjpBMeIqOKd0XUabRc1SAVIUDQdQ=
X-Gm-Gg: Acq92OGmG4W4D5OlLO+cnmXHwbPSsEzVzgymZCc1SF6GHBoFoRIvNOav4c+IkQGRx8K
	I//plfBr1AvPjUG0miXp9IGWjczoiQRtSEM6IrrjjbMCmUNBpwW8rrZfnyTdvNNx0bojAaHDMtq
	H944OsFlopIeZtCgllbEnUXUkH7vWxealNyVbMV8k7tVDBRX8iz/WMr2mVl7CrExXBCVTmt4fKh
	GeO4g4avLP6wQNimn4sLuuIRh18vrllnkSt+aIromblE1EL7bZWaUQQPZLV/zQhtFru/CG8G23k
	dcyd+LUhB2hvRYVIQzFgkZb6S8lWQFB+wPArmsb+4JbqQoNir4AsG1XZatqO/Mgt/jAJ80t8j1U
	yLrKXfJaQ8rp8TVKco0hH6esBezZ/VK6iVl0URid7GDscVCfI0+8Q0lp3ovdY23zbTfuhlUVqjc
	82/uBiPE8=
X-Received: by 2002:a5d:5d0d:0:b0:43c:f583:126a with SMTP id
 ffacd0b85a97d-45e5c5a0cf8mr16303135f8f.14.1779014333289; Sun, 17 May 2026
 03:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
 <20260516-veml3328-v1-1-1d4b663e2fe3@gmail.com> <4d1d9af9-af4d-4cb9-bcc6-e70d7640b98d@kernel.org>
In-Reply-To: <4d1d9af9-af4d-4cb9-bcc6-e70d7640b98d@kernel.org>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 17 May 2026 12:38:40 +0200
X-Gm-Features: AVHnY4KbWsiBarDYOBilUYCXGbEJfRgtCEQQHOGQDOyTn-3HuUsAQpQo0iHsNyM
Message-ID: <CALoEA-xQJ+JyJ0HHpNzed2NTXgnVnP14yVb0FHVCG=tC=DuuqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: veml3328: add devicetree binding for new sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 May 2026 at 10:38, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 16/05/2026 23:50, Joshua Crofts wrote:
> > Add devicetree binding for the Vishay VEML3328 RGB/IR light sensor
> > connected via I2C (SMBus compatible).
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>
> And then:
> drop second/last, redundant "devicetree binding for new". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
> >
> > Additionally, add an entry in MAINTAINERS.
>
> Drop, no need to describe what you did. We see that in the diff.
>
> >
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
>
> ...
>
>
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        light-sensor@10 {
> > +            compatible = "vishay,veml3328";
> > +            reg = <0x10>;
> > +            vdd-supply = <&vcc_3v3>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d6c3c7d22403..134690aa9866 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -28386,6 +28386,12 @@ S:   Maintained
> >  F:   Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> >  F:   drivers/iio/light/veml3235.c
> >
> > +VISHAY VEML3328 RGB IR LIGHT SENSOR DRIVER
> > +M:   Joshua Crofts <joshua.crofts1@gmail.com>
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/iio/light/vishay,veml3328.yaml
> > +F:   drivers/iio/light/veml3328.c
>
> There is no such file at this point.

Thanks for the review, will address these in v2.

-- 
Kind regards

CJD
