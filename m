Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A941A6813
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485424; cv=none; b=WafJ8xq8VMusJyjduj6NpTt08tC76ltIajyrUePPOTWcFvz4X/1wqJqbirzp/TkJLhn5CeMFN6t51Yuh1sbpQgX/iyxEPgB9pYHYTcr2WUlC9E5zME5TyeXSfRkahr5kYato2BMDuQgQAcrim41HUTjzlDkiqhEAjY9pkDwriuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485424; c=relaxed/simple;
	bh=/WQzFWzyWtBPCb93zCsp2dzNfY++BTiB2axu92sLf/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgJATpKW7/fTuZFBqMakUZRM9enAbxwf0FO++XROJR9P5upKyw4KL9AX+oPVSDjaapCEGTUXLdANm5mCNjIszQuibIGCr4PYf/dSCmf9jwf8pNitCiUmXMZ5UmyXf7Kprl24TGw8NQwowaniAqRouLOIb66UgOfG65ZydIx4Zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klHREm57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klHREm57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C27C19423;
	Mon,  2 Mar 2026 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772485424;
	bh=/WQzFWzyWtBPCb93zCsp2dzNfY++BTiB2axu92sLf/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=klHREm57/lriOW3wfMk8ZMP4dx4+No1pdmx8n+9S+8r/oWIwuzYb4td1hmuZsVcvk
	 q+N0en7d9MI0JIZclInY4N0XnHfAUWQr9bdpoTs52sM6Sho8hYPjjiRqB302t3I2ru
	 qwXj71CCZng6G77zrtif5hQaRzKepRPvD5n/Eek3HXGx1PDT7iAxkzrpsSzX576pIG
	 4cLEEZlnaboaDHk3yOxpOTZCdUeF/i8B3SHeOLwGqhOUlmQhDk93jKeFs8KOn9VP6U
	 fT0nm2wAZlscjIZYCPKnrji6lMj4m6j9cwPbIgXyDaZRJ6kgrYrB2eRAgVk5qhw6fr
	 L37+ZxB6U/XRQ==
Date: Mon, 2 Mar 2026 21:03:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bruno Martins <ehanoc@protonmail.com>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: ad7816: Replace sprintf with sysfs_emit
Message-ID: <20260302210337.1dc6447d@jic23-huawei>
In-Reply-To: <20260301212819.98597-1-ehanoc@protonmail.com>
References: <20260301212819.98597-1-ehanoc@protonmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 01 Mar 2026 21:28:26 +0000
Bruno Martins <ehanoc@protonmail.com> wrote:

> As stated in Documentation/filesystems/sysfs.rst:
> 'New implementations of show() methods should only use sysfs_emit() or
> sysfs_emit_at() when formatting the value to be returned to user space.'
> 
> Replace sprintf with sysfs_emit in the following sysfs show functions:
> - ad7816_show_mode()
> - ad7816_show_available_modes()
> - ad7816_show_channel()
> - ad7816_show_value()
> - ad7816_show_oti()
> 
> Signed-off-by: Bruno Martins <ehanoc@protonmail.com>
Hi Bruno,

I've applied this but want to note that the majority if not all of these
are non standard ABI that will ultimately need to be replaced with standard
IIO ABI as part of getting this driver ready to move out of staging.

Still, in the meantime your patch removes some bad practice that might get
copied so fair enough!

Applied to the testing branch of iio.git which will become togreg
once the bots have let me know if they found anything.

Jonathan

> ---
>  drivers/staging/iio/adc/ad7816.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 172acf135f3b..0e32a2295990 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -124,8 +124,8 @@ static ssize_t ad7816_show_mode(struct device *dev,
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>  
>  	if (chip->mode)
> -		return sprintf(buf, "power-save\n");
> -	return sprintf(buf, "full\n");
> +		return sysfs_emit(buf, "power-save\n");
> +	return sysfs_emit(buf, "full\n");
>  }
>  
>  static ssize_t ad7816_store_mode(struct device *dev,
> @@ -156,7 +156,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {
> -	return sprintf(buf, "full\npower-save\n");
> +	return sysfs_emit(buf, "full\npower-save\n");
>  }
>  
>  static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
> @@ -169,7 +169,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d\n", chip->channel_id);
> +	return sysfs_emit(buf, "%d\n", chip->channel_id);
>  }
>  
>  static ssize_t ad7816_store_channel(struct device *dev,
> @@ -231,9 +231,9 @@ static ssize_t ad7816_show_value(struct device *dev,
>  		data &= AD7816_TEMP_FLOAT_MASK;
>  		if (value < 0)
>  			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
> -		return sprintf(buf, "%d.%.2d\n", value, data * 25);
> +		return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
>  	}
> -	return sprintf(buf, "%u\n", data);
> +	return sysfs_emit(buf, "%u\n", data);
>  }
>  
>  static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
> @@ -281,9 +281,9 @@ static ssize_t ad7816_show_oti(struct device *dev,
>  		value = AD7816_BOUND_VALUE_MIN +
>  			(chip->oti_data[chip->channel_id] -
>  			AD7816_BOUND_VALUE_BASE);
> -		return sprintf(buf, "%d\n", value);
> +		return sysfs_emit(buf, "%d\n", value);
>  	}
> -	return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
> +	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
>  }
>  
>  static inline ssize_t ad7816_set_oti(struct device *dev,

