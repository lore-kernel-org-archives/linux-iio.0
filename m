Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07563876AE
	for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2026 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774696427; cv=pass; b=aKt6tyPpEg38GJUZm33JgoixVz3kAF/dy8i4OcLa30d8smer7BVZeUTVBeXZHBWm3cXWKvcFXdnlg3jURWsj9JwZOLHx/dG8rd73LkDSd5LTQFZBEBE0hktXyH7amYDTGjhxC0+AHO8Bs6SOg2GiY0VJIwRXsSx9EYE3c+t35qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774696427; c=relaxed/simple;
	bh=WlGGqljGNBqvG92Uu4C4Q5euss4e3NTVuNRxXJV8Ks0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrB+tcAiPCs9+xGdZwU7iYFZMAxiohNXgvUG9U7DOnWeHKKUdLoh6Yz5qeFov4g1rfBZ/t2Pz8n6nGB1vcO/ygF+oa8qrkUnb+j4twF3+KMrBDi+rqiNODqKmkwn9qeG9mtLcFrWKRbDk7xf/xxLX2WACVrbp9Gk1ddBjNdMzTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+83BruP; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+83BruP"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64fc6b21789so2221367d50.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2026 04:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774696425; cv=none;
        d=google.com; s=arc-20240605;
        b=DG+kcDJjKiQrkOcdZuaTAUqlzbt9z9JvmzVFj+Qu2ET123FitRUEmsTOaWdH7ZRMfI
         7HtGDBzo5Ec7rUTixFOb5EpqodYjLQPfv95Dm/z2CpURmQdhtaL0AkzDMzCUobwTQKdI
         uipR6nOOB19ksFu+0mfOutZHbQ28jxJ4EE9g4aeaLS1/uRPIPMjvpvrFbp+NCGyRxb2x
         ZB9LYy2MI3Kwf5XABaAzGALMBMwyAOyYQ8oWREdcyFJCUZ65eWfZvEt8wR28zvB1C580
         yajrrPvJB6zfSomeiYx5HzRQiLfnd75/aQkckNSoZ91fdyylIzu9myflXPlAMYftf8Bt
         3N7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KMYyhhG2fTttfMZ39UGwS1VPqV6Vl1dFDU5yaDpECd0=;
        fh=ar+9CveIQcVxUlcrbZr9MSuTajccLxpDU3j5M+vZ0mE=;
        b=WS9LJzLZLBBYO5otQ98ypCnMBH/dqG1uuj7emiKM70fbhuYhLyqUq1lOea6HPxJtN5
         S8OA0Af5NJS1a8E6yefzKsVLw/5ssSEch7w6KGkWrJ2lRceY3TZQfGcpP4z2Z+/niwGE
         iPu5BzIymvc6SDo4W+ceWpGayEsGpUrpnJAcR2qM3sBVk++mG78pqnGafqYMRv9EZwrt
         2COnm1IXHM8JZ210EivKsNpqTKD0QVAJmRXMyfj7lwZige7Idw2kXIlNi1CTsk8Veknt
         cKWncLKsuJlfXehSOSvth80bObAgeJD9PXyT8bRzNzuuqmeQXhErN7AX84gHVZXCL4tt
         bx5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774696425; x=1775301225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMYyhhG2fTttfMZ39UGwS1VPqV6Vl1dFDU5yaDpECd0=;
        b=j+83BruPFbqszQzA7xI6WGDVFbK5pmDV+Vv+mNgzjMq70ZX9Mx+QG+PF/i/I5GCLEj
         KJeT9DFd53Rnu5QK5UbfVeTsxQhOJD6bX9ztfdS9SvtxVRNWbMEl/0snf5pF0O3+M/Bi
         jYCxdewXj2AEdPTI6iT1+qoc8Nz5QgKOsQ+E/CLezK31FHOGqfXZb2ZnEdE332NWAIZw
         MR1sttrsm9SATwbPI+hlp7eSMh5DekO+XRCs82UMP8jHAXoY6uohlz3Yf1KyPuoG6bfb
         pFhjNhVWP5oynbYU32bJWN+jan+rS75wJE0ujjTddGT3hvfcT3b8r/zAaoac3l1V9Ux0
         CgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774696425; x=1775301225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMYyhhG2fTttfMZ39UGwS1VPqV6Vl1dFDU5yaDpECd0=;
        b=OSyCVJ4B7ibruez/Fhqjti7oPHtr7zym69l45KeQIWTmPC0JT7lqA5InP6Rxhp8pH/
         6PfD/sf0M36hbu87tk1TwHF0/tXW3j3bWgwqkpFwFADcoLDpXLqEgQks13bHdhelCqJu
         yp/xAPrCtv4NkCCcflscqAabmUQKKb3g7XXOyt/cYnd5nGWY+0VzlIoyqukYemlMvIKn
         8v7fpIkZOHc16VyTWNrn71hP8TvL2JHh5BEGMmI7mgSGJkrdShR8mhjBaTqBXSl1QCnu
         n4L6vLVATYNTx3nsf7DDiKfrDdbVvELqKQhtvGxUEECeCGi0yTrYwjDjiDchhxwM8+3i
         wg8w==
X-Forwarded-Encrypted: i=1; AJvYcCUEDopf9kRgqRdFMj/JowL0xYzIyKzsDHQDiB3mtAQoMochNLhX6jMx295RxUypOGoE5JEb51K7BgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVL6h/dFLOamVFqAtkHPEoFiLu5T7XZuLhmtOLtjXNLX11Rs6X
	h3kwwTveLxjJl7u/WcygNuY91EcEIGXwJxsECjr5P+8coSlbCvFnqNTgLNdAy5js7mEmnoMSOEK
	Fa+bItklhnoWoBNr1pp7LODopaIZHjns=
X-Gm-Gg: ATEYQzxygTeb0dVQlr85i3Vr0xYFrZY57NTIabZ9LViv7+47e9b6IZKuZsYbkxRFrxO
	pCZ6X3lzL6YdG27XmXtQlifB8zyYprHjBNURvpkCrOy4Vi0qJusRlvbfxQeR6nW5TVfXgUq7TO4
	OJSJ75XhNFFgoPbopfTLom98HXK6VbYARfgSARbr8vEFGnG2Sd5DUuhvkpn0Ttj152CT60/1ixO
	6P0eXf+92/fLcISFdCxCCs6/HPZCoobBxAhRCRVvSlYyUKU1eSjY97vWmXzRruHnwMX14m9KAfD
	f5kV8M6/No/i/v8i5k4Nbs0W9FkXE6uSC3rcsi9n49kwg3DCq1Rq2FyyiJjhltdNyOop94cRSA=
	=
X-Received: by 2002:a53:e744:0:b0:64e:a8d3:df81 with SMTP id
 956f58d0204a3-64ff72145c6mr4373854d50.30.1774696424626; Sat, 28 Mar 2026
 04:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326180529.19154-1-architanant5@gmail.com>
 <20260326180529.19154-5-architanant5@gmail.com> <acWF3erQXdxlxGAH@ashevche-desk.local>
In-Reply-To: <acWF3erQXdxlxGAH@ashevche-desk.local>
From: Archit Anant <architanant5@gmail.com>
Date: Sat, 28 Mar 2026 16:43:33 +0530
X-Gm-Features: AQROBzAg005vKBU-NZewlsP7lKan1SFntP927HeLpZQ9Dl3ptG36X8tAhJ1EJ8o
Message-ID: <CADJHxWBe5QDX2BhE-gaw3dYvjbSGhFR5kkx84Y4v7LwEsc29Sw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] iio: adc: ad799x: use devm_iio_device_register and
 drop remove()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:45=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 26, 2026 at 11:35:29PM +0530, Archit Anant wrote:
> > Convert the driver to use the device-managed versions of
> > iio_device_register(), iio_triggered_buffer_setup(), and mutex_init().
> >
> > Use devm_add_action_or_reset() to ensure that the VCC and VREF
> > regulators are disabled safely and in the correct order during
> > driver teardown or probe failure.
> >
> > Because all resources (buffer, regulators, IRQs, IIO device, mutex)
> > are now fully managed by the devm core, the unwinding order is
> > guaranteed to be correct (reverse order of allocation). We can now
> > safely remove all manual error handling goto labels in ad799x_probe()
> > and delete the ad799x_remove() function entirely.
> >
> > This eliminates boilerplate code and prevents potential resource leaks.
>
> ...
>
> > -     mutex_init(&st->lock);
> > -
> > -     ret =3D iio_device_register(indio_dev);
> > +     ret =3D devm_mutex_init(dev, &st->lock);
>
> Looking at how far from the start of probe this is done, it's prone to pr=
oblems.
> What we need is to decouple this change and move mutex to be enabled befo=
re any
> interrupts or other async events may happen.
>

I understand how this can cause issues; I'll move the mutex lock up in
probe before any interrupts or other async events can occur and send a
new revision.

> >       if (ret)
> > -             goto error_cleanup_ring;
> > -
> > -     return 0;
> > -
> > -error_cleanup_ring:
> > -     iio_triggered_buffer_cleanup(indio_dev);
> > -error_disable_vref:
> > -     if (st->vref)
> > -             regulator_disable(st->vref);
> > -error_disable_reg:
> > -     regulator_disable(st->reg);
> > -
> > -     return ret;
> > -}
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Sincerely,
Archit Anant
