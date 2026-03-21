Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952223D283;
	Sat, 21 Mar 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094611; cv=none; b=Y5VYTKx7Oh1+M3QNA5VwFu3gtPVB0Hdz9ohmpjfZ+akCbKXe0UC+msFCHs5t1Qg8Xq3XlkhgB9U0uUwrB+pF+L+NDpi+rxYs94xfvC/dFtOJbgqNegwMFmqw15OpzCgZ+/Fnr+5PYxE7evPE6WeOetNZIEPw+U7WsEnSCccg2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094611; c=relaxed/simple;
	bh=7W3b8TnUWWqd/j6oc5ffT+Gpx6IpZzgleR+IljiSNFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t564Ad1W57S+VLT21ouziNf9Qa235IlfjrMrx/91tPj4FIp6K8o4ZyOMKrRjWfosTwcHlgPODmG5zhPe4KpcMyaOwEkQH0jVA+1umYvjQLygh6h8salqpKH3oRMWNLpPTBGKU06qQ7uDgoNSI4Wk12kzl2LBda+98YReR6nBNzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY2sI+bm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY2sI+bm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4728DC19421;
	Sat, 21 Mar 2026 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774094611;
	bh=7W3b8TnUWWqd/j6oc5ffT+Gpx6IpZzgleR+IljiSNFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RY2sI+bmZOP64AvRjq5tz7rOjSzh785R/NE0njHXUEomlxkK899bkNVYtpQG/NzR9
	 4z+nW2TV2IVdyvBEOGrWLdKVprtigxa8mezhroVLzfmHWQgixTiElx4rU6oYP92EXq
	 ih35s49SXO1sybWrB8AarKbVosS1K3EEcspXxbMRPAj1Zg2pufz2yYe/PPnqZQZ2rW
	 4qRwUAYxDDOVu5DaytGo74DZhs7UMeej7bbaLnWE4GWpLiYopLMo7TAGZSD+8FNvu5
	 53A03Jj0FPjEGRjLnfsrZBqF6LEed+RuPGIFtDpp2d0W99ypQbye2mg/yMjiZW/omV
	 EhFUZDdy6P64Q==
Date: Sat, 21 Mar 2026 12:03:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 1/4] iio: backend: use __free(fwnode_handle) for
 automatic cleanup
Message-ID: <20260321120321.30214199@jic23-huawei>
In-Reply-To: <20260321100154.1258-2-antoniu.miclaus@analog.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
	<20260321100154.1258-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Mar 2026 12:01:51 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Convert __devm_iio_backend_fwnode_get() to use the __free(fwnode_handle)
> cleanup attribute for the fwnode_back variable, removing the need for
> manual fwnode_handle_put() calls. Move the declaration closer to its
> first use, narrowing its scope.
>=20
> No functional change.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
This patch stands on it's own as a good improvement so applied to the testi=
ng
branch of iio.git.  If we end up going to a v8 just don't include this
patch. (I'm easily confused ;)

Thanks,

Jonathan

> ---
> Changes in v7:
>   - No changes
>=20
>  drivers/iio/industrialio-backend.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-backend.c
> index 447b694d6d5f..58f7e1426095 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -952,7 +952,6 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, =
"IIO_BACKEND");
>  static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *=
dev, const char *name,
>  							 struct fwnode_handle *fwnode)
>  {
> -	struct fwnode_handle *fwnode_back;
>  	struct iio_backend *back;
>  	unsigned int index;
>  	int ret;
> @@ -967,7 +966,8 @@ static struct iio_backend *__devm_iio_backend_fwnode_=
get(struct device *dev, con
>  		index =3D 0;
>  	}
> =20
> -	fwnode_back =3D fwnode_find_reference(fwnode, "io-backends", index);
> +	struct fwnode_handle *fwnode_back __free(fwnode_handle) =3D
> +		fwnode_find_reference(fwnode, "io-backends", index);
>  	if (IS_ERR(fwnode_back))
>  		return dev_err_cast_probe(dev, fwnode_back,
>  					  "Cannot get Firmware reference\n");
> @@ -977,7 +977,6 @@ static struct iio_backend *__devm_iio_backend_fwnode_=
get(struct device *dev, con
>  		if (!device_match_fwnode(back->dev, fwnode_back))
>  			continue;
> =20
> -		fwnode_handle_put(fwnode_back);
>  		ret =3D __devm_iio_backend_get(dev, back);
>  		if (ret)
>  			return ERR_PTR(ret);
> @@ -988,7 +987,6 @@ static struct iio_backend *__devm_iio_backend_fwnode_=
get(struct device *dev, con
>  		return back;
>  	}
> =20
> -	fwnode_handle_put(fwnode_back);
>  	return ERR_PTR(-EPROBE_DEFER);
>  }
> =20

