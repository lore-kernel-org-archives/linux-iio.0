Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E73FCB03;
	Fri,  8 May 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254132; cv=none; b=JnyDLmkko1SdgiV892u1nQDtosLczUbrPiGTKckpihsUX0rvz2G/rG0CEd2jyE+XZjBVUL0d76O/GCiIGs3JcNd8GoCgp0EcPmUyuoWO9yfW1DujwPuPoKFpv7hac7vlEz43CGuXTiMcv8XhkbZf7jKzW48TP3vFVPyVaffaEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254132; c=relaxed/simple;
	bh=njndWHZI6Z0nobl0cD5FnartDWO+IzZ2vDq4K91Sc9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=d4RHkCV0foQQSh4I5jl0A2EhquLWA0eq/MolgSq48HluaUeo95KA7oHvYZ553Ob0wKYKH0A50m1WGiPXB/Xqds92cvBAy0mze4d/nmfouJb9BSgzFNSouH03DdjzsLZIFncKJSBRpVGxTCtSaFGY/Jg4AkI4tdN4MOL1cCxHkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLm6Zett; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLm6Zett"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E13DC2BCB0;
	Fri,  8 May 2026 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778254132;
	bh=njndWHZI6Z0nobl0cD5FnartDWO+IzZ2vDq4K91Sc9M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=GLm6ZettPeItRMeJ/O5URGxPjWgyuY2vvOJQ5o5vohXtdk06xplD9wyIG/OrNIxiy
	 1u8awMOINig2cys4oiqAcyi0SqCu0kHQ8mBBQJB2L7DxPFjCyw1M1EwF7f+8zMeevt
	 bQWHLkncdFgtQsNjAXhZUtKfmlrYl8yv4EWXnFIQER6nALUOUI6O4oB6SgB2FErqsg
	 ifoXZjjkL/L4Da79ka9k7qMJXvJR6Of2x3d/SBIDe57RxrPTQJQPdxg5PRdrWcL9zv
	 /0NaTpoFPV+REIS6b/iVtFYAnydr9ZteAZcshPXCzqkceTCluK0Gxu2ZAHJdIYpgAv
	 ug+nncTgC+75w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 17:28:47 +0200
Message-Id: <DIDEH8M45VNJ.2983JIAEX3DRM@kernel.org>
Subject: Re: [PATCH v1 2/4] spi: Support suppress_override_attrs flag
Cc: "Mark Brown" <broonie@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260508095224.1275645-1-andriy.shevchenko@linux.intel.com>
 <20260508095224.1275645-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260508095224.1275645-3-andriy.shevchenko@linux.intel.com>

On Fri May 8, 2026 at 11:42 AM CEST, Andy Shevchenko wrote:
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 5f57de24b9f7..40e738f8cbb7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -214,8 +214,19 @@ static struct attribute *spi_dev_attrs[] =3D {
>  	NULL,
>  };
> =20
> +static umode_t spi_dev_attr_is_visible(struct kobject *kobj, struct attr=
ibute *attr, int i)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +
> +	if (attr =3D=3D &dev_attr_driver_override.attr)
> +		return dev->driver->suppress_override_attrs ? 0 : attr->mode;

This should have the same design problem as described in [1].

Also, wouldn't this oops the kernel right away as dev->driver should be NUL=
L?
How did you test this?

[1] https://lore.kernel.org/driver-core/DIDE94YBOOP3.KM9I6J4JIJIY@kernel.or=
g/

> +
> +	return attr->mode;
> +}
> +
>  static const struct attribute_group spi_dev_group =3D {
>  	.attrs  =3D spi_dev_attrs,
> +	.is_visible	=3D spi_dev_attr_is_visible,
>  };
> =20
>  static struct attribute *spi_device_statistics_attrs[] =3D {
> --=20
> 2.50.1

