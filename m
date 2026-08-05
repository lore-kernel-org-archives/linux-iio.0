Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD13F9A08
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924093; cv=pass; b=F2JvRmPuUk+p8U/QvWW5JXF6KJUCHFF3W1r6pKC3Am9yRUQw9fG2jeby+nyXMekunWESguKci7rUJXTw8REo4auYAFCc7MxyOtxan8luo1/j1KQ7zwuxz9NYZk/Ael2inmco9FV8cOYsuG0yeWT3u5FtWZ3X6RhwyF9bQcC3dvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924093; c=relaxed/simple;
	bh=aCuQ4awIDkcto3h7JAxQRBcQRaCA8V5TXtFjb1C7Jqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faogiamS53HTrVlABF7u05g/qLNMJXeyr18Qi1PbBKB9Prez8H29MvZtJLB/RjaySnMmwepCOXYV8CSM6x3NtOykYqC/rGmtuYrwI5mTDSc00y9CkFGgvLGc6Ef1LwfgVFriCs8Wiu48xCcjB+rqTQfqCdIIgjKlbTLXMKzcPwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oU9gyGy/; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU9gyGy/"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1c26d7e951so135712366b.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 03:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785924089; cv=none;
        d=google.com; s=arc-20260327;
        b=QA+ruH7Zo2dT/SIR/LArTOdIKu2NpxNCqJu6jJMD4f2TwrmS8N59qtd4LADV9Llbvu
         wzE7lo3xwJUI+/PjI96BVPeJecubI2Tg7ZiGKfjKtXtR7JSmErT9kPPYqS65W0I3tMS1
         qllFV28yiREqw/qVStP9Do/Mzh+8EJ0Vw8ttQBQvs3EyHEI4y6Gr68Jn6caYNW0I2IrQ
         j+OlBbUwfkE3tI9r8ov+L/C/kN0wCAhd+jW3zjNCZf+Kr/S02upQRu/VbVjN89MtoMKA
         ZcNS5GGBrqpd0L9ym+e1BT4Rby8DgEHNJl84hrbQcrTFjfAiNfXR/WcBi3LqKPtbfBoc
         hO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nnl7dBC/2J2lIlaFKwTpn9e1OS3QoYewBPdtWMkrWUc=;
        fh=nvvM6G7pMwn0aBFBugXYkIMsOoYoIlsrFddcLfYaSZM=;
        b=jbopPmzCHo+BD7jJ9nTONCoOUJv+gCMtp+fRELu/WWzdaetLa2Gl2UrGRLdfx4X4gG
         PR+RPj0pYb94+/OEcsb2DQzpsjGlI1IKq10k18MhhoEDZWUkUkMi67X9eZ5A3N6aBwks
         seLxhohWh9IVwFOHjIRsX2qw0mBITccd/f0BciiK+FnWIcCAMTkFXZX1mfZCG5rz8a0w
         iUZ79t4KslfV0yW3yyulN1G479n59LyMmKSnYWpsbgZ7MFMf+RcUikIskHfBX70smobA
         9Bk//C7Z+vd6ky6wslWFGrB9NDpFS42yw9rFqmN6weR8h6/kJW+vvct/Umfw2RdIo2hO
         8FTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785924089; x=1786528889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nnl7dBC/2J2lIlaFKwTpn9e1OS3QoYewBPdtWMkrWUc=;
        b=oU9gyGy/C5nrjgJx98zRUyagS8GwnZ9J7gr0uQoFcum+k86VezsGOSH8zb9kNiCZ3+
         Kn0JvsnHQjJPFV8saQZhCT6GFKuFc8iv0N4esJ+YkfrvoKV5fcaK9ElDG8II1T0IBlWV
         BGCwq7Ws/3tYXmotBS0IICK14WrFfgJHstIeKBwG2yay6RMjHY+2NtRKXx5DXbvfT/4z
         gjxH1LUk70RojATFvXRKM1yjNnk535aG89plizdqKYqllKZmv9tz/ON8CLZvbIRdxhmJ
         nq2971kS9xxB5k7GiU99Luj41ARB6cqbo3GZQ4PFF5RRZ1dg+0TUGHhXFg2HIehOG4aZ
         AvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924089; x=1786528889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nnl7dBC/2J2lIlaFKwTpn9e1OS3QoYewBPdtWMkrWUc=;
        b=NImpwNzSR8TNs0JuX1gM0bJ/RhR3kBW9VreADICThJ88qqF6XMvvpslcNvyvQH/FAC
         LLNJjaH+8yWeEvV7xgIKJgWZZZZ8RzjTOowyb/sJGx53MVe3BKoNsQLOA717pLNKyyAv
         seRwguws2Qri7aYB6Srt79ikRWN9lTw4AYFqZS5bKzqFX0sAJ89mpLfaf+5mVgNcwREl
         RJVktVYyXoBRtfY8M/HUqbJ+edmuguW9syaGbGQY07tLtF4Ye2hIINUftF48538V2uA2
         bi7kY5NWcHzGLo38kfh5AQtYWAnq1rpDPcTieFmR99egEDKE78WVC2Ze6OoAsVOyeZV/
         8f6g==
X-Forwarded-Encrypted: i=1; AHgh+RrtDUJdvMR2mby3wNYN9s5Wdw3C/En+Lr4VnF5kBMkk72cIebiyNmNygPfDg82K+kmqb3qz5rNzxLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYXpfcOGEECmmoDLBmlf2eKF/hYo2ClzdkllTJAb9XaC/Y6S5
	uT/N+YrfHZt//x0EkTX9Mc1+ti8DN9kOupdpxgM1hpSB6u3BNOwhywv6uILTNe1n0MGQt85pjGa
	Hun5oq1lCdwBLvihVypA5H/Kb76HgHdY=
X-Gm-Gg: AR+sD11ryFC/TfGeRtqpdd0oRF/cFA6YPMtRnW4D+lvh9xooEx7YhokSDWo3M6pN7b0
	Z9YYvwfpPfbmODlVYYhnD+pvzEtgqK35G1/pZN+MYbfJSt207zIbURWkpGDoK/MD17CpyxhdS66
	iIfBjnyzIcmq6zeRxGWUKviXnNXYApWH2jv75DtYZd7KLrv1ZUrQCyo5F+52XbNahOMii+bcYSF
	HjCGVbRNO9v43qXrk2NoofT6ZPC/nRR3MuTbSnLJLa1r5JARAW6dBzNl3MkGm1iW97HyOSoqRSD
	oX/2J4pJuYPiTbNB9MB53RijAtJ8j7wIWLrN9+BXzkjIrxmcIqGQKLkxhn3v69/nrJ92+p2HUIN
	s1hSrroBg+50+blI9qtplu6E2A/KvACtmgpEWYwNDX0kG3Ceo+vaDH+pSPzsdpDsVTDfV/vtie8
	GgMGOcdKreaWsS9bHlrgs2ioLiaHxdG5woqdF44O856v+VqBKQB868LL1WfEcwTQg=
X-Received: by 2002:a17:907:a713:b0:c15:e118:9b99 with SMTP id
 a640c23a62f3a-c2039f3d9bdmr219169966b.23.1785924089154; Wed, 05 Aug 2026
 03:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805094135.11762-1-andrei.stancovici@analog.com> <20260805094135.11762-3-andrei.stancovici@analog.com>
In-Reply-To: <20260805094135.11762-3-andrei.stancovici@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Aug 2026 13:00:52 +0300
X-Gm-Features: AUfX_myxZcCbcuRckig6xJMzKtCW_4zohTq4GXPN5nDQZGPWkO2ClR0bcilWv3E
Message-ID: <CAHp75Vd7sq58kFE6EsLxFwk2z0QtOsyNwh0b-CrZb0HDYVjDJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ltc2497: add LTC2499 internal temperature channel
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 12:44=E2=80=AFPM Andrei Stancovici
<andrei.stancovici@analog.com> wrote:
>
> The LTC2499 has an internal PTAT (proportional to absolute temperature)
> sensor that is activated by a second I2C configuration byte (EN2 | IM).
> Expose it as an IIO_TEMP channel providing raw, scale and offset so the
> standard IIO formula
>
>         T[m=C2=B0C] =3D (raw + offset) * scale
>
> reconstructs the temperature.
>
> The PTAT sensor yields the absolute temperature as
>
>         T(K) =3D DATAOUT24 * Vref / 1570          (Vref in volts)
>
> The raw value exported here is sign-extended and normalised to
> 2^(resolution + 1) =3D=3D 2^25, i.e. raw =3D 2 * DATAOUT24, so on the IIO
> milli-degree-Celsius convention
>
>         scale[m=C2=B0C/LSB] =3D Vref_uV / 3140000
>         offset         =3D -273150 * 3140000 / Vref_uV
>
> The scale and offset are derived from the reference voltage returned by
> regulator_get_voltage(); its error is propagated as before, so a board
> that fails to describe vref-supply gets a clear read error instead of a
> silently wrong temperature. No board-specific reference value is assumed
> in the driver.
>
> The single temperature channel is appended as the last entry of the
> shared channel array and excluded via num_channels for parts without an
> internal sensor, so the existing LTC2497 channel layout and device name
> are unchanged.
>
> The LTC2499 latches its converter configuration from the second command
> byte and only re-evaluates it when that byte has EN2 set. EN2 | IM
> selects the internal temperature sensor. Because a single-byte command,
> or a second byte with EN2 =3D 0, means "keep previous", a one-byte channe=
l
> select cannot pull the device back out of temperature mode: after a
> temperature read every subsequent voltage read would keep returning the
> PTAT result instead of the selected input. Temperature support is
> therefore only correct if the voltage path also emits a second command
> byte that re-selects an external input.
>
> Send two-byte commands for all conversions on parts that have the sensor
> (has_temp):
>
>         temperature:    EN2 | IM
>         voltage:        EN2                     (IM =3D 0 -> external inp=
ut)
>
> The LTC2497 and LTC2496, which lack the second-byte mechanism, keep using
> the original single-byte channel select and are unchanged.

...

> +               case IIO_VOLTAGE:
> +                       *val =3D ret / 1000;

We have SI unit multipliers

> +                       *val2 =3D ddata->chip_info->resolution + 1;
> +                       return IIO_VAL_FRACTIONAL_LOG2;

...

> +       case IIO_CHAN_INFO_OFFSET:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       ret =3D regulator_get_voltage(ddata->ref);
> +                       if (ret < 0)
> +                               return ret;
> +                       /*
> +                        * 0 =C2=B0C =3D=3D 273.15 K must map to raw + of=
fset such that
> +                        * (raw + offset) * scale =3D=3D 0 m=C2=B0C, i.e.
> +                        *   offset =3D -273150 / scale
> +                        *          =3D -273150 * 3140000 / Vref_uV
> +                        * Computed in 64-bit to avoid overflow.
> +                        */
> +                       *val =3D div_s64(-273150LL * 3140000, ret);

We have ABSOLUTE_ZERO_MILLICELSIUS, use it.

> +                       return IIO_VAL_INT;

...

>         indio_dev->num_channels =3D ARRAY_SIZE(ltc2497core_channel);
> +       /* Only the ltc2499 has a temperature channel; it is the last ent=
ry. */
> +       if (!ddata->chip_info->has_temp)
> +               indio_dev->num_channels--;

I would do it explicitly:
if (...)
  num_channels =3D ARRAY_SIZE(...);
else
  num_channels =3D ARRAY_SIZE(...) - 1;

--=20
With Best Regards,
Andy Shevchenko
