Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE263306B3D;
	Wed, 25 Mar 2026 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456557; cv=none; b=nqlePx/j89/zeohvAW4Zcs4+KrZrt8kxbzSMxWn0L93ZVcxah89uNFqlLPbenGa8Uj8lTJD1OYrezVsVRxdQLSu8GezO7bmSlAYw/eDYkBPg+lOmUGZIc0tvd/4gyqjefxoR68mzldXxSeKctGP7/HBhMqiEMmUXOGA54C0N+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456557; c=relaxed/simple;
	bh=ku8Sbbe0WywtJti5J10Vn/PgiD3LAfGTFSBVptXcPZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrNI57q0pUrbCbtQ88r4JMuK94E/j1IlebMq0J7TmYnLaZjuYj6bngqtgcLElkGWZyeI44XLiTzuflxHzonMAJODNU/UWtE0qbmhCMLjOQgS+l/oV9YWOS0X5sdjuVDL9nodh4DZ+IZODp/rqIekrILjPuNobhe0PVB/UuXGUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1VmFiF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1VmFiF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0700DC4CEF7;
	Wed, 25 Mar 2026 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456557;
	bh=ku8Sbbe0WywtJti5J10Vn/PgiD3LAfGTFSBVptXcPZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q1VmFiF5FK0vdr8dAlGb411Y+M7IpkO2AizTN3Rvc1kX5qN2V2vqE0ZMLXzXqOZ3n
	 gzqe3dUXB89txguNTFpwCRiMECMbPth5sRlAIEf/w0cBBAXIRAvE0Xu6JuCs02pzqZ
	 MnbuzUimhj4ryZprIpjssZAynfQc5jz3HaJMRdDdGpQZgZe4+42J8xq3yx8x9BMOT3
	 q0kYmvV+7FkXKvyaNbKs+E+26x2yYayIUKMxxWk43BkPAndKT7SD9NYs/GO6fhGe8Q
	 plvGdMvglyL8V3ZhOclEZxP7Yw0fvDMfIIsF6mJbwJjs1XMXfMH2mcoQHiW3j9ZgBk
	 v4FC7AoDwTjBw==
Date: Wed, 25 Mar 2026 16:35:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Aldo Conte <aldocontelk@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner  <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko  <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH] iio: light: veml6070: fix veml6070_read() return value
Message-ID: <20260325163548.0a43298c@jic23-huawei>
In-Reply-To: <510e9313c229341f963508ca480ef6e5c5342b75.camel@gmail.com>
References: <20260325113216.170357-1-aldocontelk@gmail.com>
	<510e9313c229341f963508ca480ef6e5c5342b75.camel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Mar 2026 12:31:29 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2026-03-25 at 12:32 +0100, Aldo Conte wrote:
> > veml6070_read() computes the sensor value in ret but
> > returns 0 instead of the actual result. This causes
> > veml6070_read_raw() to always report 0.
> >=20
> > Return the computed value instead of 0.
> >=20
> > Running make W=3D1 returns no errors. I was unable
> > to test the patch because I do not have the hardware.
> > Found by code inspection.
> >=20
> > Fixes: bb18885ed823 ("iio: light: veml6070: add support for integration=
 time")
> > Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> > --- =20
>=20
> Makes sense...
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
I'm not going to try and figure out how that one got through!

Any applied and marked for stable.

Thanks,

Jonathan

> > =C2=A0drivers/iio/light/veml6070.c | 4 +---
> > =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> > index 6d4483c85f30..74d7246e5225 100644
> > --- a/drivers/iio/light/veml6070.c
> > +++ b/drivers/iio/light/veml6070.c
> > @@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D (msb << 8) | lsb;
> > -
> > -	return 0;
> > +	return (msb << 8) | lsb;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static const struct iio_chan_spec veml6070_channels[] =3D { =20

