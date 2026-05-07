Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D52C21C5;
	Thu,  7 May 2026 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173524; cv=none; b=OlSeKGuAEiPAycAgvAnoqG6fQBlXuHNbeWHEwx2ZwdxOgQuoH2QkhipmVRi9A5UMiEs/MLijGtXvrcX/HMW80A4vJfFXFQdD0t94hGJIK0/fZFxMFr3OSv6b1B7yb+8PvZVBL/VLcbguNmfSDAOc7i3a44TS8t78bKJgxcPOKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173524; c=relaxed/simple;
	bh=DaJr7r6+bPaShu0gyPhAoiy/9yd5nepzEewpYw5/8aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlFINzT1+ParAORHjDJrn3MvrEDn7jcJXPJ6Sz7OEtCkGv+wjj2xRBC2Du2VEgqNxmJH8La4LpwBhHwTvqPN+j075ag/N6pVA4ER0lGvtz6bm3Ye6YstNbunIjRbWALgJ2TkH/8qh8eKqeHe6pGJn07V7+ZjLM2mX29HqiWJuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhlwis4z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhlwis4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CC1C2BCB2;
	Thu,  7 May 2026 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173523;
	bh=DaJr7r6+bPaShu0gyPhAoiy/9yd5nepzEewpYw5/8aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mhlwis4zOXfZZAxw03APUJFBGDVmTgeMxdhKQtLJPJ9LufKHwvZImSrfvpnxGRccO
	 008h537ASpNF2mlmc31PVjMY7euS2YEY2mUSSThXtkPITnpilHl9EuVIvEEz+CV5fS
	 UiVqFTvj90VB/++pexMN7D1t8s/TEJfk5M4vj1tCOrpwOi5s0obuEnxIeOoBNXAVft
	 usiJiiTyec/SByLcD6e/nFGf2pYEWPoozBXgzLXfZotn9XBR6I1fan+RzxbbThMTiX
	 TDsbqMbllK9XOnK3S/niTqVJBfAbeJO6GIJqzn/nyZh607iZCA8crdtD8TdpfvI6Ru
	 42cekwexNGYkQ==
Date: Thu, 7 May 2026 18:05:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] iio: accel: mma8452: use pm_ptr() and direct
 runtime PM calls
Message-ID: <20260507180513.37f93333@jic23-huawei>
In-Reply-To: <4719ED48-6731-4319-8724-35F174C199B8@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-9-sanjayembedded@gmail.com>
	<20260506190654.598dca87@jic23-huawei>
	<4719ED48-6731-4319-8724-35F174C199B8@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 May 2026 08:16:40 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 6 May 2026 11:36:54=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.org=
> wrote:
> >On Tue,  5 May 2026 23:16:38 +0530
> >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> > =20
> >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >>=20
> >> Use pm_ptr() together with DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops
> >> pointer is automatically handled when CONFIG_PM is enabled or disabled.
> >>=20
> >> Switch to direct PM runtime calls and drop
> >> mma8452_set_runtime_pm_state() wrapper, which is no longer needed.
> >> This follows modern kernel power-management conventions.
> >>=20
> >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com> =20
> >
> >Hi Sanjay,
> >
> >The cleanup you have in here has made what i think are two nasty race
> >conditions much  more obvious. I think we need to fix those
> >(and that fix needs to go at the start of this series)
> >
> >Thanks for you work on this driver - this problem has been
> >there a long time!
> >
> >Jonathan
> > =20
> Hi Jonathan,
>=20
> Thank you for your review and kind words.
>=20
> Your guidance and feedback are very motivating and help contributors stay=
 consistent and improve their work.
>=20
> It is an honor to collaborate and learn from experienced maintainers like=
 you.
>=20
> Also, I would like to know if there are any opportunities in other IIO dr=
ivers or within the kernel framework where contributions would be helpful, =
especially around fixes, resource management, power management, or general =
code cleanup and coding style improvements. I would be glad to work on such=
 areas and continue contributing.
>=20
Hi Sanjay.=20

Right now the best thing you could do is to help with review of what
others are posting to the list.  Do some of that before diving in to
make more code improvements.

Jonathan

> Thanks,
> Sanjay Chitroda
>=20
> >> ---
> >> Changes in v3:
> >> - Use direct PM runtime calls and drop redundant wrapper along with CO=
NFIG_PM
> >> - Link to v2: https://lore.kernel.org/all/20260422165643.2148195-6-san=
jayembedded@gmail.com/
> >> Changes in v2:
> >> - Use DEFINE_RUNTIME_DEV_PM_OPS to address review comment and resolve =
0-day bot warning
> >> - Link to v1: https://lore.kernel.org/all/20260414192045.3598010-1-san=
jayembedded@gmail.com/
> >> ---
> >>  drivers/iio/accel/mma8452.c | 55 +++++++++++++------------------------
> >>  1 file changed, 19 insertions(+), 36 deletions(-)
> >>=20
> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >> index 2cd24b1543af..5ab981481599 100644 =20
> >
> > =20
> >>  static ssize_t mma8452_show_int_plus_micros(char *buf, const int (*va=
ls)[2],
> >> @@ -974,6 +953,7 @@ static int mma8452_write_event_config(struct iio_d=
ev *indio_dev,
> >>  				      bool state)
> >>  {
> >>  	struct mma8452_data *data =3D iio_priv(indio_dev);
> >> +	struct device *dev =3D &data->client->dev;
> >>  	int val, ret;
> >>  	const struct mma8452_event_regs *ev_regs;
> >> =20
> >> @@ -981,8 +961,11 @@ static int mma8452_write_event_config(struct iio_=
dev *indio_dev,
> >>  	if (ret)
> >>  		return ret;
> >> =20
> >> -	ret =3D mma8452_set_runtime_pm_state(data->client, state); =20
> >This smells like the same bug as below.  =20
> >> -	if (ret)
> >> +	if (state)
> >> +		ret =3D pm_runtime_resume_and_get(dev);
> >> +	else
> >> +		ret =3D pm_runtime_put_autosuspend(dev);
> >> +	if (ret < 0)
> >>  		return ret;
> >> =20
> >>  	switch (dir) {
> >> @@ -1452,10 +1435,15 @@ static int mma8452_data_rdy_trigger_set_state(=
struct iio_trigger *trig,
> >>  {
> >>  	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> >>  	struct mma8452_data *data =3D iio_priv(indio_dev);
> >> +	struct device *dev =3D &data->client->dev;
> >> +
> >>  	int reg, ret;
> >> =20
> >> -	ret =3D mma8452_set_runtime_pm_state(data->client, state); =20
> >
> >This functions makes me very suspicious and I think has a nasty existing
> >race condition.  If the auto suspend were to suspend immediately
> >vddio would be powered down.  Unless they supplies have odd naming on th=
is
> >device that means the bus would be down before the write that follows.
> >
> >As such I think this needs s rewrite to makes sure we only call
> >pm_runtime_put_autosuspend() after the bus writes in this function are d=
one.
> >
> >I think that is safe to do without testing as all it will do is delay
> >when the power gets turned off a tiny bit.
> > =20
> While in-corporating direct PM runtime call; I also observed that this is=
 against the expectation and design as per my knowledge.
>=20
> However, I assume that thisust be well tested and something which I may n=
ot aware specific to driver. So I done changes as per requirement and waite=
d for input from reviewer and potentially guidance on the same.
>=20
> Now, this is clear issue and will handle same in next series.
>=20
> >> -	if (ret)
> >> +	if (state)
> >> +		ret =3D pm_runtime_resume_and_get(dev);
> >> +	else
> >> +		ret =3D pm_runtime_put_autosuspend(dev);
> >> +	if (ret < 0)
> >>  		return ret;
> >> =20
> >>  	reg =3D i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
> >> @@ -1738,7 +1726,6 @@ static void mma8452_remove(struct i2c_client *cl=
ient)
> >>  	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
> >>  } =20
> > =20

