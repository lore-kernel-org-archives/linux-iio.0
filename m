Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694B23E0C68;
	Sat, 28 Feb 2026 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305528; cv=none; b=Mops3sJyZFxEFiBDjxD5xJiaDMaopkQ8vqh1+du0Cc4UzCqGmcNBmefbQs8/7N/a20CSdD0Gpq0o/mXEk55DKCKxb/cQB2++tXlD6Tt2QwIb/zsNmRTz8PONyyfZCE4uw6AlFPxSoSaGrbJnVgsTb4qzFy7IiftcTro5SagvFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305528; c=relaxed/simple;
	bh=54zwrw3YFK4Qs9bg2mO8RosOoA9LIeUa/4Jds0qDCvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYDYubD5SfJbuPdocOmaY3zDNLoAfp1F+UBDQq9KDPB1E8Ei/KD0YpaAwQkirHxnRwaE6qSof9Y9JViuXd7pK4B4u+J6CQUs6CTufV2W+M4mXI0FRVnrQGWBy0df/qU3t4JJt0qnIjeDZsX/F001fXJQK1htp/IBO57t0fwwZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqiSCJWe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqiSCJWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FABC116D0;
	Sat, 28 Feb 2026 19:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772305528;
	bh=54zwrw3YFK4Qs9bg2mO8RosOoA9LIeUa/4Jds0qDCvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bqiSCJWePddoOYWp5IvtpAXoZKCourdevg+IZH5pvHkHlqX0SsvLFoBhXY5wHAE3a
	 wbl/3Vt+0Ca+TzNzcohng4lcx4/9uqdQ2tRO5+f/GzawvLwM9wdAulDFftr/hGqq2X
	 c9GUVvmwvRNXoCuVSHXBn30deDyGoZcK2hL+0KClc518keg+lj5fPd3VFtKFuQnoP+
	 JI+GdewBtEIdcK2DoQ/7/w4uDA/TTIHyHwscFl2Y93bQyecGo5cuqLsbuohZIzliEZ
	 kP6P9bpnfBGbnJDWaS+vuXPe6MmDleJjfV6d6TiLqulDoMUhAQAG65+zgJmqH+0OjS
	 PA5CV1snt+lCg==
Date: Sat, 28 Feb 2026 19:05:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Mark Brown <broonie@kernel.org>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] iio: backend: add
 devm_iio_backend_get_by_index()
Message-ID: <20260228190516.35262dda@jic23-huawei>
In-Reply-To: <20260223162110.156746-4-antoniu.miclaus@analog.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
	<20260223162110.156746-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb 2026 18:21:02 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add a new function to get an IIO backend by its index in the
> io-backends device tree property. This is useful for multi-channel
> devices that have multiple backends, where looking up by index is
> more straightforward than using named backends.
>=20
> The new function directly uses the index to find the backend reference
> in the io-backends property, avoiding the need for io-backend-names.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu,

I'm seeing the use of __free as an unrelated change that I'd prefer
to see as a precusor cleanup patch.

Thanks,

Jonathan

> ---
> Changes in v4:
>   - Add Reviewed-by from Nuno S=C3=A1
>=20
>  drivers/iio/industrialio-backend.c | 61 ++++++++++++++++++++----------
>  include/linux/iio/backend.h        |  2 +
>  2 files changed, 44 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-backend.c
> index 447b694d6d5f..d90a3a0b17c6 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -949,25 +949,16 @@ int iio_backend_data_transfer_addr(struct iio_backe=
nd *back, u32 address)
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, "IIO_BACKEND");
> =20
> -static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *=
dev, const char *name,
> -							 struct fwnode_handle *fwnode)
> +static struct iio_backend *
> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> +				       struct fwnode_handle *fwnode,
> +				       unsigned int index)
>  {
> -	struct fwnode_handle *fwnode_back;
> +	struct fwnode_handle *fwnode_back __free(fwnode_handle) =3D
> +		fwnode_find_reference(fwnode, "io-backends", index);

This use of __free is a refactor, that you are doing whilst you happen to b=
e here.
Really should be in a separate precursor patch so that we can more
easily see what the real code movement going on here is about.

>  	struct iio_backend *back;
> -	unsigned int index;
>  	int ret;
> =20
> -	if (name) {
> -		ret =3D device_property_match_string(dev, "io-backend-names",
> -						   name);
> -		if (ret < 0)
> -			return ERR_PTR(ret);
> -		index =3D ret;
> -	} else {
> -		index =3D 0;
> -	}
> -
> -	fwnode_back =3D fwnode_find_reference(fwnode, "io-backends", index);
>  	if (IS_ERR(fwnode_back))
>  		return dev_err_cast_probe(dev, fwnode_back,
>  					  "Cannot get Firmware reference\n");
> @@ -977,21 +968,35 @@ static struct iio_backend *__devm_iio_backend_fwnod=
e_get(struct device *dev, con
>  		if (!device_match_fwnode(back->dev, fwnode_back))
>  			continue;
> =20
> -		fwnode_handle_put(fwnode_back);
>  		ret =3D __devm_iio_backend_get(dev, back);
>  		if (ret)
>  			return ERR_PTR(ret);
> =20
> -		if (name)
> -			back->idx =3D index;
> +		back->idx =3D index;
> =20
>  		return back;
>  	}
> =20
> -	fwnode_handle_put(fwnode_back);
>  	return ERR_PTR(-EPROBE_DEFER);
>  }
> =20
> +static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *=
dev, const char *name,
> +							 struct fwnode_handle *fwnode)
> +{
> +	unsigned int index =3D 0;
> +	int ret;
> +
> +	if (name) {
> +		ret =3D device_property_match_string(dev, "io-backend-names",
> +						   name);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +		index =3D ret;
> +	}
> +
> +	return __devm_iio_backend_fwnode_get_by_index(dev, fwnode, index);
> +}
> +
>  /**
>   * devm_iio_backend_get - Device managed backend device get
>   * @dev: Consumer device for the backend
> @@ -1008,6 +1013,24 @@ struct iio_backend *devm_iio_backend_get(struct de=
vice *dev, const char *name)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
> =20
> +/**
> + * devm_iio_backend_get_by_index - Device managed backend device get by =
index
> + * @dev: Consumer device for the backend
> + * @index: Index of the backend in the io-backends property
> + *
> + * Get's the backend at @index associated with @dev.
Gets=20

It could either be=20
Get us (in which case our Get's is valid) or Gets as it the function is
responsible for getting.  I think Gets is more natural here.

> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *devm_iio_backend_get_by_index(struct device *dev,
> +						  unsigned int index)
> +{
> +	return __devm_iio_backend_fwnode_get_by_index(dev, dev_fwnode(dev),
> +						      index);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_by_index, "IIO_BACKEND");
> +
>  /**
>   * devm_iio_backend_fwnode_get - Device managed backend firmware node get
>   * @dev: Consumer device for the backend
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 7f815f3fed6a..8f18df0ca896 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -237,6 +237,8 @@ int iio_backend_extend_chan_spec(struct iio_backend *=
back,
>  				 struct iio_chan_spec *chan);
>  void *iio_backend_get_priv(const struct iio_backend *conv);
>  struct iio_backend *devm_iio_backend_get(struct device *dev, const char =
*name);
> +struct iio_backend *devm_iio_backend_get_by_index(struct device *dev,
> +						  unsigned int index);
>  struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
>  						const char *name,
>  						struct fwnode_handle *fwnode);

