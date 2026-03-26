Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761639A7F6
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557511; cv=none; b=AzBbn4TdPiCnSDNUN8v1+5LscAmpbRvF4qxJLvyMP83M0WBgowspF0Up1PQl+LoaWpP3bwMGLogOMlh4lnL8WfSJZ3GONf+MxTR4AX6xn4cSQc79+QBQYbE2PgpbqhkgnYBxT/7532kszqYGiRu1fPk2iTOQBfRtIyORBLw9zgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557511; c=relaxed/simple;
	bh=CejSRyWsuA1et1DDvUxGTd3//qRgOpgWhr+RF60/1I8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esnROBmiZZxX/3EWtpXH+nw/LRBwcj9u9pKeu86gSZ75cNY7b/Ka3hYo7nnQawqz8l8oY9Ykyzz1WdIc312cijZTd7zkq9Azz1cBRtkyI1fT2kUZ6l1oavsgyCA9uZgLY7OGffzmqcVvXohj6exRW6jbUy4o7D/0x3ZoVT4jwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qD1rRRdK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qD1rRRdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BB7C116C6;
	Thu, 26 Mar 2026 20:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774557511;
	bh=CejSRyWsuA1et1DDvUxGTd3//qRgOpgWhr+RF60/1I8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qD1rRRdKTB5OPdRMJRX83fFpDawkvD1g6ujJHe/+EQsnA/T9AeC1OnLz6LWqO0A3E
	 2w4Weivki1u3o29hLoyF6PlBhNSkJ1XoFqN7qOQf3pZorvHAan8XbakJDgW/aVpN+G
	 Zg06a5y2wSGcpI5d53tE1lYHmncq20JifDKzwSy/lIiVWrRcsFy8opYLu4hYtt5pN8
	 6JM8BLDlXvSf9Hurmu37dk2TJyaf/HT3rHZfZIsrxIqbHixZrJ5/6hySoKxlKYvM46
	 3XR3Cj3OFR7O6jYUGLU+jwUhDcGPyOpVtKj9UbXRCcnhAuLlFEJMgXOjSa4gAhBE0D
	 M7Xo3iUBVm4og==
Date: Thu, 26 Mar 2026 20:38:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp4821: add configurable gain support
Message-ID: <20260326203824.59e8e950@jic23-huawei>
In-Reply-To: <20260326071242.9218-1-nikhilgtr@gmail.com>
References: <20260321180707.73a7ad60@jic23-huawei>
	<20260326071242.9218-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Mar 2026 12:42:42 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Add support for configuring the DAC gain using the GA bit.
> Expose gain control via IIO_CHAN_INFO_CALIBSCALE.
>=20
> Scale is updated dynamically based on selected gain:
> - 1x gain =E2=86=92 2.048V full-scale
> - 2x gain =E2=86=92 4.096V full-scale
>=20
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Just one small thing from me.

>  static int mcp4821_probe(struct spi_device *spi)
> @@ -177,12 +235,15 @@ static int mcp4821_probe(struct spi_device *spi)
>  	const struct mcp4821_chip_info *info;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*state));
> -	if (indio_dev =3D=3D NULL)
> +	if (!indio_dev)

Not related to rest of the patch. So doesn't belong in here.
Also generally not worth the noise of changing these.

>  		return -ENOMEM;
> =20
>  	state =3D iio_priv(indio_dev);
>  	state->spi =3D spi;
> =20
> +	/* default gain is 2x as GA bit is active low*/
> +	state->gain_1x =3D false;
> +
>  	info =3D spi_get_device_match_data(spi);
>  	indio_dev->name =3D info->name;
>  	indio_dev->info =3D &mcp4821_info;

