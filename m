Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795825660;
	b=xqi4a/hDs8FIq489BMcJxzYC0g1rZb/CBV5XslrNeAwNazTKhSg7ab5AXVHNq6EK43a0
	 9DPB1OA4kMS59p9FEbtFGs1ghHCFv5B9SX9ry6gTGtVOY6SiiJZw2wmj9NGPg1RbMOSOn
	 LrmzQfQgcpMCCl8EhQh2/WcZWYbQjb4DUH1ks4gKbM6msYcUzxHbaDOrKfAa3UBgB8CYb
	 7GDcwrCZaJIpjMAYyBpyax14b/l6UWQTT5KMkg0fttSrWbdGJRkIDgj79bPy/WcuCBgmm
	 Kz8ophdV/fTmHRgyyXv2/NbAEO1k1x64Q0QGkOMpexOILVhNA2EJPOVvpx2PWKk5qsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825660;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PmAsgEuxcUceiXNg69sQRPAQXrCE9XqCgcnntSDppbc=;
	b=PHYI1iWcxMc9BV3QVgUwwQCsdrerxNHwwB1VmBCbPAJKcMgEUa3bpxPKJ/4FjvTUf/gD
	 dv778fYg3rJZajXaCzDLenkc2dh1gLq/pJXFkBXalLLHTGsOA1ra48iEhfel9DDf2uYkL
	 LB39W+/h7sEPgKlTiFw7n01hmZOHRFw4il81lZB9S0lt5mUgouqiAm9Nsf6zhDQNWluty
	 muQ3EHRkoMvOpHOgCU6piaqJ8wxuL5sTigyTyLhQDEu8VDGD79wrjxOq7jGQkdGeviVys
	 RDhreHVl4kstxWmT1pIE7IfyP3rULQRYmDEy4oypFvzQBSVYcy1kGlY/xbdbx27h7qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOYlPsbf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE19606A31C;
	Sat, 28 Nov 2026 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOYlPsbf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA171F00898;
	Sat, 28 Nov 2026 00:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795825660;
	bh=PmAsgEuxcUceiXNg69sQRPAQXrCE9XqCgcnntSDppbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EOYlPsbfcCCilc8DyKbjd4AFq99WXqn3LRfn67aS9kOoSSzsNuPP8Wk6Xej0iC0y7
	 sNW+UhPaUpG4NjoZqR5lYBsekFsL+vOpGD43hg/sa9X2PDP1L0Xnh+mtGsQTcRcaTT
	 dMWqsi1UEuaIchVRhWR5ZGYK2rWjM0HXja4QWpTXo5k3tdRXR4e8MXXmBCKTqKBqIF
	 352FQUFM0Hs/HxqBxcXdXTjy00YfbBOhB0xKamAJrq6yjo+NuAwbv6m13nxY9dD7L0
	 xTpEFEZEKPRuF6eGHZW4irwIWzRpdasmsgWP7QUr79ozOZTqTlWc5fpXS/Tk99RkB2
	 9W+PsLUubO35Q==
Date: Sat, 28 Nov 2026 00:27:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org>
Cc: development@redaril.me, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Peter Rosin
 <peda@lysator.liu.se>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers: core: platform: Add
 platform_get_match_data() helper
Message-ID: <20261128002732.7c47a16d@jic23-hlaptop>
In-Reply-To: <20261128-iio_rescale_platform_ids-v2-1-4c35f16c4f77@redaril.me>
References: <20261128-iio_rescale_platform_ids-v2-0-4c35f16c4f77@redaril.me>
	<20261128-iio_rescale_platform_ids-v2-1-4c35f16c4f77@redaril.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Nov 2026 00:22:09 +0100
Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org> wrote:

> From: Fabio Forni <development@redaril.me>
> 
> device_get_match_data() retrieves driver data through the device's
> fwnode. However, software nodes don't implement
> fwnode->device_get_match_data(), so for a platform device that is
> dynamically instantiated, device_get_match_data() is of no use.
> platform_get_device_id() can be used instead, but this doesn't make the
> driver code abstract enough.
> 
> Add the platform_get_match_data() helper, so that driver data can be
> retrieved from platform_device's fwnode *or* device_id as a fallback.
I'd have added a reference to similar cases like i2c_get_match_data()
or spi_get_device_match_data()
and perhaps have followed the naming in there for the return variable.
Both call it match.

Other than that, LGTM.

Thanks,

Jonathan

> 
> Signed-off-by: Fabio Forni <development@redaril.me>
> ---
>  drivers/base/platform.c         | 28 ++++++++++++++++++++++++++++
>  include/linux/platform_device.h |  2 ++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 3593d45f4a7a..7db56ffbb6b1 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1090,6 +1090,34 @@ int __init_or_module __platform_driver_probe(struct platform_driver *drv,
>  }
>  EXPORT_SYMBOL_GPL(__platform_driver_probe);
>  
> +/**
> + * platform_get_match_data - get match data from fwnode or device ID
> + * @pdev: platform device to get data of
> + *
> + * Get match data from fwnode if available, otherwise get match data
> + * from pdev's platform_device_id->driver_data. driver_data is
> + * cast into a void* pointer.
> + *
> + * Return: -ENODATA if no match data is available.
> + */
> +const void *platform_get_match_data(const struct platform_device *pdev)
> +{
> +	const struct platform_device_id *id;
> +	const void *ret;
To follow similar cases this would be named match.

> +
> +	ret = device_get_match_data(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	id = platform_get_device_id(pdev);
> +	if (id && id->driver_data)
> +		return (const void *)id->driver_data;
> +
> +	return ERR_PTR(dev_err_probe(&pdev->dev, -ENODATA,
> +				     "no match data available"));
> +}
> +EXPORT_SYMBOL_GPL(platform_get_match_data);
> +
>  /**
>   * __platform_create_bundle - register driver and create corresponding device
>   * @driver: platform driver structure
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 3bd0f1f0d870..426148768b38 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -326,6 +326,8 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
>  	dev_set_drvdata(&pdev->dev, data);
>  }
>  
> +const void *platform_get_match_data(const struct platform_device *pdev);
> +
>  /* module_platform_driver() - Helper macro for drivers that don't do
>   * anything special in module init/exit.  This eliminates a lot of
>   * boilerplate.  Each module may only use this macro once, and
> 

