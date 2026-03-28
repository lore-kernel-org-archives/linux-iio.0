Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0219E819
	for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2026 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774695385; cv=pass; b=C94fpnrRlH8UKZ0JKrE1LafbRVX6suNCh7A6xv4ty0V1HB4qrNLsrlEyd+97RQ1Sxk0NpaBf8kgW+p/oOWWLKEUiL3K2heqbaSmVJAVqNOXjBqqeNSRmTt1dpJYn3DPmuoaw4SqEBIf3oILwip5DYU/lRFweAoM+dLjof6BD/lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774695385; c=relaxed/simple;
	bh=Q6rf2d4TEu9Dt5nshO8m5f1z58ow2zRkZdvzKBMZv18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMPbMbKf7gomgOIecHpYj0aiy3JUWa5ebdf/mphf14Vk4R9loEiwgcmBFJXaWjd83vBz3vuk6B6HZUW7FsrdnEb+0sw+2z1rBzEZMTaBCNG0Xk14LClV5ZryeXs9BkJYT5TsPpauDuNt0NhuJEtXXhTwuzptN5jLcXWdZy5XGT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPPUFqZ1; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPPUFqZ1"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so3184641d50.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2026 03:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774695384; cv=none;
        d=google.com; s=arc-20240605;
        b=Wr37QhT0iIor8dBN4Spk4Xvcqx2fLq3RHOAZAHGmTfaOX2upuww9LfnIqctpp0CJJp
         GyxK0gNSMUm8IyU+sfCOwmQV1P+d3/ts3nDQH1ozr+GlJAdSoN0TiNKVlJQ4as8uuA50
         08RTFDmgMSl6F4Hsgo7+/nQZYVKCds3MOF2XM0Q3fLZ35nBmLCOezKQudo68BI3VMWsm
         y9kvQz4jLpEU93gAN0YAniTlmS0ZbuhfG1FTwY0XS3ZDqs792cNhPO4RH9Zr48u80RiN
         fOM6DKz6gagBcplDfqF+WQzFydwsSJXN6F7gKNt41BN9lCVwvojV6LewMG3kJ/TTw/Zx
         InXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RpsDWLJU5mEjf5qczOEamc7cgc7t8Yrz/H8cQi7o6yI=;
        fh=DEZJyIGYq1uwCdqkAe2DcXaGaZS98yfpCFIj+IN0LtE=;
        b=JdFPR/47rfL3DpsS5UH0YVIKWVxyTf0yhi+s2QjJTYpYH5vGT2EWivzbIbxkqarqL6
         4M/0FRM/pxB9vJrZbhsyPMvRzupF9IMCBnntBXytzWi2d+kTePwrVA7gyyn3MH5hlHtr
         tfORqiUhaBTes7UeLV7wXQnDH57UJ/6c9SPBflSlYjXGUNN+kRi/kYtawECIeY7IIldd
         s5vs4cVAp9uk8me6UC7UzGvS+GsuPMZjd8oZvn2qho3Zl5wcfoIeVLaLvwpcnD2NYmz6
         Rf763XZiLcCHPDgxFIhNJFNyNYeNNVRC8OGomNTqd2A15P/SDXauGN0plSeiVz3vbg4u
         cuzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774695384; x=1775300184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpsDWLJU5mEjf5qczOEamc7cgc7t8Yrz/H8cQi7o6yI=;
        b=OPPUFqZ1X9CrXDMYZxmWgozn/Z/f6WayYENMX4yJhMUhNLDkeLzKzrlXsTY6uSusOt
         R84i5aRM9kkf8q+P1EpW7cPCemPKmsH6846KXM10uQye5sD+BDDldp67TW9dBADJCgUD
         hXT+XY+ZpdW7xmUx/iALZITZglqeXvVR2t0U1apv/2cC09vuLT0mSl90i6n+6vty4BE1
         Sw2rapBybFP1duOUuUKS6uILrtbArEObdz8zJ5XnKzEaK63K6vev3w1kujprKh0yk/Fp
         /mu7Bv0MPsZA64WgR0k9aCCWZL/YpB9jGvWWisKbfQ/oEFVNI9OdSXjS4gNvhGceR0UO
         JWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774695384; x=1775300184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpsDWLJU5mEjf5qczOEamc7cgc7t8Yrz/H8cQi7o6yI=;
        b=rvdhDxlEFKhcPiOeDM/5Vv/2bDK34z+bzvYTWqfDt0L1jtMygZ3ViZGBCDBsWUlWlE
         X3pqzrFTrW5c1oBloZWPvhyK8kOCjlsMJasaVuqhAHjEyBM4jiv6J1qD2pZsMXPEgzas
         Z7D9oJFQ2tWoCCnrPwyncEIiOT98lplhQ0AhxH+z6rjmaI64CrlIpVTSCSRAzh80cEnL
         5UmwU+vo85dspXltCX8nVUjjAZETIWISMZBDaN6ecBS7RPlTw2o7tsMbRAy79GeKxtFb
         OsxtWCd1l0u4i/rgJtmv/GNDT0WZkyd9svEe1JYNxLla57GxlqUfo1hNIceTUwELesjz
         8OGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXEMct73zThTF9erFhrag3wB6sh0Vvno+PUiZgaiLxSoRYMXSTYxBZZBWEw9czkOI5ecURVfha8ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/X3ZHiMU6x/PWJdZ0FFBasTGUwsrp87zIgtovF6D+64kW/30J
	An71ShzS5qHh3rrx7I1HELvOJ7G9UNdCeJ1LNTmVfvDfvdxZlgz2FejbK3GKeHGhiOB0z5rIHGg
	Hc3M4uQdV4kr0fbjwP09sooxleYfFsUo=
X-Gm-Gg: ATEYQzzIZ0PkolmB9vS2WifsXt5UgGFo5cT1KO9iy4iq8EM+pksWJhkpUhA0cboKAQ6
	jAHtsz3P4QOpmsXC/q6KelbSCmW8neaIunP2XceFg8M1dVNbezvHuojI6NfdfPOHYVU+3E+YUNG
	Pm9Dig0MyJvhLkJTe7Cs71UY4VPLUc0HY7N96WL9LHVYu7EWkVCWcFP4tpeYCncXH8AnQQjwsYw
	OJSvQThgvgBfAkEhJCLja3UGjqpKvLVuOrBqPt/3SAbFRg5X/NeXjvk2RdJ4xN8mxg54iusYgfL
	9sn6+C+S6zq8tqG/tIfpCbT4hYEn8Zuidy77pzjYDlpV8ztCaqdx0FPp1ZEDpRIsD8TDP9bXrw=
	=
X-Received: by 2002:a05:690e:4809:b0:64e:a3ad:cd71 with SMTP id
 956f58d0204a3-64ff71b7a1emr4293979d50.12.1774695383662; Sat, 28 Mar 2026
 03:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326180529.19154-1-architanant5@gmail.com>
 <20260326180529.19154-4-architanant5@gmail.com> <acWFI9KMN8Qtouuq@ashevche-desk.local>
In-Reply-To: <acWFI9KMN8Qtouuq@ashevche-desk.local>
From: Archit Anant <architanant5@gmail.com>
Date: Sat, 28 Mar 2026 16:26:12 +0530
X-Gm-Features: AQROBzDRldnwGWVIiSXfcd01kzVvsq5wHj4O3h0PYG6VCCwecllaboGgUkGeH-o
Message-ID: <CADJHxWAMC2spE6gXN+86prWi1+QmUrnSfyOSFyToYD=vTDD0VQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iio: adc: ad799x: cache regulator voltages during probe
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:42=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 26, 2026 at 11:35:28PM +0530, Archit Anant wrote:
> > Since the reference voltage for this ADC is not expected to
> > change at runtime, determine the active reference voltage (either VREF
> > or VCC) during probe() and cache it in a single variable in the state
> > structure.
> >
> > This improves the performance of ad799x_read_raw() and removes the
> > dependency on the regulator pointers during fast-path reads.
>
> ...
>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/bitops.h>
> > +#include <linux/units.h>
>
> Can we have a prerequisite patch that sorts headers?

Sure, I'll add a patch that sorts the headers.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Sincerely,
Archit Anant
