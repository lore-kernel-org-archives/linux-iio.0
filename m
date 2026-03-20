Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3973B3C1F
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013303; cv=none; b=McRRUznXiHLX42Yivqv1kRz7e1BlE07Z0hP7UvOYagCi/Qjvdy+FzEDXZFKVNAmYXha2gBcvpr8hPpPo4rNtMPAzCqN+d8BArJK5QkjDzwHLN2szkoNkPvtkWFN2twG6qgdVvPD6ewUQ8U18K3WOUPaEME0BXoMfIWkkZFEAqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013303; c=relaxed/simple;
	bh=zOS8ljRIL8AvsCSBDP2a0G/OZJiR8ZywmMS7+RWDzSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cizQShUw+KSSNvPw3bAYvgLy/UfP8LO+0tBGa2+bfuvUu96EgJfVch0mCfkMGoRVSYRr+Yr0ss0YwG+rH3e4+J7R0Cin9JsgukSsLJVsmKa98cvi65Tgacy/WacgFa3fJ70Jg0z1TNKeXajeKz+9T/kVQhKSMJlu+FcX5l6366o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64937edbc9eso624576d50.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 06:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774013301; x=1774618101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnHKasPdLyWom6p+vZgOC2nZ3uHo78ylYD1IwIAQSc8=;
        b=MXq9XOVfLw52Ibb9rMLt11wKqQQVgSMDs/XO14XgTVfrjjK3J7U6907gpO1pUZ7E9Q
         Vf/XFkzOyzfOjRo/0dw7GdGu3PIs5BAZbICI74zc+yO7/bM1x8jZLmcRiXPJb4stz+KH
         7HYDwewB23WUavDfWIJPR7q65SCGXKK7g4uKgUn81qXQwQFnG+R0n7Ekx1t2iGyUoX3P
         JksOe8R1zIrHk4o7Gepav3jNQLRDmDQ/4yuIGs+gI8fSI95bEsu6FN0uGawwPCCzNGvr
         +mh7Kuk2u36nvamD7LBItmQnChQOtmEtoi3+XZ8QMnlYqp90l3iJtO+xi+6p1IfOEr8e
         0HHw==
X-Gm-Message-State: AOJu0Yx8OYvd1haW7ZVadlGgZTIsNs97U4p6hXzExlksdeNFSz+N1i+V
	LyQdP5qHnhjIKNJLgc1yoh+4+dbG1X6A6Z9mzuWix7ij9L12o9OE+BYVJWU7emfqBgo=
X-Gm-Gg: ATEYQzx5pdU5kf7y0XUBAIrzfqgKO/V+N4qgqNk1bDFIeSpjUuZ0L3tTKjrfavmvdny
	bK51fIXfnHsyCXWqZqfBskoCi8pwFCb2tniQB2k1XcF0O6IIeLGGlAy818cLM9ZC/bDsumWJbbZ
	EGVBsSzPJJlY0ZxCFap1QKXLitUpNVvToBnk2gFMaTAU+TbYoBq751EBMqi/6xoZQzdU24oxjtr
	OAUPN+7nwHi+RmarKpdWHuz5frBqWq004bxhw4DycSOM62zpbNfi7VAD1Wrer9DHr+h/kaEQ06p
	WhlXkt/3Q66VShxlj71PMbKRu3mrBlC95vPXs1Bm7aPJgbHS8tgIKJHDwA8EatYVSbRqVKadGJ3
	g5JoiU02LZi4C6qBP+WQc+6uLO8GiMMMbI2Kpag7Wh+ue9iPCpsytaRDBcz0pV5AGfoPZunAmys
	61ugYxuKoaENeQ9lLKZraGiPR1ybIBx087OL92uWWD7wklm/orwBJZZxSThIZmQmKQ8gu1UHlts
	AMDAXYxRwopU9+Xs07fS2UVZqOvJgASk+Hjkkmi2w==
X-Received: by 2002:a53:bd4e:0:b0:64d:613f:d833 with SMTP id 956f58d0204a3-64eaa6deec1mr2279426d50.26.1774013301341;
        Fri, 20 Mar 2026 06:28:21 -0700 (PDT)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com. [74.125.224.43])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabe7e34esm1430514d50.10.2026.03.20.06.28.20
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 06:28:20 -0700 (PDT)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64e8ae85700so576903d50.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 06:28:20 -0700 (PDT)
X-Received: by 2002:a05:690e:250c:10b0:64c:97af:5b07 with SMTP id
 956f58d0204a3-64eaa876062mr2412781d50.76.1774013299949; Fri, 20 Mar 2026
 06:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190738.151614-1-email@sirat.me> <20260319190738.151614-2-email@sirat.me>
 <c59cfc77-b49a-48c4-b975-026ccd3be31a@kernel.org>
In-Reply-To: <c59cfc77-b49a-48c4-b975-026ccd3be31a@kernel.org>
From: Sirat <email@sirat.me>
Date: Fri, 20 Mar 2026 19:28:08 +0600
X-Gmail-Original-Message-ID: <CANn+LW+zdT-kHN-SyHeogEk9FdsaXYkkobia=Tn9-FQmVv2nOw@mail.gmail.com>
X-Gm-Features: AaiRm50SJtUUGE-fgAQPU3OhbCzpjkCBsW8VSo4GBa7fcT40d-apXhHGJ7fci9A
Message-ID: <CANn+LW+zdT-kHN-SyHeogEk9FdsaXYkkobia=Tn9-FQmVv2nOw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 6:52=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/03/2026 20:07, Siratul Islam wrote:
> >
> >  properties:
> >    compatible:
> > -    const: st,vl53l0x
> > +    enum:
> > +      - st,vl53l0x
> > +      - st,vl53l1x
> >
> >    reg:
> >      maxItems: 1
> > @@ -21,12 +24,17 @@ properties:
> >
> >    reset-gpios:
> >      maxItems: 1
> > +    description:
> > +      Phandle to the XSHUT GPIO. Used for hardware reset.
> >
> > -  vdd-supply: true
> > +  vdd-supply:
> > +    description:
> > +      Phandle to the vdd input voltage. This is physically required fo=
r operation.
>
> Drop the description. Schema tells that.
>
> >
> >  required:
> >    - compatible
> >    - reg
> > +  - vdd-supply
>
> That's an ABI break and nothing in commit msg explains why. You need
> rationale for this, but most likely everything was working fine before,
> so supply should not be required.
>
The vdd-supply is practically required by both the drivers depending
on this binding,
But the original driver author did not specify the requirement on the bindi=
ng.
The driver works with or without the binding (it falls back to a dummy
regulator when not specified),
but specifying it makes the intent clear.

Upon discussion, Jonathan and I agreed that we make it required while
making sure that
the driver gracefully handles older DTs that omit it. If you feel this
is still not appropriate,
I'm happy to revert to optional.

Thanks,
Sirat
