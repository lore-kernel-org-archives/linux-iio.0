Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D727435A96
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665211; cv=none; b=TL4U9cnWQDU9D/CarsvNWaCPnzP3C6sD9MTvH5denh/tUIYpNA1eZzojYc75Kjz7Jm/U0aiXjNb9LgpfUs04x6Voh6tGbJyPyx4hlp/ebq2sx7PKZxVKISVHcckM/Fa185XNSb3Lg35Trd/OBIRKOyRrF7WtiDtmCQZx8uH7sLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665211; c=relaxed/simple;
	bh=0UKEACgwyHBvgbMD7gx6HxfUBabYa/Ihyo8um7fvXmY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7BJBAYT5NbzOuGatfrgAiAc1rKo42EokInE+g3+fzi1d69BrgqjrSKhNYw083eKFHfCGyUeTYghSJBIpA/zUF6ysSCKBg0esoKXIBAevWV7No+nMHu+wyNmiOHswjwn8BpFoNNq6fO5TxdEtpUsR8T7EucdiW3lvoptj3UV1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KhEiVBcs; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KhEiVBcs"
Message-ID: <e2f4b1c8df3f1d4193cff00e72e2bfc4affa05d1.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784665195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBsuJ6UrRwHad2SsezxmhLhJu14qAsvGKExsVUEhLEI=;
	b=KhEiVBcsox6Ok2KIJzbrsiieHfy6uLAf369LOeAVze5zRE2q6V0m2Dvas1FIQ7Tlqv4W21
	IqFlkg7HFXJuzSpQ6ivDzein+R2EwKk//iezbmSqI9J82PZaV7k50bQl5HiUXPRRPb9Ni6
	J7fh8jEUd8mxJ91eqXDgAVyB5Ha/qIk=
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add support for QST QMC6308
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, David Lechner
	 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <u.kleine-koenig@baylibre.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 02:19:37 +0600
In-Reply-To: <20260721134843.7484-3-jorijnvdgraaf@catcrafts.net>
References: <20260721134843.7484-1-jorijnvdgraaf@catcrafts.net>
	 <20260721134843.7484-3-jorijnvdgraaf@catcrafts.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Tue, 2026-07-21 at 15:48 +0200, Jorijn van der Graaf wrote:
> The QST QMC6308 is a 3-axis anisotropic magnetoresistive (AMR)
> magnetometer on I2C, found e.g. in the Fairphone 6. Its register map
> is not compatible with the QMC5883L's, so add a separate driver rather
> than extending the QMC5883L driver.
>=20
...
> - Switch the license to GPL-2.0-only: the dual license had been
> =C2=A0 carried over from qmc5883l.c, which this driver is modeled on,
> =C2=A0 without a reason of our own (Jonathan).
I wrote the QMC5883L driver. My reason to use dual-license was I wanted=C2=
=A0
people to be able to port the driver to Non-GPL OSes like Zephyr, NuttX, BS=
Ds (specially RTOSes,=C2=A0
none of them are GPL, and these sensors are widely used with MCUs)=C2=A0wit=
h least friction.
There are stuff that can't be ported (like regmap etc.) but the rest of it =
could.
Also, I read the "Linux Device Drivers 3" book where the samples use Dual B=
SD/GPL.
>=20
...
> +	/*
> +	 * Reading the status register clears DRDY, which is why the poll
> +	 * and the data read stay under one mutex hold. A runtime resume
> +	 * clears DRDY too, so a sample converted before the last suspend
> +	 * is never returned here.
> +	 *
> +	 * The timeout is 50ms of headroom over the slowest ODR (10Hz).
> +	 */
> +	ret =3D regmap_read_poll_timeout(data->regmap, QMC6308_REG_STATUS,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (status & QMC6308_STATUS_DRDY),
You can split by logic. i.e., put "status, (status & QMC6308_STATUS_DRDY)" =
on the same line.

> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 * USEC_PER_MSEC,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 150 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> +
>=20
...
> +
> +static int qmc6308_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
>=20
...
> +		if (ret)
> +			dev_warn(regmap_get_device(data->regmap),
> +				 "Failed to discard stale sample (%d)\n",
> +				 ret);
Move "ret" to the line above.
> +
> +		return 0;
> +	}
> +
...
> +static int qmc6308_probe(struct i2c_client *client)
> +{
...
> +
> +	ret =3D devm_add_action_or_reset(dev, qmc6308_power_down_action, data);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, QMC6308_AUTOSUSPEND_DELAY_MS);
Add a space here.
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int qmc6308_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct qmc6308_data *data =3D iio_priv(indio_dev);
> +	unsigned int status;
> +	int ret;
> +
> +	ret =3D qmc6308_set_mode(data, QMC6308_MODE_NORMAL);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * DRDY may still be set for a sample converted before the last
> +	 * suspend; reading the status register clears it so the next
> +	 * measurement waits for fresh data.
> +	 */
> +	ret =3D regmap_read(data->regmap, QMC6308_REG_STATUS, &status);
> +	if (ret) {
> +		/* Best effort to leave the chip in a consistent state */
> +		qmc6308_set_mode(data, QMC6308_MODE_SUSPEND);
> +	}
It's single line so the brackets { } are not needed.
> +
> +	return ret;
> +}
> +
...
> +
> +MODULE_DESCRIPTION("QST QMC6308 3-Axis Magnetic Sensor driver");
> +MODULE_AUTHOR("Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>");
> +MODULE_LICENSE("GPL");

--
Best regards,
Sirat
