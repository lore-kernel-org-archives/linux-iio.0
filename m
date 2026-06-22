Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61D36404D;
	Mon, 22 Jun 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119543; cv=none; b=E9MhRE0TSx3ye6+YnSUMOwuj6JPaugutWw/nmnVcG0j09YSfdBoZyFRaoDOEPJ+BvQaTO2RToFxPGUuvrIr7Kow2YmcKXwy+vvqdknJt0kZyNhMQw83bruK/vJS+1BVOtSozSv8r6JimZ3obzYV7lYxi5ANHtZwH3NJHpKJNsqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119543; c=relaxed/simple;
	bh=SO/ky8tf7LfcnlBCgI5bysYdRGWkHSQ4gDImOC2wAN0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QF7Yd0kSfqIyQX7p3rVqjnASn2ZF6+wCN2E8RAgcjdLE79x1YChb88biXRNjIfQW92dQ0E9hY6P6RUsD5fYrnvi4eQoLW8QFj6BEwyomtFl6mtg01eumqfc7KgDhH6q4TJTNQ1mjrs8LNx9dGlucLfvfoQhT/Ni8xESljnc3oHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 48AC32001DF;
	Mon, 22 Jun 2026 11:12:19 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wbahX-0043yP-0h;
	Mon, 22 Jun 2026 11:12:19 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wbahX-0000000093a-0V8E;
	Mon, 22 Jun 2026 11:12:19 +0200
Message-ID: <9c5104eb504e390c2267e0a17762fdb6d73d75a4.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/2] iio: dac: Add AD5529R DAC driver support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner	
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko	 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet	 <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil
	 <jan.sun97@gmail.com>
Date: Mon, 22 Jun 2026 11:12:19 +0200
In-Reply-To: <20260519-ad5529r-driver-v3-2-267c0731aa68@analog.com>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
	 <20260519-ad5529r-driver-v3-2-267c0731aa68@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Di, 2026-05-19 at 17:42 +0200, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/dac/Kconfig   |  17 ++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/ad5529r.c | 527 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 546 insertions(+)
>=20
[...]
> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> new file mode 100644
> index 000000000000..9bb63030db95
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c
> @@ -0,0 +1,527 @@
[...]
> +static int ad5529r_reset(struct ad5529r_state *st)
> +{
> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);

Consider using devm_reset_control_get_optional_exclusive_deasserted()
to save a few lines, and to make sure the reset line is asserted again
when the driver is unbound.

> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	if (rst) {
> +		ret =3D reset_control_deassert(rst);
> +		if (ret)
> +			return ret;

This branch could then be removed.

> +	} else {
> +		ret =3D regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +				   AD5529R_INTERFACE_CONFIG_A_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}

regards
Philipp
