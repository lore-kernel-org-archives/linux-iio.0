Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5F30F958;
	Sat,  7 Feb 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479405; cv=none; b=oh49OU/NsWfvGAAheiykM8UiaAYvDpr2IxTpSRtGKMaP3wvzHsCxOqaGe0GCJWwbgR83dxurWxTl9UG51uc32XaolSyEOfCuZbNZRvcpfX20xwA4S5omkx1WMO2YXBTc4nwpnuBzyQtIlnBtYfEykIeNGcn7ZjzWDruBSf7iL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479405; c=relaxed/simple;
	bh=zw45NeCFoqaPMli4y6cDm2YgadvaG3mxAX5JGumYly8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2W+fReaNQHhpxku9IPzQvlOu0dBzmVsCEIGYrMs+4IVWh+5GwjAbiVWzrl0GjeRgqQGp+BeXOWsa8iT+jLC9QhraMjFHwu077+7UjqplojIjLTCNmjH3cvrfzrPxHwdXdHjnrNA7o+SxZ5ZwrxmLgKpNruNymCm6Le6aFnuUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWQ0UygD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWQ0UygD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9566DC116D0;
	Sat,  7 Feb 2026 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770479405;
	bh=zw45NeCFoqaPMli4y6cDm2YgadvaG3mxAX5JGumYly8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rWQ0UygD03X4yd0D9zQiNpygsvvEB3M1V2JmxqTgsHJ4HdD2XUn6jSLOHYR47x0T/
	 pwpo7F9QlbYbnQs5npfv5R6eLqbAKzx9nQynq4bqeRfP3MaA/XWLW4Vhl8tx2MtW7A
	 aQijfSXaFySTPdEpFFY++LLhxg1fwE3zaDbtVkxeKdTG1V/TC0I71tDhvCiyWAb/FD
	 hEC93WgrFUNKtE9diVeVKUO0aTeJKclIKFCoamORcRCdEDMw3ic42winORahD/6rU5
	 z129gDZqj3NLlOsXwNRtMwgy3UjcsYlohaNLPBqXMKCRMth5wHfJmk8B5PrWOTilbo
	 ltDnjMKT9Dktw==
Date: Sat, 7 Feb 2026 15:49:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Linus Walleij	
 <linus.walleij@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: gyro: mpu3050-core: use
 pm_runtime_resume_and_get()
Message-ID: <20260207154956.10bd4dff@jic23-huawei>
In-Reply-To: <a75be02da0b55997b2384a481d85b680d1372a78.camel@gmail.com>
References: <cover.1770039759.git.antoniu.miclaus@analog.com>
	<3edc89e901fd9d55c5355c4ec007636b1c8d6801.1770039759.git.antoniu.miclaus@analog.com>
	<a75be02da0b55997b2384a481d85b680d1372a78.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Feb 2026 09:45:34 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2026-02-02 at 16:56 +0200, Antoniu Miclaus wrote:
> > Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
> > mpu3050_read_raw() and mpu3050_buffer_preenable(). Unlike
> > pm_runtime_get_sync(), the usage count is not incremented on error.
> >=20
> > In preenable, call pm_runtime_put_autosuspend() if set_8khz_samplerate()
> > fails since postdisable won't be called on preenable failure.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> To me this is more than just reference counting. It's also about proper e=
rror handling.
Agreed. I think these should both have fixes tags
and a commit message that calls out a little more clearly what is being fix=
ed.


Jonathan

>=20
> - Nuno S=C3=A1
>=20
> > =C2=A0drivers/iio/gyro/mpu3050-core.c | 17 +++++++++++++----
> > =C2=A01 file changed, 13 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050=
-core.c
> > index ee2fcd20545d..1cc421eb4782 100644
> > --- a/drivers/iio/gyro/mpu3050-core.c
> > +++ b/drivers/iio/gyro/mpu3050-core.c
> > @@ -322,7 +322,9 @@ static int mpu3050_read_raw(struct iio_dev *indio_d=
ev,
> > =C2=A0		}
> > =C2=A0	case IIO_CHAN_INFO_RAW:
> > =C2=A0		/* Resume device */
> > -		pm_runtime_get_sync(mpu3050->dev);
> > +		ret =3D pm_runtime_resume_and_get(mpu3050->dev);
> > +		if (ret)
> > +			return ret;
> > =C2=A0		mutex_lock(&mpu3050->lock);
> > =C2=A0
> > =C2=A0		ret =3D mpu3050_set_8khz_samplerate(mpu3050);
> > @@ -647,12 +649,19 @@ static irqreturn_t mpu3050_trigger_handler(int ir=
q, void *p)
> > =C2=A0static int mpu3050_buffer_preenable(struct iio_dev *indio_dev)
> > =C2=A0{
> > =C2=A0	struct mpu3050 *mpu3050 =3D iio_priv(indio_dev);
> > +	int ret;
> > =C2=A0
> > -	pm_runtime_get_sync(mpu3050->dev);
> > +	ret =3D pm_runtime_resume_and_get(mpu3050->dev);
> > +	if (ret)
> > +		return ret;
> > =C2=A0
> > =C2=A0	/* Unless we have OUR trigger active, run at full speed */
> > -	if (!mpu3050->hw_irq_trigger)
> > -		return mpu3050_set_8khz_samplerate(mpu3050);
> > +	if (!mpu3050->hw_irq_trigger) {
> > +		ret =3D mpu3050_set_8khz_samplerate(mpu3050);
> > +		if (ret)
> > +			pm_runtime_put_autosuspend(mpu3050->dev); =20

