Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625F5464C;
	Mon, 31 Aug 2026 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134427; cv=none; b=QUHyu0TzU0dLIZAdjLty43Y+8zWBqBzkvyKVU5+e0aPP/che3JUsiCw+E/gUwheMI/rZSQHifiwBS/x1oN3J+yvvgS9IOC57AKUgAhJ/h5oIj0+XRVcgL6S9R7npqrMTV6SLhLo1sxZflE/58P9nmtChg0OqR95F/yEQSLpfz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134427; c=relaxed/simple;
	bh=88beVbLle2VzVKgPoNC78IsjPe2aRstcwv/nqXpEZas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaVfvVfGlLzA4TfEEqVqtRMww0ZYOmebDRALL0MUiDyTITEgAEwvB/V9QLQdiaAepBwApAPOAkhNF3Nji0HqmbVzp3G4pSTCqNjwSJH3dwpROH0H93FFMLrP2QKNXuYuqB+UBzRYujkwG8Ab6ReaqBj+HqI9XOosCYUQEgB8mLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebo10sxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebo10sxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6B21F01568;
	Mon, 31 Aug 2026 00:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134426;
	bh=syoCgZSs3Dla9bQrGRm0VtDod2hWnIQMM5bOiwY7qes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ebo10sxNZqEvm0QlHRTqqMY98AIFG/goax0FGFV3ZWfZ8oUGjHGNKSLNYAUZdUeEM
	 iML9t0cILyfhibyhuHdNmpwhPjSZ4bEA2tO/0IGc2ihn0dHtG0RP6q/FQ3R8nnq1n8
	 x8/9qzmkVLg5JrfktaGLmpPDb9XgZAtuV1o7FjJuw26CnI0IstSlBmFBZVzizG4kdb
	 8wFA47kCwPhK61fviiqJ6WkKf2h94bDQuqevK6fAfkYkg9CVKb7MbBW8MxmYl1V87t
	 tVagt24OCj+StmYucZw9enYyo3WQu0tTG56xS0AxG5YeQ+dlLCeuB+M9YY/BVB07Pu
	 254Tsm8+zUcDw==
Date: Mon, 31 Aug 2026 01:00:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yang Zi <2959243019@qq.com>, lorenzo@kernel.org,
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: fix division by zero in
 calibration data parsing
Message-ID: <20260831010021.67cbf4c1@jic23-huawei>
In-Reply-To: <ao7zrbXG6f-pPxIB@ashevche-desk.local>
References: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
	<ao7zrbXG6f-pPxIB@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Aug 2026 17:09:49 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 25, 2026 at 05:21:10PM +0800, Yang Zi wrote:
> > hts221_parse_temp_caldata() and hts221_parse_rh_caldata() compute the
> > sensor slope as ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0). If the
> > device reports cal_x1 =3D=3D cal_x0 the division causes a divide-by-zero
> > error.
> >=20
> > Return -EINVAL when cal_x1 =3D=3D cal_x0 in both functions before perfo=
rming
> > the division. =20
>=20
> Do you have HW to test? Any fault injection perhaps?
> The problem with div-by-0 is that it's implementation defined, meaning
> that it's how compiler decides. Now, the question is, what will compiler
> do in the current code (no patch applied)?
>=20
Whilst all this is true, the code shouldn't be relying on any particular
behavior.  So do we need to know?

Reality is the hardware is almost certainly never returning values where th=
is
is true.

Jonathan

> ...
>=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err; =20
>=20
> > =C2=A0 =C2=A0 =C2=A0cal_x1 =3D le16_to_cpu(val); =20
>=20
> > =C2=A0 =20
>=20
> I would remove this blank line as it's coupled with the above.
>=20
> > +=C2=A0 =C2=A0 if (cal_x1 =3D=3D cal_x0)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > + =20
>=20
> > =C2=A0 =C2=A0 =C2=A0slope =3D &hw->sensors[HTS221_SENSOR_T].slope;
> > =C2=A0 =C2=A0 =C2=A0b_gen =3D &hw->sensors[HTS221_SENSOR_T].b_gen; =20
>=20
> Ditto for the rest.
>=20
>=20

