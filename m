Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7188255E43;
	Sat,  7 Feb 2026 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476261; cv=none; b=O7x9oZFgR9gm7bIBD0lAMJHOfsET7tAPjBXyclWWhkKT9uAyHGw6yhizsZbXNG1F8NQ99+lmLa/A3n/6Rqb6msqwew451r2XJWns9nPMVlEh8YEg2Yn9c15SFgULZ3ojOe5hwQyrW0Lj2iXJDaE2eTdJq5V7y1Ucl58nlOqmPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476261; c=relaxed/simple;
	bh=mhEwiYTQDjhTQppnhNZ0pw2vQBCifA3Qj1CAtJyYjsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTr1zSeua4rd7VCKPwl5AHvJGzOIYMPci9140UwyGHsizPlQKfTErXASTa+RpN0t/lwkfxT9gS8gFT51EVIB7dtrqbLetEvc/cOxA8YTncEveEK5ZzvMqpUpUFRDYsplcOD4kndYk5S7e0URNGMaa/g7a0aijbFYObvwjU5rCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRmyFrDe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRmyFrDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207B7C116D0;
	Sat,  7 Feb 2026 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770476261;
	bh=mhEwiYTQDjhTQppnhNZ0pw2vQBCifA3Qj1CAtJyYjsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fRmyFrDea4g6KRfylJdeTBaXN1QASY7GEMIfJmDDsyQBRPa+IlsJDJAA9OPdG5Ili
	 PYqzOtG9ykxneYHFOVgg9o5eK87+uWCseMLu7AWFL2ixyGUBH+V7RSP5X/rBSBBWDa
	 aLSUV1yqmY53PMTqzzuNrD/K1cIN+5nXJFF2OLydqlsKHGyFEkhFU8C8W1u4UMZ+Vd
	 GnzcffwMgZnmeEO0q812y+8W+EEChCpCGUpXV9sapf4ELKSMU5qrNSiE/J3zxHGbkv
	 Zbqij841rqVdRnWIRAA8X+8kpUUujer4zUQSXo/FtD7CfUrI390HctFwlGjXPIfCz+
	 fmKsrEOM69mEw==
Date: Sat, 7 Feb 2026 14:57:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Mark Brown <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio: backend: add
 devm_iio_backend_get_by_index()
Message-ID: <20260207145731.69c8d842@jic23-huawei>
In-Reply-To: <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	<550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 18:07:14 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add a new function to get an IIO backend by its index in the
> io-backends device tree property. This is useful for multi-channel
> devices that have multiple backends, where looking up by index is
> more straightforward than using named backends.
> 
> The new function directly uses the index to find the backend reference
> in the io-backends property, avoiding the need for io-backend-names.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
One thing inline.

> ---
>  drivers/iio/industrialio-backend.c | 51 ++++++++++++++++++++++++++++++
>  include/linux/iio/backend.h        |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 447b694d6d5f..3b692d48481e 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -1008,6 +1008,57 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
>  
> +static struct iio_backend *
> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> +				       struct fwnode_handle *fwnode,
> +				       unsigned int index)
> +{
> +	struct fwnode_handle *fwnode_back;
> +	struct iio_backend *back;
> +	int ret;
> +
> +	fwnode_back = fwnode_find_reference(fwnode, "io-backends", index);
Applies more generally in this file, but does holding the fwnode over the
__dev_iio_backed_get() below matter?  If not
	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
		fwnode_find_reference(fwnode, "io-backends", index);

and you can drop the various fwnode_handle_put() calls.

> +	if (IS_ERR(fwnode_back))
> +		return dev_err_cast_probe(dev, fwnode_back,
> +					  "Cannot get Firmware reference\n");
> +
> +	guard(mutex)(&iio_back_lock);
> +	list_for_each_entry(back, &iio_back_list, entry) {
> +		if (!device_match_fwnode(back->dev, fwnode_back))
> +			continue;
> +
> +		fwnode_handle_put(fwnode_back);
> +		ret = __devm_iio_backend_get(dev, back);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		back->idx = index;
> +
> +		return back;
> +	}
> +
> +	fwnode_handle_put(fwnode_back);
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +/**
> + * devm_iio_backend_get_by_index - Device managed backend device get by index
> + * @dev: Consumer device for the backend
> + * @index: Index of the backend in the io-backends property
> + *
> + * Get's the backend at @index associated with @dev.
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
> @@ -237,6 +237,8 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
>  				 struct iio_chan_spec *chan);
>  void *iio_backend_get_priv(const struct iio_backend *conv);
>  struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
> +struct iio_backend *devm_iio_backend_get_by_index(struct device *dev,
> +						  unsigned int index);
>  struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
>  						const char *name,
>  						struct fwnode_handle *fwnode);

