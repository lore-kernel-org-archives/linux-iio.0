Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064B330328
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887823; cv=pass; b=m2xkZIfjfhMF9MGBTmBpP9NCn8wgRT0+rsjjVUqal4Vz2feFD4bzrFQwE1yShHAp5wRbudMMnuNsDbrKgy004rrsXgJwZwkd9/LB6HnzOnOOpK8ivgO8rmL03TeQDS4pTezqeRtGfyUno/Ckxm35giGvL2L+S0Yu9Rm8igBa9mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887823; c=relaxed/simple;
	bh=EFeaMKilYWGX1XMXzgGkEn2zYLcYkWlw4Z/yiMD6M0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf2LFLDzAc2Yv+WQlV1pDGz2QU+tNGExTzIb5c5nc4BbiOtfG5Q6xoDW3YteIRgBvj22uUT/fY4Ag7mfdR2eOp3DnsHsTqeCum/9GH2AbChMb1wBc3Y/35h62yvcMma7MH5k1vhKeaNGpjm0yYz2FRAn7oKGbdJ3iKpnpcmxsgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuFNlil5; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuFNlil5"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so748276d50.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 19:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773887821; cv=none;
        d=google.com; s=arc-20240605;
        b=aPgkcP6dTDUMLv4CibIha+pBZUlUWpu9ietFfuzB3btM+1D5iyIkaUgz5V8OsMLEJI
         QBaEYQD5ti8c37XRHzA/1yyU8TytnlF6gtEGn4yhh6txYyTC7Wn00n7xL9U5IPyyJO/B
         7u01PMAn3ax69W9py33crkQWMGd6Zpxct88nU2sAHe6dhPRULi1jHGRIdlqB2fg+aInn
         OBZAEOU44YuPPYRiST8ZSLCikqZ7OAe7oSxKomUFzQKGTuUSavDGT094+DZcNGMw0gaJ
         DaQNf+U2quZXvF20Qx+nQTH0BNZs1bHW+aDO4W3KLJNorAjB3naXvwyjA/3e5ZG/GRy/
         vw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ElYq+oTK8+nRutGz6Shz1p2+MZzYihLiB9R2Ot3WgcM=;
        fh=/miEqew52RlMXV1Wg2nIo111+Qbhr2oUzVQsmf4vL8M=;
        b=MuKMmJrWX4gaeyAA5iNuoxCMw4rSx490itDTqW5l3epTv44wMRlCYOCa5Gb93isz3I
         PlX9jOjVIwf30vdPUzFf3yep7LI/OVIO+N9llwqCE+DLa3ANWTLmCcPyhIw6I9pa38X1
         n2YSxgFPA7laj3XUeOTnlQw/DV8H6/9aGOvW4/0lxUkyFjoQvyBDaDFOlhAoPxQ5wfGz
         /nLA5+g/BbSdgBUTy2OTSqxM1wsgQkjU94sWGykSuR0+e5nrLnbTn5kQOY2x1FVuy3lc
         cj88vCElKdwLKuxh3S1rrXG70Q4UrTOiqoqIP6bGxmv6jzTWzRUhxcn6Cf/akSX5zS/v
         4hZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773887821; x=1774492621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElYq+oTK8+nRutGz6Shz1p2+MZzYihLiB9R2Ot3WgcM=;
        b=ZuFNlil56qWHMvRIr3KB6R3GeDY3b/WdXDCMWp18gKw/I7w7+/2eC1yctM8Hd4Xs00
         JWzRni3gt6Al7+XsQs8vcU29NjVinwkFkxk30Kj7/9xg4fomXiRRRf9yhTPzd3uzT1pb
         SpzMAQL2jHc0uvCGEQLZNUQhQbwN2U3OmAq3bp1NARSa7VfZCDG9sm2XVSnrH3LbHuh+
         b/BfnMMG881BDxIRHZSpkohiOojsaTdZvvyQBd15BRGnQeEmK3v39CkKhRyuBLxsEMg1
         l6QAk4oMeHOHuzhAiUYz0Skd09x5U2xFBosAfyYiVEW22GQ+jrxcNrirjYhPMw8rJ68Z
         RqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773887821; x=1774492621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElYq+oTK8+nRutGz6Shz1p2+MZzYihLiB9R2Ot3WgcM=;
        b=YuuFkwJMejKxliRaeGc8SqKnFiDCONfHud7WKcHLHudCE71Kd4O4t0qZO2TBEi2jxl
         +ZVqnk7M2Z/DKZjZH2jXsuLf7glCQq7Sc3uxxvQEJ23whj4U+oPY/tuz+BUdWiKNUspV
         BTyWpQJMjONZPSxmXqnJ3GVlbOnE0FwSY+LHbOI5SiJRYi1P4wKkvSM+86zvv7Dq7KzE
         bahu6OaKjS9pXlDQvWkMDm3nZocGWOZyBR+IqiGcIdKhdQZsRnj6PctdhiEhEnr3EN7o
         0wyetFr7FdN19+sDuGpthIA2ItrMJ7vf69t6XLnARiRjPUTNz8exefI42r+O5s1peJAr
         tEEw==
X-Forwarded-Encrypted: i=1; AJvYcCW6nA9uAB7Fq9DxR9EvfPp5i00hKjAXCPY8vN9jrD4yJo2u2ZJHGyhip5dXW+IC+nQpnqpJKncELnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXQS8Fwz3cs4lX1JEs0+Ff4lc4QirzvV3Qhx+h0OSiw3NwcIN
	OdBMIUZaGd4wSiVyINn7I4JH63/UR2ado2Cap7PZMT1J9GZDk3lDst0/pHqsnncyd9gAWMgSWra
	bWeO+AvW3gqUTEaWMozR9MHC2PkgfpVo=
X-Gm-Gg: ATEYQzwaczH3AcJ5+C+4qu1ZXRx79wceLo5iuCnggT9JsRF1MW8wY8AU+N8StxhNkkt
	KjPmO99dH/A6r2InV80U1g7ilo7T5wu+6dcLWlb6k/OVGDGBT54bhTKHEWrYQNOF438qVTIL+3S
	DaAYN6guM5etMLXx7QNfdLIPKBMNYZBh3uNYVWzGFaF7wn99j0Y/dpJk0tuYNtAYdsxNx7Nle/l
	FLu9uDro7DzYpIikcA3YL7bCCUkcnKpA5z42E6j+R7JiyfDn+vBFj6PldZEu5q+Uw/ZqozEez6f
	Yy+cZW2rHmbWzGzsS62f07i6IieSe8mA+1Qdiy2aU632q4KwzH0PxHinVGQxVWx39uG07Ts=
X-Received: by 2002:a05:690e:389:b0:64c:9c1c:5f64 with SMTP id
 956f58d0204a3-64e9161405amr4759964d50.75.1773887821439; Wed, 18 Mar 2026
 19:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318092715.42538-1-architanant5@gmail.com>
 <20260318092715.42538-4-architanant5@gmail.com> <abq5dbYrYuq5DQ5J@ashevche-desk.local>
In-Reply-To: <abq5dbYrYuq5DQ5J@ashevche-desk.local>
From: Archit Anant <architanant5@gmail.com>
Date: Thu, 19 Mar 2026 08:06:50 +0530
X-Gm-Features: AaiRm51idL_sEZmadldZuRQIUtx69Pt4q-VHzHMPCypTJPFLFHiOcDNqZH5RgRs
Message-ID: <CADJHxWCcdNTj_76jomZPW9ifojj0iuWsWYUtWkYxbp7M4CBtpw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages during probe
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 8:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Mar 18, 2026 at 02:57:14PM +0530, Archit Anant wrote:
> > Reading the regulator voltage via regulator_get_voltage() can be a slow
> > operation. Since the reference voltages for this ADC are not expected t=
o
> > change at runtime, it is inefficient to query the regulator API every
> > time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> >
> > Determine the active reference voltage (either VREF or VCC) during
> > probe() and cache it in the state structure. This improves the
> > performance of ad799x_read_raw() and removes the dependency on the
> > regulator pointers during fast-path reads.
>
> ...
>
> >       case IIO_CHAN_INFO_SCALE:
> > -             if (st->vref)
> > -                     ret =3D regulator_get_voltage(st->vref);
> > -             else
> > -                     ret =3D regulator_get_voltage(st->reg);
> > -
> > -             if (ret < 0)
> > -                     return ret;
> > -             *val =3D ret / 1000;
> > +             *val =3D st->vref_uV / MILLI;
>
> Not sure I understand properly this MILLI in conjunction with FRACTIONAL_=
LOG2
> below. Is this simply millivolts? Then we have "(MICRO / MILLI)" pattern =
as
> of today to show that in a better way.

My bad, I thought you wanted me to use either MICRO or MILLI i.e the
fitting one
instead of 1000. I see this is the preferred way to show unit conversions.
I'll redo in accordance with this pattern.

>
> >               *val2 =3D chan->scan_type.realbits;
> >               return IIO_VAL_FRACTIONAL_LOG2;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Sincerely,
Archit Anant
