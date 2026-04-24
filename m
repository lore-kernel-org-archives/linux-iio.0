Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369233D6D5;
	Fri, 24 Apr 2026 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049441; cv=none; b=PVCj6GBg74/Mz1ZsF7LMT/UITOBYQp3Z/7yEREhLd4hnz+7PfzVyS0Gn1oq8J3WlzYgW/JjdTC6MWbxU7igfVisZo2OMmMHnCrW9v1cPGrAH5gek9JUO1oJ8jlROWRPy07Nt2DRK8OloG5tI1GWicylPcxKCxd8eloR8kbr33XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049441; c=relaxed/simple;
	bh=y0wDYNpwZm3PC8kTlwPJ5TJrjG3dC0aflc/oD3XFG10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4IJTq9tXSxA+arrN4WwyBA0vKB4W6azUunaQLMGBBXw0X1smtNSsgSxa7Lz3CL/g6tZqgGK3CVMoCsgL2Ogtxv+OJqjE+iY07GlMe1sSw1VpRV2/CZAuRzLRAcVo5EV6UD4gVg/9OglwLf/Kjcoizvc+G/AgfQEgyoiwg53YoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8bAeCuj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8bAeCuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89549C2BCC9;
	Fri, 24 Apr 2026 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049441;
	bh=y0wDYNpwZm3PC8kTlwPJ5TJrjG3dC0aflc/oD3XFG10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8bAeCujknvZOR+NWBUcSss6sADhqc5dXVo1Sv/E6v1km/+WUq7X4QrYnKlyRUYAa
	 /VEZubhsVebbZgTM0q2QCbyQ9XFWqVbtOa/lm806qHumwjbYgnScy2PLyYDmyVfHL6
	 nndA3oB2ofmdgqjl1SD10PSPAn8Q8wcSV344udTlkWYVV3MjHRzxGNXARu+z304wor
	 XxMbCDuu23Ax2ZK/NXX4vUWIxLUBA0pMpXY3j4Ezibfksa97fuSC/3z1gxWTnwewJk
	 75QnTiagxs/xN+vqQqg01Fw48fDj7Pv20mza+BjkT5BdLSWBYR2KJDWNYrbRj1zEpn
	 viFBAlvuTSd/w==
Date: Fri, 24 Apr 2026 17:50:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kunjinkao-os <kunjinkao.jp@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: Replace sprintf() with
 sysfs_emit()
Message-ID: <20260424175032.7335f5c3@jic23-huawei>
In-Reply-To: <20260424150617.28194-1-kunjinkao.jp@gmail.com>
References: <20260424150617.28194-1-kunjinkao.jp@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 23:06:17 +0800
kunjinkao-os <kunjinkao.jp@gmail.com> wrote:

> sysfs_emit() is the preferred function for sysfs show callbacks as it
> is aware of the PAGE_SIZE buffer and prevents potential buffer overflows.
> No functional change intended.
> 
> Signed-off-by: kunjinkao-os <kunjinkao.jp@gmail.com>

Before sending a patch out, check if anyone else is working on the same code.
Currently this is the 3rd instance of the same thing.  I think
the first one was in this series:
https://lore.kernel.org/all/20260331072453.6530-1-mdmahmudulhasan1511@gmail.com/

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

