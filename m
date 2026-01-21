Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2EF3816F0
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004361; cv=none; b=L3mpkHhfPq9lF01tVI4KrwXroES9CzEGK7+vYg4q9a+MsKOchABjuaoM8aqzpCX4xdmaM4BZ6f0w5oRt4X2RvM1MTzKPbOrNnFSRd39YMOrKt9hHTvtLEpnl0JZ4QGYLAq2c9fKS1v2mxej2ohoclTzW9P3odSlajKJManYcRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004361; c=relaxed/simple;
	bh=U6AfKx4a56pbE/bWX0xpp6yHrDtNa+tDYA8lqH/H8go=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNFtXqQ95lH87429jtUhkcWM3WxFgWDdtjv4dt4T8gEr7/gw/vaOUna2CFoufb9Ux6MurqZh232meCYB0sjyGBmgZQwtSXp60O6Mt9iAyswDY6c6/7qmbggh9xPvT0N3RghPOz+Jb41YQxEbyREtvb5jjizd+0NPEpIdZWzQX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IkzwRbCC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IkzwRbCC"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-435a517be33so5557f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 06:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769004357; x=1769609157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U6AfKx4a56pbE/bWX0xpp6yHrDtNa+tDYA8lqH/H8go=;
        b=IkzwRbCCRFweekzIyaX7xeVfGBnALgRtAYW9wSQfRtOz81X/57uZmEYVfQTK55nohP
         KnEWvUIgbAPdwpHcrWemcDNmEu3cn/Gdb/2lQY3m+Jk9pWdajZlP1w00lfox2hWJZu6R
         TDoCBii/BPdSasfjBdFLGgtPjv/+D/5UQPABt/mXILQfo6USyfJQEHx7WO0hUTKNLlHb
         P6Mxym0hvDg6pfpQEBXIS+e9caIIVbh9Z4TOYRB88lr/g1gNTeW+21+gJiGQlomSWIxB
         odmm7pzeijPO7F0IXGTr6T05N6BAcfnQTrVxJX4eBgN2oaDnIvVKJTt7SJRiQk+7Cjoi
         XqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769004357; x=1769609157;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6AfKx4a56pbE/bWX0xpp6yHrDtNa+tDYA8lqH/H8go=;
        b=LLkjcpvlYckYl0V/mVdP5jvgJ6Ba2frLXswd5pHBZ7r6nLd8N4ZtvHGdHsg+0KxMv5
         1jy50v+B4eJgSLnOBi1mr7tbo36bAjZyO4t8cR01LFfgm8pVE87fTuU0QHX/U6fE6ozP
         DTvVpocdPAweTn2JY3Wbc3JQQOXpbXLwdd1LHKtN+gp22nRkbuU+1evdsXLl7ewbH3Uo
         q3a1Yajmw7tvVZ0etjmcyXD/1fj2fsDwbrh7pqSyFLg7NRsEH7EWp8QVIc3GwhrpSbBI
         QBwu62nr0RPRjCCiNPBf8Tpfk0bUn0RV8NbCOH+EGXP99RcpHKLqnu+zbwZk8L0UtRL1
         fvFg==
X-Forwarded-Encrypted: i=1; AJvYcCVq6/nP5I24ojestpc3OKWSgRpOzoarrOgZ880rMtel5ZU72UzbNWbJRY1cEjFY9E8V7wICTssuDPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUBfKRCYK0FtyWdf/HtlNeKCedmr+D3wUzgmYaU5eol/CyUVC
	ZOa3tDuF1mwA6/9LStx/AACgoXBtdhqpG0MXd5s2gxz5/L5aN2rmosJr0KqW5v+FnYM=
X-Gm-Gg: AZuq6aJAYaqDzQ3WxawzQv6RjqjdnXDedsjzK2I7BoXsCur/fRBKMnXMLvv5bwdhHm0
	2zl5NDsvCrwzrQc+2eBr9jbTENoQg7Nl4XBCCpI3mhuEEqBAmSUf5xg6+70PLOKw1Y9djxsfpiI
	TEn/y/vtpry3sv5ZH+oc4nku5BSIExLVUWJlBR50bcpO1vv8GhTYD7xrechL8CffCJXxJ7LWFqQ
	B4xZSKcfb4FVlechp4KKzR8ivWkjhnhOF9vg8o0SOy8iReRkHvC0Xs1mNNMM3lBqA2LqVR72q11
	gtkiVnvuJ7laGQEwGDvxAaRMyXinuBXHw1PaYZPYPoIvDbsqwUMjy0XTzfPKkjKMyVIk7Be1J+T
	jEBo2uMC1eLcU+enAsJzt2la7Yti3lmendjvexCA9JqYXzE48EUxvlTETG6RMN9lE7mw=
X-Received: by 2002:a05:6000:2089:b0:435:9ef7:5c3c with SMTP id ffacd0b85a97d-4359ef76526mr3574067f8f.25.1769004357420;
        Wed, 21 Jan 2026 06:05:57 -0800 (PST)
Received: from [10.203.83.9] ([151.35.203.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f12ee69sm13731631f8f.11.2026.01.21.06.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:05:57 -0800 (PST)
Message-ID: <0168c543e320aeacbbdcdd7f4f3bb0edb81b79f4.camel@baylibre.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix check for invalid samples
 from FIFO
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Jan 2026 15:05:54 +0100
In-Reply-To: <aXDK6KRIIPjJxfFK@smile.fi.intel.com>
References: <20260121112758.1831077-1-flavra@baylibre.com>
	 <20260121112758.1831077-4-flavra@baylibre.com>
	 <aXDK6KRIIPjJxfFK@smile.fi.intel.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-21 at 14:47 +0200, Andy Shevchenko wrote:
> On Wed, Jan 21, 2026 at 12:27:57PM +0100, Francesco Lavra wrote:
> > The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> > accelerometer invalid samples (i.e. samples that have been acquired
> > during
> > the settling time of sensor filters) with the special values 0x7FFFh,
> > 0x7FFE, and 0x7FFD.
> > The driver checks FIFO samples against these special values in order to
> > discard invalid samples; however, it does the check regardless of the
> > type
> > of samples being processed, whereas this feature is specific to
> > gyroscope
> > and accelerometer data. This could cause valid samples to be discarded.
> > Fix the above check so that it takes into account the type of samples
> > being
> > processed.
>=20
> ...
>=20
> > =C2=A0st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 u8 *data, s64 ts)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s16 val =3D le16_to_cpu(*(__=
le16 *)data);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct st_lsm6dsx_senso=
r *sensor;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev *iio_dev=
;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* invalid sample durin=
g bootstrap phase */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (val >=3D ST_LSM6DSX_INVA=
LID_SAMPLE)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((tag =3D=3D ST_LSM6DSX_G=
YRO_TAG || tag =3D=3D ST_LSM6DSX_ACC_TAG)
> > &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (s16)le16=
_to_cpup((__le16 *)data) >=3D
> > ST_LSM6DSX_INVALID_SAMPLE)
>=20
> Since data is u8 *, it might appear on unaligned addresses and the proper
> conversion here is to use get_unaligned_le16() without any of those ugly
> castings.

data here corresponds to iio_buff in st_lsm6dsx_read_tagged_fifo(), which
is declared as __aligned(8), so it cannot appear on unaligned addresses.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
>=20

