Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC792D8DD0
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937438; cv=none; b=skG/pVERQY9AwmCWXpK/AbrD4fwTImaikeLdYzmLBex/xyH0RSvd4S2dWLt4qc9D2Uusedlc/EFLsv9CZGCk4nWhI6sExvRY+UF5Dv7dQXWJ3qNfuEnds8Hy78HX3csfHHe2mSJGb2Q9frTdMBB+EyWPD+GW5dKa+RuCmxDxHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937438; c=relaxed/simple;
	bh=n+VYlEwI6ctI3pyKixI8TWm6nE2Lv/uB0QABZm26g/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBBTgJedJmjzhkTEwAm6RXaKSIMHSoia2y8RJhILjaSdCKiKBmyueILj6Rx2Onw3Eg/bMTBlQXuhFBLcU+F8MY7QDttdzR9+3gGlDP/lPAYMob9jqGAXQz3qfM/ZFYvUs1m7AbZjYIqj8FPBj+9yVFwXRXucfqL9Z6FkXwm5fvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bfb3347ce0so556257e0c.2
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 10:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787937434; x=1788542234;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GJwmn2u3yEvtirjEY/Sfkzcv2VJy3izJDZbrh31Q+TM=;
        b=Wg69aG+QKwXpcA6JrmfxPTWfwytE1QKUiuIOz2xqnnUPGxEqatKNLimMrixiL39iqo
         uKG6phTmKctlQZN3G9AvzGyp6GZjAhVsr7rABZCZMG+bwxQpZfJAGLQ7iJB3mQWX9jXC
         BNRY+FwGBjDDOaXhBFMFLB5PoSLUIvrA2dJzx4R+EUAI0LY/Kq8xh/Hvu1TyzrxfZz65
         SKFVgZ0j9w3NlBIDwDttPQpxV32VRnA91HId5hGANfXpn+zC7+OJckYt0aypHu3ecWOh
         pvARsKzXKaNzURE7rh0rldmkryS7i3kIxO7Nrtl4FYE2ZXtQiReCl8QzOiAJYtIRr2Zp
         RFjw==
X-Forwarded-Encrypted: i=1; AHgh+RqgBho3E00FxQCxzLIoLwEcw62BcJVJxhs7SDiMfEycH4G8bRkXMPgZmhbj7TuTQSG4iwQVuY69pB0=@vger.kernel.org
X-Gm-Message-State: AFuF++kWZGG+d6hOSvadoSCxtNG/9WcTe1NLuXAmTCyq64MIn4jSlZQL
	/zFJWOIKC4iuhVi3LKqvqcguRPiEuwHMb4i28hgxIFx8pZIkwaO7HgEkrfy9hjy2
X-Gm-Gg: AR+sD12Uq7woVa3+YNZHCQXA8Vc0CjdDjbG6FF8BRkAScJYecbWGOmEhFCGDisZTVEc
	hraSJVux1F+ocRJw7H/WMmxJvRmlhbLdrpMjjSbnoU6xAHa7rOra4KyaAaRJA0Rk7yUiRZT5BaM
	v8QDuId+NEzRUWyDhhWta72VD4sYiIeo6Zst11NISTo5vHI7wpWpCnd9XK48t0oYRqZqXtJIUWO
	GuVMXmqM5L9pGx3Q2o6/OipvsbqUIvpc8bhzxKTcKUE67GWLeVTn7CRZ6rJ1NNBeU+BQUMTyuPi
	IIz+GJ9M7zkNlhl5En+vy62f7xtMK8Geom4CPmWwm9+VQ3HSdTXeEbA6tmpYQ71tBoslBN1si0d
	4aAti5d+yMb++wFfeXQ90/+uNKou4UukHFaWWPWVdqaatIiPZvVALXXu4nQfPSonxSGCQm1C3dK
	GVhDFYPqzo+JMFpmgVRVAIdxRCU31DybPCHmxVSHZ27StNwPcORb2ltH08rgdQ4QBfylB84K7Qq
	FN7ElM4mEyJVq72QSjZ6Hl/sg==
X-Received: by 2002:a05:6122:8602:b0:5c1:2b9a:7cae with SMTP id 71dfb90a1353d-5c68149a8e1mr3251813e0c.6.1787937434040;
        Fri, 28 Aug 2026 10:17:14 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7159c4c8asm1822647e0c.0.2026.08.28.10.17.13
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 10:17:13 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7868ca1f0d2so176664137.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 10:17:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqoMbz3D/FdefpeuqBFjjFpNW2KVgZ+WjoSzb4DTxr1xPiPYcdkxM5uOYvUjAkmFrpsZDMjeMxUA90=@vger.kernel.org
X-Received: by 2002:a05:6102:5128:b0:780:7e65:f0ab with SMTP id
 ada2fe7eead31-7859822155fmr2331935137.1.1787937432929; Fri, 28 Aug 2026
 10:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260828145943.2077589-8-cosmin-gabriel.tanislav.xa@renesas.com> <20260828-stoppable-clone-db6c2fefe0fd@spud>
In-Reply-To: <20260828-stoppable-clone-db6c2fefe0fd@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Aug 2026 19:17:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUryFJFQ+NWRzXWTzhW5yWvUsXc9y1=wTS13BGOaKg+5w@mail.gmail.com>
X-Gm-Features: AcwNN1Ug-iBgmO0xBVDQC1ANygzOTknsYPhMGIIdZDUDE0bFwxADxDj-zP0M5Nk
Message-ID: <CAMuHMdUryFJFQ+NWRzXWTzhW5yWvUsXc9y1=wTS13BGOaKg+5w@mail.gmail.com>
Subject: Re: [PATCH 7/9] dt-bindings: iio: adc: renesas,r9a09g077-adc:
 document DMA support
To: Conor Dooley <conor@kernel.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Conor,

On Fri, 28 Aug 2026 at 18:21, Conor Dooley <conor@kernel.org> wrote:
> On Fri, Aug 28, 2026 at 05:59:40PM +0300, Cosmin Tanislav wrote:
> > The ADC can transfer conversion results to memory over DMA.
> >
> > Allow up to three DMA specifiers, as the ADC conversion DMA request can
> > be routed to any of the SoC's three DMA controllers.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

> > --- a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> > @@ -57,6 +57,18 @@ properties:
> >        - const: adclk
> >        - const: pclk
> >
> > +  dmas:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description:
> > +      Must contain a list of references to DMA RX specifiers.
> > +
> > +  dma-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      const: rx
>
> How does this make any sense?

Each entry provides the same functionality; the DMA core picks one that
is available.  This was one of the design requirements when support
for DMACs was added to DT.

> If the device can make use of three DMA controllers at once, you need 3
> names. If it cannot, then just limit this to 1.

How do you expect that to work with multiple (the number is not fixed)
different names?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
