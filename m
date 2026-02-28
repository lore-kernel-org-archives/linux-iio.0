Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5D2E7F32
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299194; cv=pass; b=RkIGBau5cJ/Lo79c8mmHnbIWPKxLkvuymbc6HeIsz36cOFSkWyskzsmDWV85UlJG1oEgN7ZvEy6iY018yhMGH86FHHAiY4hMjpF5FJBHtl9aJnCAI7fkEF1oHaexZSSnpeesuCG/iP4gQUnr1kyUq6UHnJ2nc+gCX5VWMX+nRNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299194; c=relaxed/simple;
	bh=eLqgLHcA8Iq3deI6sbVSW68PDbuGHAs4owGt7UXg7Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4PnOGO3gb6c8XjMcoViFcE1FjQeE/6KwRX8258uTIFwx7xQbEKaB42DNGHMKUVWOupABeW5OFN5/4WPN48FZBj9uER2IaX9lTBf+kjzqErrzHXbeQI0UI5I/WK6Fe34HN1hjQrA2XAUXP6rSxUv/Y5RKmshx49QXOJzvCw0Lw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS2/FBll; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS2/FBll"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-797ab169454so29503807b3.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 09:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772299192; cv=none;
        d=google.com; s=arc-20240605;
        b=XxbEnOQ6eX/LZ5hTEjNHaGdAunGc1zdGNbb1BbWnl6s5UMqR0Lw1POn7sXUvGiUxmK
         wXWmPTyRebiNLpQpX71e1qMcSulZHCDj/fHP3Ps3sFsNRctJFofeLci3iXaH1cpPJueZ
         J2PQr108keTpgxuXahTdNlADaefRghz8l83zaBQ7eY49axPDcO7befBGlwXlAcc2veVY
         GBZ/dYX5z0E/9uMcdyjfWh/HI6RI8MFrMvnI7HW5svZE+7J1zuEEjO6NmDS7CGn2Ighg
         +EQw6oJmgGsfPSlwsEGWsAckmnmn/RU6BKt9r5l6cGsQd4VPgP7A7gN5wQEHW/AFAV7g
         cNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eLqgLHcA8Iq3deI6sbVSW68PDbuGHAs4owGt7UXg7Yw=;
        fh=uo2FEK0gqa8Vn3w1Z30qvuzrzgmadTpCpE1yWISpqYw=;
        b=IXWy2iTBP/XdX12OUEP2fsoGPtoMCfhtycJp5HnxHgiiUmGTEZ1zwZSeqtAzILS39U
         Vu2E/fhgsz2M+2FFW/vPqX0B/2TLpjG0OqZlb6o+GuiPxWX9PYexJM2/WbXYCz4IGenh
         z22VizYjiODDRrnONz3bi+DyQv+5xY6I429RZTVrCKlA58zf6/mCtGrhoBbZoQjjRuIX
         ianmkah7RCjYx0GhJ1cfAocAgY3RYrMddjyyTuhQV1sk7DyODJETQdSuzJgIHWU38GmU
         95VBfB+jG7HGoKlIP0q+CEtdXQIh5fG/96VOF73yAbvwxgDXqUfQJHP4g5DIeGQ6H41P
         FttQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772299192; x=1772903992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLqgLHcA8Iq3deI6sbVSW68PDbuGHAs4owGt7UXg7Yw=;
        b=ZS2/FBllsFGcK9yOuwEvQvqjn9PorYZGf+ogYLLfbJTG59Qf0PiSwpOZwm47gvUz6Y
         2nrCk5LJ+IrFQUQroydJpWG0pR7NWDgKRCmtfEeLA5HsSKH/E128S9pkDxWlOXUfpqvn
         igEgvKxiUd+bX1QCq0o/lAvGWEkket4ejSISDgJDplpic01O7HnifMrZhIu6vtxmkyt2
         WvuLIickdwlHC6KQ1DtDNW9IpQ/yk6Q6FnCQ+DTfiaZPvze7Y1AbdSoqpd13gGXKW0gF
         DdxiPEEyo1oOZAtViq35OhNBrPKPAajpJZKvoQ+2ttTvNq+ubOYbQ2Sc8ElCdqLKw/ao
         Gusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299192; x=1772903992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLqgLHcA8Iq3deI6sbVSW68PDbuGHAs4owGt7UXg7Yw=;
        b=eX/Wja4g1BTw3EuUO37sScwA3ztGWNWYjilItuOGtKeIh2hbuujGUiYboWMrMO6lPJ
         BiKjsrKkOX8RH6giUfo+66JO3a6Pk05IuMxO/nVQSFz6WdKJDUpT3/2U+ZMJqqchEls0
         pLWIged2mHxUMUEZ03yPtF4FDVYa3SRlGUQM7T06SZQAdKujmbK9aNuuzr2mA1kxfWcr
         nK7k/iuv1XRJ7mVcRKUSJqZncOT1I6mS41Ddulq/WCTfkMuk8/NmzWYixcRZlu+6BNJJ
         gu6XJkWI6VZzMdhFkefslyyi7ynn7k2Vk0pSJZgnhWKE3y8rgR5s/0ZAz1bj6CFaVM8U
         NUxg==
X-Forwarded-Encrypted: i=1; AJvYcCXDWQ+Tcx6tEl/1iembvtI/my0WOtqiHrWckFroCbrakr97lWUXS7eEEBaWATlbBP+d7vN2u2lrwMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWWq/Ak1nbDUXi/ft4P214Ju3Jx9DR6BSxGKaO8HaMnv39ddp
	/Pxi4cr35fDyEqzqaehQXUxD7U2XGdyiugKyBRB1iIe3wL3UcH/Jdlnqy1GPEEhwC+DXAvqUPuu
	GfwM6WjYNyQ22QJwMKXh7DKMsALX5PxQ=
X-Gm-Gg: ATEYQzzz2LP3aVTOfRnbahcz213CbqH7iPldm/SLg1NV1gsG/mk+RizFbLE888z29m7
	2xnbANGS8V2ee5iTtdijMbOZAOobouHNfGKHajlHfqtWc/Uk7AIaO9+k42hceOp5RchhVqQ+CzU
	tzhEe2dSpJ1lLzeE1wqb5OjbSgeciqJ94WnEPrTbwtRMuwZZZje5QAS/AM7OgrMa0vn/gasNbc4
	zYkcc8SoJiRs1ZJwM1R6uU1WWORAM0Pfgtc3N9i2MLztxk2DOjZtmsRFq8OquMe3UCQmyWEeBFz
	MPSFVI35dJF3sSMU4KQ1LsFbUaR7Rhsbp29Ifew=
X-Received: by 2002:a05:690e:1449:b0:64c:b401:f52 with SMTP id
 956f58d0204a3-64cc23701b2mr5539225d50.79.1772299192417; Sat, 28 Feb 2026
 09:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228154515.16639-1-architanant5@gmail.com> <641c4d59-4cfd-49b6-b6de-692db48db1c7@baylibre.com>
In-Reply-To: <641c4d59-4cfd-49b6-b6de-692db48db1c7@baylibre.com>
From: Archit Anant <architanant5@gmail.com>
Date: Sat, 28 Feb 2026 22:49:41 +0530
X-Gm-Features: AaiRm521txuXhG2EnO2eaB5xuz0pDxQp1IZtZ1_1n90c2KEK3q4g_7I4TfTjWes
Message-ID: <CADJHxWA6QT9LqAR4n3UUHsr73X1S=SvwWCtO=M220SBUD91p-Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad799x: use devm_iio_device_register and devm
 buffer setup
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sat, Feb 28, 2026 at 10:06=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 2/28/26 9:45 AM, Archit Anant wrote:
> > Convert the driver to use the device-managed versions of
> > iio_device_register() and iio_triggered_buffer_setup().
> >
> > This simplifies the error handling in ad799x_probe() by removing the
> > 'error_cleanup_ring' goto label. It also removes the need to manually
> > call iio_device_unregister() and iio_triggered_buffer_cleanup() in
> > ad799x_remove().
> >
> Since we are doing this, why not also handle the regulators and
> rx_buf so that we can drop the remove() function completely?

I completely agree that dropping the remove() function is the
ideal end state but I initially stopped short of doing that because of two
hurdles:

1. regulators: since ad799x_read_raw() needs the regulator pointers
to call regulator_get_voltage(), I couldn't simply use
devm_regulator_get_enable().

2. rx_buf: st->rx_buf is dynamically re-allocated (kfree then kmalloc)
inside ad799x_update_scan_mode() based on the scan mask. If I use
devm_kmalloc there, it would leak memory on every mask change.

To drop remove() completely, would you prefer I use devm_add_action_or_rese=
t()
to register custom disable & free callbacks for the regulators and the
final state of rx_buf?

If that approach sounds good to you, I will gladly prepare a v2 that
eliminates the remove() function entirely.


--=20
Sincerely,
Archit Anant
