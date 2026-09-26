Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3454707A;
	Sat, 26 Sep 2026 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382186; cv=none; b=lE24AVhAGWBCVFKMK1b2VuNBhwW5CdJCD/OXmFtnF7gwIqgTDoMQoRlqI+9LQkDp9NGPBvK+WEqWLfGMZMBMmlCNw5sMwnJdlzhmCcgf7Hi5kKRgv7rexCJFLd+hwJdX9yGp0UanuypncuV290ZF3NReYlJmFVl2oA0UGrD0itk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382186; c=relaxed/simple;
	bh=fRMUdJ8vjW6p1nlb4SHwlr3DYAV30ITj/1LALlrkqus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYzM57MKmveTpPjiv3VHStt2iSF1rMDkSVoZ2Js9NQ490eZdaNPYsg1vslMlEJqZHVQD6qo3i/r2w6eih6e922/eHTFDNwnV43KjN7eycIFZ46FzfNOX10Z/wXFqLAPmMlAliXOakBkuzdpvBKMDlp4JdXk4WCeiq7UD7eoJzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP2Wkff2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP2Wkff2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1241F000FF;
	Sat, 26 Sep 2026 00:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382185;
	bh=0/wwdqxxP3JImm4pML8mkdI+NlGI/uvOGcu4Chp3Ins=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WP2Wkff2WP3ah+/vc4fhHRrza6LaTC8TpahvNRxFQpIjhcvee+GprEpKN6l24Eci5
	 agkGjllVpuCNQ3JDNDShmO+U8jF4coqUAx499vC5kWH7UBoQSPInd7q36JujquNnZc
	 KgZga2X0I6jfSBeHW9VThBy57dSMpqmEuzMOSdRcaWdrucn582mLKUBTEsqV8tDJKP
	 8f7K1jg7UOzKosbnIEiyyb8iVuZRxco2VVTFu7nAg3HOwkilr8ceYWyz9k/gjUHkK4
	 X7UASJXuauBUPuBvsYjn3MKbjBTvsRlPvyJVmd+buo10U3LdB/V0EAQ3sfehBJe0SZ
	 WB9qAk/N26PCQ==
Date: Sat, 26 Sep 2026 01:23:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads112c14: fix negative settlingtime
 check
Message-ID: <20260926012304.6eb5aaab@jic23-hlaptop>
In-Reply-To: <20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-v1-1-1fd53e7242e8@baylibre.com>
References: <20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-v1-0-1fd53e7242e8@baylibre.com>
	<20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-v1-1-1fd53e7242e8@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 16:27:43 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Fix checking for negative values when writing the settlingtime
> attribute. MICRO is an unsigned long, so on 32-bit architectures,
> integer * MICRO is evaluated as a 32-bit unsigned value. A negative
> integer part is then zero-extended to a positive s64 and passes the
> < 0 check. Large positive values can also wrap around.
> 
> Reject negative input before doing the multiplication and do the
> multiplication as 64-bit.
> 
> Fixes: 839cbb1e2331 ("iio: adc: ti-ads112c14: add settlingtime attribute")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/message/20260910-iio-adc-ti-ads112c14-filter-support-v3-9-e5a9b27ddb1a%40baylibre.com
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ti-ads112c14.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 3c877126b0be..483f159e2836 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -729,10 +729,11 @@ static ssize_t ads112c14_write_settling_time(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	settling_time_us = integer * MICRO + fract;
> -	if (settling_time_us < 0)
> +	if (integer < 0 || fract < 0)
>  		return -EINVAL;
>  
> +	settling_time_us = (s64)integer * MICRO + fract;
Hi David,

Given you sanity checked that this can't be negative, is it worth changing
settling_time_us to a u64 to reflect that?

Jonathan

> +
>  	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  	if (IIO_DEV_ACQUIRE_FAILED(claim))
>  		return -EBUSY;
> 

