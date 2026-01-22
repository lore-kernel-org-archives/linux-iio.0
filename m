Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620422759C;
	Thu, 22 Jan 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108654; cv=none; b=BdoYiGvvArpyFhkq1IX4AeAdPlOzzBI9zEQo/Zbco1LwOCZkAh4yQKbouK1iedxUkFh4+AHAFYSf8YdJaczcIqFvdlFAjn4Cv0uT/nqhRUy8eaObmTxVl6O8INUi/88yTYfFPX3TQea2zmTC0cfnrNoKRyX1Ej0GOMw71oTOjXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108654; c=relaxed/simple;
	bh=BO9Sq9sx8NYYFhIW21JkkF7nUDjl0/F1ylxnmRgz6OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJTU7N4l9DderphiJnqNjBKkJBZb5ykV5p3GHwHyAhr+KvFfM3jgpnVIddiJV82elHec6x5334MGznR9xbIJsx0OxQ1uAdfOpg/j0JdMSpqVqENeuOu8Ui9+oFXIeVQz9cse5hQ4Rp6HykNqdleNnn6JK7v8jb8nKRJAw6QrQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV26ch4o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV26ch4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DFBC116D0;
	Thu, 22 Jan 2026 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108652;
	bh=BO9Sq9sx8NYYFhIW21JkkF7nUDjl0/F1ylxnmRgz6OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XV26ch4o0bA7vt/1QI3VU2YAnLWo7zUsDZahO953+J8O6nC4jLXLmY7yzl3f6rfp+
	 bTbD3iajMcHYez6jSkFaYgx1hf3n0UQLfU2wxZ019g0F0l/XlhRtnCFY0SZ8Wyw0VW
	 VCaNba+uWodgLv1SeeG5Ac2ZHAIR5gkVZ867ZMRC3UspPqIluCrvVVSRlVMbAhvppX
	 9UumfEShE0aA5U8qB3r0ZVKwNZNP5hTWegKBbmh34T3dYJR4y5PRjeSCwNbyk1sLql
	 aF8AGjuiN/adQLN3Fdu0v3bq9mwl/Aw8W6v5m2/I2sX+pSqI4ylhWV0UM26JxPfBxi
	 6ComxACvFpvuw==
Date: Thu, 22 Jan 2026 19:04:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH v5 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
Message-ID: <20260122190401.510234c4@jic23-huawei>
In-Reply-To: <20260120-lock-impr-v5-2-d4d22347041f@gmail.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
	<20260120-lock-impr-v5-2-d4d22347041f@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jan 2026 01:20:42 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> In order to eventually unify the locking API, implement
> iio_device_claim_direct() fully inline, with the use of
> __iio_dev_mode_lock(), which takes care of sparse annotations.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

So sparse does change what it moans about with this one in precisely one in=
stance
There are 9 false positives with Al Viro's updated sparse - I haven't check=
ed the
original one recently.

Anyhow,=20
drivers/iio/adc/ad7173.c:416:12: warning: context imbalance in 'ad7173_set_=
filter_type' - different lock contexts for basic block
becomes

drivers/iio/adc/ad7173.c:425:9: warning: context imbalance in 'ad7173_set_f=
ilter_type' - unexpected unlock                                            =
             =20

Lets go with a bit meh for that and move on...

> ---
>  drivers/iio/industrialio-core.c | 44 -----------------------------------=
------
>  include/linux/iio/iio.h         | 40 ++++++++++++++++++++++++++---------=
--
>  2 files changed, 28 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index db803267df6e..0f8e3aa98b72 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2201,50 +2201,6 @@ void __iio_dev_mode_unlock(struct iio_dev *indio_d=
ev)
>  }
>  EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
> =20
> -/**
> - * __iio_device_claim_direct - Keep device in direct mode
> - * @indio_dev:	the iio_dev associated with the device
> - *
> - * If the device is in direct mode it is guaranteed to stay
> - * that way until __iio_device_release_direct() is called.
> - *
> - * Use with __iio_device_release_direct().
> - *
> - * Drivers should only call iio_device_claim_direct().
> - *
> - * Returns: true on success, false on failure.
> - */
> -bool __iio_device_claim_direct(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> -
> -	mutex_lock(&iio_dev_opaque->mlock);
> -
> -	if (iio_buffer_enabled(indio_dev)) {
> -		mutex_unlock(&iio_dev_opaque->mlock);
> -		return false;
> -	}
> -	return true;
> -}
> -EXPORT_SYMBOL_GPL(__iio_device_claim_direct);
> -
> -/**
> - * __iio_device_release_direct - releases claim on direct mode
> - * @indio_dev:	the iio_dev associated with the device
> - *
> - * Release the claim. Device is no longer guaranteed to stay
> - * in direct mode.
> - *
> - * Drivers should only call iio_device_release_direct().
> - *
> - * Use with __iio_device_claim_direct()
> - */
> -void __iio_device_release_direct(struct iio_dev *indio_dev)
> -{
> -	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
> -}
> -EXPORT_SYMBOL_GPL(__iio_device_release_direct);
> -
>  /**
>   * iio_device_claim_buffer_mode - Keep device in buffer mode
>   * @indio_dev:	the iio_dev associated with the device
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index aecda887d833..e263ab5eeccf 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -664,31 +664,47 @@ int iio_push_event(struct iio_dev *indio_dev, u64 e=
v_code, s64 timestamp);
> =20
>  void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev=
);
>  void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_d=
ev);
> -bool __iio_device_claim_direct(struct iio_dev *indio_dev);
> -void __iio_device_release_direct(struct iio_dev *indio_dev);
> =20
>  /*
>   * Helper functions that allow claim and release of direct mode
>   * in a fashion that doesn't generate many false positives from sparse.
>   * Note this must remain static inline in the header so that sparse
> - * can see the __acquire() marking. Revisit when sparse supports
> - * __cond_acquires()
> + * can see the __acquires() and __releases() annotations.
> + */
> +
> +/**
> + * iio_device_claim_direct() - Keep device in direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * If the device is in direct mode it is guaranteed to stay
> + * that way until iio_device_release_direct() is called.
> + *
> + * Use with iio_device_release_direct().
> + *
> + * Returns: true on success, false on failure.
>   */
>  static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
>  {
> -	if (!__iio_device_claim_direct(indio_dev))
> -		return false;
> +	__iio_dev_mode_lock(indio_dev);
> =20
> -	__acquire(iio_dev);
> +	if (iio_buffer_enabled(indio_dev)) {
> +		__iio_dev_mode_unlock(indio_dev);
> +		return false;
> +	}
> =20
>  	return true;
>  }
> =20
> -static inline void iio_device_release_direct(struct iio_dev *indio_dev)
> -{
> -	__iio_device_release_direct(indio_dev);
> -	__release(indio_dev);
> -}
> +/**
> + * iio_device_release_direct() - Releases claim on direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * Release the claim. Device is no longer guaranteed to stay
> + * in direct mode.
> + *
> + * Use with iio_device_claim_direct().
> + */
> +#define iio_device_release_direct(indio_dev) __iio_dev_mode_unlock(indio=
_dev)
> =20
>  int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
>  void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
>=20

