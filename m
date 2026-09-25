Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5D175A5;
	Fri, 25 Sep 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790302877; cv=none; b=h/3kIOYNp74NpPEwAwCG/Gawoyy5w9AlocsXWCSVUqmzARPsoefVUeI8qLWoxPoe43tFEaBSOM9zUX/DywlYRBRlufLUeRP0ooEnNLAefMaeH0DppdGjJ41qo9uKx/2D68o8DOuRLvD3FWe6QzxGr1zM6NQwhJm1wj6WkL+le/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790302877; c=relaxed/simple;
	bh=uG+YuAGp1NLwbcQB2WhgJpq0q1f05jxwA1iiXnbuw2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqRvS+lukZLw3qmMGbQtKbErNyqi5GAsInV3/dTFAxy1BSo8Dfx1Xl+kOj4Y+yBC6dB7R3xalFr7PboYySvhJ/6Z0dZ6W3H6bal5na8Hvr3OvbpFffa/8hsmgJJCic5tO/OgfBgXPJ+xH2BiXSIKyOJvyhksNI2iVRFb/3KQdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue1lzc8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue1lzc8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06881F000FF;
	Fri, 25 Sep 2026 02:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790302875;
	bh=Xfo5qT2POM4lzH4Nw96hq1cRzbMak5J/O6OVJbhCxQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ue1lzc8hJ9ZbjW8j6KNwH6l5ZzITW/o8M4EDAzieTJFB/r9ZK0vibsx97Wnglshhj
	 fkdZFw9X4uiiI5M1GKn2l9MSxnj9kXI84FGrHe0F7gMJET6BrXNHSWhivXbRsfEISt
	 u8eaIEM6D/aB+67xrxOPjCFnPfrP/f/KoaezLCVBPoGAX5YQQ+KCq7++/1AH9+7+V2
	 8SQLUlJgDDhgGpjsvKLaFOVnxSi729Zlbi2bLpLx5Fwi2D2ykONhLkD/fEiZ6Z5Y5J
	 Qrsd2qlSwwjKI4RtIIWcCd4UD1w5G+n9wtn+2JbxtqIT06Pphtp3lOYVP7NjnztAxw
	 vgmg/FQY+baFQ==
Date: Fri, 25 Sep 2026 03:21:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9 3/5] iio: magnetometer: ak8975: use temporary
 variable for struct device
Message-ID: <20260925032112.1cf46d80@jic23-hlaptop>
In-Reply-To: <20260920-ak8975-cleanup-v9-3-1b0f00ec19ef@gmail.com>
References: <20260920-ak8975-cleanup-v9-0-1b0f00ec19ef@gmail.com>
	<20260920-ak8975-cleanup-v9-3-1b0f00ec19ef@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Sep 2026 20:05:25 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Use temporary variable for struct device to make code neater.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
A couple of places in here where I'd also switch to dev_err_probe().

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c | 65 +++++++++++++++++++--------------=
------
>  1 file changed, 32 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index 59a7bb83a731..42f6892f4efd 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c

> @@ -580,6 +579,7 @@ static irqreturn_t ak8975_irq_handler(int irq, void *=
data)
>  static int ak8975_setup_irq(struct ak8975_data *data)
>  {
>  	struct i2c_client *client =3D data->client;
> +	struct device *dev =3D &client->dev;
>  	int irq;
>  	int ret;
> =20
> @@ -590,9 +590,8 @@ static int ak8975_setup_irq(struct ak8975_data *data)
>  	else
>  		irq =3D gpiod_to_irq(data->eoc_gpiod);
> =20
> -	ret =3D devm_request_irq(&client->dev, irq, ak8975_irq_handler,
> -			       IRQF_TRIGGER_RISING,
> -			       dev_name(&client->dev), data);
> +	ret =3D devm_request_irq(dev, irq, ak8975_irq_handler, IRQF_TRIGGER_RIS=
ING,
> +			       dev_name(dev), data);
>  	if (ret)
>  		return ret;
> =20
> @@ -608,12 +607,13 @@ static int ak8975_setup_irq(struct ak8975_data *dat=
a)
>  static int ak8975_setup(struct ak8975_data *data)
>  {
>  	struct i2c_client *client =3D data->client;
> +	struct device *dev =3D &client->dev;
>  	int ret;
> =20
>  	/* Write the fused rom access mode. */
>  	ret =3D ak8975_set_mode(data, FUSE_ROM);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Error in setting fuse access mode\n");
> +		dev_err(dev, "Error in setting fuse access mode\n");
>  		return ret;
>  	}
> =20
> @@ -623,26 +623,25 @@ static int ak8975_setup(struct ak8975_data *data)
>  							sizeof(data->asa),
>  							data->asa);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Not able to read asa data\n");

_setup is only called from probe, so the prints in here can all
be return dev_err_probe();

> +		dev_err(dev, "Not able to read asa data\n");
>  		return ret;
>  	}
>  	if (ret !=3D sizeof(data->asa)) {
> -		dev_err(&client->dev, "Error reading asa data\n");
> +		dev_err(dev, "Error reading asa data\n");
>  		return -EIO;
>  	}
> =20
>  	/* After reading fuse ROM data set power-down mode */
>  	ret =3D ak8975_set_mode(data, POWER_DOWN);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Error in setting power-down mode\n");
> +		dev_err(dev, "Error in setting power-down mode\n");
>  		return ret;
>  	}
> =20
>  	if (data->eoc_gpiod || client->irq > 0) {
>  		ret =3D ak8975_setup_irq(data);
>  		if (ret < 0) {
> -			dev_err(&client->dev,
> -				"Error setting data ready interrupt\n");
> +			dev_err(dev, "Error setting data ready interrupt\n");
>  			return ret;
>  		}
>  	}


