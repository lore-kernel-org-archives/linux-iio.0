Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11691353EF5;
	Thu, 29 Jan 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708431; cv=none; b=m6jnoG6zBjYYXcqrYh80A0NY/A6Ihw6PIA6Er0DxqBckuaUT+ie3VL0vnd4MpoHy9q7Ff+OED4bFuYjBhxGyDgzl/xhaGXZbcCTg24mVEMtrzKM6ljaqkQUNdRPpTbOtfOyQadGn3IGjMEBo+eBpf7wQSgJC0qGD8yEUHHfv3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708431; c=relaxed/simple;
	bh=fYP2RlhYd4RePCK+ThFf8Jd4BlgUN5MNH6gx5qAkWek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cft1CkXGTG+s4BSPwDlNbRposBpjIOPIuxrtRieJvO2acvno7xom205xxUB5GTPWEriKqE1VrrqyKbRj3qBeLqwM3OgHuD6xAE4EpXVQjvP4MY/oZmdh3JGwZ/WeLQnDbO5zfaFp4QvzsoGnEK/0pEJn1uuf9TntS8v2gpE1oVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObFHkFc7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObFHkFc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF19BC116D0;
	Thu, 29 Jan 2026 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769708430;
	bh=fYP2RlhYd4RePCK+ThFf8Jd4BlgUN5MNH6gx5qAkWek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ObFHkFc7mJDpJE/BHViqxPuWM22uL4ZnrcuJuloTZO6H3IEpUDGwFBtrkYkXHu+KC
	 ANKx94dlkduh7VWpQn7QpkLKilLheQNQlbcWv2ETOTZg1dG2qfkVrmspPYNuGSN9UF
	 TSQZTTw9qCltgcsm0hJqJsfgX2JcKiNJEhRgm4LhQQzxPk9Rn5Tkiyz/CVoXCtC6RM
	 cMnFYZ6lPngWJGEhOx/SHATffbI5ZZAVZxw8yqPnCCrJKw8xIq6dq4xU5R3LEehrh8
	 EGnIavwp54eWgUmlKef/PsMcWrWg2ZW+inQ1umS7SxU090wlNCawuEpaKyudoikVeD
	 Sa3Dexlr5Jkqg==
Date: Thu, 29 Jan 2026 17:40:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, haibo.chen@nxp.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: vf610: Add missing check for
 device_property_read_u32_array
Message-ID: <20260129174021.4022306d@jic23-huawei>
In-Reply-To: <a820c04c224366e31ffbc6d7fe38068f8aab4137.camel@gmail.com>
References: <20260128042700.2260803-1-nichen@iscas.ac.cn>
	<a820c04c224366e31ffbc6d7fe38068f8aab4137.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jan 2026 09:29:47 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2026-01-28 at 12:27 +0800, Chen Ni wrote:
> > Add check for the return value of device_property_read_u32_array() and
> > return the error if it fails in order to catch the error.
> >=20
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > ---
> > =C2=A0drivers/iio/adc/vf610_adc.c | 5 ++++-
> > =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> > index d7182ed0d2a7..d53723ccc5b2 100644
> > --- a/drivers/iio/adc/vf610_adc.c
> > +++ b/drivers/iio/adc/vf610_adc.c
> > @@ -871,7 +871,10 @@ static int vf610_adc_probe(struct platform_device =
*pdev)
> > =C2=A0
> > =C2=A0	info->vref_uv =3D regulator_get_voltage(info->vref);
> > =C2=A0
> > -	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->m=
ax_adck_rate, 3);
> > +	ret =3D device_property_read_u32_array(dev, "fsl,adck-max-frequency",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 info->max_adck_rate, 3);
> > +	if (ret)
> > +		return ret; =20
>=20
> As Andy pointed out, this is changing behavior so it needs to be properly=
 justified. Also since we
> are here, maybe use ARRAY_SIZE(info->max_adck_rate).
>=20
Given the driver has a fallback for info->max_adck_rate[x] =3D=3D 0
I think this is intentional.  It would be clearer if this had done.

	info->max_adck_rate[0] =3D 8;
	info->max_adck_rate[1] =3D 8;
	info->max_adck_rate[2] =3D 8;
	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_ad=
ck_rate, 3);

though rather than where it has the fallback in vf610_adc_calculate_rates()


> - Nuno S=C3=A1
>=20
> > =C2=A0
> > =C2=A0	info->adc_feature.default_sample_time =3D DEFAULT_SAMPLE_TIME;
> > =C2=A0	device_property_read_u32(dev, "min-sample-time", &info->adc_feat=
ure.default_sample_time); =20

