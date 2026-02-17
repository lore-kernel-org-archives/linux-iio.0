Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1D212B0A
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336039; cv=none; b=sfePaQajrSYiQCvXlE6If63aSY7g4L+RwQLiB/dl83pD5b/nq9rwwG7s7NneLpfeQMvxf0xnlCmIM95z8pxHpeZAXx96tviS1jlPqhgfuY+BbA/yQUahwO/Hqib3USUfY1RziwtcRVYUJLVXoNcE91kx4t7t9pK0jh7yTs27+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336039; c=relaxed/simple;
	bh=zbVPxC9iGlj+7Bta/P2F4XBgYDwzU/MucGkHHYFuXm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPi9Yd0zknoItrHyESUk0xtL/72Z7Ount0Fdb85wVnyKB/NCRPQ30kfAifB3SOXzGC2/TyWyO8mg9XqsX4CgjkYPOcf0Dt89ZMUzXXMXXTG5C9Y9Xy4mt/yBLQe8kFYtov82/iImxm1XSrpW4bartA0W0K4+DQBRobPdKylzS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLEQU8U5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLEQU8U5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso13873255e9.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771336037; x=1771940837; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=trPpBZeGVYC91Ra1y+YKJwGDyGi8gSy+JdgzkPSCUcU=;
        b=NLEQU8U56c13UxJ3CemlkuOnR+NZTyB4sz6lzozyc2usYRqDMh+nYUnVtwDNdet0pU
         LQHSlY/yVBrAoyaFcQBePnZhQFFh9Zgz8HfNpfpZ7ST301IcpU+TBv1sWO8E5RHpGB2Y
         4/Ssbzx2iqFNZ+gLc2QUHBamnA90d7mnN26JwM6JIb1pwSjWDBvcl80sZDIOYwlgj1vc
         UerZPj/BQm7Xelt709VagOuTDIj136qVfoVhJIbK5kyX7yan8ZsXbvw9IsQ0aMM/o33z
         h7DSonbmbGhY6t3pkykpLGgDa1rTK/sQj+GqOsmYuuF0TiLYPXEJcXDermrQ+DcqcqnN
         JuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771336037; x=1771940837;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trPpBZeGVYC91Ra1y+YKJwGDyGi8gSy+JdgzkPSCUcU=;
        b=w7apbGOKYW1UiTO0vXfCopkJ4WEouQjcMuZyB+qnIMQ+TfmkmtKEB/BzVjBvJ52w4E
         79T+qUJkiq3TzwgnvFV1B4h/xvihzy6nc0Ae7UKwWjtcQY0IU2qgd1Ec8CxV8/Xwivr0
         Kk0bh6w77u1ZsUGrtOTcdNPMlPlkDqPBLvB2S8W+XSIyXFtmt4l1ogLREItQQ4qN6A8A
         G7PZlVIyOSxD1XhYfFyFmI49H5BMVxDNC96drYxyjYq/xAdbQUUVMvqQCVqKyuCwCjSv
         QIZLGfvkDWuGR1jYFeI6v1Thumd4bNAlkK9a8zgn7n8hElmphZNodKWyII9SUXxD2tf4
         YueQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9Q/G64mp2Yrnr4m40wJIhVWS+0ETP451ZpQKsVJnCPT09VgsKvfYWtNA0TXcV55jFiNqIdQQkLtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0eLONCYe4m4AZpQUbY3drCZWV9We8liaPuIMj1JHSUQGhGMw
	rEMVf6alVAHELuCqootOgVASQCBg0TirIgeN4Da6aCKQy/ie4kObQy3C
X-Gm-Gg: AZuq6aJDpo1Vn9Z77dZs+oL48PwVi3HGz3Vhei4elBtM/SJDZkP+UUwh7CftEmNulZ5
	acFB8nQukGKqeksQjKPiZz0iz7jRFWlfqq6LU+8KTb+oB9K0xB91u/3RdLeClN2vYmNDFtceKVC
	VkCotPzu+U3JVATbOp64/sIMluhexp43IZCFq7xEEcnSiiTYb5O+uGmnCtRl9LYTe2xpMq6up6J
	cujQWVvKNc14sTRfAf3ZxmuFDqWnJwq7Gqu/03ZzfnnblEjL24cqN+4GPV6UyEvCxG2Zo9xPOf8
	7ausoEZDSS7CfOEIR0VtyoasxnJ7239c0Zj22Q5urhCz5bUciZywLR8FQa7i/ZaA5xEiR5Z55X3
	LD4pS6s0LlrhnBTXf4/I3wRtmcq+6lqA32qOdgPwgdyrdoVZbpHGgSHdgOgtdm7ZHQT46U41f+0
	cnhxKPTI8H2CZnjRxBn6C+aj3jh+n5p3w=
X-Received: by 2002:a05:600c:348e:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-483710960eamr273273585e9.33.1771336036396;
        Tue, 17 Feb 2026 05:47:16 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a58721sm129400205e9.7.2026.02.17.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:47:15 -0800 (PST)
Message-ID: <aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Harshit Mogalapalli	
 <harshit.m.mogalapalli@oracle.com>
Date: Tue, 17 Feb 2026 13:47:59 +0000
In-Reply-To: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 09:05 +0100, Andy Shevchenko wrote:
> This reverts commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8.
>=20
> The added code is currently a dead code. Moreover, the driver is not
> designed to have any defaults effectively making driver data a mandatory
> information to work with. Taking all together, revert unneeded change.
>=20
> Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/iio/adc/ad7192.c | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 530e1d307860..8b1664f6b102 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1402,9 +1402,6 @@ static int ad7192_probe(struct spi_device *spi)
> =C2=A0	st->int_vref_mv =3D ret =3D=3D -ENODEV ? avdd_mv : ret / MILLI;
> =C2=A0
> =C2=A0	st->chip_info =3D spi_get_device_match_data(spi);
> -	if (!st->chip_info)
> -		return -ENODEV;

I'm ok with this but as long as we get some consistency agreed on. So far, =
IIRC, the policy was to
check for the NULL case even for the cases where that was not possible to h=
appen.

- Nuno S=C3=A1
