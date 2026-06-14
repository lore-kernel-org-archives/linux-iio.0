Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3A31A061;
	Sun, 14 Jun 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442858; cv=none; b=jz4qisdewO12xsKRCghhe17CPCOaF9jbrzi1bWz8p7BkVOrRVTdriVzsl4i97jL9oEHhnCM6GZl/o3WMw0n/gvalpLziTeGBU/caOj8lnRQ7KNegELn6jtfX6NQa7bUmRoCXioOFAuUluXUYJTFG6iHOq8pOoacRL936fUDiEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442858; c=relaxed/simple;
	bh=5rVX2Dgnva6ZkPfET/wVm40ROeihzDgH3Ej79NLhuo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjPqz5+9f+C2YFGOUUdzlWwM30lGWEVHQ4NWAtNwUjnUZtzSfgAmRTTm/RJ2eM3P+3iB8+Uz0kSohLlwAD8VB8aVXId0pEp5kY2T31U3rSqnONsPFyCzEJOax7lwIditoJqPNK3FJ5RpmhfDB0igXD5PBChuxj6NFIMxC33OZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MglRcIld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MglRcIld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CB61F000E9;
	Sun, 14 Jun 2026 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781442856;
	bh=gJlbvhjeWZOq8F+GVZ3biwWTY5iN4vzyP5vi/SDVYeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MglRcIld0S42Mv8A7lkpEHqsQRNJXwyWFUSHPAx1SZ8/5b8NtN93A/xY/ZM/xA3Sz
	 fZfLlHSvv5sd5ZpN0qupRQzqzkcMYH4Kg8Txw7fYyxc0H+0OWrFn8YoX2zxKKrelnl
	 dF8XpuCzLu9EEbMy2NLx1Dbam0uWmxTrMdVL8gCa10cdea93Ocu8daktUjq6j9vpSy
	 6+qPKX0lVZhdM90G1WOu2nRrN6XOgoe5NkdRgKyOVpe3SgQlhmT6mOLoC77fL3Brpq
	 mYCPAZIObbRiFkkY6bDbMD4/oEFSh7r1Fq4TZtDe9/gP51utC+8qHyDFd8GUW2gQxi
	 ZPkSPEerOiz2g==
Date: Sun, 14 Jun 2026 14:14:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] iio: accel: kxsd9: fix runtime PM imbalance on
 write_raw() error
Message-ID: <20260614141408.080a7cae@jic23-huawei>
In-Reply-To: <20260614071549.81920-2-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
	<20260614071549.81920-2-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 12:45:46 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> kxsd9_write_raw() takes a runtime PM reference with pm_runtime_get_sync()
> but returns -EINVAL directly when a scale with a non-zero integer part is
> requested, skipping the matching pm_runtime_put_autosuspend(). This leaks
> a runtime PM usage-counter reference on every such write, after which the
> device can no longer autosuspend.
> 
> Set the error code and fall through to the existing put instead of
> returning early.
> 
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> Assisted-by: Claude:claude-opus-4-8 coccinelle
Good find.  This one is nasty as it is easily triggered from userspace.
So I'm going to pick this up as it stands.  However, if you are interested
in a doing a follow up series that cleans things up further:

- The pm_runtime_get_sync() return value is not checked anywhere in this driver.
  So good to do that.
- The various places in this driver (including this one) where runtime_pm
  is involved would be nicer handled using the relatively new
  PM_RUNTIME_ACQUIRE_AUTOSUSPEND() / PM_RUNTIME_ACQUIRE_ERR()

Probably makes sense to do both of those in one go given they'll be touching
the same code.

Applied to the fixes-togreg branch of iio.git and marked for stable.
Note I'll be rebasing that branch on rc1 before doing a pull request.

Thanks,

Jonathan


> ---
>  drivers/iio/accel/kxsd9.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 4717d80fc24a..7ac885d94d7f 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -147,8 +147,9 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
>  	if (mask == IIO_CHAN_INFO_SCALE) {
>  		/* Check no integer component */
>  		if (val)
> -			return -EINVAL;
> -		ret = kxsd9_write_scale(indio_dev, val2);
> +			ret = -EINVAL;
> +		else
> +			ret = kxsd9_write_scale(indio_dev, val2);
>  	}
>  
>  	pm_runtime_put_autosuspend(st->dev);

