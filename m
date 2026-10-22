Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792634342;
	b=bBhNlF/gQVr4wQwiwRzXt/cVsCNpAooKG3FMfarWsnopPCka1TA6uhwmGCQnRF+YLe0I
	 J6IPmjfNnKq8Uqpvm1kspCrH1moDfljUEZsfevFF0+8j3GzAjuAcNJXXyngC6iXiCOEQs
	 H8Zhh1252B9tumYGHVEX6OCeTw4lwkcb/ljjOoXfDjHLByl/nr5N2kV7THv6nPThMpAYF
	 Zjh1mMfGt0Mys9vh3wBfYciKePalzsHIlgHO4OqohEi5G20TRSiDvVSGj7OSh0AF4KB7J
	 FEYgdMCgN+AA9qiEoSN2G/A5MQBcwdJlLEFlvTuPMga1Me+HkOX073rhQujuh5b7cPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
	b=1qJOteioIrzLl3HDSZMGcgyBWG0cyPuGD323UyaDgfam8NbryQ1//vdUvY4Su9VktSS9
	 42+o5UrYz3VAsRFXvnU3SqUIPJlB2ohSz/9RYsxPPqriMAn0KWcdrMyHp4XkwS4CqvcC5
	 9X65NX51cVT7CH0Pw0yWx6ZxvkhIAggbdRAWQe3Dz/ggELeyPZSzAfz6nb8IdHbcDVyzG
	 F2fT+n7BVUfjBTG36t8UHe6CGwDBZgilwGlfJ2oXSKDEAxVjGP0/goZPOy0bC3jUZ3MGu
	 3inN+aXYgrxh5GEAKXAsjadeKUbXe1JOc0azolY66sZbImt23N5m93/pqDIXpukr44Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=murgatroid.com;
	spf=pass smtp.mailfrom=murgatroid.com;
	dkim=pass header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=Dn22YTWF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1B606A31E
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 01:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA1B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=murgatroid.com header.i=@murgatroid.com header.a=rsa-sha256 header.s=google header.b=Dn22YTWF
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550c917fd3so1824841eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 18:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792634341; cv=none;
        d=google.com; s=arc-20260327;
        b=GoGkfNU6IA30M0PadKHqvNtIGqeM+i1m8+WUFulBLEwmb2qDCHbDcvSM9rce6rbrhN
         UTA53x6jboMdhEkid+AINPoGMhqtG691NuQkvujSwYUG0E1XMncbBPOfrUetHJKcm1wx
         HNYF4hc7LyIz540NJ1iBGtPE4uEp7H6wwHyygZh6UC7gmbvwhaD9nmKGTLVA0WDHRP67
         MeTxBQnQ31WHO4i/yA5QB4udbh+9vQJ8XvcG+VtU9SfPBr1mS6VkLRW3Xus5yY9RmWnM
         wp8xCPOPd+1LZIlYxf7/9hP+HFX60fpty9H77bTP2R5AsHdd1wOT+CCdTQGgvgY1bkz2
         FBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        fh=vkUB1hxcquXv+TpKt4W5YvkEZSE5UMPGdJ5NCCUkDf0=;
        b=lBDSQMbKJjIT+SNTPaWhBDhz5dixe8sLd9QS6tlSaNrZPaCG0q932lNlR7mzed0acK
         rFRZ8NrNJFFQnqxzFhB60osSg69jkrKfMx01c7G8p9oEfb92KgoCGZ4gyTMSod2PBPI8
         CIGg9HbfxobPDH1oMLcssUc04pYCAg93VlGURBt2BunOQrCjmCRzrCP979OJFU4V2DT3
         k2Mc4vZrEJaJmFxSIeFbGiIgWKjMfpO2Wx7UJZnLb3LZNGWOzTyx8vUgE0alXdfHdjsL
         uxVOBSwx7vXPh0keRI3n/DcMP9TfhZWu7qIQO+8E9SqiuOkGHq7zBJN0LZwKR346kwgY
         33xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=murgatroid.com; s=google; t=1792634341; x=1793239141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        b=Dn22YTWFHXuz5eBGAfgcXhBaSngAcdqW6Ktq+DQbZGylcggyWaChglRW/PsuJhLKQg
         ttkF4JCIZP0NHjN2sKShcr4i3TjPFg+AUESLvr8tjPomsIvOO3VHDGgnFbu7HXRmkwJz
         kImqDIsxFiYu0K537EdLnpNStdF056NaZPRo14LbHN/aqM0mWS4rIhbcixaBq8jovoA8
         W6w1+JotaqCa3STOt6xyC2CdQVdq2ylm+m5PNfmvuVoXH0WeS7zIEsdTk6dsJR64Fv2s
         xW33Ws90oMWQ2mjlNcvVNYalCROvgRUMnn1KIjCqem8758v8B/qRmxfeeJxCtX06kTx/
         cZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634341; x=1793239141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ow6Xf98skWxAAfr4tUT3DSmhy2FgTs7yUfongXRVX40=;
        b=aF/t1NjvUZkBhVmo69brr5j5bmXvnUVG/wCt+nocJF144zprEAonDDIyaM1aTRNPyq
         +od2JKoRMbElgilms3nBTaF+Sy+UtLg7FbvnCAkxEC683G//XoyrKeAU7iCAgbSKeJJd
         JaXE1KjIHysgMqK0siom1tdkcj6uiVICTzVjmDczXaGwRBTeporVaBGWvYH8cDeh6hOR
         eQyi3C/6WFbUeYNaAeF+QfXz/YDj+Te0bxFtLH8QED87LT4+0QUhB2J+W8Ms+swkjcC8
         OtUuccJcjnLDCakKAjCW2cPgtk9CGJPP8mSkuZtammfjHv3OcYFA88+3er1s3aEpqVgx
         QYMw==
X-Forwarded-Encrypted: i=1; AKwUvBynhvySoDpJfi4hC3of0gkX4d2QGULQE00hJ3Q0IKsY9wo+NiI9ZEV2bshSIGsVCSBdJhx66HHKAc4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv6OAc6KTxE7lBTJb+1f1aFi5uJ0u7whwt6R9OINm0Y7DolO7U
	aLO2wzG5F1INob20VdHUxAp8KXh4U3VrExRv1y1xr4GoZMEU1DauiSM/3PUxujrojcgC0RKogeb
	mLhsM6fW+jWehbB41n6F6pdTmp+zpMsot16NiFe1Z
X-Gm-Gg: AYBFou01MAHuAOITjeAFKDkAG8a8/G6UVuqDRMdSs3bPI5aFQ8eJzO1IZylJZBhGwZG
	Cz0Bh0jagGABuRTOdlJN3M5KzqvrNGROWhhQ95vdMqfFHXLLe29/KhBCYBrnigOKLJDbzJjVo2n
	1B8e5cg2JoPkAupC1qPFbABXvl8dVWT3QDsbhBZyZBKPKU3yDS3hocWngD+NCIEX16HvGpNCvBe
	O80o2JlIOGvhzptPodkGmrZxJKTwlExDD9osfnsgcWeNgE5aqu2fK+jco82/E3hfUu1Vxiwb9qZ
	wM0ZNx3BauyqN085G6DUv2jj3BAdwU+/RBhFMvlSwdX+wqdOSE83wzey6MeOXi3B4esowKGHsol
	J0XB3c9GhK+I66dHsssv5jUxwPhYZjHzyW2S1w3qJNu8sGDYV9COLoF2NzvadRH28e6a+b2bgKZ
	7KKzH9vBUjJO51ALgKIOmUcqb02fYktm8N754=
X-Received: by 2002:a05:7300:e70c:b0:351:1bdb:e3b7 with SMTP id
 5a478bee46e88-3674cb37bb2mr5335214eec.15.1792634341036; Wed, 21 Oct 2026
 18:59:01 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019023420.83976-1-ch@murgatroid.com> <20261019023420.83976-2-ch@murgatroid.com>
 <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
In-Reply-To: <4470c427937d26035d81b99ee7d06e2a602ee4d7.camel@linux.intel.com>
From: Christopher Hoover <ch@murgatroid.com>
Date: Wed, 21 Oct 2026 18:58:49 -0700
X-Gm-Features: AclHuK-UlpT4QZJ3hk8thqk-ORABl_Te8RQcU0z-w1fijnZP-8kQdVwWN9ZtSy0
Message-ID: <CACw0PsaJr6E0Y3AXoGKDUiKp4vsaA+GEJjPqEhYuSoKqDp1jUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback removal
 with raw events
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Lixu Zhang <lixu.zhang@intel.com>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  Is this issue actually reproduced or it was found by some AI tools?

Real life.   I wedged my kernel several times with an MCP2221A usb i2c brid=
ge.


On Wed, Oct 21, 2026 at 6:22=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sun, 2026-10-18 at 19:34 -0700, Christopher Hoover wrote:
> > sensor_hub_raw_event() holds pdata->lock while it looks a callback up
> > in dyn_callback_list and calls its capture_sample() and send_event().
> > sensor_hub_remove_callback() takes only dyn_callback_lock, so it can
> > unlink a callback and return while another CPU is between the lookup
> > and the call.  The sensor drivers remove their callback in .remove()
>
> Two spaces before "The".
>
> > and keep the struct hid_sensor_hub_callbacks in memory that devres
> > frees right after, so a report racing an unbind can call through
> > freed function pointers.
> >
> > Take pdata->lock in sensor_hub_remove_callback() too, outside
> > dyn_callback_lock as in sensor_hub_raw_event(), so the removal waits
> > for a report in flight.  pdata->lock is otherwise only taken in
> > sensor_hub_raw_event(), and callbacks are removed from process
> > context.
> >
> > Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christopher Hoover <ch@murgatroid.com>
> > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/hid/hid-sensor-hub.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 6470a290ebfc..7cf9f398592e 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -173,7 +173,14 @@ int sensor_hub_remove_callback(struct
> > hid_sensor_hub_device *hsdev,
> >       struct sensor_hub_data *pdata =3D hid_get_drvdata(hsdev-
> > >hdev);
> >       unsigned long flags;
> >
> > -     spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
> > +     /*
> > +      * sensor_hub_raw_event() holds pdata->lock while it looks
> > up a
> > +      * callback and calls it.  Taking it here too means no
> > report is
> > +      * still using the callback once it is unlinked, so its
> > owner may
> > +      * free it as soon as this returns.
> > +      */
> > +     spin_lock_irqsave(&pdata->lock, flags);
> > +     spin_lock(&pdata->dyn_callback_lock);
> >       list_for_each_entry(callback, &pdata->dyn_callback_list,
> > list)
> >               if (callback->usage_id =3D=3D usage_id &&
> >                                               callback->hsdev =3D=3D
> > hsdev) {
> > @@ -181,7 +188,8 @@ int sensor_hub_remove_callback(struct
> > hid_sensor_hub_device *hsdev,
> >                       kfree(callback);
> >                       break;
> >               }
> > -     spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
> > +     spin_unlock(&pdata->dyn_callback_lock);
> > +     spin_unlock_irqrestore(&pdata->lock, flags);
> >
>
> The patch looks fine. Is this issue actually reproduced or it was found
> by some AI tools?
>
> Thanks,
> Srinivas
>
> >       return 0;
> >  }
