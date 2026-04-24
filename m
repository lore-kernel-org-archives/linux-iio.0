Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436E2BDC23;
	Fri, 24 Apr 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043671; cv=none; b=p3OToMkrNsvN6wKy0gakjv5vVspvVIgCaDiVcbb5sq4J8uLBkL/OYBVqa6qH46Rr4luwgelpWBcV4wrc1FZuHNdxRAW/Vmw8yx0u5uEyBrpHj11ZBAaEKIvWk8uQbrLu6IprF8o4jkDiz+PjqLSrmVKhKcddUWCz+aEK09WgCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043671; c=relaxed/simple;
	bh=4He5zd0X6Q3m/S1JQmYc48fl0nraa9F1DjbDYMe+rxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXZlB0zStak6JQF43VLbC1L2AWOCV6PPzhBrwuhkwKvWzChYAS8FunscirUlg7l2MeC57MK/Iao4JiX3bRxB1aPnv1RUWS/nFmsfIsuw+Sy8t1JSr5Tg0kopBXUe1BldFyOirXPxLdTUbFPiAwPf2QX2LdmZBWFt7y4t4EVgKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=icZj26Dt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="icZj26Dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96302C2BCB2;
	Fri, 24 Apr 2026 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777043670;
	bh=4He5zd0X6Q3m/S1JQmYc48fl0nraa9F1DjbDYMe+rxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icZj26DtCnbgqqOv7N9N7FtpQTkZ9PC9WeANjvXhDicnuxx5FIOCpXLWJEubkCq49
	 hSFLBPkR+fA6SVdZi/CjI9Kg4803MvNwXpAFTAfJ9+GUB/NmEBmeMZQBehyHZoKAH7
	 v8alcMzE6hZGEe1EU++DjrOT8TRz3QvDI0AYRpBs=
Date: Fri, 24 Apr 2026 17:14:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: kunjinkao-os <kunjinkao.jp@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: Replace sprintf() with
 sysfs_emit()
Message-ID: <2026042412-dictator-preschool-7acc@gregkh>
References: <20260424150617.28194-1-kunjinkao.jp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424150617.28194-1-kunjinkao.jp@gmail.com>

On Fri, Apr 24, 2026 at 11:06:17PM +0800, kunjinkao-os wrote:
> sysfs_emit() is the preferred function for sysfs show callbacks as it
> is aware of the PAGE_SIZE buffer and prevents potential buffer overflows.
> No functional change intended.
> 
> Signed-off-by: kunjinkao-os <kunjinkao.jp@gmail.com>
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
> -- 
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- You sent a patch that has been sent multiple times in the past few
  days, and is identical to ones that has been recently rejected.
  Please always look at the mailing list traffic to determine if you are
  duplicating other people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
