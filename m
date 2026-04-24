Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D75310763
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022769; cv=none; b=Ur0ZwOdXqJmolui9vwFkFdlf5QX9c5tJXI38eYPzwy8Ez9XkfJWeeNKCxA9/ohBvUU2+EyIbtwjV7SJvNzVofCTkwsHoJs8S6BuVlaStW32IPS7JbbEDf/2MIZjwOAdkgLykJI4KUFvqqkFU5O2QyNLr69CyB8UW8oEPjmIPyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022769; c=relaxed/simple;
	bh=m6WV7EWKujpqNzwSC6VrIDZlcXz5kzfkgETq5VnefOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IaY9EHVP51/JGVAszj7qkqjKqnUCvI/He+xJ6TF+5+pDqMqjNPPiM3ECi3Go2C/O7ZzDFBBeeyapbSz/ShkhhtKlZBLxBuGfBjx+A8eXZtIgUr5cd4euAEftPQF+h034p/fTqQ0nQDFGe8YWk/l7ZrNfELvtXpadnMN98RlFn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wGCnP-0004S8-9Z; Fri, 24 Apr 2026 11:25:59 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wGCnN-006yIh-2c;
	Fri, 24 Apr 2026 11:25:57 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wGCnN-000000005kQ-2zTp;
	Fri, 24 Apr 2026 11:25:57 +0200
Message-ID: <a38717c7b357a8e7669a8b05f9f41751d1bbf627.camel@pengutronix.de>
Subject: Re: [PATCH 18/22] iio: dac: ad5686: consume optional reset signal
From: Philipp Zabel <p.zabel@pengutronix.de>
To: rodrigo.alencar@analog.com, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Auchter <michael.auchter@ni.com>, 
	linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Fri, 24 Apr 2026 11:25:57 +0200
In-Reply-To: <20260422-ad5313r-iio-support-v1-18-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	 <20260422-ad5313r-iio-support-v1-18-ed7dca001d1b@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Mi, 2026-04-22 at 15:45 +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Add RESET pin GPIO support through an optional reset controller, which is
> local to the probe function and deasserted by default.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index cfbc1624e01c..f239880d1cc7 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -12,6 +12,7 @@
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/sysfs.h>
>  #include <linux/wordpart.h>
> =20
> @@ -509,6 +510,7 @@ int ad5686_probe(struct device *dev,
>  		 const struct ad5686_chip_info *chip_info,
>  		 const char *name, const struct ad5686_bus_ops *ops)
>  {
> +	struct reset_control *rstc;
>  	struct iio_dev *indio_dev;
>  	struct ad5686_state *st;
>  	int ret, i, shift;
> @@ -544,6 +546,11 @@ int ad5686_probe(struct device *dev,
>  		return dev_err_probe(dev, -EINVAL,
>  				     "invalid or not provided vref voltage\n");
> =20
> +	rstc =3D devm_reset_control_get_optional_exclusive_deasserted(dev, NULL=
);
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc),
> +				     "Failed to get reset controller\n");
> +

Nitpick: "reset control" [1]

[1] https://docs.kernel.org/driver-api/reset.html#glossary

Same in the commit description. Otherwise,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
