Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7C381E9C
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503070; cv=pass; b=GGWsq1JW1ISb9TwkEipu6N5uso4ImL7Mc8EWiYJfP5mJtXtAOcN2ukUnqwdD6ZC7H2RDeb2gnu6aY99yx/d9XznETYg5AwhkstZ4fz0H83lGAyuarV7IAyYhRoCHSpCkhBS+H1ywWEUrVDilCtKJMg/dHlcon7WN+i7Xqy+QbVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503070; c=relaxed/simple;
	bh=V854Ow2c2JggNkbUsdfKDXvNBoWqMEC1lG5D0DCmDe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqEDT9aldVBbfVEvOkmu9oy7aZ8grmfmyGZjPw1FeCsPzvZ483scsd5DSb7AabQNyXjYkDzvukbgrwIStSU2Cl27dcsGfBiQrfOv1y+9BQyhvX4U3zyvZJCciQ3G9PqSe9YIk8FTJCy08S09L2dXd1I3Q0N8pIOxBsX1UdIKD/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9Xv0e/H; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9Xv0e/H"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b01cb18515so359856e87.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 19:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786503067; cv=none;
        d=google.com; s=arc-20260327;
        b=kon2tzYKEnFCF5G6jto0Ncsjtne8XsvJTznw+EfLFz8+JWoUXLk5MSNz/LnjBmmfNn
         Ky2w7kX6Nf9/QG7iWMGTKP+lPGzj0pN0Cv+LXnr1xxHBkKTCUf4pW4DH2XScQ1Ol4i0q
         ye2PZv/Ts2DitKzNtqNhyvhwVm8XhrIaUeovvXEKtdd8vM//gGWO2hgTZ2/0UKrQ0Fzn
         JchxRHLb3NLurCeG5B+oAHMtVPt/t2sF7W8QPj0aQC9O2p0Dy1ikIFEYwHvN85czoqH+
         ULkJxGhon4IcvL0icMn98owcelee0u0a/5OclxloWb4NiOU9ll1RF5bHSRGJFoKA03Ey
         unfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8qdxGMS0Je6Ctd6C+/Ey4+6laaYf85O2UWbiB0Tw8Vg=;
        fh=2JbqI/bIzMAU3qXNWmOe0vXymXmZleBMQIo9naZaTCE=;
        b=F2aUJeK5oisynOYCWwZuRsKlw1hPoyXDxb3N/6NhXrbExb7h6Co3/DNETAiK19Ia3P
         GdwFvs2cVY2LTVgi/XilA1hBcSpyKlZOhRYZB5JUaMszJfYmPCZndTZ+BbS+W07B9i+V
         PGOT1o6GH3A49cZhXvm3D/Mzrsc0WvXun0O/QVYE/1LymiKZtICoVadvZBLwFYfzdgmd
         J8o0+jVZjtCHBl1Mqet1xEAkPBBXSkXqQ0y/dgThW3FCg49YyVEkMvd0v7Urszpz+yNw
         EeHeFlsYnOTchiRf/wkvrkNPKt7jSy3B1KnS6/fx6R4ak6edkKvedkSQBpyz60Cy7xSL
         ZARw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786503067; x=1787107867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8qdxGMS0Je6Ctd6C+/Ey4+6laaYf85O2UWbiB0Tw8Vg=;
        b=c9Xv0e/HavEqYpw8lTxeV5GyK1chgAvRD/Rt0IHTEQ5TrpfZdLyO9GCiW8GiflD1mF
         CPMYESXycb87iUZnSUjEDJZqfWuWapjrGy/bUEiRhvMpJhMOvD+cOSO9bCOCl5sFL0+D
         uNPMQYq0FeCOI76Pcta1LsIgVPwgWUbIpz+wqVpMt+KeR3zPZb+oYQa3C9dBaPp/MEFl
         KZjC5RqU0S+M5fz8Sui1fEyERbl2sDKoOzimAr4iR1PZPQyUVVvE9RTRMJc+FVwgRYM7
         frX+YRtw6nm6wnMAsT6GaCKmVGGTTc1B2bBPj2w/Pe8JsCn4hVeYeTYpeEj6DJ42blZG
         PVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786503067; x=1787107867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qdxGMS0Je6Ctd6C+/Ey4+6laaYf85O2UWbiB0Tw8Vg=;
        b=On4nGyWiV1YirlI+ihMiD3qpN/ScNKVqA3kFAQJ9bnWLDN8WWEJfmZHOm6Uz+nofHF
         Jigu2vYKEnHpU0fGJKnL1/y+Rc06hRewMB24hzSaE1/Wu0Px0g7W5i/PboIdVqENLT4/
         u6ZmETyqYJDJpQMFuVlVcYK9GYmE9LKAwto0p8R9SBlCxltRw/br9y5oVBDznyIq5IDB
         BQGBv04iISqsaGespvLnKQSv/ZguPAymJ91V/qGf569kE6bBnZIqtw6/hb49I15kUKY8
         Q+6/5aUs3Wv6YvK8CnAp4JJH/QblB4Xv4/8Es7kKuZdYyM9eP2bXlz/NIWB9s6vvuzXW
         yy2g==
X-Forwarded-Encrypted: i=1; AHgh+Rp6QQWQgMJ7fre020pS6lja1IYvKxOjLbqeJ0ffPnJf5Y4XhMMODs5mDQ2tSe2f4Ye/7CYGQqOe/0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKQc9CptN0bEETpO7limuVwmAbLID8T5XEaHtTx8FMX1b+E9u
	sknNBRlH+gGONN3ul1PLBly99KfHhmRRdWqQpqqfFvKsIFBqayFEvIO3Xuhx1KyhBj92aW9zwMm
	GQsTwVBqHF5Iz+hcPMjIv8889noixW8U=
X-Gm-Gg: AR+sD12rIClhtMKFJAiVb+38gneX6lrcojugy6f8ePCReuhlGDJGlIjSjhwCWpdxSn+
	m/0aP5u57DXTDYuTDN41eFTCNTQ8gbjagNm4/msvW+MZqqm6aZYtALkKOeItZY/Vj7cocJrwYXt
	dFxTrF/GLjZomBmvNV8VodRp87SgPexVML7K7nnpUJIkVbDTxHuVxm1cfZ3Y2kxQuhjuwAdzFs3
	XPOVfYrM5yUtQvpgshmDxB5OR3e9Lhb7JaJZyh2xjmGEktesXaBBDSR169EKQ0KcMtg/V9onzLz
	w8u3mL8vh2MqZuwj7S3l1AM1xozaj8BSrhqa43t/TZKIiw==
X-Received: by 2002:ac2:4353:0:b0:5b2:9357:b8ce with SMTP id
 2adb3069b0e04-5b44e31ebffmr172006e87.40.1786503066563; Tue, 11 Aug 2026
 19:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-1-ae704ac17241@gmail.com> <20260811-union-editor-1d475c5f32cc@spud>
In-Reply-To: <20260811-union-editor-1d475c5f32cc@spud>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 12 Aug 2026 10:53:57 +0800
X-Gm-Features: AUfX_mw_q5_mMZ-WJHvUb4Gvmf9v3nIjjfS1widE18Qorp8AFIvUm08pqXCCl0c
Message-ID: <CAF7HswMcBx_DS4gLtsiy3ceBYBABF1ktJV4=+cDwAD9gLhP26w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Wed, Aug 12, 2026 at 12:56=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, Aug 11, 2026 at 10:48:37AM +0800, Kyle Hsieh wrote:
> > Add device tree binding documentation for Texas Instruments ADS112C04
> > I2C Analog-to-Digital Converters.
> >
> > These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> > interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> > interrupt output.
> >
> > The binding uses child nodes to dynamically define the connected
> > single-ended or differential channels.
> >
> > Excitation current, burn-out current, and reference source properties
> > are also included to fully describe the chip's hardware capabilities,
> > aligned with the ti,ads112c14 binding conventions.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
>
> > +patternProperties:
> > +  "^channel@[0-9a-b]$":
> > +    $ref: adc.yaml
> > +    unevaluatedProperties: false
> > +    properties:
> > +      reg:
> > +        items:
> > +          - maximum: 11
> > +
> > +      single-channel:
> > +        maximum: 3
>
> Can someone explain to me please why the maximum for this is 3 when reg
> goes up to 11? What do the additional reg entries beyond 3 represent?
reg here is just an index for the channel node, not an input pin number.
The chip has 12 usable input MUX settings (8 differential pairs and 4
single-ended inputs), so at most 12 channel nodes can be described,
hence maximum 11.

single-channel refers to the physical analog input pin, and the chip
only has AIN0-AIN3, hence maximum 3.

Best regards,
Kyle Hsieh
>
> > +
> > +      diff-channels:
> > +        items:
> > +          maximum: 3
> > +
> > +      excitation-channels:
> > +        maxItems: 2
> > +        items:
> > +          maximum: 5
> > +        description:
> > +          Additionally to AIN0-AIN3, IDAC1/IDAC2 can also be routed to
> > +          REFP0 (4) and REFN0 (5).
