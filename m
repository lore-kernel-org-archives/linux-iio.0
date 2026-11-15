Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701936;
	b=1CxiPMVNkNrl7NacGhePIfFh7EO50TMMVmBKU2DvHfKSl6Tl5eo3dAd2J5pRD7yqsmV8
	 EG4QKgeOS+Hi3+kAR1WjafJFIOx9+rjIeWiVMBoMBgchuPy9SiW5NMRV8YPE3hVYsXruQ
	 9agNPK/oYYyYaXolI8ytE4scuve3cp8f3B+U1fdjjEJbHhasCGYJpGZOi9FsOmw2VZZix
	 8i8/8rqE9qZp0ms8PRjg3xNBCOD+Lyy33VVR8q83LpR3KKaWuds20j/7OKza1kG0YbpMt
	 fo0nq25CDoMg8ElU8OnfT5e9D9A+GFNG8G7T9Xx/YQ06OvVnlfeJK7VdNzuzAn/jUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701936;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EZxe3fLIr15GcaixYMlvps3d1PnaVZ20JcGF+Wr3YZ8=;
	b=dKahy3dA8blxVhVUK4PIX+tvAe4Bjl15/JOXNGat+FuE4MOxTp+paIOhSRhVXsiYbSeM
	 JyR6q2XM7upzeIVx6AgAp3qCXlku7/7Rgv+m9dPtes91H+RoC59UlsVv2tDu/c5nWrBOT
	 2gRw/pVzWRHlmOk6JPGn34alExx5AcehTOe6qv1SRFViU0NL9ecIMxafUSIYozemDIjE7
	 odX1hJ1dlxQ6baj94YPcADzsa0Q6ZgXn7D7QNSZwB16VB0XprQh0uA0AksAt8xPyisSec
	 4qTItAtteP+cWLJylZP4OpiTXP59yVER5zmzNlbD5EomIi4t/ejvfJXb6q+NtFXYhVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwRn2o9P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2793E606A330;
	Sun, 15 Nov 2026 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwRn2o9P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329351F000C6;
	Sun, 15 Nov 2026 00:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701936;
	bh=EZxe3fLIr15GcaixYMlvps3d1PnaVZ20JcGF+Wr3YZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AwRn2o9PJPdY4Tsh8f7dj4K/jfCtYiXAKcWLF0yQ0QLmDqxcF9BGCWNZxE6Bj2NIn
	 XdwEkc/MHOgMrlCheM4punrxGrDokcTG1uhVaU+DiH2gVgVvbhS53D3X7cF47QVBbp
	 cRZ4N7IOemShmlDKlVb8zfUDmzoHSPgVLg48sPmNtyI20H4lCtejLmjm8B970Cx2RE
	 0dbQCcf+hj4gB4YkN5uFUq3mAPJGv+NqA57memdEMrOGlOCsAr82vqQEushYZf51c2
	 TaLFps8Tt0tFlvCYDKgoZeyOSGvZ7/SF1ZbkEQjhV0bycOVX1oHJbYrg6VsKkx9eSC
	 8VMn+oxSdhmNw==
Date: Sun, 15 Nov 2026 00:18:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 11/11] iio: adc: ti-ads1015: Replace custom shift
 macros with FIELD_PREP/GET
Message-ID: <20261115001849.17c18851@jic23-hlaptop>
In-Reply-To: <20261109165805.31160-6-architanant5@gmail.com>
References: <20261109165805.31160-1-architanant5@gmail.com>
	<20261109165805.31160-6-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 22:28:05 +0530
Archit Anant <architanant5@gmail.com> wrote:

> The driver currently uses custom _SHIFT macros and manual bitwise
> operations to read and write to the configuration register.
> 
> Modernize the bitwise logic by replacing all manual shifts with the
> standard FIELD_PREP() and FIELD_GET() macros from <linux/bitfield.h>.
> This improves readability and prevents potential bitwise errors.
> 
> Remove the now-unused _SHIFT macros from the top of the file.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 79 ++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 2c3ba1b91aac4..8f7ec61314363 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -11,6 +11,7 @@
>   *	* 0x4B - ADDR connected to SCL
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> @@ -38,15 +39,6 @@
>  #define ADS1015_LO_THRESH_REG	0x02
>  #define ADS1015_HI_THRESH_REG	0x03
>  
> -#define ADS1015_CFG_COMP_QUE_SHIFT	0
> -#define ADS1015_CFG_COMP_LAT_SHIFT	2
> -#define ADS1015_CFG_COMP_POL_SHIFT	3
> -#define ADS1015_CFG_COMP_MODE_SHIFT	4
> -#define ADS1015_CFG_DR_SHIFT	5
> -#define ADS1015_CFG_MOD_SHIFT	8
> -#define ADS1015_CFG_PGA_SHIFT	9
> -#define ADS1015_CFG_MUX_SHIFT	12
> -
>  #define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
>  #define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
>  #define ADS1015_CFG_COMP_POL_MASK	BIT(3)
> @@ -382,17 +374,24 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>  
>  	pga = data->channel_data[chan].pga;
>  	dr = data->channel_data[chan].data_rate;
> -	mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
> -		ADS1015_CFG_DR_MASK;
> -	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
> -		dr << ADS1015_CFG_DR_SHIFT;
>  

I'm probably being inconsistent across versions, but at least
looking at it this time, I prefer the building up common cfg
and mask first, then adding the extra bits in the following.

>  	if (ads1015_event_channel_enabled(data)) {
> -		mask |= ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK;
> -		cfg |= data->thresh_data[chan].comp_queue <<
> -				ADS1015_CFG_COMP_QUE_SHIFT |
> -			data->comp_mode <<
> -				ADS1015_CFG_COMP_MODE_SHIFT;
> +		mask = ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK |
> +		       ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
> +		       ADS1015_CFG_DR_MASK;
> +		cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) |
> +		      FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
> +		      FIELD_PREP(ADS1015_CFG_DR_MASK, dr) |
> +		      FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
> +				 data->thresh_data[chan].comp_queue) |
> +		      FIELD_PREP(ADS1015_CFG_COMP_MODE_MASK,
> +				 data->comp_mode);
> +	} else {
> +		mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
> +			ADS1015_CFG_DR_MASK;
> +		cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) |
> +		      FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
> +		      FIELD_PREP(ADS1015_CFG_DR_MASK, dr);
>  	}
