Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717412147F9
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481076; cv=none; b=mU59o4KESeEodGv81TwuhfV7qcOOWa+6Ici9/c5lCqFWw1WrY+GWIVFrG7kedAi/giguO/UgyGDLgFSlpA/bFHvi5Ewt5yaTwg33JBBwBmn4dzRam9cWOlHanXW1HAIxGqJotql7sZQ/V4sdEUj8n2FslEVfXVo9BrOd1V9C+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481076; c=relaxed/simple;
	bh=y8xOqR8Ymmkf/HzSd1k1S1/AGzJdINVUIyPEQa2nqpY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:In-Reply-To:
	 Subject:From:References; b=cHgo8CO2SLX0kV3QJuyYmW+oqSIg8zKJKhNsDHIkKfK9cvSiWzgjZWDiQFGOmZHv/lqF30l87K0vthzgKXWp+zyZiG6FVb6PTiooDknIsgTJjz7nn7YCYqC7zj63OA1vCTC/pq219MRTzrVzyUKBRhoTNd3HPfCBFJUTXzX/rbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1AsFpiB; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1AsFpiB"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a354eea06dso84133eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 20:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481074; x=1784085874; darn=vger.kernel.org;
        h=references:from:subject:in-reply-to:cc:to:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z3urhXLpgSjs1fm/dRVMoD1HkuMQyRBEjXk3/gC42Pw=;
        b=m1AsFpiBlIurJwQKJmpa5DKsZbma5HmD5Lw6j4EYOLICXL6qslgRA7wbD9lBSDs2fE
         fRJNdVEAcLwzJZEium1KvfK2ibtvY4Judko896aT9Wgq9rOCWnWExAL/dUkqb5eHZrIm
         jNPtGCSmP8DOFkDTfuP/+F2oOHBRsbQItrrSTm5EJsLRJ/t+LqbguYui0jPLZQ//1aTv
         5IJDVDrnUPe+CaZ4HayNxtWRjuEw5lnYWqF/kDwSdspw50S/3Pckoe+Qpc/5PB7gArRI
         PdErEGFgJz638cVwJADQ3m0XiLGHV8VRv/s79gBH96ZmRCkX7mnuSpjDo3pjqtSFzwtg
         mBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481074; x=1784085874;
        h=references:from:subject:in-reply-to:cc:to:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z3urhXLpgSjs1fm/dRVMoD1HkuMQyRBEjXk3/gC42Pw=;
        b=eBGlNTOsQNMywsTYPjzrQY3W+OLR3yQOl2gz1oboLh+vbA3bfUgkA8t04k/obX6SGX
         EYaxBkxUuiUE0FomuPF+GcFrqzPU/+wKtArInqV19AKMlnWzsd/QEyJEtTN6AJTOxX0K
         EGP9DGrD1RPgfiMjniQ+ZlzdMZl2tRC9F5YUxk1ncb42Hm7Rrbj7JkkC8jpY23Msq/mt
         fmnxSc4O5NlO9hF0mHBB0DRC2dNO6gdzXp0k+UHHE+EcpVXcBEPRGHEkuP2iTtdUQC4k
         oBnN+nmUxg7t7fgLi/pF8BfFQt+aDbbx7Ng3ejF6kZ/RhCaV046Xa5+TFlWMCg2e/vXc
         0lpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lHLbVtWhZSpDaYk00m8FnJGKBIDn//cpmXRyF7WYvGQ4l4rhboo7F+CoJIDaxEHGY+J6+feHbEYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEqxE+Gcfgtqx+001fXQxZFKpcK7iMdgpltFMBWkiV8fVjuFD
	bqsiAUoFj8Ei+sV7ATHVhW82Nkh12xPgiADbDO5Agdsqz4wtDICbQcoqb39Cvw==
X-Gm-Gg: AfdE7ckLh/53ge6PPIIDJbemGS/hu9ITph+/6QPiUWveAYvEZsN3qhg5EkIO187OvI/
	rx+MDQKmuYNYaPBQmYdLQj4wBF1OCrfJCzWCXtMVmUs+Dm7jOghaQOCdMiuG3UDWSGNQdz3t0Wt
	2sh1N8AhgULvH2dl3Y2cZ0QvIWDwNpni851I/vO9pyMtIJCsEM2cbqcu3J/Ga60a1Su5JED2Uf2
	PMmXptg2QjC1KPO/yuHkUvrYtOX1rRFgYMpt3O7FHmD/1YBRRRFNdLyrimThoSCUMyyrhihNPs8
	p3EDNbyavP86zn5JUdNH8K6SAZugfTMCp7WGI6xym1U7N8yK1nzKW6nmFF9ZZl5HTxQ+/KvZKRI
	R3ntBYGXDL1oOMHMwCsyx4RTajcUyk5hqTGt4gDgxiesB3pCx2zWBuP7LflRl0NdBrSRiRI0kIA
	BEp0vTHCrsB2M2vucvwTEX4ZDl5/7dI2KTavIOSiE=
X-Received: by 2002:a05:6820:2d42:b0:6a1:91b9:70bb with SMTP id 006d021491bc7-6a36da217e8mr556725eaf.56.1783481074271;
        Tue, 07 Jul 2026 20:24:34 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a5b559dsm1059965eaf.1.2026.07.07.20.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 20:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f511ba55c0fff6fb9f67f4a2af33ceac80f36d1462c112af329f5675203f;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 07 Jul 2026 22:24:28 -0500
Message-Id: <DJSV9W2UFA5D.P60TOWBEQNUT@gmail.com>
To: "Caio Groff" <caio.groff@usp.br>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <antoniu.miclaus@analog.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
 <andy@kernel.org>
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>
In-Reply-To: <20260708030727.1378063-1-caio.groff@usp.br>
Subject: Re: [PATCH v2] iio: accel: adxl372: replace manual bitfield ops
 with FIELD_GET()
From: "Maxwell Doose" <m32285159@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708030727.1378063-1-caio.groff@usp.br>

--f511ba55c0fff6fb9f67f4a2af33ceac80f36d1462c112af329f5675203f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Caio,

On Tue Jul 7, 2026 at 10:06 PM CDT
Caio Groff <caio.groff@usp.br> wrote:

> From: Caio Groff <caio.groff@usp.br>
>
> v2: add missing blank line after reg_val_l assignment
>
> Replace manual bit shifting and masking with FIELD_GET()
> macros for clarity and consistency with kernel coding style.
>
> Signed-off-by: Caio Groff <caio.groff@usp.br>
> ---
>  drivers/iio/accel/adxl372.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index e375d068a3f5..daf5813ff50e 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -150,6 +150,11 @@
>  #define ADXL372_Y_AXIS_EN(x)			((x) & BIT(1))
>  #define ADXL372_Z_AXIS_EN(x)			((x) & BIT(2))
> =20
> +/* ADXL372_TIME_INACT */
> +#define ADXL372_TIME_INACT_MASK_H  GENMASK(15, 8)
> +#define ADXL372_TIME_INACT_MASK_L  GENMASK(7, 0)
> +
> +
>  /*
>   * At +/- 200g with 12-bit resolution, scale is computed as:
>   * (200 + 200) * 9.81 / (2^12 - 1) =3D 0.958241
> @@ -577,8 +582,8 @@ static int adxl372_set_inactivity_time_ms(struct adxl=
372_state *st,
>  		scale_factor =3D st->chip_info->inact_time_scale_low_ms;
> =20
>  	res =3D DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
> -	reg_val_h =3D (res >> 8) & 0xFF;
> -	reg_val_l =3D res & 0xFF;
> +	reg_val_h =3D FIELD_GET(ADXL372_TIME_INACT_MASK_H, res);
> +	reg_val_l =3D FIELD_GET(ADXL372_TIME_INACT_MASK_L, res);
> =20
>  	ret =3D regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
>  	if (ret < 0)

First things first, don't resubmit for minor style issues. Most of the
time these are fixed while applying. Secondly, don't submit a new
version until at least 24 hours have passed, this gives enough time for
more people to review.

Also, put the changelog for new versions underneath the --- so it isn't
included in the commit.

Last thing, don't forget to carry through any tags for new versions
where there was very little or no change from the previous version
(though some people may do it differently).


--=20
best regards,
max


--f511ba55c0fff6fb9f67f4a2af33ceac80f36d1462c112af329f5675203f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCak3C7QAKCRAQghIb0dl/
iQRRAX4rrdVmTNo5Ktqj8OzKWEG81j1AZfENdGIB+n5jvDvmRhHWL3zvVgDSKvM9
/ON8teMBfjoPNI99fjaZDOX2oNsSLSQTrtMsDFhcgVrwMdIUrO1kcwDesq847E+C
/unXdbCAcA==
=IsLe
-----END PGP SIGNATURE-----

--f511ba55c0fff6fb9f67f4a2af33ceac80f36d1462c112af329f5675203f--
