Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A33126C2
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723865; cv=none; b=g8ZngJvMkWPAx090uWYIsnLo5HA+7mNa/zOH4K/TEuH4LQx8xOoOKYWE3C/an6VsVROvgR4Fd6mFYVMyuE1qa50Zq98Dj8Ynlc2gMpj0s0qh5mfAc2PNqeHVAr9bk868PX6es3IwG7yUKEpa34j2bbK51uQNWxp1IBvn6bqsUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723865; c=relaxed/simple;
	bh=Z/QLbGZLB99eUtuXmocBvEQikv5QC/t9YyuXuQ0XXOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaqFzk2w9w89cd1HkncHJBuwzkgjUUH+wU0gBGvTL22GPrkvr+IPCDe9FTKABEAlO4ZJBRjB2k75woJzjigxHXZdMunM+2P3Jvc/bh1QOq7KgVzzw7keR38dv+CxCagJtb+h6U8OlZIhZVKrGxO0obB3/pIy78SeADy5yfvsrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJDTvZvT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJDTvZvT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso42371155e9.2
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788723862; x=1789328662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y1git0WZ96wbt+gAecFgsUj5GK1DOjSXBKImfrfl2XU=;
        b=nJDTvZvT1bCMBXJXlHTu6CIhUZx5BNJ7cxRi/5qKbe7/hbDNNpIrHr6Mg8jXTQlCNn
         JWFg+4GuuwJ5ISdt1e7zP9PYR2QrSOvLftSk5f26rL2hzy0Zd4NLvvlpkW/DyD58/L0L
         t6Y6cB+uvrChDyZ+WiXCSbm0gBdhvGFJm/Yi0GJiCztw8vUfhVkPQHc7QFRyTYc90BS0
         Ykko0UtXO9OkYBSaukbhJebU54Ap1hMOZHLnfDGe939PRWwxFxtCIkNs8ecRGeCLk/Ar
         I/o2WU2r57WvEp6xv8L1rD2F/+/e4DIi+9+9MHR7Qqwl6YGlk8Jnw65yRY96CeMEJvGg
         ixVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788723862; x=1789328662;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1git0WZ96wbt+gAecFgsUj5GK1DOjSXBKImfrfl2XU=;
        b=S+6iAuHaMIRhEvjar/4PCRIfzYhyWOuZbGLkIB0pwrEDG0ENG3/3W3X2l4wbxcCdPc
         OeV1LLQVck9ApyGeSv+jdSithukRHaoweTz7tEtyMiEPF71WncdFSalIzrwlvXsX4fso
         SHDkJZgtW+Pvy5ddmq3AbYup9VeHXFTnb2DeJtF1oi/9iSPYitFiXW+HIkfGxmuDAKXc
         QTB6wZfzKuc7OwGY06S7n+8X7sx2AMea/DXPA2slJQ9AAqAQH3G0whROkZOYOJ3mnxwQ
         Z7S/j5SQe9tEdz+h8kCTNtsYYW0iJQUk0Sy5hfKxnsRyWDeisOAceD6KLpwbg8rnHMj3
         21WA==
X-Forwarded-Encrypted: i=1; AKwUvBz2umf4JwZV8lsS56GpOrdHrlfgEANqicVnRsVj+QFlBB+4kXoKdXKy59GsBJYXAhr81u+ZBBFWfQk=@vger.kernel.org
X-Gm-Message-State: AFuF++n4bYmSdrgBeVaW+S5RBvbORiztILEzMEVQ0huF94JpPKRejncO
	wpUkc6AZ0Ku2WNqCp/wmYg+Zbq1ZQwcoM+4y6IDy/rBiVhfsSajjfgu1
X-Gm-Gg: AYBFou26WIi8HZo0JVJdAWj6KOX6yjZuz8+Sl1xns3K6HQA0Xr1CROnhzXm2L8PScd4
	ueZ+ABECCrAmbz9zPXRa+kLG4LB4nweJ+DwPOij5Q362Tze5xV0Oy8tvxpgzyg1sSGF5iR6jg4X
	NIrV7IZbssnnHmsqtJGjixBL1Mk7EdP9HLs5mFqRZbb/+hJAV6An1CIb1TL5zs98sEtnBwRE7VY
	0UercJYKXPjl76TazSIA0sBh60u54T+U9FL1/PWRkHGOg4+/Rhv7e0g7tKEa3huhar4y+Fge1po
	zszTmEql6FR7Nk0i/ocdNrT6rgU6eT8rnVB+JRrvCzbwdvr92NpdooQvj/e4VoZZaFupTXZxVbg
	/GLACMtOAPh08UMsTDKV5sB3I2Ca7+IteYtvssmJSkDUj2zw5nmrAiJUdp3EbJfsF7Jd3O+dSjF
	DCFB+TjD4iHOWBnbWJhVzQInqR9AcC7m88yW+rXpuMNeneJm43xWCybolO86mJPP+3p+P3CubnY
	DqUKIs5VsHw8QpwX5tnyoIg5dZtv0EEKFQvBoYZhk2E50bw5WQIaEQk4X874OU3tpHv5IMhEYZ8
	BzKcIqyp+UF5FXFdYaZOv+iUwP2/SmkyM7ZnC/GBTFWTkA9WrAJbgEFf2cWT2BCjT8ZQ9WEfENc
	nKvBcKUoWZ5TMBUX7S98cmg==
X-Received: by 2002:a05:600d:113:b0:49c:d618:e341 with SMTP id 5b1f17b1804b1-49cf827b19cmr106524155e9.14.1788723862396;
        Sun, 06 Sep 2026 12:44:22 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm567978165e9.15.2026.09.06.12.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 12:44:22 -0700 (PDT)
Date: Sun, 6 Sep 2026 21:44:20 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tuna =?UTF-8?B?S8SxbMSxw6c=?= <tuna@tunakilic.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260906214420.580dec27@systembl0wer>
In-Reply-To: <20260906185942.595251a5@jic23-huawei>
References: <20260906045428.4f03494b@jic23-huawei>
	<20260906090802.1282585-1-tuna@tunakilic.com>
	<20260906185942.595251a5@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Sep 2026 18:59:42 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  6 Sep 2026 09:08:06 +0000 (UTC)
> Tuna K=C4=B1l=C4=B1=C3=A7 <tuna@tunakilic.com> wrote:
>=20
> > > If AI had anything much to do with generating the patch then
> > > a tag for Assisted-by: LLM is appropriate.   =20
> >=20
> > AI was only used afterwards as a sanity check for the datasheet,
> > in_range() semantics, and the final patch. The bug and fix came from
> > manual review. =20
> Ah fair enough then to not add a tag.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Thanks,
> > Tuna =20
>=20

Hi all,

sorry for the testing delay, did some light travelling this weekend
and didn't have the hardware with me.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Tested-by: Joshua Crofts <joshua.crofts1@gmail.com>

--=20
Kind regards,
Joshua Crofts
