Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC03033FB;
	Mon, 17 Aug 2026 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935614; cv=none; b=hR9WD+EqJb9rxO3fEn0sn0FesZhNIyIsoagED8xe3tdx9bLphWkUyAHQI5L+07sL+FFea1hgeOnp77NraKk5CYVJH4kQ8ZASgxbyoo23cEJQzgwlyaXEQojjOBdFmzCoEqo5kXp2wJNtOU/oAKnM7Vo/UlzuEuTsnrQcxlijDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935614; c=relaxed/simple;
	bh=53DChTC0SDikA9nFgc9dWRTtKG84JvQypiaB3N6YQrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2PsbYnnz+nX9EKDp4at8P9lXCrXrIqT//6N0zxkAgn74nBIgDGxLiPnLCgqtHWho5wLw7WErfokasvLWtolMTMFhaqsGttGwivxtA4O8uM49g1PWxYxNb8+6Rh9Eu7Bk8fINtb+DiJOEkbwRjUNijZPVS1Lw+/ta4cUsCbH3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo3YxSo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo3YxSo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E061F00A3A;
	Mon, 17 Aug 2026 03:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786935612;
	bh=oaTsz16RuC5m4NBeRj7UH3OUMuRZ33dUuXg4UMZlPe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mo3YxSo+jmKWEqltBfBODRoEj/FECALG7z3dQbE5i2ng1MrjTInvCCTnOLJYKhrDw
	 ep0CFPra+aqooQUj1rCkED51Rav6z1cbiwKvRLa7WSBfBgJsHGlg2Hby4c3GPC0kzK
	 08JZUXL96YMPLzd8GvxbsTip/Crz2xXXrvbemLZW/G6jBZFLMSNl8/DSU1fFm86bhm
	 XlkCVRPCw4IbVSDx7RJg99gjFDfyWyKkg0CcAMy2eahbc65Ydha21SbwmekGXLXGpV
	 MEmFsVSXvMNnS3yZygc09QsaPgK7/C7iqs2aorQWXwld2LDjKYY3ZwTlG+pIxLX9LF
	 nF03ybTGRMc+A==
Date: Mon, 17 Aug 2026 04:00:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Gustavo Silva <gustavograzs@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: imu: bmi270: Use in_range_inclusive() in
 bmi270_write_event_value()
Message-ID: <20260817040006.1778790e@jic23-huawei>
In-Reply-To: <20260816-minmax-in-range-incl-v2-2-766f737dd6bf@gurudas.dev>
References: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
	<20260816-minmax-in-range-incl-v2-2-766f737dd6bf@gurudas.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 12:26:21 -0700
Guru Das Srinagesh <linux@gurudas.dev> wrote:

> Replace the three "in_range(val, 0, MAX + 1)" checks with the new
> in_range_inclusive() helper, expressing each as the inclusive [0, MAX]
> range it actually validates.
> 
> No functional change.
> 
> Assisted-by: Claude-Code:claude-sonnet-5
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>

I like the improved readability of this, so if you get the implementation
issues resolved, this patch is fine by me. 

Jonathan

> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 2ad230788532..7f386a615b39 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -1132,7 +1132,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
>  	guard(mutex)(&data->mutex);
>  
>  	if (type == IIO_EV_TYPE_CHANGE) {
> -		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))
> +		if (!in_range_inclusive(val, 0, BMI270_STEP_COUNTER_MAX))
>  			return -EINVAL;
>  
>  		raw = val / BMI270_STEP_COUNTER_FACTOR;
> @@ -1152,7 +1152,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		if (!in_range(val, 0, (BMI270_G_MICRO_M_S_2 / uscale) + 1))
> +		if (!in_range_inclusive(val, 0, BMI270_G_MICRO_M_S_2 / uscale))
>  			return -EINVAL;
>  
>  		tmp = (u64)val * BMI270_MOTION_THRES_FULL_SCALE * uscale;
> @@ -1161,7 +1161,7 @@ static int bmi270_write_event_value(struct iio_dev *indio_dev,
>  		regval = FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK, raw);
>  		return bmi270_update_feature_reg(data, reg, mask, regval);
>  	case IIO_EV_INFO_PERIOD:
> -		if (!in_range(val, 0, BMI270_MOTION_DURAT_MAX + 1))
> +		if (!in_range_inclusive(val, 0, BMI270_MOTION_DURAT_MAX))
>  			return -EINVAL;
>  
>  		raw = BMI270_INT_MICRO_TO_RAW(val, val2,
> 

