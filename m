Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67F37186D;
	Sun, 15 Mar 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600899; cv=none; b=pOkqIR62RqUGi+zFrVQ+OKJXKpFCkZvmei3FpvLMt/VyTZd7iDufA9C3c1k4d7hBwkuWyNVGOtNfFLHNeUB+jzp63sITiNohIpLUXqE/LrzyjJ4dmkODSHTvAJ0KANZX/Bzmam8APq3Q3PykayXPbLmPsOA3QSKQNSLjn7IWarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600899; c=relaxed/simple;
	bh=TwH+pd2ChAy7/3Anz+GwZM060YFrfRcB2tjLFP3f6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOcS0EF8RVbvMJ13DniHLyPKCe+fa0g9Qrcca5CXqQSYgXt42GeXUdY01lBlrUfT8UXwb81Spz/u232zsMbqoBqr514Nv0FHJeKd2rVGznKbV1vwAD7zxRJqlEoW+MQCgQ6KorGh+dnTSbsmwRq7poVJ34OYmMKsdb5jQuwKl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKcsB7Qb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKcsB7Qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B4DC4CEF7;
	Sun, 15 Mar 2026 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773600899;
	bh=TwH+pd2ChAy7/3Anz+GwZM060YFrfRcB2tjLFP3f6VU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oKcsB7QbUeIA2hZhYZ7gjlCoGCUmBkwbzzPLTiLNfLQVAJjU9BqUXZyY4EtFXdXrj
	 uuN29h6IM4TqaAD/2giNdqSX693+oLlDQ9WmH3iJioGdU9ftEUQ9PubPjWaLO0vKYc
	 /b2tBCSyAttMl9FENDNNNpLyylX0f1AJ9ya4Jyypsor/m1X571gzLkgRcKdCyTAQFg
	 yky9PlZA9S63pMsv8gxnsf/F2aaQXoeto9naopJKbaffNhF0UeiWJBYhmkTIyJDEoy
	 U1Zvm4xM1iVnJvr/Gl267cCmL1f1IxrfvtrUcSvjdEOGyof8msNuWwyF4l/kagdYVD
	 tPs+GVQH+ioCQ==
Date: Sun, 15 Mar 2026 18:54:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: ssp_sensors: simplify cleanup using __free
Message-ID: <20260315185450.4c3fe811@jic23-huawei>
In-Reply-To: <20260315125509.857195-3-sanjayembedded@gmail.com>
References: <20260315125509.857195-1-sanjayembedded@gmail.com>
	<20260315125509.857195-3-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 18:25:08 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace manual cleanup logic with __free attribute from cleanup.h. This
> removes explicit kfree() calls and simplifies the error handling paths.
> 
> No functional change intended for kmalloc().
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Hi Sanjay

I'd suggest slowing down with new versions. 1 weeks is a usual good minimum
because it avoids what has happened here where you get feedback on a later
version that could have been given on the earlier one and hence
waste both your time and reviewer time (a little).

> ---
> Changes in v3:
> - prepare series to have all respective cleanup API support for the ssp_sensors following input from Andy Shevchenko
> - Link to v2 https://lore.kernel.org/all/20260311174151.3441429-1-sanjayembedded@gmail.com/
> Changes in v2:
> - split series to individual patch
> - address review comment from Andy Shevchenko
> - Link to v1 https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 87a38002b218..9df94bd02e3a 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -326,7 +326,6 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
>  /* threaded irq */
>  int ssp_irq_msg(struct ssp_data *data)
>  {
> -	char *buffer;
>  	u8 msg_type;
>  	int ret;
>  	u16 length, msg_options;
> @@ -370,7 +369,7 @@ int ssp_irq_msg(struct ssp_data *data)
>  			 * but the slave should not send such ones - it is to
>  			 * check but let's handle this
>  			 */
> -			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
> +			char *buffer __free(kfree) = kmalloc(length, GFP_KERNEL | GFP_DMA);
Andy raised if this is the right thing to do at all I think.
Maybe look at whether there is a simple maximum length and stash a buffer that
gets reused each time instead of a fresh allocation. May well simplify
the code.

>  			if (!buffer)
>  				return -ENOMEM;
>  
> @@ -379,8 +378,6 @@ int ssp_irq_msg(struct ssp_data *data)
>  			if (ret >= 0)
>  				ret = -EPROTO;
>  
> -			kfree(buffer);
> -
>  			dev_err(SSP_DEV, "No match error %x\n",
>  				msg_options);
>  
> @@ -411,22 +408,17 @@ int ssp_irq_msg(struct ssp_data *data)
>  				complete(msg->done);
>  		break;
>  	case SSP_HUB2AP_WRITE:
> -		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
> +		char *buffer __free(kfree) = kzalloc(length, GFP_KERNEL | GFP_DMA);

Scope isn't what you think it is...


>  		if (!buffer)
>  			return -ENOMEM;
>  
>  		ret = spi_read(data->spi, buffer, length);
>  		if (ret < 0) {
>  			dev_err(SSP_DEV, "spi read fail\n");
> -			kfree(buffer);
>  			break;
>  		}
>  
> -		ret = ssp_parse_dataframe(data, buffer, length);
> -
> -		kfree(buffer);
> -		break;
> -
> +		return ssp_parse_dataframe(data, buffer, length);
>  	default:
>  		dev_err(SSP_DEV, "unknown msg type\n");
>  		return -EPROTO;

