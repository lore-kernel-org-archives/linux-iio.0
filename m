Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8141C3C1F;
	Sun, 19 Apr 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776603934; cv=none; b=VjHyRXQSPLIZ9Gm614k1j2RWiW5cFvzHaY1TxNV4W/TJJglnpQKMV7EEXwLtTDplvFDtdMuesi3ls96DKDgF44hAXnVvbqVxlySPgRjqoIaX8gKVVUWTCmg55eBv/ud8qepxSwxEZF8iYApkDzDRUTFcDlKLHpYE6sEf32AQAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776603934; c=relaxed/simple;
	bh=Cl/A22O7i9TmyBOebXLKojggWBID9AuppH7WHK8ruqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEMVsPEo6nBA4BJPPpwE6+uhFsSc/m1H89kjGZK3mWB1qhuYXyb43lz+y6Om1VZFkpqWhGV0MIdjDPvqt+t4QIJy1KiLnu9UWJNEcHx9h9aAT9+xunxBcFTUMOHCzPaAun1Xxlw5oPcIdVb6nbdSk+tK3vI8YE+0q5G8S0cVpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp5z4Bwk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp5z4Bwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA9AC2BCAF;
	Sun, 19 Apr 2026 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776603934;
	bh=Cl/A22O7i9TmyBOebXLKojggWBID9AuppH7WHK8ruqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fp5z4BwksB6l8d58Mm32VRkUI/VS9UeRSWsDfBtmQsAGS2TQn6leAh1EHRA/DCZc7
	 pNs008AOTSmbZpekZRsW3XxgXTOh/k/IUrbfOheG5JvsluJOucLbx9TlQTp+j9ag7S
	 9ZzbBXnrbpd2OB+rDGakq/EmisLHHi1JjBdvZR2royXkEuIYAIIWQX8CndNjRimr+N
	 A1j/GQgUSgE/hlVpiqB9Q4phySvHv9KYdjOA1bqZjjJXfh7KHZOfyul1O7rugdghiM
	 cPo33kOG9L9qNjjF4UW1bMRh2GlTa2/fEmjAFRot1QB6TcPzYsSFjzRuKzPyewi0jp
	 OzQhWJfb8BpAA==
Date: Sun, 19 Apr 2026 14:05:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: ak@it-klinger.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf08: replace sprintf with sysfs_emit
Message-ID: <20260419140529.3eeb0531@jic23-huawei>
In-Reply-To: <20260418005203.85696-2-m32285159@gmail.com>
References: <20260418005203.85696-2-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 19:52:04 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> This patch replaces sprintf function calls with sysfs_emit and
> sysfs_emit_at. This removes unsafe functions and makes the driver more
> stable and modern, by ensuring that boundary checks take place.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Hi Maxwell.

Changes look good but I think we should make a few more changes whilst
doing this.  Whilst often we'll ask people to beak out different
types of changes, that gets a bit 'flexible' when the code is changing
for other reasons and the other stuff is small enough.

So here I'd prefer to do all the stuff mentioned below in one patch.

Thanks,

Jonathan


> ---
>  drivers/iio/proximity/srf08.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index d7e4cc48cfbf..6d38a894ecd3 100644
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
> @@ -238,7 +238,7 @@ static ssize_t srf08_show_range_mm(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct srf08_data *data = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d.%03d\n", data->range_mm / 1000,
> +	return sysfs_emit(buf, "%d.%03d\n", data->range_mm / 1000,
>  						data->range_mm % 1000);
That is really odd indenting. Please reindent as:

	return sysfs_emit(buf, "%d.%03d\n", data->range_mm / 1000,
			  data->range_mm % 1000);

If there are lots of similar cases in the driver this may make sense
as a separate follow up patch.

>  }
>  
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
> @@ -334,7 +334,7 @@ static ssize_t srf08_show_sensitivity(struct device *dev,
>  	struct srf08_data *data = iio_priv(indio_dev);
>  	int len;
>  
> -	len = sprintf(buf, "%d\n", data->sensitivity);
> +	len = sysfs_emit(buf, "%d\n", data->sensitivity);

Might was well do
	return sysfs_emit();

>  
>  	return len;
>  }

