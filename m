Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2593D8114;
	Wed, 20 May 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272697; cv=none; b=CXBmyXZL00li4/YHvqPRC0DbX+p1A5YwfHpfsZpqeB/40iNRSn4crruWsvcKBbXg64Jk7lDf+lYNmP/392s1ICnOxvcdJ7Oy8SO4WGxjFOK6HL/wLwsorv495dwoi2YxfaR3ivPEZlntwa7yFaDEhuduqS4cr1VndbeRu2CVs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272697; c=relaxed/simple;
	bh=Kf9H4+Yj0u9YhotYy9wiJDpzBvEf1F37heOkprUMTkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHO6oZVLLeAolbbhJhtPhshTW60LLw+qzKH9Yj8eXNmsvI4Y3yqH30sEkMCT2eQTBkxGelNmIt1TuWW/qfhdTvEH0QTivspg9sqSWAs+kyKI0hHgvQHzW/uh7ygCU+gwc8L1dvor8tL8uKwOu7AjCXrhdIPNs/7gmew0utG6/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKLDCqta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKLDCqta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395481F000E9;
	Wed, 20 May 2026 10:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779272687;
	bh=Y4rdOQ18U0Csxbf5sPupL4tUuoi+9+87zmrht4kEkJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oKLDCqtaswAz9XMOOCiUVjwniqYwcLyRTWQ4tj89JDwScq785b60mN5ING4FBX9G0
	 uXIPi5T0SUeS4GWTo4zMiFcOmYgWJ6eFAjQETElD/dzC2TSNQfpufdjmUXCoye35/S
	 hGifxXyuahquCNasR4A57+p4MxrgA4lW+NQYa6pmivElrdtijM7PjXGd7XLRbw34H9
	 bVDh2Im/4OrJswnKPlkRP+J8UjINsj6Ju39XqxfNYxU/68HS4EOOiHZRIYsm7IKnj0
	 tmLlvfGcf8Q5C70BRgG8fNmby8ldpG1ad6dc3J+AxSo7Nog1D/6V6spstknySxenIx
	 8JEyoHCP2uQAA==
Date: Wed, 20 May 2026 11:24:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 08/11] iio: adc: hx711: split variable assignments in
 hx711_read and hx711_reset
Message-ID: <20260520112438.4b396652@jic23-huawei>
In-Reply-To: <20260518220228.63322-9-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
	<20260518220228.63322-9-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 03:32:24 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Separate the initial value assignments from the declarations in
> hx711_read() and hx711_reset().
> 
> This is a small preparatory cleanup before the later loop-iterator and
> variant-specific changes adjust the local variable layout in these
> functions.
> 
> No functional change.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> No change from v8.
>  drivers/iio/adc/hx711.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 30e1ce321747..9e5cafa1e307 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -159,9 +159,10 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
>  {
>  	int i, ret;
>  	int value = 0;
> -	int val = gpiod_get_value(hx711_data->gpiod_dout);
> +	int val;
>  
>  	/* we double check if it's really down */
> +	val = gpiod_get_value(hx711_data->gpiod_dout);
>  	if (val)
>  		return -EIO;
>  
> @@ -204,7 +205,9 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
>  
>  static int hx711_reset(struct hx711_data *hx711_data)
>  {
> -	int val = hx711_wait_for_ready(hx711_data);
> +	int val;
> +
> +	val = hx711_wait_for_ready(hx711_data);
> 

Trivial but no blank line here. We want that error
check closely associated with the thing that set val.

>  	if (val) {
>  		/*

