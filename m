Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D947427E;
	Fri, 24 Jul 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934013; cv=none; b=XsGswTZNqTv4Kjgb7pA5/wRotO8b6lRHHJIoqCYcxITE8GonWGwLQt35xxMmviJX9PI2ZUTBi98xRdRVuIBBHpkUw7weV/dUhu+umwKWsC1KQRMul9yZO+jdusC3MudsNmWMmNl6iO/nP0VpdJZwCxoermd7M65kZLapnq4//JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934013; c=relaxed/simple;
	bh=foPblbdU4EjDYT/LU2p8y4gcIRkuuLU5KXoas6qNbts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKNqjCGsXOcSEN4YXrSbmomNFiFybkKQIEJDBQ72lz+4Q3mP6AXyQKUqM0g4WGaNF6pHSI+RRgj99jN2YkpvgULAz2dJhjUPY146lgvpra4x2RbD4b36/32SZMIE8/XO3YktTwYzVc3P5s8IwKcpeNIbTvSQ4JoJBFDZccD1eGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eldyq2HT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eldyq2HT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D31B1F00A3D;
	Fri, 24 Jul 2026 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934009;
	bh=QRFJ6Hfu7ktmcToupdz3vbf6Pc9ju8PldTxoQxkm6Xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Eldyq2HTGQVj+kb6gBOy9elHCZuzzScC9Ai7W64pmtUPq6qEgl3WMZpjWVv0dbcCi
	 v3ppZY5FAil2MSVbYUAgl3kVovaf7SPY/qojAKtwJ2X7VuMT/9AJpv8qoRZBOSxked
	 J0ESvl01/Nq42P0bQrPB8YT0U0lw56BDptWCB3mIJ70Y5IHJejrV1zfJ7RoCBtiKwG
	 SPtDgAW/hQ5lllQ1JBcRYuYXiqjA7cnhBoTssyHDCPyIZaXnxXEF3Z4kSfVxhsniXh
	 svlLPuWKPCi4kTWK72W4H42hnxacLEHl13YVQU3Jnzg5heuPPKOTNgC9A9FNPtL4VG
	 ySrXXH3T5o6oA==
Date: Fri, 24 Jul 2026 23:59:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, David Lechner 
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko  <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski  <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=  <u.kleine-koenig@baylibre.com>, Luca
 Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add support for QST QMC6308
Message-ID: <20260724235959.32093b7d@jic23-huawei>
In-Reply-To: <e2f4b1c8df3f1d4193cff00e72e2bfc4affa05d1.camel@linux.dev>
References: <20260721134843.7484-1-jorijnvdgraaf@catcrafts.net>
	<20260721134843.7484-3-jorijnvdgraaf@catcrafts.net>
	<e2f4b1c8df3f1d4193cff00e72e2bfc4affa05d1.camel@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2026 02:19:37 +0600
Siratul Islam <siratul.islam@linux.dev> wrote:

> On Tue, 2026-07-21 at 15:48 +0200, Jorijn van der Graaf wrote:
> > The QST QMC6308 is a 3-axis anisotropic magnetoresistive (AMR)
> > magnetometer on I2C, found e.g. in the Fairphone 6. Its register map
> > is not compatible with the QMC5883L's, so add a separate driver rather
> > than extending the QMC5883L driver.
> >  =20
> ...
> > - Switch the license to GPL-2.0-only: the dual license had been
> > =C2=A0 carried over from qmc5883l.c, which this driver is modeled on,
> > =C2=A0 without a reason of our own (Jonathan). =20
> I wrote the QMC5883L driver. My reason to use dual-license was I wanted=
=C2=A0
> people to be able to port the driver to Non-GPL OSes like Zephyr, NuttX, =
BSDs (specially RTOSes,=C2=A0
> none of them are GPL, and these sensors are widely used with MCUs)=C2=A0w=
ith least friction.
> There are stuff that can't be ported (like regmap etc.) but the rest of i=
t could.
> Also, I read the "Linux Device Drivers 3" book where the samples use Dual=
 BSD/GPL.

That's a valid reason but I do expect people to have one rather than cut
and paste.  I suspect a port that way rarely happens because of things
like regmap that you call out.=20

> >  =20
> > +static int qmc6308_probe(struct i2c_client *client)
> > +{ =20
> ...
> > +
> > +	ret =3D devm_add_action_or_reset(dev, qmc6308_power_down_action, data=
);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_use_autosuspend(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, QMC6308_AUTOSUSPEND_DELAY_MS); =
=20
> Add a space here.
This one feels marginal given close relationship of the 3 lines. Still I th=
ink
I agree it is a tiny bit better with a blank line where you suggest.

> > +	ret =3D devm_pm_runtime_enable(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static int qmc6308_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +	struct qmc6308_data *data =3D iio_priv(indio_dev);
> > +	unsigned int status;
> > +	int ret;
> > +
> > +	ret =3D qmc6308_set_mode(data, QMC6308_MODE_NORMAL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * DRDY may still be set for a sample converted before the last
> > +	 * suspend; reading the status register clears it so the next
> > +	 * measurement waits for fresh data.
> > +	 */
> > +	ret =3D regmap_read(data->regmap, QMC6308_REG_STATUS, &status);
> > +	if (ret) {
> > +		/* Best effort to leave the chip in a consistent state */
> > +		qmc6308_set_mode(data, QMC6308_MODE_SUSPEND);
> > +	} =20
> It's single line so the brackets { } are not needed.
That gets complex when comments like this get involved.  In these
cases I tend to leave it to the author.

So I've left this one alone.

Series applied with tweaks to patch 1 to resolve the feedback from
Krzysztof.  I'll apply it initially to the testing branch of iio.git
but probably push that out for linux-next to pick up (as togreg) within
a few days.  If on balance you want to change the license back to dual
with BSD just send me a patch stating the reason and I'll merge that on top.

thanks,

Jonathan

> > +
> > +	return ret;
> > +}
> > + =20
> ...

> > +
> > +MODULE_DESCRIPTION("QST QMC6308 3-Axis Magnetic Sensor driver");
> > +MODULE_AUTHOR("Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>");
> > +MODULE_LICENSE("GPL"); =20
>=20
> --
> Best regards,
> Sirat

