Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15948423A8F
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310457; cv=pass; b=qju+kU7aBW2kMl2TnFYx5oYQD2tnm7oiNRV9zOdDy8QnTnm9QxZtGYfuCuKNumcw4vTQB0YIu7KEK6aIjePFk+r2qud+BPYUa6+4Rqd+iK0DbvyULo1dQMJvqsiLUni/2B4508aun85czQxzZ5P+ZAW6sXEwv7P9iH4MqF8WaLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310457; c=relaxed/simple;
	bh=OpvS9XyVUoyw+oX1Lr7fUn152Rj180s+IMS/CRzzP4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlFv7fxwKhcc03Sw8MbnEQ5ZhyYGzK0unLqn67njXcGCIDXL9TsyGuyBAgfPx18V79JJ9lWn2FiwIdti5RXUerdMWWcpHdC1+yTjhDSPFvv1b6SBdTk9lkzFMyAKT8TSmkjho5tkzMnzLhKI1zdMPt61C4mECBNYd8xM7tPaiMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e50E3c+f; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e50E3c+f"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8850aa5b56so204688766b.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 08:54:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770310455; cv=none;
        d=google.com; s=arc-20240605;
        b=AoZexBcp20hnuowZnUSaqybUCA9mVeC+4PLIO+9UPlzQ+WuPUnWdm9SeesEMeW7j47
         RfitUtqO7RS2shK2S4cvY+ZOQFnNkWbba7Ierg+gI2cXf9ZSaT0Qj/brF+GtKLd3ZbnZ
         gbn50jMGJk1UYbouRaTmDaXjfZOhO8MX33JWNusd9ZGmTlk0u8VTw2ZbvkCdOBh+SgjE
         XNk0Eri8JuTuZWn7uvsJiuQDuGzBFBDdZdfx1nOERiBa5757jLG5bKmDFt/TrKOW5Vd7
         6PNPFZFUu9JK25TuBNsTCBgjqlg20NCz3av2u/ljhXetiod5u+hS0RE7ecab0THloBTW
         3Mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mok7tSoTC7RJ19nbmvu/1cT2bgwCt+f3Z/EsF+273Lw=;
        fh=Fh4khrxS0iTMIVCykRMRepVCxm5v2uLd6UtRt5G+ElE=;
        b=O6U5tXyIceMe4uq3ybkvxoeLK3oDEt/Ch8z9noVb9IO4oCe5CJqH33AwmsT+dL+Ge3
         IG04xJhQ6D/icz2wd03rxZJ0GQIpiJkcCiiElN5MhJ3r6CM5IZmRB+T6+cbpESAd373f
         2QqaeglA1voXAf53dyMMgT01khCPAsFEccVp467vCG8PDvBgiuOCPDuU7+Gtfl9k8RTj
         qK6pi/gA+ERx/ULwSzxkFGBSf9SbF+uUGiUocZojMKxczv1RMjleNRx9RQ8Qrl3ilFxx
         FqrJqbDzNIVNPYIPCH7ps5gKQdpi14meX+ant1hyLGAeJu2VDO8Cx68JEhiS0uQnQYNq
         f7YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770310455; x=1770915255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mok7tSoTC7RJ19nbmvu/1cT2bgwCt+f3Z/EsF+273Lw=;
        b=e50E3c+f4Da0k+Q/3Q8f6VXWkUv03psrrJVDfQ58zas5t/ua/TaDNPhnW45UvQXMC0
         lqBc9mXfZZ47u2gBxugXxViYfAInMRrfii3Kp7SC1f6o9Tq+tDdG8R2TpSpjJnc38YK4
         BczhPHgOAkME6NwS5vmiuaUDkvTY3rFu19+pLgvpn80o7lHvUBzKybJaMsv5WgJ3alxD
         tkd6idxlXtdq1blPngEQlk045RnApB6JkUxWLuU4W7bX2UGaRG5KnI3VGyvfRSz9g8lw
         u2BaJhgG8zUA6k/Pm4ggSR8MSyFwBpe2AMhcx6+TGWTxy1OpL2fhE6TrHE+3HDsyBmGf
         xHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770310455; x=1770915255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mok7tSoTC7RJ19nbmvu/1cT2bgwCt+f3Z/EsF+273Lw=;
        b=VcYBddk+KqVpc3DccnAm7d2oxTakcL+9liJTKfoZt/F5iDbrOUuMoNYu/47x47IoB+
         toPsfoVh3jWteShc0vKXHmZ125Iu64LQgaBJ94WiKu8qLImG35CxzUvrQ4T2hGcG8PRo
         qk3/lGSpfbr7oxlTXPGMnQ2aBZEOlts2/N7HPZS8kpq6p4YC4T6hUY1v2X2Gl/wB+CHv
         AoHnmmvNvZcyjWTMX3zA2YBf8t0hLI/elu2gCRp0neP5D/BbgtbeTqKMDo5iI+eCcSbt
         ZVZktr7ta/i/W3RJ3UKAp619OG8LpJneOlcd82K2gM0KwSu37bKIynGhx1ZyHaID2xSq
         ruQg==
X-Gm-Message-State: AOJu0YwHOKQNN8qkc6p6VZcMbThVVNjjprO8BAWr+PZehdOMYanGwwG1
	yfqcvuqkISFR5K5NO9SgfqLWRr+s//qktFKQvLgKtBHbOKWlNJcKBfh+FHrGJvEWxBMaH7BP3d0
	IR8BIdnIuHQICIVZQkv4YBkp/b9S2Um2L4u/s2Lysww==
X-Gm-Gg: AZuq6aK7SJ2/fTJtLw0/i7iW7QoQCZ7vW5ADnkDPqUBm8xZfFjSzVyC+j3NzzvtJCtg
	8n3FPi3np/464pXQs6ETTS41XO082DFVByjqjHHqqg3Jo7L+CKLDvVCIGJCmnb4sPV9IzNU5Hsi
	1/ftI9KdixoAx+8ANs+/fryvdjRWxMTg3PgcG4gWw4baHfevRqzGDPPh+qp0FksbjDO4rSMEXBn
	a6LIMGjzXJ0rlt+GR15ecmIDWggzih1BbepXlRgBhSoGSx5CLL6j1mSxubjWqFcuF+07Ew+ZJXI
	hUubvsgi1wDA85Ib48EjUTfUQ1PWT2djsZeqxlhsfGGnGREGFYf3DchWStOLuLez0l/5uNo=
X-Received: by 2002:a17:907:94d4:b0:b87:2fcd:1955 with SMTP id
 a640c23a62f3a-b8e9f40de76mr467741166b.50.1770310455075; Thu, 05 Feb 2026
 08:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770309522.git.marcelo.schmitt@analog.com> <a5721b31e7cbf8327c74d761757d9051c289297c.1770309522.git.marcelo.schmitt@analog.com>
In-Reply-To: <a5721b31e7cbf8327c74d761757d9051c289297c.1770309522.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Feb 2026 18:53:38 +0200
X-Gm-Features: AZwV_QhA2nGFwsXuz10t8Kj4Zl8EbQywBy3FuQIW-ZrEVDmxdKmmWiomaychFD4
Message-ID: <CAHp75VdFvVMBr6U40wQ-9Eo3e-svsdfOKhkEt0cfUbFoDbdA3g@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com, 
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 6:49=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
> that scales the analog input signal prior to it reaching the ADC. The PGA
> is controlled through a pair of pins (A0 and A1) whose state define the
> gain that is applied to the input signal.
>
> Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
> through the IIO device channel scale available interface and enable contr=
ol
> of the PGA through the channel scale interface.

...

> +static const int adaq4216_hw_gains_vpv[] =3D {
> +       MILLI / 3,              /* 333 */

I would go with

  1 * MILLI / 3, ...

for the sake of consistency.

> +       5 * MILLI / 9,          /* 555 */
> +       20 * MILLI / 9,         /* 2222 */
> +       20 * MILLI / 3,         /* 6666 */
> +};

...

> +       gain_nano =3D gain_int * NANO + gain_fract;

> +

Unneeded blank line.

> +       if (!in_range(gain_nano, 1, ADAQ4616_PGA_GAIN_MAX_NANO))
> +               return -EINVAL;

...

No need to resend, if Jonathan and others are okay with the series, he
might be able to tweak this whilst applying.

--=20
With Best Regards,
Andy Shevchenko
