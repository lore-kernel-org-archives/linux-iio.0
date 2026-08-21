Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5891A262D;
	Fri, 21 Aug 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274089; cv=none; b=S7edZSBXYvGLiQKabxX2XlXIpy1xYzodThFw/YbsC9/8wjd5Rfo87Ys5Mh9nsrXDLYTaVe2HMzs6d8wxvB2jx121JXs9zFKEnRM32mf0yxeKq8iXANlO5rRfX3AzedPlkKNDCUd/6lFotb8rzIhWQGCosOXzbWAYscDv3eaJKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274089; c=relaxed/simple;
	bh=zc2EEruKEeMuof6lIdlFGgvrmpPI31gFAeQAHOTK6dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SapP4cg580uiv+niyvlF6RrsizaOeaeiiJfgMU1QEVsfp3+N62fVYUxsC+2gCMeN85BWwmPSpLy9Cq7TJ8Ehe9dMbcvnceO4iJD9Gxq4u9tFHHM7xnHIYSEFjAwUA47Bbd6OtevaI47Qef2DbtG6RRjClgrqBUTRC7yII6KYD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFLnwqya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFLnwqya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160781F000E9;
	Fri, 21 Aug 2026 01:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787274088;
	bh=39ogNTuvFSpDXYDC6NVXih1kOy1idmujErwRlsoi/FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gFLnwqyaiLonaSqw+xQsYo1PgzH6xxjlrTXcSJoY23gUpaBptXVrFZBZx8ysHv7wP
	 NCnS1r4tN/l+zcGheX4AICpxYIxFVE78F1FKuOYINNxWqjflUPXvoXrcC8uCt/Xcln
	 m7Sr2Zx7p2iNWCNKX0relxoH+XOXfZXovCazFkLHFWkgUov6Q0uJLM9Z4/RvHWG+wW
	 U6HKY0Yy+DGwYen3r1KQPjNKSII76UFI28ZlOsxYZwrTBgNIKtjIx0/qWwjKUTrS+9
	 EdAIVUTbs66UyM3Zi9W/vOnJtkBE/JvWaJhK0mcM9RqPoteLQljunND870y81e9Fzy
	 qLcoJqeafuGHw==
Date: Fri, 21 Aug 2026 02:01:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: pressure: ms5637: Add per-variant
 compensation
Message-ID: <20260821020122.1c2cc7dc@jic23-huawei>
In-Reply-To: <20260820141224.23730-6-adamianlouis@gmail.com>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
	<20260820141224.23730-6-adamianlouis@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 10:12:20 -0400
Louis Adamian <adamianlouis@gmail.com> wrote:

> Previously, all sensors used the compensation for the MS5637-02BA. Add
> correct temperature compensation for MS5637-30BA, MS5803-01BA,
> MS5803-02BA, MS5803-05BA, MS5803-14BA, MS5803-30BA, MS5805, MS5837-02BA
> and MS5837-30BA.
> 
> The deprecated meas,ms5803, meas,ms5637 and meas,ms5837 compatibles
> resolve to the -02BA variants. This changes the values that meas,ms5803
> and meas,ms5837 report.
> 
> meas,ms5805 now uses its own constants, correcting its readings. MS8607
> gets its own constants struct. The values match the MS5637-02BA ones it
> previously shared, so its readings are unchanged.
> 
> Signed-off-by: Louis Adamian <adamianlouis@gmail.com>

For this one Sashiko raises a valid concern.  The ABI is changing for
those deprecated choices.  To avoid that will require a slightly 
annoying dance with extra copies of the data to keep the old name.

One other question below.

> ---
>  drivers/iio/pressure/ms5637.c | 376 ++++++++++++++++++++++++++++++++--
>  1 file changed, 360 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index 359f3a8e79b2..81b87b79e011 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c


> +/*
> + * MS5805-02BA01 compensation constants
> + * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5805-02BA01&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580502BA01-50
> + * Pages: 8-9
> + * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
> + */
> +static const struct ms_tp_comp_consts ms5805_consts = {
> +	.press_scale = 1000,
> +	.high_t2_multiplier = 0,
> +	.high_t2_shift = 0,
> +	.high_off2_multiplier = 0,
> +	.high_off2_shift = 0,
> +	.low_t2_multiplier = 11,
> +	.low_t2_shift = 35,
> +	.low_off2_multiplier = 31,
> +	.low_off2_shift = 3,
> +	.low_sens2_multiplier = 63,
> +	.low_sens2_shift = 5,
> +	.vlow_off2_multiplier = 0,
> +	.vlow_sens2_multiplier = 0,
> +	.has_vhigh_temp = false,
> +	.off_t1_shift = 17,
> +	.off_shift = 6,
> +	.sens_t1_shift = 16,
> +	.sens_shift = 7,
> +	.press_sens_shift = 21,
> +	.press_shift = 15,
>  };
>  
>  static const struct ms_tp_data ms5805_data = {
>  	.name = "ms5805",
>  	.hw = &ms5637_hw_data,
> -	.comp_consts = &ms5637_02_consts,
> +	.comp_consts = &ms5805_consts,

Is this change actually a fix?

> +};

