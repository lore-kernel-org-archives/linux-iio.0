Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C43F3289
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654703; cv=pass; b=kBctdirMeIuEcTp9tLXelmMgJ7nR/AAD6c8XGsL1iq/Exgk0wl6hRrQqiXDCvNptQJJW0f+dXD13z3Cm5uIf0+slGi/0J/IQbX+dQZv5in2L0juqnOqV12YyY1pfsnyDyyLsPdTruoojt+XnfJIy1qQ2VnR6MG89ESJJiFsheDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654703; c=relaxed/simple;
	bh=/xB5jWHXqzTzVpEIuX53vofBJ70T8JLPbOmbdW9c2j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBPkQ261HUb6yxPQZhp6rGExKSQD3nI4DnuFT4wgSjbyOqYJ4q6LcSGLAQV1rHXnrIKaUcLZgfQ2h4tYr6g021N/eR2DcPjV0dy89jSLbrPudVNtfuvvDoD3RRF+4YTtPVKxhyb8V+jMu2k7UpaeALFpR6e5VLVwI/CW89Va6w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h19OaGZm; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h19OaGZm"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso420940a12.3
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 13:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786654700; cv=none;
        d=google.com; s=arc-20260327;
        b=X7ToCdyAx7GMZbIu19zJ7/tZ1jc/T2/VUSvfgwG01Qn6BeQ3lNFj8h1Bj762rjlRrc
         K4lzL1D8cl2gi3Etre31JBW88aQc6UAHoCPtyTR7Kl2M3dKl3shWZhvyFdV5PCgUkix6
         R9bvPgfXbrnq6pphUUHHu83wGOWWrsWLcVV42AN+jMwTDdradTrwgSqy/7PBOXeq08dK
         AhRKBhdrXxY2tfIDKz4YhHCjM3P37nZCH2e/gg8gZBL7wbpBtSDoVhZ27dTmbOUYqbwe
         YsMeq1DBtXIBDTYIciBFq2RTS/lqrf/OupDjVE4G5thjgLdQaE2kxIq5gt3p283/qvZs
         BG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMKOZgzufVVCLOJWeEGJ15IjqhNjAOcuZzkZmWD1eJY=;
        fh=n4clxhMzJ9w7eSL00IKSJoToUT/dSgkHxrP1DuCgMUk=;
        b=SC3SQjDhpVbudj8l8JImUEzdmUc4h5BNa1oFdsPWyh3lDAzzwEVbmsMPN1LYCLL5Ce
         i1S9Vf6TR7+XJEct7rPkLLogSntILPkTh/LshC9Pk+8QfNSeJ7WtVJW7ei7ejR7hIJvR
         Ji4SAFx+rDsbF7wnSLdNAmOYWoLHnDZz8ULIipkzg85ruWA/lWOwOIp5+ENb39Hl6JlK
         ETQE82Gn7aKSW9OppXir3/ctQUfPeKtKEv7UfhTVzUkcQLm1L+BPKSYRlx5W2a5D/veq
         RnuxiOq4CDvUFfiasEN0m17hk7oBC2F22PfxLV1i0DppOHQgCeF6gAXKm61ow6lF+fGN
         r0VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786654700; x=1787259500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FMKOZgzufVVCLOJWeEGJ15IjqhNjAOcuZzkZmWD1eJY=;
        b=h19OaGZmoG4y8EdQqoS+d3m7noBw5+nt2lRRRtROTMXim263mxbszy9tI7C0ucjnZA
         /Krdp6YmpNxTwpfDOgnsT5yQ39dIFVWC0EdsrmEC+gRskbzuF6vZTo38edzWkSu0bsEg
         w5gYGf4o/1T1Xd8OMeB7m4MmUpwqhSPkzE8t55CWgZC8Y4M8X19pVNDajDt1M2Wa9gQS
         m9Z4QadUHbjkiC4ripB/t7BKufuLRjfDaggMBd2Hh/Ee6yWPbDlM620gzi+f2TqsF7aq
         7glaLoO5S3t5PiaI97WH+1ML0IDmrCK1eypXiG6wy4vs/MNL5TpMSCeDm1eZS/HJ91zc
         zVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654700; x=1787259500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMKOZgzufVVCLOJWeEGJ15IjqhNjAOcuZzkZmWD1eJY=;
        b=Po2kVTV2115EFPsO4s956twoQhScrPJwlRzL5IRIDAW2yUM1AZgR5IEx/+sT8y5T35
         Tsv+vOg9Kf4U7rDgKcJK8z7mpbVQvV6/yhWShC1rXhkw11xB86y5dff4j8noGv1ATGJg
         CzBPpkdjyslA2lEioMU8YITzwOOgFVp4oC6Xxp+hxmRprBgPHwzT7tOkRl5/PnzWXyfO
         yTSQzbHu6Gepg+wDiPJDEpwzV6j02OEATL2dU7QOBYzBCmAmvBfRidqfAlNd2a4cGkIo
         1LPa+eEbZeRMk46IuxqT85jtbT2VoEFupNSRkrPUjYdTBaC8LgE8fEa8mav+L7un/2kt
         vqnA==
X-Forwarded-Encrypted: i=1; AHgh+RoJmkZz2qecKxUgg4MVOHOMkGFLJ6cuV+C0P/M907JxzKojq/f4uCYDyWwOBx3m1AKEkbIGUjmCn2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lh5I2TbXeBZ8Y3tvVyDKQ534MxHWWMpuDP5QhZfN74bZxeqY
	fQ4MRjT54O9LqskhwvhZGLR8DNTWx+FRYX2NRMT+HhKubitXZgwBf2f9ymRKkPtCpFdUPpNE2Gt
	9cspk7Ae+zJABr/YmNpoxu8542CjHEaI=
X-Gm-Gg: AR+sD12qzDyZYaH/5y2XFQ6RyG3L+OXKIXgXXMO5ShHnMSQ/xYfyKnQ2Rd25AQN+Q+l
	G9Gu3wJbapNeQLnSzDFZe1R38cSaUO6DPAmTpZsB2wNOn8Eye2aY/jEj4p8RhZ+pwAoLGNs3/ro
	WqUlaxn6eKqyR4Y8Kdy1hKEQpFmWiQMqJFa45jdV1sPBQ1KUTh4WeiaffuzeNjpjZhbbaG+LVK2
	rmv4Mg3V9vCRtvKk5K4jpIJPs1qtwxRTiWYRIfO4jLRQfOmhlp/WSklnnTPv8wcf5S7KjrV5UZ1
	uOMQDjKRXVhQPH+dQDfDzBZZ5o4HBI9Ku4mC4k/eElMyIemmo6BeQtuD0lNG84MVLlySNRmArSI
	DlFrESva8pvPmVjTvwtT1kX0Kz6557aIknH7llOGB9s7S9lSJmKQoI9hNUEwFdSQseuHNuUst9E
	/5Gjqxu0n4erjdayJ8K8hrvJsuQHaYfg==
X-Received: by 2002:a17:907:9612:b0:c20:2eee:97b7 with SMTP id
 a640c23a62f3a-c212a0f45f8mr50426766b.10.1786654699886; Thu, 13 Aug 2026
 13:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813160139.70000-1-andrei.stancovici@analog.com> <20260813160139.70000-3-andrei.stancovici@analog.com>
In-Reply-To: <20260813160139.70000-3-andrei.stancovici@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 13 Aug 2026 23:57:43 +0300
X-Gm-Features: AUfX_mzQbBF40TX5-53l7NvXgRquRfw3jQNW53giSLK5VOi38_cPDpZfU8jUQPk
Message-ID: <CAHp75Vd2_NwPjqM1MMBn-2KP2h=ug=Nv-v1CgfmfPdN3jE50Yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: adc: ltc2497: add LTC2499 internal
 temperature channel
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 7:02=E2=80=AFPM Andrei Stancovici
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

> +                       /*
> +                        * raw is normalised to 2^(resolution + 1), i.e.
> +                        * raw =3D 2 * DATAOUT24, so the PTAT scale (data=
sheet
> +                        * Vref / 1570 per kelvin) doubles its denominato=
r and,

Kelvin

> +                        * in m=C2=B0C, becomes Vref_uV / 3140000.
> +                        */

...

> +                       ret =3D regulator_get_voltage(ddata->ref);
> +                       if (ret < 0)
> +                               return ret;
> +                       if (!ret)

In this case I would rather see

  if (ret =3D=3D 0)

as it's about value and not a returned error code (success).

> +                               return -EINVAL;
> +                       /*
> +                        * 0 =C2=B0C =3D=3D 273.15 K must map to raw + of=
fset such that
> +                        * (raw + offset) * scale =3D=3D 0 m=C2=B0C, i.e.
> +                        *   offset =3D ABSOLUTE_ZERO_MILLICELSIUS / scal=
e
> +                        *          =3D ABSOLUTE_ZERO_MILLICELSIUS * 3140=
000 / Vref_uV

This is a bit too far. In the comments the plain numbers are much
better, we should understand math and physics behind.

> +                        * Computed in 64-bit to avoid overflow.
> +                        */
> +                       *val =3D div_s64((s64)ABSOLUTE_ZERO_MILLICELSIUS =
* 3140000, ret);

Casting is not needed, the trick is to add LL type suffix to the 3140000.

> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }

...

>  struct ltc2497_chip_info {
>         u32 resolution;
>         const char *name;
> +       bool has_temp;
>  };

Have you run `pahole`? It might be that on some architectures there
will be a gap in between existing ones due to 64-bit required
alignment.

--=20
With Best Regards,
Andy Shevchenko
