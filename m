Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94A2F7ACA;
	Sat, 31 Jan 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879527; cv=none; b=dPPgmyvZFX6boWv638hwklBQ5gCP5XMuIa6O5YVhfkboyPmFGfNSU975IfJS5GSsUWI7pHnJAVzIjaDPE/Fhf0tJ391QH6oMmu6ZLOSzp0zYwRKOy3gzEABBEub1Hd2+brodcp+cI4lLjioYrq+wI2voWcheR697AtO8zwKe6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879527; c=relaxed/simple;
	bh=VaEKrnm/XBpapGLqvfrWNcY+dtbEj2x0SCRWbumdbuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKFLx79qakf9/nK9aM5irFFNV/eRAkf/YjvnJ4YBxwCKjjFTgr1vz6Km3smxaR5adL+tlri9FnB+JFPgtOWzVOk9WhUGR/KTG7Xaj6FyWY/JOpbg0YqwG0/xOLCJzCcCuRrRzGLs6FH8ZjzEmCx9k8gfOi263KgMCL79XiyoQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/nsWHD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/nsWHD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F680C4CEF1;
	Sat, 31 Jan 2026 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769879526;
	bh=VaEKrnm/XBpapGLqvfrWNcY+dtbEj2x0SCRWbumdbuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u/nsWHD+s0OUPWxHalyqjQp7CEVdRHDfJyAURVdfjHhfrE58Sfdehob+sUygRGtoK
	 Bpqw0w3nzDFg/B9/xgXsahBKFeODLNdi4kmUYP0SRsNf6oHvMSEAmfy987nbiipQju
	 xo4NbaWSQDlJI4kPy5zz8EyPJStypXfrxMVBqEbEDg0ZC1GzI6zcXgrnaQmdp5raMY
	 bvk1WKBwt50epRuiUMK+tfBz61Q2SZHbhW2dQakpDemmdyty5eWAdGNCaYhIkYmv8b
	 VkvAu2AR65IF9uYVmDxhEj16jZcB6mjr7Bz5ZaU0rbJ1F/9/qMsAE/kcJpfwVXLkXr
	 yUN6O71V1MVcQ==
Date: Sat, 31 Jan 2026 17:11:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Waqar Hameed
 <waqar.hameed@axis.com>, chuguangqing <chuguangqing@inspur.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: ltr501: return proper error code from
 ltr501_get_gain_index()
Message-ID: <20260131171158.5c4b93f9@jic23-huawei>
In-Reply-To: <20260130135241.137353-1-antoniu.miclaus@analog.com>
References: <20260130135241.137353-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 15:52:38 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Return -EINVAL instead of -1 when no matching gain value is found
> in the gain table. Using standard kernel error codes ensures
> consistency and proper error handling.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/light/ltr501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 022e0693983b..29e93986dea6 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -754,7 +754,7 @@ static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,
>  		if (val == gain[i].scale && val2 == gain[i].uscale)
>  			return i;
>  
> -	return -1;
> +	return -EINVAL;

Look at how this is used. What you have here isn't wrong but I'd rather
we returned the error this function provides than overwrite -EINVAL
with -EINVAL at the caller.

>  }
>  
>  static int __ltr501_write_raw(struct iio_dev *indio_dev,

