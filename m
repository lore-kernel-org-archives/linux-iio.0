Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A92DB781
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779036995; cv=pass; b=H8CEfCF+IfCMTn+ndwnnr4rvx9gxwd3/Gh/KbXCYXcXcMFUzrwzgfEp8uVxqSnouWUhVOBede06+0EyCls4UbRISwPg7WfcR0omuQuMF+xW+3Ha5RpSpjUmYnI76gvw19O1Jib8JgBAdDGN75O4Mojwgsfj95A27ebnJYiXWnMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779036995; c=relaxed/simple;
	bh=MUjh+oHaRCc/cv9DTSI5erq1wByDpr8s0je1rxLgQl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcJPvhxjXvObGoM6k7uJhS9U3hxnFAG4fB2SbZ2YqSYXKSJIY/JfDa2BmrATPeekHrW23NqzCxY/74akgm+IMz96B2BX9J7UBnFI2rKeOS5VbQ0YTY600QWEpiNVYDcEeb/+qTHsTezToBQdE8lnFlRXsARiCtzz4UOc5rWZXcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=si/Pimyj; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si/Pimyj"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65e15fb394bso1125008d50.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779036993; cv=none;
        d=google.com; s=arc-20240605;
        b=ZUIOICwAPJf0W7mzmiQRq+qTgjojx67zsdKEzKDaD2wm+nAIDUXUFDXQNv5DlnGztg
         wZ4pt8Z05zqXrsRS/9YpY1xC/RhAZ26iL+wa0wIixv+mrRyad7B85ggndP4a0lDsB/6f
         lqcQZiA7567xP0wHtTJPfxZUsVb2Pp5av6EMrYUThsQsamhll56ucXjtvwa8aD8PEEUh
         nwHkNFA8l1kD8yr8MZ/UvXFq+LJuye+0k+7wkk2HI86CbIzxOq/D+RBk+f9HMXbVNPvI
         eXLCz5aJdlfhLGZankECYWtUFqGe559epjiQPElx4cnIbjskJuKcBbzYm5Ep+YOOOi1Y
         c4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i/55JZGS4Yf5N+QpiIM3AsqyWU4hWY+2mWlPLLbuMos=;
        fh=1IWNdY4tRrmlp9SeeLfSt9kLyGuczWtnye/9CZhwJvE=;
        b=igSqLC6qFnepCG1RSEvjSGY29QYjzpJXasMsxgSuPUn1urn05TUEhtfaF+7RXn1Mq9
         vJ9owDZO0D0TvjiYjbuZyI0fBxQv5DrYUj7xCRmi2Uc77RTyNgb7UxPI4Xtt7lYKLNwU
         pd9BUILKoxM7M58PU7Bx/vnvT/9CVWqFi6JRnB6Rme5HZM3vnKF3MTxOrWNGaigbeX0m
         tWqkDaXbrx9vJ4jgYh8P9qJhtnrz+4B6FoyrxAFKUZMGRD5JyZI/DYGAfCjBxrqYIb1V
         ridCBLo2WJHZIUJ7jjFcnbbP7E+qPurzvtjBsZh9vK419W4VY6EXYPaTiMS0YDiZj7BX
         7gtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779036993; x=1779641793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/55JZGS4Yf5N+QpiIM3AsqyWU4hWY+2mWlPLLbuMos=;
        b=si/Pimyj0pjb2PN8IWIfDcw+wdAr02cdGpMyktLX2xFjH0b3FPaTmX965bH/wtWPqY
         QrLVpIblzt5zF4bQAskbVoPtJ72KFqNhxNDvfu1WXpNUee7IwY2cRWQUgm0PNKKAUn4J
         YeQb76vHUHyeXVfjH2SSFo49P1n9qOG4oloDmo/y3C56wFH2PT5Vh04IYH8NkEwCgTJQ
         Qq6cOiuR1zGjZ+RjcbNs1xn5d1ZdDl9cn+NMaoJjcal7PIs+zfOSCbtb/7LMvKUBHCSo
         hRwpiMC39V+7IikfioxEPuNTV7OEb/jyn0uhZ/4UUdDE8TxqWjxLpnesKEdS3ExSuZa2
         qhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779036993; x=1779641793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i/55JZGS4Yf5N+QpiIM3AsqyWU4hWY+2mWlPLLbuMos=;
        b=lqu3Yl8LEC3wRPrtbOkbWlfGW+WilZNXvyKjBa1i9AYZexqPVqYTmEHRNv7G4sKUwU
         pCAUhwU6Ll3qH5d6dBGs5WQTDEr/e4O5EZ9f6YZbfrLXjSW7A4/pTotWI1J7uLhcPxrR
         Z748TxUDu4aOo4dpxXL9aZXsgrlIF87qiwebax34JrPmJrHHZCU2F2XqHU3WT+osamcm
         7+9M9yTo1if5QX0RicU7cGm0FRs573ig1ih/onWICFbDoDvX9Hf5OzAVjPzK4apAan9P
         xC9C5tLepOBeDGjIhT9y8IeJEsiQ6fZ1dRRmBJcxN5AlUhaWo3+Y2OpB2um9Mn6FXSsR
         w4Kg==
X-Forwarded-Encrypted: i=1; AFNElJ/r3ril+YL+K/EZtSFHTHhdXYjA1yWiDSceF3PcrKmvdBA6W2/4Ehdab3HTqjCb8DefmZOjeBi1my4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVEXemLz07SwKAoxBB2WzpbXU+61wv2MLORThEhG5dsV7bkiN
	dnYY3cKoyffRGSuyuQANFfIUMYWxgImn3zWC5Sn9B8yqpIEEVov5+vOKiRNoU45rPd4up6NaWzf
	JeGYQYPCc0dN12e3NZY7Fylq4TojRX6Y=
X-Gm-Gg: Acq92OGgiNfqpCSPIgjOpYaAM9LAnN+NIjT5b9vgCCrEp/TgvyuwBIagkP/OsnsweuJ
	yfcK4NCLFHr5qwf8wPLoHuf3hmamcN1lPjI/ZNO3fbYzZ2ssu07RBereIiRqDDkFefFoGOA3qnA
	dEbnrHZlYy9OLJCTFtDII0VjF1k1NQNOAm4KxfH466GTF7Jxdl1PqR7V1KMX70J12YDz7V1ZKuF
	nEQmhYO8PaFadQjNRU7KAld6aJMQlHsyQyhnm0qHBvVoJwZPO8w71Ewp3cZ/Mlu0Vph8aOHCQio
	d3DJvbG0r9oY438Q
X-Received: by 2002:a05:690e:dc4:b0:65e:28f3:4a4c with SMTP id
 956f58d0204a3-65e28f3523dmr10361954d50.64.1779036993477; Sun, 17 May 2026
 09:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513013638.147606-1-m32285159@gmail.com> <20260516135458.7a4c3b8f@jic23-huawei>
In-Reply-To: <20260516135458.7a4c3b8f@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 17 May 2026 11:55:05 -0500
X-Gm-Features: AVHnY4IyMPMrtZKmskGZjmKov8N0_97X1ePOQHDMaDQa6K1faUm8ExM2Q18PqBY
Message-ID: <CAKqfh0G8xGBwwZ2-mVfR8PitUXh2gWJ9=pkXB_XVWD4fiXp8Tg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: kmx61: Fix potential time-of-check to
 time-of-use race
To: Jonathan Cameron <jic23@kernel.org>
Cc: sashiko <sashiko-bot@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 7:55=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 12 May 2026 20:36:38 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > A time-of-check to time-of-use race condition exists in
> > kmx61_write_event_config(). If two threads enter the function at the
> > same time, both threads may pass the check and get to the lock. Thus,
> > when the first thread releases the lock allowing the second thread to
> > start execution after the first thread modifies data->ev_enable_state t=
o
> > force returning from the function, the second thread continues executio=
n
> > regardless. Fix this by moving the data->ev_enable_state check inside o=
f
> > the critical section.
> >
> > Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigg=
er")
> > Reported-by: sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159=
%40gmail.com
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
>
> Sashiko has more to say.. Please take a look.  I'm rather nervous
> about trying to fix the bugs it's finding around reference counting
> without anyone testing.
>
> Maybe we can get enough confidence with emulation or stubbing.
>
> https://sashiko.dev/#/patchset/20260513013638.147606-1-m32285159%40gmail.=
com
>

Yea, unfortunately I don't have the hardware with me. If someone else
wants to test then maybe...I haven't messed around with QEMU much so
honestly I wouldn't know how to emulate such specific hardware.

best regards,
max





> > ---
> >  drivers/iio/imu/kmx61.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> > index 3cd91d8a89ee..3afa369de3cf 100644
> > --- a/drivers/iio/imu/kmx61.c
> > +++ b/drivers/iio/imu/kmx61.c
> > @@ -942,11 +942,11 @@ static int kmx61_write_event_config(struct iio_de=
v *indio_dev,
> >       struct kmx61_data *data =3D kmx61_get_data(indio_dev);
> >       int ret =3D 0;
> >
> > -     if (state && data->ev_enable_state)
> > -             return 0;
> > -
> >       mutex_lock(&data->lock);
> >
> > +     if (state && data->ev_enable_state)
> > +             goto err_unlock;
> > +
> >       if (!state && data->motion_trig_on) {
> >               data->ev_enable_state =3D false;
> >               goto err_unlock;
>
