Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC37261A;
	Sun, 26 Apr 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214150; cv=none; b=pv0abthUX/Mh1NP496Tr6RJ4apX2k8VU+mamZDWjurmFcVaM+ggaCJ4xgq1nHLAPmXGyjYIVe0+H85H4puKAnm6x/Q3BXRGBGPtoTL1OKT/SZvU8TEsMTDUr4BxV5VOJZOnH5mLH/pWqDDJKMmH/dRu1TCs0nvXXwzxorufRmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214150; c=relaxed/simple;
	bh=RwC39tm8nIuOnnjTYqgGd5kfCwEV/ng5p2o/8ZmTnro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rmkc3Q2Ia5M5Xm+r1YCDqh8ywXi9p5iDy4Rux5Rm5NtDXzwz30LxMttx98thsE3u72W4wnSCLxB6/u9d0EKOcOqCixDVOW0axCkhs1r1nIc6hG2wHnqlbUELziXM3eYvD09J6RwZg+ehlENIXkKuUXbL2WUv8daOnouPszFIMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZAkM+Z9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZAkM+Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFA2C2BCAF;
	Sun, 26 Apr 2026 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777214150;
	bh=RwC39tm8nIuOnnjTYqgGd5kfCwEV/ng5p2o/8ZmTnro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cZAkM+Z9Y6fD7vWHkW47SHa2YRDFmKw0Srczx7KAfUDS+wE9/aw+dbwhds/ALG5hR
	 uzTVV1xbc3eE85X4xFvGg2RzouL0ZU5G1lEb431dD2B6+kPaA9kSlhC+NGKZcqEHpZ
	 oPIsAexXIcNgaDcJADR1Yzwx6uS28QDZdkeSJepAtuMreU0YTqMaB+nZWr54DIqGhI
	 O+Ayxp+3youaqLjhvKwpeYfGV0hX3KdCVmIB289EwCiYhWhO4pWBy+15VkJC4g0mrU
	 JB3Olcg748uKTV6jLEcmYB7sP14agUexgVeqHt0ILpxDjqkxV/xpSasaBKX6fTRwqg
	 iT+7SWNke8KYQ==
Date: Sun, 26 Apr 2026 15:35:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 9/9] iio: ssp_sensors: reuse embedded RX buffer for
 SPI transfers
Message-ID: <20260426153540.3d43a085@jic23-huawei>
In-Reply-To: <20260426091710.3722035-10-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-10-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:47:10 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Avoid allocating a temporary DMA buffer in the interrupt context when
> handling hub-to-AP and AP-to-hub SPI write messages.
> 
> Replace the dynamically allocated RX buffer with a fixed-size,
> preallocated buffer embedded in the driver structure and reused for all
> SPI receive operations. This removes memory allocation from the
> IRQ path, simplifies lifetime management.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 870214551f0b..e41da88bf96d 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -339,7 +339,7 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
>  /* threaded irq */
>  int ssp_irq_msg(struct ssp_data *data)
>  {
> -	char *buffer;
> +	char *buffer = data->rx_buf;
>  	u8 msg_type;
>  	int ret;
>  	u16 length, msg_options;
> @@ -383,19 +383,12 @@ int ssp_irq_msg(struct ssp_data *data)
>  			 * but the slave should not send such ones - it is to
>  			 * check but let's handle this
>  			 */
> -			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
As bellow.

> -			if (!buffer) {
> -				ret = -ENOMEM;
> -				goto _unlock;
> -			}
>  
>  			/* got dead packet so it is always an error */
>  			ret = spi_read(data->spi, buffer, length);
>  			if (ret >= 0)
>  				ret = -EPROTO;
>  
> -			kfree(buffer);
> -
>  			dev_err(SSP_DEV, "No match error %x\n",
>  				msg_options);
>  
> @@ -428,22 +421,13 @@ int ssp_irq_msg(struct ssp_data *data)
>  		mutex_unlock(&data->pending_lock);
>  		break;
>  	case SSP_HUB2AP_WRITE:
> -		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
Is there any chance that GFP_DMA marking is needed?

> -		if (!buffer)
> -			return -ENOMEM;
