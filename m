Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A263EBF17;
	Thu, 22 Jan 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114600; cv=none; b=cLaT2NOIkMSU4MrWnTuPdPbLhDoK4C+gEXpPaNBgYZU6cddFU6dySouTb2uqLFJUCVYDuP1fFon5jtUdsya5vHhDS5VGUOUXJG585pMVwtSzmRx+c3Xb/vk3NOXr1WWhlXE3CJWubKSJnUhUuFHuh7lAoa5NmwlpWBh+DwUma6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114600; c=relaxed/simple;
	bh=q9JFXX9VbN4aJyujRj/rnjc/mZVgkgTl+lrmZ4CIgdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBJYYKRPtKzNyl+fetpkwOm4e7iRgJv+74AaBEcfF7EgRNJDcsa7F/bhRPLQQJzuQC2Y2LoYKZjS0OIpBweHW8QZKG7jeieOtlJ5n2siEWSv86R6hQHF724ZWD0flv35nQnLS+aKiNuMerttvhsjf2be5ccSIvivLGxx+3tKVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLExk6WG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLExk6WG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9691CC116C6;
	Thu, 22 Jan 2026 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769114599;
	bh=q9JFXX9VbN4aJyujRj/rnjc/mZVgkgTl+lrmZ4CIgdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oLExk6WGHEzYu+FsKekJvKBUy3gITt30aes/XvF5vvsJlq7/qnLWgIKtO5J8LwYhq
	 Gmb1DhRcfrebf17X+ybFKby6zJ6TcGjrxC0mLAEQSbZmH6Zg6TYTI9gjEuvNIouaOd
	 eraD8PLlMMwC8Dogfv3AvhFLbxnpm9sMiqO6egZn+B83OL+V/XkMgBZ/zOQxxX/ozJ
	 qeAeRE+TKPCtJ3CHoq8V5qOpyr8uGMICuHaKlE4Mq+DTyxHjNhrVsHY3A25IlNyWS5
	 xaMVX9cR+t9nsHOO7gOkBYvwwDKm/jeAzGPpllJigRdjoY9KRvsBiciuQGVMCXFC46
	 ULH5XFKNDCQRg==
Date: Thu, 22 Jan 2026 20:43:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: industrialio-backend: support backend
 capabilities
Message-ID: <20260122204310.55446399@jic23-huawei>
In-Reply-To: <20260121-b4-ad9467-optional-backend-v4-1-18d2c0d450cc@vaisala.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
	<20260121-b4-ad9467-optional-backend-v4-1-18d2c0d450cc@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 12:08:30 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Not all backends support the full set of capabilities provided by the
> industrialio-backend framework. Capability bits can be used in frontends
> and backends for checking for a certain feature set, or if using
> related functions can be expected to fail.
> 
> Capability bits should be set by a compatible backend and provided when
> registering the backend.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>

One question on the 'sense' of the cap that controls whether it's
always on. It's the sort of question that I'm not sure has a perfect answer.


> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..ac80abb71bbca88c3f6313d8d67b9c7ace076ceb 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -84,6 +84,28 @@ enum iio_backend_filter_type {
>  	IIO_BACKEND_FILTER_TYPE_MAX
>  };
>  
> +/**
> + * enum iio_backend_capabilities - Backend capabilities
> + * Backend capabilities can be used by frontends to check if a given
> + * functionality is supported by the backend. This is useful for frontend
> + * devices which are expected to work with alternative backend
> + * implementations. Capabilities are loosely coupled with operations,
> + * meaning that a capability requires certain operations to be implemented
> + * by the backend. A capability might be mapped to a single operation or
> + * multiple operations.
> + *
> + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports digital interface
> + * calibration. Calibration procedure is device specific.
> + * @IIO_BACKEND_CAP_BUFFERING: Backend supports buffering.
> + * @IIO_BACKEND_CAP_ALWAYS_ON: Backend does not need to be explicitly
> + * enabled/disabled. It is always on.
I'd like opinions on this one. To me it sound backwards though I can
see why you'd go this way.
Either the backend is capable of being enabled / disabled
in which case we have to further assume at boot it is disabled
(which is the dodgy bit!)

Or the backend is always on. To me that's not a capability,
it's a limitation.

My slight preference is for a capability meaning we 'can'
do something so the 1st option.

> + */
> +enum iio_backend_capabilities {
> +	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
> +	IIO_BACKEND_CAP_BUFFERING = BIT(1),
> +	IIO_BACKEND_CAP_ALWAYS_ON = BIT(2),
> +};
> +
>  /**
>   * struct iio_backend_ops - operations structure for an iio_backend
>   * @enable: Enable backend.
> @@ -179,10 +201,12 @@ struct iio_backend_ops {
>   * struct iio_backend_info - info structure for an iio_backend
>   * @name: Backend name.
>   * @ops: Backend operations.
> + * @caps: Backend capabilities. @see iio_backend_capabilities
>   */
>  struct iio_backend_info {
>  	const char *name;
>  	const struct iio_backend_ops *ops;
> +	u32 caps;
>  };
>  
>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
> @@ -235,6 +259,7 @@ int iio_backend_read_raw(struct iio_backend *back,
>  			 long mask);
>  int iio_backend_extend_chan_spec(struct iio_backend *back,
>  				 struct iio_chan_spec *chan);
> +bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
>  void *iio_backend_get_priv(const struct iio_backend *conv);
>  struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
>  struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
> 

