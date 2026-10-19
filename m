Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D824E2F1A
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411752; cv=none; b=CSNALcr2keQaDu6/11ByruiU4X7GxNaNyzw8x+q6bw+sQHwGMYnrlCBrau8Pco6TkKMuXX4gvA4CCtMgrUFl4JyYxxiFYJ+5wh4Oct+4aGOPk4yLYl6RSvx7VN+PXxMliN7VpLKxs7tpvrBJusfM8Ac3vojB4+mkZYVbiqybhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411752; c=relaxed/simple;
	bh=B6PGmkEOmOTvRMG4KJSxa+Qi5H7nSmTaQb5cEDlkSyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF25i3F0lLD1w8hrDhKdxadG5wzNUPFknCdHv8aGn6gpbEfMrIYRwIrM8+5+CaGHguzZr7zvS9BWRIAAGauJYNw8Jq1ngzIZA32dpwzexIbkFRWPVuxYFCYf6jCK3QFY/gPzR33qa/Jh0PyUy3Wn3PYfr8yGeKtqZvIq8ay2+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG0nZZZc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG0nZZZc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so13808655e9.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 05:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792411750; x=1793016550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LQMT+oVedzgIQTTgsSc7H1Q1yfN1sP8EFn/tjZr2lw0=;
        b=aG0nZZZcNESLfrAJZ88dTK2CwmbB/xFE0YTlAIeNI3JH6AS3EtXBYYqJoUXNa8t1OG
         bqu+9nzydFdpZsPMtljMGEz+EiPasNyyN4v/N1BANtsJK4lvHZKV2eb4ZrQlJtO9rJU8
         GFhQ3uza5XhDizUYFWGt5eBMbZ9yje0ZAu3f7wPxHJ4FAYenBwEUWiOQNhW530wuXpPm
         9VHoao8d5EYpwOz/C+HiFlDbKhBOIPo6n/Yx9QGMntzEML64Ymn21T7jNEtcniUGz1It
         yEDNJaxe/uHBodggLQvTtIQYBEd9Rn52jeFLPKO+zG5qLQ9G1LurnbC/hq/sJpE7pCVW
         Vodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411750; x=1793016550;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQMT+oVedzgIQTTgsSc7H1Q1yfN1sP8EFn/tjZr2lw0=;
        b=05iqwy/7tmwy5pwv5aJl5lLIrpqptfNNT3eqyQQWwu+VqY9feysVRrzbDioJ3gobCn
         DtBynRYJbbc0zUj9wS2zsD7fo5E4qzN//LyeEbsGfUtSMnkCIGILjQcBQk6n74BpIAix
         KWtj6B+F144ZzhIuZEVQTwJEcH8/TtiJb+kv4kN0BjIipTPmDPj3GEcAt/2W8ibfXJO/
         ySdHLZP5OzrJldnScPaP9NSIWnETXSZOBbE0TV4yabJwK0+f240K87kV3gV4KVvka2w2
         jTkk+6jNfVJJDQUAFwpunCtf/62MPvUh+zkHLzDY+M/PYvkpvt6opW1hPpVkdNoK9bhM
         9ydA==
X-Forwarded-Encrypted: i=1; AKwUvBwfhxNjcj9UZx9JSbF52swE1LBstayaielQLgRnA2/FGGAIPpyq0gLrCrO3/raM3D2L4zNCVFgulRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcAKCr43Na+CYSeqyp9nrj9U3GtzvLnMN4aPDln5+I0ObYWmxD
	7sl8cpp6F6zlmtAdGrJatCvVNtYa974sGkN7VbzVuO7Sw4ZGnwyD8Sgo
X-Gm-Gg: AYBFou1WUvqUOWQqm4jhwlBU6wYXUXBDjrFzIjyJt0wd0XHrpW07O9QQXi+yP4iYtOe
	jbDvHqoX1AIL72d4lI3tEy0+ig/SLKXcrqRzL7v0jxPylT7HcpYrbbZahTpiKrK4rx5KLMTAb7g
	vj8P0cB8isQhiNPtBX4F/rx5Uy2dItMy29ofBWH61YjL0ZRk1/BE40tWpFyrEZgvoB99Xkwa+lS
	jpIexJi/xuPZhLr+dTIbWZIQW1UdA9VMybR4S0qfwDVYIy9DTTrsCGjyZgboi7pXr32T5risu4h
	2fiDatQzTkhwg4D5UP+HzzpJeasNUhyQjfaYrIHY5mEkd3ZYjtd6lKR7PiWYQ8gmfXPGR0wrQQB
	a4+ucE4dVXYEkbnH4GGY3zHwQuWGIh+0+Buwt/kKgMQ30rpKG4PWTWCQkJhWTrANshqi53781KY
	q519qlsXA/oZKR0nOFJtHCrlHZe4SFwlMKMQbcjzU6g6LejqtDV63yulrNhmCkhnwyqPtuwMcUg
	a+rUucQV469JqsXD2HVRq1xW3dxNR0C72OhclfJUW5SCoq/IWSpWiHFSYc28OlW7B5gbLSrQXAW
	Cp3/bv6sWlwpnc4sEe/PabHTmyuwU0Rai0lahyEiKyt3NLPE3GuqtxiUX6qwF6oiry2GJc1nBQF
	xonmUBN0o8KwgHkidf8O8/Q+5/+5Oex9xP+uWrxrrnONm9hHP7wwHCKDGxvNpEKbJdIMFaBHIYH
	8DVehG
X-Received: by 2002:a05:600c:4e8a:b0:4a1:8961:78dd with SMTP id 5b1f17b1804b1-4a1d7616464mr168857525e9.27.1792411749417;
        Mon, 19 Oct 2026 05:09:09 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ad6245sm279022375e9.3.2026.10.19.05.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:09:09 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:09:05 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dingisoul
 <dingiso.kernel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: gyro: mpu3050: add missing trigger cleanup
 on remove()
Message-ID: <20261019140905.00000094@gmail.com>
In-Reply-To: <atX1alPtnByIsGFr@nsa>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
	<20261017-mpu3050-fix-v3-2-d6f29f335a2b@gmail.com>
	<atX1alPtnByIsGFr@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 11:54:41 +0100
Nuno S=E1 <nuno.sa@analog.com> wrote:

> On Sat, Oct 17, 2026 at 07:19:21AM +0200, Joshua Crofts wrote:
> > The mpu3050_trigger_probe() registers a trigger but
> > mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
> > to clean it up, causing a use-after-free bug.
> >=20
> > Add the missing calls to the iio_trigger_unregister() function.
> >=20
> > Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> > Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.ke=
rnel@gmail.com/
> > Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/gyro/mpu3050-core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050=
-core.c
> > index 879caf3b729c..9e747836df3e 100644
> > --- a/drivers/iio/gyro/mpu3050-core.c
> > +++ b/drivers/iio/gyro/mpu3050-core.c
> > @@ -1262,7 +1262,9 @@ int mpu3050_common_probe(struct device *dev,
> >  	pm_runtime_get_sync(dev);
> >  	pm_runtime_put_noidle(dev);
> >  	pm_runtime_disable(dev);
> > -	if (irq)
> > +	if (mpu3050->trig)
> > +		iio_trigger_unregister(mpu3050->trig); =20
>=20
> Yeah, I think sashiko is right... I think we can just reuse the if
> (mpu3050->irq) condition for unregistering  but then this patch depends
> on the previous one. And such dependencies can be set for stable so
> don't think it's an issue.
>=20
> I already pointed it out and Jonathan seems to have said the same. If
> you do have the time, converting the whole thing to devm would be nice=20
> - could be patch 3 :)

Bad time to be lazy :P I'll have a look.

--=20
Kind regards,
Joshua Crofts
