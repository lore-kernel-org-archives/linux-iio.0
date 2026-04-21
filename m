Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE002C2363;
	Tue, 21 Apr 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782528; cv=none; b=lmv7+0DKm2f9mUXbUAomdraKbNz/Fi+0IIdWrYM4CJvDq1U5mcmqOAUn3HCLBIcKlnTEKmcB7KJRiZPjj0n0wITlQy/UDFu/YcFmWmCfcplHO0cPRBKd6UC1uj21Lmz7OWG/+R33M0lB4poZuUw6amjBkDxY4V7YGNeltku4Jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782528; c=relaxed/simple;
	bh=QHjeAaDeTm1KTQk03p1jbjW6OdIYW8kO1yzahqg5KrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kriwCmHeUqj1YSkpeBLKwV6K/ZSrOxKxpIslEkAuxm0cWtMBiLd2khSSoflOBOeTgZBiXtzmK9XafdrFjNOIOUugNf3fZ4HMkMUb1p+zCH6a3G9Yw5iWOGMAF2wSyose//ngEotr7VWuOfh0k4urNSO9I8nuE9VdqVDBBX6SS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAAnWk9U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAAnWk9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29624C2BCB0;
	Tue, 21 Apr 2026 14:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782528;
	bh=QHjeAaDeTm1KTQk03p1jbjW6OdIYW8kO1yzahqg5KrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hAAnWk9UGz7m4EEQ9A0KKzoU9sTQLttcsI8Rs3eeEN6sV9MOgTxMJH4kPBm1/Zr+z
	 rPbhQqaWJBkGOjXoOCE3a1ghOIseQirDGNprZKqjM62FPeiFoJR2zyU/JNcNJ0UrHv
	 aDTHdi6FoVfhvkcsuzlBtQv6ZqWtmMUCDW5xAdpohArphT+TvR3xSze9i0N+CCv06R
	 ERpWxi1UGnZ9F7Gx5v3Ix/vu2o+E/9icBSlLPOmKZkg72Fs3oV6AlFGBVDoI9i3b/W
	 zTzGwIMka+Cw66vHdv1K8ubwdVXyw5Q5hsvetEVNNegyQoEW6/0Iu4sgdeOlD31GWi
	 UL0ZkUDXn6JOw==
Date: Tue, 21 Apr 2026 15:42:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: ak@it-klinger.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: proximity: srf08: replace sprintf() with
 sysfs_emit()
Message-ID: <20260421154201.041f03c5@jic23-huawei>
In-Reply-To: <20260420230813.25985-1-m32285159@gmail.com>
References: <20260420230813.25985-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 18:08:13 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> This patch replaces sprintf() function calls with sysfs_emit() and
> sysfs_emit_at(). While the current code is fine, sysfs_emit() is
> preferred over sprintf(), and will help modernize the driver.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  v2:
>  - Fixed indenting of sysfs_emit call in function srf08_show_range_mm.

Not true unfortunately. Now broken differently.

>  - Optimized return sequence in function srf08_show_sensitivity by
>    directly returning instead of modifying a variable and then
>    returning.
> 
>  v3:
>  - Changed indenting of sysfs_emit() call in function
>    srf08_show_range_mm() per Andy Shevchenko's request.
>  - Clarified commit message details.
> 
>  drivers/iio/proximity/srf08.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index d7e4cc48cfbf..e92526459dcf 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -226,7 +226,7 @@ static int srf08_read_raw(struct iio_dev *indio_dev,
>  static ssize_t srf08_show_range_mm_available(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "[0.043 0.043 11.008]\n");
> +	return sysfs_emit(buf, "[0.043 0.043 11.008]\n");
>  }
>  
>  static IIO_DEVICE_ATTR(sensor_max_range_available, S_IRUGO,
> @@ -238,8 +238,8 @@ static ssize_t srf08_show_range_mm(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct srf08_data *data = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d.%03d\n", data->range_mm / 1000,
> -						data->range_mm % 1000);
> +	return sysfs_emit(buf, "%d.%03d\n",
> +			data->range_mm / 1000, data->range_mm % 1000);
Should be:
	return sysfs_emit(buf, "%d.%03d\n",
			  data->range_mm / 1000, data->range_mm % 1000);
Or
	return sysfs_emit(buf, "%d.%03d\n", data->range_mm / 1000,
			  data->range_mm % 1000);


>  }
>  
>  /*
> @@ -316,10 +316,10 @@ static ssize_t srf08_show_sensitivity_available(struct device *dev,
>  
>  	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
>  		if (data->chip_info->sensitivity_avail[i])
> -			len += sprintf(buf + len, "%d ",
> +			len += sysfs_emit_at(buf, len, "%d ",
>  				data->chip_info->sensitivity_avail[i]);
>  
> -	len += sprintf(buf + len, "\n");
> +	len += sysfs_emit_at(buf, len, "\n");
>  
>  	return len;
>  }
> @@ -332,11 +332,8 @@ static ssize_t srf08_show_sensitivity(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct srf08_data *data = iio_priv(indio_dev);
> -	int len;
>  
> -	len = sprintf(buf, "%d\n", data->sensitivity);
> -
> -	return len;
> +	return sysfs_emit(buf, "%d\n", data->sensitivity);
>  }
>  
>  static ssize_t srf08_write_sensitivity(struct srf08_data *data,

