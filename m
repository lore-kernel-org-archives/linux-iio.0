Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F34403E8B
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285229; cv=none; b=bRNuy3mkIl96cC1H8YDlhAh6WeCHa5YaGMhScOU26Mz31DGJSWE1fKczGOsyYg6FK2Nqb1ZUSjhIU9D8s9spJNiSdwaN5h4V45BDIv5EZGZof0UhXuIAPeZZB5U7ipxleYpRfT4FVLJrgZWwm/+Ox4Rn4kPikTDevpFmxACzM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285229; c=relaxed/simple;
	bh=woQVhQKsMqGjt0kxKh39K7OtYp+rBM7ZkivE1hZCqlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+rgIkAUQtmdHYWm10y9ngG1ScIMe9ZLre+M+HVwGbIVQ/Vf/GXIS0VeZ9XJn0h2ytCt717HaOXmMllyUCZ/Ao7DXeRlMcbA0jmuNG6S5aAEsYAnzD4DQS9EDBrTz87e3GZcSWyP+A0uNX6+mlLJzlLs8zB7rJ1SFczfgKWl3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwJgHCOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwJgHCOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E451F000E9;
	Fri, 12 Jun 2026 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781285226;
	bh=4Nh9r8Gxfv4On6LBsUe9USfZPOQWaQ9mmDgLIMS1vb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UwJgHCOt97qReQrNqiB+KvXMaJjReibuOz6atCK8SNrmQE7w6l6+JpyFNv8aluBiZ
	 NpIKp3rLzSfZXdCE2jyCa7mLo29OiAYBxltVvP+G+WK51ZFu6w8KszdKTmClbjz+5p
	 yOkWkDBea198OWbKi1RK89zjw6b7oVDnRMscJ55dVPNSMqi9o8f6A9iLt9ly48VN/1
	 KL8JNMH7W3GThnSpjbtXKanK9e3l13h3gQ0l0AzFcJUbMg03Bj9tXzfDUQrrqN+pk4
	 Xv5pAmgrQ3j1MitZrewR/ijL9ap6LDUnL5h09n8/NznEB9oyJN7GhKsJWgWuBtwgMt
	 BoXWy3eVw3g3A==
Date: Fri, 12 Jun 2026 18:27:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcin Bis <marcin@bis-linux.com>
Cc: linux-iio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] iio: dac: ad5337: Add driver for the AD5337 DAC
Message-ID: <20260612182700.102057cb@jic23-huawei>
In-Reply-To: <20260612133125.196208-1-marcin@bis-linux.com>
References: <20260612133125.196208-1-marcin@bis-linux.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jun 2026 15:31:21 +0200
Marcin Bis <marcin@bis-linux.com> wrote:

> Add driver for the AD5337 dual 8-bit I2C voltage-output DAC.
> This part uses the pointer-byte protocol and is not compatible with
> the AD5337R nanoDAC+ driver (adi,ad5337r).

Ah.  Here's the explanation.  Make sure that's in the dt binding patch
description as well!  However, the binding could be shared.
Note that sharing a binding doesn't imply a shared driver.

+CC Fabio who sent the original patch to ad the ad5337r.
Fabio, what was the history of that part?  I can't find any reference to it
any more.

>=20
> Signed-off-by: Marcin Bis <marcin@bis-linux.com>
> ---
>  MAINTAINERS              |   5 ++
>  drivers/iio/dac/Kconfig  |  12 ++-
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad5337.c | 159 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 176 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/dac/ad5337.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e035a3be797c..614589b6efa4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -438,6 +438,11 @@ W:	http://wiki.analog.com/AD5398
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/regulator/ad5398.c
> =20
> +AD5337  ANALOG DEVICES INC AD5337 DAC DRIVER
> +M:	Marcin Bis <marcin@bis-linux.com>
> +S:	Maintained
> +F:	drivers/iio/dac/ad5337.c
> +
>  AD5446	ANALOG DEVICES INC AD5446 DAC DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index cd4870b65415..de2bc2ec2269 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -62,6 +62,16 @@ config AD5064
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5064.
> =20
> +config AD5337
> +	tristate "Analog Devices AD5337 I2C DAC"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Analog Devices AD5337 dual
> +	  8-bit I2C voltage-output DAC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad5337.
> +
>  config AD5360
>  	tristate "Analog Devices AD5360/61/62/63/70/71/73 DAC driver"
>  	depends on SPI
> @@ -247,7 +257,7 @@ config AD5696_I2C
>  	depends on I2C
>  	select AD5686
>  	help
> -	  Say yes here to build support for Analog Devices AD5311R, AD5337,
> +	  Say yes here to build support for Analog Devices AD5311R, AD5337R,

Separate patch before this one please.

>  	  AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
>  	  AD5693R, AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to
>  	  Analog converters.

> diff --git a/drivers/iio/dac/ad5337.c b/drivers/iio/dac/ad5337.c
> new file mode 100644
> index 000000000000..b983baa203fe
> --- /dev/null
> +++ b/drivers/iio/dac/ad5337.c

> +
> +#include <linux/iio/iio.h>
> +
> +#define AD5337_NUM_CHANNELS	2
> +#define AD5337_RESOLUTION	8
> +/*
> + * AD5338 - 10bit, AD5339 - 12bit
> + */
What is this doing here?  Add support for them
or drop the comment.
> +
> +#define AD5337_PTR_DAC_A	0x01
> +#define AD5337_PTR_DAC_B	0x02
> +
> +struct ad5337_state {
> +	struct i2c_client *client;
> +	struct mutex lock;

Locks needs a comment on what data it is there to protect.

> +	unsigned int vref_mv;
> +	u8 cache[AD5337_NUM_CHANNELS];
> +};


> +
> +static int ad5337_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad5337_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask !=3D IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	if (val < 0 || val > ((1 << AD5337_RESOLUTION) - 1))
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);

	guard(mutex)(&st->lock);
	ret =3D ad5337_write_dac(st, chan->channel, val);
	if (ret)
		return ret

	st->cache[chan->channel] =3D val;

	return 0;

> +	ret =3D ad5337_write_dac(st, chan->channel, val);
> +	if (!ret)
> +		st->cache[chan->channel] =3D val;
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}

