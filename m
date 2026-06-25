Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6332E06EF
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370413; cv=none; b=pQPDrGs1GA5t/rcuSG86Ug+E2+7VdcQm7zbuBd6e81MtROzLlppjU3D8nD+YeJomHUxwyI6p6KQl6ItiejZtLUfrSocgRQQSo7lEZ0CJQDVLUIu1+U2ZDF4dqj/1xhtg+xOPVerCoW+RbhWzruMHJm+ihJOJuLzwCRe/o995u68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370413; c=relaxed/simple;
	bh=ocDMCPCVk4vD8AsrlTz1uxLK3tzjDYYHl9+zv15oNCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORjKNV6uCHtYe3dPwo8/6IojA2X4zZagAk4Xa9DZNrICAtqAB2N7KeO+aaol7lspX+z1tYh02dIwaBtNolJMrv1JY4E3jK9Utu6nQ2Iv/nJQ0nFYKeWrAZSZ39p1TtkAYxJJFND4lJ7qPZ6V1Z4TzSXKwxGjfV0MNIqaVT36mL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeFmfYUz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeFmfYUz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso13949365e9.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782370410; x=1782975210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=527+QTmY13teDKGyNepJ0jPYC5z44tEECNyArKFfF1c=;
        b=NeFmfYUzmvN8K0fhtJiP4JeRt/akMAFlIus5hY5LyVHuWcGM5oNCxlMP07PAErUOEe
         ugMu/wJk0lkosDYrfn+TDx7DY5Kw7OGAVdT8h/VcSPtUJX9GKO1+t0z84Ytp7c8vEeIz
         LRI3ns2HjtJE06MEPdVa+uE6V5HH29OfnrGLOYNbit9b+XiQ1UWBFzjcTXJ5Nluqgukz
         qCCKrPvnDWRpuId63vW9XfHAV/DYvEI6+wf0Q6qxCs7ssn74NIXRWQNm3MxMcmiCyAVz
         /9zpLknItdaFuOXHJ9eizPbdsRA9KUdXtMUN8BBl5gv7BBQ776EGVzsBiU/DmdX4cSc6
         O3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370410; x=1782975210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=527+QTmY13teDKGyNepJ0jPYC5z44tEECNyArKFfF1c=;
        b=Q8winwhf9fB/RCSDS5dk4cOIsbjC6UCk9A4RtqZN5KEsd3Ho5k91vOOJgVr0hjgUdv
         R6G5s0QUMJma4t8qMfw0aGKDlahsV4KA+wt45xfNzG4klmtUbz3YdL4Kt6SYQZtpv+96
         ciuKni0w5BYKeT+pYfFbTrU/H8QIsldIq8sTvQAtSNntxG6Ca3yGX1Hjl29+2ecDrVBX
         dMeImcg2Xh4uzMAyEPsBUuzFwhzDFwC9UmecFtPPuFzHP2AvhyRVy/jqyuxWKAPNfipR
         ofB+K6+2ff9R7I8kKkImrfr9PMI9S5uhI4XPcUNIzXQG4JCPgPUYD7g94uRoN1QJs0wH
         ej4w==
X-Forwarded-Encrypted: i=1; AFNElJ9c6Yk0ag0gQquMYekQmPU3fVyViMX8VC4OP7URDr9x3QL3NbHI8bLos3UJnWEG132984Zaakx1zJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3s4aXzygOJfolffk+nYuC8wOWKbdpoQEmsemiJICwRg2w3L+
	ELm0n5qq3CKYHXA2FX/lRIbnIonqoXoMKCFxH31tqJxtfQORBoyvucNv
X-Gm-Gg: AfdE7cnlIcK+QQvsmMY5AzCkeQwCyKR3trBmwd0qH6TBvn1OYqKOUlNNooACJDYZo6P
	wXZCbshu4luOEAY3dpaZE9pR1vW77adQg/SoQqqc/ktwdMoRuH1DCOlq3L8MSFH+45UyDcXdr3U
	s7J/r3abVUsD/AM/hoiPWTXwHPzbS4HDAVZcNoZifqlmqHPmRk6YwQgY9PxwmPyooTUXH9p56Ge
	JhGPQFqNChXX6GNBxDfP8CtxEuur1vaPxj5tamWlH+zD6M4ShJXO69j8DEnVnnbJIDaYTE+Kpc9
	msHIFVsRPUJxo5yMgdf4TE294J5BH+joT27XnFcLNuuOso1uWLK0AqjTaJ6yHpc0ni4OOqU65zb
	GRm0Rt06gxKlD06idLZQo274MzHpkTTg+51CPRBhndOUTk7qGQ/QZAtHzKX4YoomUXZsrvvAh/+
	I6i+D42yfYx6vgUDp76fcccuB+teh7XON8qB8gVXBz1pPtOCphCeVrgAo5E6mPsC07QxKAYZn0t
	LbUHg8gfPCOIWUAtppHm212CZY5fzY+IkHAiNJvjUJhBqAxcIIJr4U0N4DFw+Bm+8BvXAOnL7GA
	U05m6Oq8L9Vif/rVDgW8ixtI9bKzmXqQE/L3uzuge3LVocMWOTvx8tU=
X-Received: by 2002:a05:600c:6219:b0:492:4fc6:75e with SMTP id 5b1f17b1804b1-492667c7325mr13136695e9.0.1782370409895;
        Wed, 24 Jun 2026 23:53:29 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49265975147sm44140535e9.5.2026.06.24.23.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 23:53:29 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:53:29 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <20260625085329.00007959@gmail.com>
In-Reply-To: <ajzNmy3Vhh_Zl9Rs@ashevche-desk.local>
References: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
	<ajzNmy3Vhh_Zl9Rs@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jun 2026 09:41:31 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 25, 2026 at 07:20:42AM +0200, Joshua Crofts wrote:
> > This series adds REGMAP_I2C support to three AL3xxx ambient light
> > sensors that were previously missing this dependency, causing build
> > failures. =20
>=20
> There are two problems with the commit message:
> - SELECT versus select (see the comment against patch 1)
> - you mentioned build failures but haven't provided any evidence, please
> provide a reasonable lines of build output to prove that
>=20

Sure, I could elaborate a bit more.

Just run `make allnoconfig` and `make menuconfig` in which you select
IIO, I2C and any AL3xxx sensor and `make .` will fail with errors such as

drivers/iio/light/al3010.c: In function =E2=80=98al3010_probe=E2=80=99:
drivers/iio/light/al3010.c:185:24: error: implicit declaration of function =
=E2=80=98devm_regmap_init_i2c=E2=80=99 [-Wimplicit-function-declaration]
  185 |         data->regmap =3D devm_regmap_init_i2c(client, &al3010_regma=
p_config);
      |                        ^~~~~~~~~~~~~~~~~~~~
drivers/iio/light/al3010.c:185:22: error: assignment to =E2=80=98struct reg=
map *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer withou=
t a cast [-Wint-conversion]
  185 |         data->regmap =3D devm_regmap_init_i2c(client, &al3010_regma=
p_config);
      |                      ^
drivers/iio/light/al3010.c: At top level:
drivers/iio/light/al3010.c:48:35: error: storage size of =E2=80=98al3010_re=
gmap_config=E2=80=99 isn=E2=80=99t known
   48 | static const struct regmap_config al3010_regmap_config =3D {
      |                                   ^~~~~~~~~~~~~~~~~~~~

Hopefully this is enough.

--=20
Kind regards

CJD
