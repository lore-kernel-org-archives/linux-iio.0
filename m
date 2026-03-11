Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E83090C2
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260542; cv=pass; b=Zc4zTZdpW8XfwoxjoGcJAq9VaM+HFHl3AHkkwUVr0o2hcbEBRTacps7X3dRuhI1V5xx96roV20OSrR1O0dHl2rZquOwnxzRBKNde1bX7NoSCc2iwgasujZqvR5QRN8XrZ8TakYxoB9b7SkkNRfuZiXujy1MtWDu2AtByIDNmB2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260542; c=relaxed/simple;
	bh=38+2N7ZJuFyG0UPwIwmnpAPM6azdgPeuvfq8MVnWFYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTtmsVNVYh9A8+pRK5xajD6OSS9kK6dGiiMgIRCz4uli7hJaQIK6o6xk9VtUSnLlBPVyBzYhMWUHS3Q8zLRQbHHa9+XFZLsnOkxuCZzAqaeGkJPw7X2Aw1pXw0/3AUfRqPoX8beZQL/zo9l7cI4RB4D4XntrJZxC5VJYXSLPH78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs1Xh4yD; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs1Xh4yD"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9431300833so36578066b.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 13:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773260540; cv=none;
        d=google.com; s=arc-20240605;
        b=YZ8lP6MQ8qsswQue3ZW3jhgsrQC4dJVImgOMxB5uOXufuEjs79ik68oqT41V1mmMQJ
         u8uVLm649OAGbOqtPwmU6R/NrjenpqBpWcC01IuXzRei3cdIX4og/DiSwX67kDnq5lmc
         rxfvxLRgFj1hgn4wpNzIEyyufDlDJ/ZeHirAIqUsjYZkLerdYAR6kdkZZX4HZyLrJ3f9
         36cf/ZkIOSBAfDlP9PHRJ4I1C7RTbp5PQuMkSb6sydfV1UBza7gPhJf1wLdAF5YrSgAE
         KmzGTPdEf1R0qOqqo31dQ7mA5NFY7dARqCHA4+UebGxjs7fYcZIX6+FMnXaM3ucaXoOo
         7+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bB7481rsK1O6nMKj5HmnagqD0USg3675favP4HtAnJI=;
        fh=Maw/rq26/45z+esJtnKnZu3lzEVf0tjFXmoBPXHvSFg=;
        b=eC5Emb42Qj480pFywASDqTNWJYIyPjuoc5pjBqk0rO5uOdYGR9y6fW7UyWLzUM007Q
         u4KyYkiYcPjRAaiX9IytAfIJh3BdjACRM4raWzTlVWwmMdAnZifvHtRIz55TtLH3TIZQ
         M7m2B+53+bqAvxv8e+90G/RnFXrcCiL38mxA3rtTBcnudm66d7tvijiQ0GisO0WGGwVk
         sY328nBdoF8qitM6wqlXNki1gZ27x1iIv6OGTko2eYzP9TOY4cCGl4je1iLWFkwC7P6Z
         EeXg3OKuEsP3q4JdIHe4qGJeLZ9gJc7jwW2ja4MEr/tuCbOUfQK71F8g+cbNlYuun7YU
         MIMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260540; x=1773865340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB7481rsK1O6nMKj5HmnagqD0USg3675favP4HtAnJI=;
        b=Qs1Xh4yDz1NV1j+DooXwc2wpmeRN1sVK4ilLShqVhwAqkDMgonFTDfHjw3CT9b21Yw
         M1i9AhAnptbi+yh2HU3A9iurBDjh5ua1Q9sk0fnbB0rDXk2IqXRi76S/sTBJG7ONhtY/
         7jy2lUwnnDdVGBN6GaU5mrUyvhHPyqwpC5SJ/Sftt7Wr7l1ykmwptzt7TKNIAVR5StGR
         Ik3Q/vadsUS0D3ioB9R0nPTy3SZL1d7SKyQ2Gex9WhAHMHdOotiBJqkY8dJ0nvoRf2UG
         IxtehUcLmafdZXcFDSmTKl7ADXF7RmVqZHLESaGs/R0CeXlWP7pj+tBrBMd2+4ppG+Xa
         YRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260540; x=1773865340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bB7481rsK1O6nMKj5HmnagqD0USg3675favP4HtAnJI=;
        b=q0kcX5U2H5RhFBRht5WrAfLGXYxWFFa8Vdw8NRNnQ3DARE9nvHez7MeaYa57MPGRRm
         V+WTFr5HPfDlgf1kOduvMG4lvGxgKWIklNfFSitML64N33VRTzasJz+fskGWE5xLJ2Po
         tyF4wlQRIPnPaj8oymWUPd5UgEpMfj+o5x/+T2eE5XRRHwZNCefkwfGsu9t3yWhanxfx
         hEDQ0yAavApl2iaSUW0M0x+VMyCBA/HyMLDHegvtRBJy+NOYq9BFyutYyRxFS6BWhkpl
         j3eqBag7mr5q0rcDuxe+ZGGAu5vD3SvPvT0V7Mdp/CrDyvtTy4j0DZULahmpsyKlt4ia
         kkTA==
X-Forwarded-Encrypted: i=1; AJvYcCU44v95o1Viv2FpB4UsviMOrBstfPdM0hmfERabkMhJjIGecuSiTjZQZXvWSn1s59lYX6RkEyTviXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr47lXsIfVAKVVcQ+OT0Fx4SFy/EmU3HRW2EMXQpkrwK9E7E9W
	PvpOjRFZ9DLxgoqQm/N2IAAUR2I1wZb2kEEoPRCzym03b9EjQZX0YJ3c6dVEU0EK8uvYXClRaEe
	AEMv1EJ4qY2sArnSqDahnzijz0CkggLE=
X-Gm-Gg: ATEYQzyYnAcackriOuj/KCoWR6EnFEovCioSR9twBZLskc4zA4BUkjtaeyz4516V/J2
	iJnlM+S1VRuzCTcRZ+DRZVG+BNuFGBOhYWp7uchwQxwlpsRfmcsaRHsvAHjzD+djttbyZlZhMlP
	bMoJS0O3AZqCzA5TAYy/OCoXE80BEasFVA6FrC415MPPUFJ24yWN9ldAfowwOXEwmxwdwvuotrs
	dEyYdFaRo4sXmeUTmjeNYQOVUDfxF8ocYwwnD/+rvqQJsZObJRdZrnks7d4IL5kCOfKGeJzWIBW
	GGxVwCsZ1dL/16v6+gTM0Skn90M5f6aeNhijiokHudv8eO7unCnNMNxGJnIKDuiyQuVwh3F1oZ4
	mHeGynf4=
X-Received: by 2002:a17:907:3e99:b0:b96:df8c:42cb with SMTP id
 a640c23a62f3a-b972e534dcbmr218538466b.46.1773260539396; Wed, 11 Mar 2026
 13:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311182050.3467471-1-sanjayembedded@gmail.com>
In-Reply-To: <20260311182050.3467471-1-sanjayembedded@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Mar 2026 22:21:42 +0200
X-Gm-Features: AaiRm50R55fdindFPEeUQt9rfkKPHdczecHaTaDxZi8DkDzmfiFHcLVdIYXirG0
Message-ID: <CAHp75VfsAVy8xBtftMwdzmde=9Bf5aFbdr+SW1=Ep01X8eaDhQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: st_sensors: drop temporary kmalloc buffer and
 reuse buffer_data
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:21=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Replace the per-call kmalloc() scratch buffer with the statically allocat=
ed
> buffer_data[] field present in struct st_sensor_data. The existing buffer
> is DMA-aligned and sufficiently sized for all channel widths, so using it
> avoids unnecessary dynamic memory allocation on each read.
>
> This simplifies the code, removes redundent code and allocation.

Spell check your commit messages.

> No functional change intended.

...

>         int err;
> -       u8 *outdata;
>         struct st_sensor_data *sdata =3D iio_priv(indio_dev);
>         unsigned int byte_for_channel;
>
>         byte_for_channel =3D DIV_ROUND_UP(ch->scan_type.realbits +
>                                         ch->scan_type.shift, 8);

> +       u8 *outdata =3D (u8 *)sdata->buffer_data;

No. We don't mess up with C99 definitions. The only exceptions are
loop iterators and scoped variables which are none in this case.



--=20
With Best Regards,
Andy Shevchenko
