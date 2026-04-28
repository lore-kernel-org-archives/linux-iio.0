Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0163264CB;
	Tue, 28 Apr 2026 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394236; cv=none; b=DQb0WTQSxZr96/RKTSBsAUaDttxteDx936Sq+gGvkDrK7/7Nb12laNRgiS9/Ut7Ag/qFqKJ70McZbGhkKFgS/lr7x8SIdEfXoc+5R8/3f7XqTf4wkA+R01pgi7tchOm4Ks4tfRPdvwaQLWy8EOjK8H4grCvD241wG2tZE5Ays34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394236; c=relaxed/simple;
	bh=I8mEkeuha7kBzqdbUOmp+GHPz6esuWpLFtrXlt0jSbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUefEucU5M46LkbKAj+VmBTyXhkVUy1L2kWTxaRK4t5+s8BXy6rmmdNBkXode7Xpyrk6erd9n0r9sQ6LyPX+WQrmDAUViaKVy6GbJqnPhcUfrF8O2WZYFS1zie0SaMAQlucM1RrrjkI1Mn3rL63fbuvwW6fv8I+oP8ZaXP98HiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GORjBUXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GORjBUXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB716C2BCB7;
	Tue, 28 Apr 2026 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777394236;
	bh=I8mEkeuha7kBzqdbUOmp+GHPz6esuWpLFtrXlt0jSbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GORjBUXoZIIx+r4Psv2Tped61MpFLOlKmOX/DR3VkqZ2Q18csJRrqqOp/HA+7c4Bl
	 tlFFZIxNIslWfKcTRIVN/2L1cq+hSXu9QyFCbRvR43TuNJcA10+H6Ci+7FaRQuSHDl
	 dJODC+/1RZfUvhXvsOfaxl8qg7F7vXjQbxxVmHEPjqcv6J8//3Xo+hJvhub8fSAzo0
	 k4sQ0WvKksbviuoU15OXVg+jZWsHkTU3MtnPNzm9acbR35mFh/sKGmEfzzNDj1zLWJ
	 5mCiBjmDb3IU82Nm+8qeVjPR810lGcZ5yHIL/TTiqMu5NCJABQGxFw+QMyLIzowOux
	 jN1UaF3rpgX9w==
Date: Tue, 28 Apr 2026 17:37:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: buffer: Move from int64_t to s64 for
 timestamp
Message-ID: <20260428173706.29b5cf3e@jic23-huawei>
In-Reply-To: <20260427185147.3016331-1-andriy.shevchenko@linux.intel.com>
References: <20260427185147.3016331-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 20:51:47 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> iio_push_to_buffers_with_ts_unaligned() uses int64_t for timestamp.
> Move it from int64_t to s64 to make consistent with:
> - iio_push_to_buffers_with_ts()
> - all current users that supply s64 anyway
> 
> This will reduce potential of wrong type being chosen when using
> this API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
I was being overly optimistic and thinking we'd get rid of this ABI by
now so not worth fixing.  That's going a bit slow, so fair enough.

Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 2 +-
>  include/linux/iio/buffer.h        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 46f36a6ed271..6d92295422be 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -2422,7 +2422,7 @@ EXPORT_SYMBOL_GPL(iio_push_to_buffers);
>  int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
>  					  const void *data,
>  					  size_t data_sz,
> -					  int64_t timestamp)
> +					  s64 timestamp)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index d37f82678f71..e0344d51b4f9 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -71,7 +71,7 @@ static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
>  
>  int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
>  					  const void *data, size_t data_sz,
> -					  int64_t timestamp);
> +					  s64 timestamp);
>  
>  bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>  				   const unsigned long *mask);

