Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473F38D419
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051578; cv=none; b=K0HmD62724d6m3SDwwOsmh3zsTa8tFew82Jxifo8zTu5Da/hh2NslN/cfYGFXzGLx5UuQZe5oLyyqtZK6qyRjTV6zZ8TOG81rGePj1/WEm5mvy9uj1ZciUYDR5VpANt3pMWpgyFTQFV9tf//fWUojn/CmbJapuGKl78eQF+5eTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051578; c=relaxed/simple;
	bh=PC7iK9ghcLxujaYe1sBYImcNs1M2UD/XwoVRZxYo8jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIEnA9HRbhmiAiF10UPloa6gjeHR//r0xqv1hqbkIKru6GBG6/oyujMfa3tbSTqPkP/DuKlpseJLF5sbqIN4MWe36QaYpoRkhA+2daPFmzZPv7pCFyBNJwAWIr6V07dtn+K2xVXGGOH/LQw2vFIK57n+dDl5GCD/Nxs2zt9o8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=zwU9yVft; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="zwU9yVft"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49068493267so38545465e9.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780051575; x=1780656375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=REK62I331lUwouEMVLLpq3kmjZ7SBSD27YX0AVRlIss=;
        b=zwU9yVftHiw7UtVLWMcHYevsKEfqZYAWigwYheqPhdYZlvm8e4msra+RbQhd4mI+ol
         G78DepAsFnn//3X4TY0w6AmZJxVwiGdxDsB+nGPh7iYo08LgaO34zGp/B3hciSq8sfjd
         GHgT9hxe/ain3P82qfGvV91ElkJ4tShBbGV6fZVIv9SVORF9TPur7HVvLaBKOPTfLtjS
         VYbeAAN8NZ93SAm1LZbX4yniFkfxBqw19pGpeMcLdVtqCLcbl9RJvbnpfeCjO02kqWz4
         B9LEk0PlssblBjTypvJ1BCPNHxueCsdR+KpvgjAm9EpTdvWgQNibqiYjVIVZjoJwIh7I
         YnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051575; x=1780656375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REK62I331lUwouEMVLLpq3kmjZ7SBSD27YX0AVRlIss=;
        b=Y162hZvHbd4Yvsw9ovSoPEtMGTFwE3bmPWGxoMDQsC1BWV5FFIryZklH9DHxSZbugb
         oEjxdNOmppJ/r1RNj8DVrXF3CzFP9iC5SfUWZiyBTxn09MsObLPOeiC/T2lU6dqsc488
         N/cOGB+LkjfUC+uRKbW+MLOaB7HWm7yQLG2AQ+aLFopLYUh+gjQjKKf3gxJZG0GrV/hg
         dt9y6sUihZ2PzC/1hb+fjWyZ6ztmotx9yeayT6qHdzednEaYV/8QCK9SSP04CvCEGr/E
         y9cdmJNB/s2EkTT4jo35MrzpWqR6iUYhyxh1XT4+feJkxpSEk4Y2fOlCj/b/9LtNzdKz
         ZE+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9rDRhHpGCEr2llFq29Nl2u5ljZSxWfkqHpXtVJ14jbzXLvuJ6Ex1tos62ujZnIWqw2yKY2VwfQrt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5MjAUXm+5iVPX4iT4KhcVOfIhnKtmOsLTJFe2sh9BK7I5fQ3B
	ICUX+Lc1HrhdtxGz7CbF2uV1zDMOtFPciUUxd4IoD9QM98GqcFbmxl7rsj3OAbQkwdM=
X-Gm-Gg: Acq92OGU/zJ6VQWRCQkBul1uSf4EyTR8WIM2v8F5rx5Fo5r9KWeqoG0T612ciBP4B3c
	BI1Jvn/0bNTPGvl3xw7nJHLFh5IqNgWPC7IzC2vQHrloD2gOUhG/Kq2ptpn1IBpOo6pg7oQo7hC
	PRwKMrS6AQZuCm2Qf/gR1OkT0nHPEt8NpGoiLc8N0rytkTDZQfEQWCnniDJyPmK7F3MG/Jh9JKc
	tP2Dbs3jYDprTjABXvTiRfmZe/k0Itt8Ft4D49w8+y8ZWBsMqNSbziX6Lxmal73mRz3bOmziu0K
	5qbwjgDpVZIF0YFc5mfysxuR7cvl8rbRQNzeR7UUJYggM3Jqt/NNxvoa4CmYyFknEN/O/MINyFC
	ndJRkumoDlwrsHE9ZwUKl2rchpEzexRspz3eSLHp/jV4hegnXsuBOGTKYnQTSeKQnv1jz3NcDa9
	FmHdaLY6mx22FfS8d9nVYe0VOLZe/dAV8nEaPDDpithEE1EUzvWkeAwn93oH6LOJ3z37Snb5mVp
	RjrVeU2ZtqUxvwuIf4UtaHXDlDnuKUctkYfJ6h0uqUXgj6I5U0bO4pKx9cUJYGtmAWmEJe0OpVI
	bSVFeDrihRvUHfc4Mcyogq2BNHypjg==
X-Received: by 2002:a05:600c:574d:b0:490:778:4fe8 with SMTP id 5b1f17b1804b1-4909c0ba8c9mr28839315e9.25.1780051575110;
        Fri, 29 May 2026 03:46:15 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68980csm41024205e9.1.2026.05.29.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:46:14 -0700 (PDT)
Date: Fri, 29 May 2026 11:46:12 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <ahludIZPMUlPDTG_@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-2-clamor95@gmail.com>
 <ahlhinOh3NxB7FY_@aspen.lan>
 <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>

On Fri, May 29, 2026 at 01:07:50PM +0300, Svyatoslav Ryhel wrote:
> пт, 29 трав. 2026 р. о 12:51 Daniel Thompson <daniel@riscstar.com> пише:
> >
> > On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> > > Document the LM3533 - a complete power source for backlight, keypad and
> > > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > > converter provides the power for two series LED strings display backlight
> > > and keypad functions.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
> > >  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
> > >  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++++++
> > >  3 files changed, 304 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > > new file mode 100644
> > > index 000000000000..866b0fb8ed04
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > > @@ -0,0 +1,68 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI LM3533 high voltage series LED strings
> > > +
> > > +description:
> > > +  This is part of the TI LM3533 MFD device. It represents two high voltage series
> > > +  LED strings for display backlight controlled by the TI LM3533.
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/leds/backlight/common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ti,lm3533-backlight
> > > +
> > > +  reg:
> > > +    description: Control bank selection (0 = bank A, 1 = bank B).
> > > +    maximum: 1
> > >    <snip>
> > > +  ti,pwm-config-mask:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Control Bank PWM Configuration Register mask that allows to configure
> > > +      PWM input in Zones 0-4
> > > +      BIT(0) - PWM Input is enabled
> > > +      BIT(1) - PWM Input is enabled in Zone 0
> > > +      BIT(2) - PWM Input is enabled in Zone 1
> > > +      BIT(3) - PWM Input is enabled in Zone 2
> > > +      BIT(4) - PWM Input is enabled in Zone 3
> > > +      BIT(5) - PWM Input is enabled in Zone 4
> >
> > This is optional and the drive implements a default (zero) that is not
> > documented here.
> >
> > Is zero a sane default from a DT binding point of view?
> >
>
> Yes, if property is missing then PWM input is disabled which is
> equivalent to setting all bits to 0.

So the default should be documented in the bindings?


Daniel.
