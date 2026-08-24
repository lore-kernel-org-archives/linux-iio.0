Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF4B1A9F83;
	Mon, 24 Aug 2026 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530866; cv=none; b=CUkHM7jruzESva7VWpPNHBouwS2XVaW4eiwAZq9ZgmozWWK9LQyL6lnLf8VuGvgAr1MOSrt847Lj1CKT43iMgyr8f2uElpY1vhqxApGsnpZTVjwwX3wT/MRFCBjI+3AS0ilzY+hyTCkg3kvXLvB4QhEA+cYZeNrpLCxspdj4/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530866; c=relaxed/simple;
	bh=6HitN05kbB6gM4oOYprsYVw7JzmuMQnXJTb5Zw2TvOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMYzPiV4xMmMCPTABUl78vmgQT1JCqPw1hiELSBrzV3RsQgCgBkQ7N2Ym8OSRn/m79gDvYER01Q6S9a30TTznPTded9t0ysaY3fkFTn1SGvojd/1GRIjBXgmndm7DDCv2ipCHWY5QNkzDhSGKhE9kt1yQKlCfBS1PMCsPnIEej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtOe0VQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtOe0VQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99201F000E9;
	Mon, 24 Aug 2026 00:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530863;
	bh=Ls0Y3+Giut5994jj7vNtfO9biz6zciA4vs31FaXYJxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WtOe0VQS1G7YQ0e572qI5ycBBoLPIzkJlrTLd0DNtHkedemxt+wjHWZxdUmekDstQ
	 Qai+mth6bf7ynmIRoiQJTid12DVsybJhIjwQK27XjbxmRJKmJSeuqYcZhoiZ4FxKR/
	 /cAzVOgaveVMuh2o/LfRXyTVdCODnLSUGLPNJkkEZZ/H0DktRv2eZCEEls8/QIOCAF
	 E0JWe3KjR7B430Od7Q95BwzuMaE60M2FE4W5PtNB9HA8yxMDQh+Q3ZGPSWEadCVQSe
	 mbYerd2DZpKISzzN9eydqaYgdSONpqKTiqVc5mwI8N59PhRxcSu9nwIflnXQ9Cqcoo
	 P1nA1p3aog+pQ==
Date: Mon, 24 Aug 2026 01:20:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Chris Morgan
 <macromorgan@hotmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH togreg v3 1/2] iio: imu: inv_icm42607: propagate runtime
 suspend errors
Message-ID: <20260824012059.0a38fe2b@jic23-huawei>
In-Reply-To: <51769a1a-8d28-4224-9b36-06b04282db74@kylinos.cn>
References: <20260811020345.950137-1-lilinmao@kylinos.cn>
	<20260811103301.1157404-1-lilinmao@kylinos.cn>
	<20260811103301.1157404-2-lilinmao@kylinos.cn>
	<20260815215028.784c7579@jic23-huawei>
	<51769a1a-8d28-4224-9b36-06b04282db74@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2026 17:32:43 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> =E5=9C=A8 2026/8/16 4:52, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Tue, 11 Aug 2026 18:33:00 +0800
> > Linmao Li <lilinmao@kylinos.cn> wrote:
> > =20
> >> The runtime suspend callback always returns success even when updating
> >> PWR_MGMT0 fails. The PM core can then mark the device suspended while =
one
> >> or both sensors remain enabled.
> >>
> >> The sibling ICM-42600 driver propagates the corresponding
> >> inv_icm42600_set_pwr_mgmt0() failure from its runtime suspend callback.
> >> Make ICM-42607 follow the same behavior by returning the sensor shutdo=
wn
> >> error. Keep a void wrapper for the managed teardown action, where erro=
rs
> >> can only be logged. =20
> > What is the practical affect of a sensor remaining enabled?  Bit of
> > power loss or something more significant?  This info matter when decidi=
ng
> > if we should rush this in during the rc phase, or wait for the next
> > merge window. =20
> As far as I can tell, the practical effect is additional power
> consumption while the device is idle.=C2=A0 I found no corruption path, b=
ut I
> have no ICM-42607 hardware to reproduce the failure or measure the
> current.
>=20
> It does not necessarily persist indefinitely.=C2=A0 If the PWR_MGMT0 write
> fails, regmap may contain the requested OFF state while the hardware
> remains ON.=C2=A0 A later sensor read requests an enabled mode, so
> inv_icm42607_set_pwr_mgmt0() retries the write instead of taking its
> "no change" return.=C2=A0 If the bus error was transient, the cache and
> hardware are then resynchronized.

Please capture some of that for the commit description for v2.

>=20
> I also noticed a cost to this patch: returning an error such as -EIO from
> .runtime_suspend() makes the PM core set power.runtime_error. Subsequent
> reads then fail in PM_RUNTIME_ACQUIRE_AUTOSUSPEND() before any sensor
> register is accessed, until the PM status is reset.=C2=A0 A successful sy=
stem
> suspend may clear that state.
>=20
> The patch therefore trades a logged idle power leak that may recover on
> a later access for a potentially sticky runtime-PM failure.=C2=A0 Since t=
his
> was found by inspection only, I would not rush it into the rc phase.=C2=
=A0 I
> would rather revisit the error handling and target the next merge window.
>=20
That is fair enough.

J
> Linmao
>=20
> >
> > Jonathan
> >
> > =20
> >> Fixes: 3007c1530f96 ("iio: imu: inv_icm42607: Add PM support for icm42=
607")
> >> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> >> ---
> >> Unchanged since v1.
> >>
> >>   drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 15 ++++++++++-----
> >>   1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/driver=
s/iio/imu/inv_icm42607/inv_icm42607_core.c
> >> index 190e998f7b8ef..0da362967f63b 100644
> >> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> >> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> >> @@ -537,9 +537,8 @@ static int inv_icm42607_enable_vddio_reg(struct in=
v_icm42607_state *st)
> >>   	return 0;
> >>   }
> >>  =20
> >> -static void inv_icm42607_sensors_off(void *_data)
> >> +static int inv_icm42607_sensors_off(struct inv_icm42607_state *st)
> >>   {
> >> -	struct inv_icm42607_state *st =3D _data;
> >>   	const struct device *dev =3D regmap_get_device(st->map);
> >>   	int ret;
> >>  =20
> >> @@ -552,6 +551,13 @@ static void inv_icm42607_sensors_off(void *_data)
> >>   					 st->conf.accel.mode);
> >>   	if (ret)
> >>   		dev_err(dev, "Unable to turn off sensors\n");
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void inv_icm42607_sensors_off_action(void *data)
> >> +{
> >> +	inv_icm42607_sensors_off(data);
> >>   }
> >>  =20
> >>   static void inv_icm42607_disable_vddio_reg(void *_data)
> >> @@ -619,7 +625,7 @@ int inv_icm42607_core_probe(struct regmap *regmap,
> >>   	 * Ensure if sensors get turned on at some point, they're turned off
> >>   	 * as part of teardown.
> >>   	 */
> >> -	ret =3D devm_add_action_or_reset(dev, inv_icm42607_sensors_off, st);
> >> +	ret =3D devm_add_action_or_reset(dev, inv_icm42607_sensors_off_actio=
n, st);
> >>   	if (ret)
> >>   		return ret;
> >>  =20
> >> @@ -688,8 +694,7 @@ static int inv_icm42607_runtime_suspend(struct dev=
ice *dev)
> >>   	 * however the tradeoff is that an unused sensor won't be
> >>   	 * turned off until the entire chip is no longer in use.
> >>   	 */
> >> -	inv_icm42607_sensors_off(st);
> >> -	return 0;
> >> +	return inv_icm42607_sensors_off(st);
> >>   }
> >>  =20
> >>   EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) =3D { =20

