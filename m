Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF1EED8;
	Mon, 31 Aug 2026 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135472; cv=none; b=c0h36GuJ4eOOLchTFy/+TmmYuiglvzzyTWY+FJGlCDMn7fwlPFHVKh/LnATitT5I6WtuP/X8N6jd55mOjZLkugSZitcx778VXQiENIkhWJosM6bN0pu/Iwtvz5w0O32egQk036Djb/9eikgkIEJ7A1poCVg0mzkYLdhFN04qbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135472; c=relaxed/simple;
	bh=3A1s75w6yBHCrzkPz4OXN7iXNRtStl0NXVco/whZc1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Il+I+w4OHngpot0TDNF+jc1H1wOTCVyTTqJzqQSO5b8CDjyfIQyR2mqGv3rsb3losO++qxOWiqmFl9u8vy0hKpeLZmLJMNQnByAST7alMCwvnNpjfN1xMyRyYQRp9VyCSHNnR0ZPVMhVQ61KWna5L0oIoectD9afNzP4nzoQTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kleKRPW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kleKRPW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847DC1F000E9;
	Mon, 31 Aug 2026 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788135470;
	bh=RcsJ9VjEFob7KN1Uh9/V2lYRRojSuc85augoJT/WwT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kleKRPW3FblfDZjO1Pbq1msAtYXqMNlLDnKxFpeav/ZkbZmiPtiQMY8ttM9Q+XzYi
	 7PH0TwRZnHJq2rIfwZArw/xwERm4rIOuZfqivi1LOcBwWRqw4g/KYxgb9L+SDh+UDC
	 jmz7O7Kusa0MuUeJXnJnerB/TjCEfOj5FYLmVK+FB+o7Va4l71QV6xHM1uJZw6WUqI
	 +0+8LQt70wgDimqp3WGthJCjk2pFJ5NWrU1JidY9DOQ0y3DP6D8lmkQTKjTrFsQmjG
	 rS8wVrfU+1gDUcpD2HN1iUjhxKGr+rhqQfbWkgviY/DAsIZT9QRthWdKiRnkO0hSC0
	 638YDWC8nbsgQ==
Date: Mon, 31 Aug 2026 01:17:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Yang Zi <2959243019@qq.com>, lorenzo@kernel.org,
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: fix division by zero in
 calibration data parsing
Message-ID: <20260831011745.1ac064c5@jic23-huawei>
In-Reply-To: <20260825113958.000038b8@gmail.com>
References: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
	<20260825113958.000038b8@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Aug 2026 11:39:58 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 25 Aug 2026 17:21:10 +0800
> Yang Zi <2959243019@qq.com> wrote:
>=20
> > hts221_parse_temp_caldata() and hts221_parse_rh_caldata() compute the
> > sensor slope as ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0). If the
> > device reports cal_x1 =3D=3D cal_x0 the division causes a divide-by-zero
> > error.
> >=20
> > Return -EINVAL when cal_x1 =3D=3D cal_x0 in both functions before perfo=
rming
> > the division.
> >=20
> > Signed-off-by: Yang Zi <2959243019@qq.com>
> > ---
> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/=
hts221_core.c
> > index bfeb0a60d3af..7d1f04951d8b 100644
> > --- a/drivers/iio/humidity/hts221_core.c
> > +++ b/drivers/iio/humidity/hts221_core.c
> > @@ -288,6 +288,9 @@ static int hts221_parse_temp_caldata(struct hts221_=
hw *hw)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> > =C2=A0 =C2=A0 =C2=A0cal_x1 =3D le16_to_cpu(val);
> > =C2=A0
> > +=C2=A0 =C2=A0 if (cal_x1 =3D=3D cal_x0)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > +
> > =C2=A0 =C2=A0 =C2=A0slope =3D &hw->sensors[HTS221_SENSOR_T].slope;
> > =C2=A0 =C2=A0 =C2=A0b_gen =3D &hw->sensors[HTS221_SENSOR_T].b_gen;
> > =C2=A0
> > @@ -327,6 +330,9 @@ static int hts221_parse_rh_caldata(struct hts221_hw=
 *hw)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> > =C2=A0 =C2=A0 =C2=A0cal_x1 =3D le16_to_cpu(val);
> > =C2=A0
> > +=C2=A0 =C2=A0 if (cal_x1 =3D=3D cal_x0)
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > +
> > =C2=A0 =C2=A0 =C2=A0slope =3D &hw->sensors[HTS221_SENSOR_H].slope;
> > =C2=A0 =C2=A0 =C2=A0b_gen =3D &hw->sensors[HTS221_SENSOR_H].b_gen;
> > =C2=A0
> >=20
> >  =20
>=20
> This definitely needs a Fixes: tag, otherwise LGTM.
Looks like hardening to me rather than a fix. Given those algs come
off the datasheet and the div zero case makes no sense, I'd not expect
the hardware to ever return a combination that triggers this.

With that said, the cost in catching it is low.

I was going to pick this up, but seems patch is corrupted.
Looks like we have tabs replaced with white space but I haven't checked clo=
sely.

Please fix that up and send a v2.

thanks,

Jonathan


>=20
> Feel free to carry my review tag.
>=20
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>=20
> PS, a bit of process info: I noticed Sashiko (sashiko.dev) failed to appl=
y your
> patches. To prevent this from happening in the future, please use the `--=
base` flag
> when running `git format-patch` to specify which commit it should be appl=
ied onto.
>=20

