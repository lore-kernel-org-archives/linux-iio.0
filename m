Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4F317145
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650804; cv=none; b=diShTxqRHEgygRAvUKyaiEmBxuE3OKCdxBnfLBSxoUnNe/WC+s8qnEvNe7zuVx56UyeMeTdeAXEmP89F5BzYl09Ih3458vsKC7trThfuuQeb86qxeLiRdUf86+a7VAYu5KgUA020mzYg5HdaUMOULHQyfB1PYBzPr+DdW5ww1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650804; c=relaxed/simple;
	bh=9wJZiSmpJkaWQYC5Sfiwp3fgYQo5ibADA/Ym5bAdoUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9HfyDJAZYZKPFewuBkRt6cQsLJFi/7NbTpEHFTlfw4bKWejMZkS/YDE/S5H5hs2McSQgALny1VHih24+xqq6j00dkmuti5tvmko5Jwc3KhDH48CR0eIvtM1BlZ2hKn82MHsVAkBLDCI+6jFyhButL+r0ZiCppL8/KRyCuicyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YogIfKM+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YogIfKM+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2022323c37so709711166b.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787650800; x=1788255600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9wJZiSmpJkaWQYC5Sfiwp3fgYQo5ibADA/Ym5bAdoUg=;
        b=YogIfKM+15Dzg2YCI254Q2GLk2kXGzirtzYQyX7r32WqgLDsFvASSJ0KwNHLyeGUkI
         sJFL3A3Al+tFUmD5bckn7MQJ7q12QTc5rfaQ6hb7UGVUs1BF1GMbMX8g25cl/bW5pFHr
         c8j44xqc2Gugl+zkTa7cuBjT+NNo+923pppSHuuI1CmjUlw3f5qJhrk4vZ4S6e1+wm6a
         zG9KhPOI3t/YNiz65IQTSdwGnx0xOTsGL07TQEeAPHrRiLondHcWwdDd1siEoX8YMwaQ
         BY/tJudSR/KIs5uCT6mWjRx3/UO6r9uXWuQhsnWDahmlh+kIhGD1386BLsf93B/lkH0U
         RwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650800; x=1788255600;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9wJZiSmpJkaWQYC5Sfiwp3fgYQo5ibADA/Ym5bAdoUg=;
        b=hExA4Ps7H6vEyvGPaEzEH3JThUXixYAMI+WNEeUsJG0EZ/d32BkEnx6p1hQ3HtL/K5
         eAdjW6HqLSpiYFG2epgfvmHzviz3Os0m820F2e1zG3hJHpph8zUQ+fN0LDry6Q6a2tmN
         zdkTvaL/3SrFrBRCWIBwtmsNO0TPOhEF0YQRS0PFvwWunLZvgJNbQp4kVmx1ADSVElWq
         isChSZcPbWmC0KuOEcOddSGW0MvFpMpkKx0ecQY8o+UPPE1FxWiTQV4VYfHCwNRMYxA+
         zarnSOhXtNzNLJOlMUTFgiLsOMsVlDjX8sc8vcREmzCv2AQL/vPuOn/W6antwEtOHDpp
         6cwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpheDcf55oj+q+SG40c7RCE8mri5NqyvYOJ42GyTT9Z5A2+c/kHtsO3c0qdc6pLNAeczAc5LQPi73w=@vger.kernel.org
X-Gm-Message-State: AFuF++mlK7Xl/0UpgbLn5Xwtq04L0P+A5fxnQtmBHDvKT8UfitfQtp90
	c/Gi4So3xxBQ4YkYXN1v58nY6FYsfKOeV/NaNl0BcXwK0V9441AnABg5
X-Gm-Gg: AR+sD129AT5NmnF860zjHh6UNz4R64aWoSN+pdsR39VqyG8w9zzvscZdI9Gl6p0sYiT
	GcDO5ypIMrwAUBpwKoZ/wcTmf4xGd2syMwFSz13gTUY5SGYz0VL9lGsgw+/NTOCr+Ogw6g+IsNk
	SSKoOogbl2/DA1dfGh63KSpK4qM0ldr7OqUYq6SdZg6xjTVRpt216nAfe0g84gJUncF1hkqkm2t
	AMAFmHUXF+80v0/4vHoEKBedxO7ORNYtxlQcO922k9jU9j1DswiAnEQBDSsGHymnrudiXb1sbkq
	JjWdqTfIPevrH27UuDQoh34ddYOM5CckyZExRtav2NaNmc9dJo/gUCJKGGfdurKziiNkG8ZSwdE
	buM4Kmk7Jx9rtxTcYT16+a/HhwZM5qX4GOATGLOxk0XvxJvIb1Wn3wazhMxvTgu2KBBJf9VwydE
	5d9P9rdeLC7OcwCOQrgH8t8PNBfxvABOw1zo5Z5RftD4aqvWTMgtp8B0x7vAugOyQg7zPv+ouuz
	V7aLA/mQ5D6uDoDuaTcMrLJdl6XOxrv1/PoFf+X7kx/p1tw4id2kIckVt7r4LTIvluAI2AIXhX5
	3TsfDmcni7S0vahVyqm8i0vfiy5svO7nKf4fKkaB5ioiGPS2VZrnSoTveOj+4/0MiJDwPZJRfg2
	96JovjAjABIf4/nE5kR82JJROuUG7z35m1rsw0CMTgiuLkwJ4ig1fxsTChYwOmM9JqrCKxA==
X-Received: by 2002:a17:907:7241:b0:c16:6a42:c7d6 with SMTP id a640c23a62f3a-c24e589b49dmr532567266b.9.1787650800013;
        Tue, 25 Aug 2026 02:40:00 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496297189sm1641420266b.22.2026.08.25.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:39:59 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:39:58 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Yang Zi <2959243019@qq.com>
Cc: lorenzo@kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: fix division by zero in
 calibration data parsing
Message-ID: <20260825113958.000038b8@gmail.com>
In-Reply-To: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
References: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 17:21:10 +0800
Yang Zi <2959243019@qq.com> wrote:

> hts221_parse_temp_caldata() and hts221_parse_rh_caldata() compute the
> sensor slope as ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0). If the
> device reports cal_x1 =3D=3D cal_x0 the division causes a divide-by-zero
> error.
>=20
> Return -EINVAL when cal_x1 =3D=3D cal_x0 in both functions before perform=
ing
> the division.
>=20
> Signed-off-by: Yang Zi <2959243019@qq.com>
> ---
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/ht=
s221_core.c
> index bfeb0a60d3af..7d1f04951d8b 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -288,6 +288,9 @@ static int hts221_parse_temp_caldata(struct hts221_hw=
 *hw)
> =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0cal_x1 =3D le16_to_cpu(val);
> =A0
> +=A0 =A0 if (cal_x1 =3D=3D cal_x0)
> +=A0 =A0 =A0 =A0 return -EINVAL;
> +
> =A0 =A0 =A0slope =3D &hw->sensors[HTS221_SENSOR_T].slope;
> =A0 =A0 =A0b_gen =3D &hw->sensors[HTS221_SENSOR_T].b_gen;
> =A0
> @@ -327,6 +330,9 @@ static int hts221_parse_rh_caldata(struct hts221_hw *=
hw)
> =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0cal_x1 =3D le16_to_cpu(val);
> =A0
> +=A0 =A0 if (cal_x1 =3D=3D cal_x0)
> +=A0 =A0 =A0 =A0 return -EINVAL;
> +
> =A0 =A0 =A0slope =3D &hw->sensors[HTS221_SENSOR_H].slope;
> =A0 =A0 =A0b_gen =3D &hw->sensors[HTS221_SENSOR_H].b_gen;
> =A0
>=20
>=20

This definitely needs a Fixes: tag, otherwise LGTM.

Feel free to carry my review tag.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

PS, a bit of process info: I noticed Sashiko (sashiko.dev) failed to apply =
your
patches. To prevent this from happening in the future, please use the `--ba=
se` flag
when running `git format-patch` to specify which commit it should be applie=
d onto.

--=20
Kind regards,
Joshua Crofts
