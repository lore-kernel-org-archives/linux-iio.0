Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB53F871A
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113934; cv=pass; b=M6tTt+iVSmceI/wou506T14yMSyQ5SLUyBTGjhCdlge3JIwv5m4+zyL03dF4hq8MVg88OaUot65WP+SjMMF4IDWFHYo6urJzk6N4zjQ7WQa/0wWO74gmGq0D2Kffo4dwbn4IlltSXaYBxlBz69Vo78Lm5vz7xri0VLnTnpbby/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113934; c=relaxed/simple;
	bh=xuow7G3f6BZxe2u9mbDa9GR+btG5Vz+B4t18943dAXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfYo1hAbpQr9EuKQH0v5EI6gYT9sY0yl59d6746nfyFi/tRluQH/FvhgcbnYcZGyllufk//a9WlQRA/Vf7QZ7x5bpkjzdlYTppyWIek/u59laRQkWen/VbjcwlTMYtnfSo4jQkJUy6VBeplCDHlp1QJTZduhNXQtz2h7kdlh1M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVaj2VIY; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVaj2VIY"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso2144894f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 07:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779113929; cv=none;
        d=google.com; s=arc-20240605;
        b=ih89S+1AUq95Sn7YLwYkiafPuq4CSrnng/D+sVRT59kNC0plrPR3KCzQYn+A7DHjby
         crpOUIwH+iyNKA+20uLgzzXgppNpvKhq3EkfXp46wKwzREJGTgMiqbbamDpwsmR6/kEL
         HMobKU0W+3ORH54vZxyEnG2LCECkQ/9KzdwUrnKjugu7QJHPSSZNTYjx3B1i67h+gtP6
         BUTVDLzgNlS60KyiiBeKAK0hICDZ7Y4NBfhFxsnbT/WP04hnrXvNGZcojKsa2cB89QVB
         eU0wNRYA9imTWgbeolpE10OQ5wf6jPg8auAVk1ukOsuo5NLRFGkSqoTs8ZBxjFgT6ax6
         bSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iMFAIkVwK5eQG96dgwCv58Stxk1/depDhaUJOjOWwdk=;
        fh=NVcTwPxUexNifbR9sVu1k0zAfRL1sJYt5NgJHcbJUu8=;
        b=Z2Kcf2mPyu189gSI4C7WuvCRxzJdFGZRly+5NG7vqF1k3kprNGx5xAIhICBLMSR8b2
         BOumGEOioi+y+Jr6QV2ASzV8QnUwXgkBr3NkQLxOKakoTtiua2XX3Ofsz2AjP8RI20UK
         l078w6WkYBff2qy2TdrNKWWkGyAGijWOYrEcjvHTLgJPUcOLoHUMiSlx9yzUn3LHTwo1
         3Thq9p0sYMkWPIoQ6URNOWwFmTkuj+vR46nEfUcmBwawrwN/Ok9BU/2XATd4PS79oRgO
         Dmx8GxQENuFD8fZcnsqpksAmbVhC6zfx9R5ETU+n9ZyPUpxoB5YvZiGqQ4rkT2HxPr3L
         2aWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779113929; x=1779718729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iMFAIkVwK5eQG96dgwCv58Stxk1/depDhaUJOjOWwdk=;
        b=MVaj2VIYZhzi5MOo7Cl712ncRu9OfWvaumvGJBDxuytEXdWe4MHcXymqKDB5OCPRgv
         z6ERk1s87gHRyW3nmB9sGEVXX1sKShwyE6Bkbvq9CWkE6a7Nul+RU0id8gwLiifl10jo
         8gBBXQL3rCW3HZvSjD0q0sorZIzxdweiTdk+9JD0+5dytll5eGLNHqRbM6faFVplXl/a
         5W4jiiiWT9odvowmOqlm82ksFi69/HyQbco9tCWMj1Wds0aKfsgeAImgyV9vGLLAtSHg
         kOUoLL8InYYGrISOWqV/LghkgU9fQMTyACjoq/FaD2fWII3b64lMmVTk2FbNQajviJRV
         BdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779113929; x=1779718729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMFAIkVwK5eQG96dgwCv58Stxk1/depDhaUJOjOWwdk=;
        b=kVlz50Gp+ihhP7b9jO3fmEobTfzeQ/blKlNxB6T6sKzsHSWnC+CqiOMn58sTuDwkzo
         Oa1+N3Jmps01/339/XgqwA8sc3jKt9U1veqjVO1nIwdBbFBjMer2T/3ExrIHAKgO2gG+
         UJt5MMJ2RitKxs8LtzKtav1tvhFmg3GxsbY+m7hPJH91X9d6JkUHch4QzKf3om7P6jBc
         eufUayxbQsx+HU+WUkMca9miJlNoof/nnOQC6C2EL9VMhGx39/xWBwqlY0/9QGCxbKPo
         XJMu/OTeOujN4Fh7YLv7HZnZnHfkHgu8YiW67UfFDGeWvxWrRV4bRcGlTBxtwxA0b/pR
         Oynw==
X-Forwarded-Encrypted: i=1; AFNElJ9MYyPbUOGr2jaKWf1uDobYcwrgHzikYQ0b2OrMK+9J0XrVQq/wGbPi76glcW1LvAPct4XwCeWBMDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmK8AxQEVDdYu7y6ed1CD9ogS4sSTtYYGVIrjiIKiTiXC61oY
	F/XQSngmjK5Fb2OXThXOgZA4X/UjEariygbm0XRVO2FNIyDGtptr9+ExvRj14AnIX7T2Oko/V0H
	XFzcpe7JgFkPA9bJfVOD9AQ9EDYL14o8=
X-Gm-Gg: Acq92OHPXK+GNjI3k0ooghe43ayvg5mhAZvAHqzi4Vhlqlp6RH5Xj5WDAHT5iAhS+vY
	Vpsy69zdjyDl0jAy9l5/ysNzND/Uqeg3aKWKZxHFL+8wJWnyuSeweMIo5Of1f5VwPj0GK2A2q3n
	IfSYJwoHGZitce9QyYvF4vccYn8vZC1dZeX9MuN+AR+9hpLwCSh9VjkQHAjSST+YNMppVTorkmR
	UY4kI8iRDx1ZGChNOD1QAfIBqeM0rjmESfF2mbET1CvKTCWCw/XY9PvG3w9eX0Pd3LP3bxSN5KZ
	Y7LIg64Q+a2ZpiRH2d6JVRUjnB5+myPN9+DI/j+1yQbJr1Oaj6ScEfg97x19NyponeDqXbz5DWT
	BWqYR4pI1aJkKD/wRjJCABcbu3chskFAr8Zw3EFaFCNZUykw7hVKn05rG8I8AIL2dASayfm4cIa
	zUBSnAfILTZmcNgTcB
X-Received: by 2002:a05:6000:2f83:b0:43b:3d02:7806 with SMTP id
 ffacd0b85a97d-45e5c58ed80mr25602693f8f.28.1779113929216; Mon, 18 May 2026
 07:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
 <20260516-veml3328-v1-1-1d4b663e2fe3@gmail.com> <20260517141054.3981672c@jic23-huawei>
 <CALoEA-yk9dJFx=pjjm-=UmTi6Wzx1crLswFfGC2QtPMCP2834Q@mail.gmail.com>
In-Reply-To: <CALoEA-yk9dJFx=pjjm-=UmTi6Wzx1crLswFfGC2QtPMCP2834Q@mail.gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 18 May 2026 16:18:37 +0200
X-Gm-Features: AVHnY4KtdgYmA2UL_w_pGgUt2FELICyPTAO87MrpbTWGkY8mAyGUbt4TtvHM1hU
Message-ID: <CALoEA-wrMkqvqDVPDUSbVSQNF56CB3R84Ch5=nX+8aJqmYxDhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: veml3328: add devicetree binding for new sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 May 2026 at 16:26, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> On Sun, 17 May 2026 at 15:11, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 16 May 2026 23:50:53 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >
> > > Add devicetree binding for the Vishay VEML3328 RGB/IR light sensor
> > > connected via I2C (SMBus compatible).
> > >
> > > Additionally, add an entry in MAINTAINERS.
> > >
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > This is very standard looking. Have you considered if any similar
> > bindings can be easily extended to cover this device?
> >
> > Note that there is no direct relationship between bindings and
> > drivers, there are single bindings with multiple associated drivers
> > and multiple bindings covered by a single driver.
> > Also dt-bindings get used in multiple projects and some of those
> > will do different splits in what code covers what parts.
>
> Hmm, now that I think about it, the VEML6030 binding could be easily
> extended to support this device - oh well, should've checked earlier
> and it would've saved me a headache.

Before I forget, any idea if I should add an F: reference in the MAINTAINERS
file if I'm just expanding an existing .yaml file? Given I'm not the maintainer
of it, I'd expect to just have a reference to the actual driver file and not the
binding.

Thanks.

-- 
Kind regards

CJD
