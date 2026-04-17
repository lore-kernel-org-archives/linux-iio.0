Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496B2949E0
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432397; cv=none; b=t2W9XFKiwDNYsZqWZI7D7qtuActtlrw/hIdhE/qCuuEnRKIHW236lgCBqMgAJCxYw2XBDmh/99X9z8LlTfrD/5NZMF+VdGhMp01a6hbAPYZfvInXLZ/tWikqCInTL3yqncmOVN1ZalBzuek1u+M1X5wp0de1i8BcNSLuuwJiXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432397; c=relaxed/simple;
	bh=dSjtk+heiCl1/HayOyGnu4OmJNDDqD0xgjSS5vSLekA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VP36kkkaQn/RsH7HBg5eiGMTqrDwp8XVnUNCvFSvEvsoPxWSnYhDxfilslXX3Oqs+vpgdxr9QWDPrhrEJH7/VQCe87lq/g22q5D9ExJvoLsktknzHUqAE7iccBfugcKGAtzo2Bagr8KsJAV0U5Pe0OGVvbNjp5ewoQ5cMCHl6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fxwcz38zXzHnGhV;
	Fri, 17 Apr 2026 21:26:11 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8507E4056B;
	Fri, 17 Apr 2026 21:26:31 +0800 (CST)
Received: from localhost (10.203.86.132) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Apr
 2026 14:26:30 +0100
Date: Fri, 17 Apr 2026 14:26:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marcelo Machado Lage <marcelomlage@usp.br>
CC: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, Vinicius Lira <vinilira@usp.br>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: mcp3422: write bit operations with bitfield
 macros
Message-ID: <20260417142629.00000270@huawei.com>
In-Reply-To: <20260417005041.484742-1-marcelomlage@usp.br>
References: <20260417005041.484742-1-marcelomlage@usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 16 Apr 2026 21:50:40 -0300
Marcelo Machado Lage <marcelomlage@usp.br> wrote:

> Replace manual bit manipulations with GENMASK(), FIELD_GET(),
> FIELD_PREP() and FIELD_MODIFY() calls. The resulting code is more
> readable and maintainable, and some macros previously defined in the
> header are not needed anymore.
> 
> Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
> Co-developed-by: Vinicius Lira <vinilira@usp.br>
> Signed-off-by: Vinicius Lira <vinilira@usp.br>
> ---
>  drivers/iio/adc/mcp3422.c | 43 ++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 50834fdcf738..d93036bf9a85 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -13,6 +13,7 @@
>   * voltage unit is nV.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> @@ -25,9 +26,9 @@
>  #include <linux/iio/sysfs.h>
>  
>  /* Masks */
> -#define MCP3422_CHANNEL_MASK	0x60
> -#define MCP3422_PGA_MASK	0x03
> -#define MCP3422_SRATE_MASK	0x0C
> +#define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
> +#define MCP3422_PGA_MASK	GENMASK(1, 0)
> +#define MCP3422_SRATE_MASK	GENMASK(3, 2)
>  #define MCP3422_SRATE_240	0x0
>  #define MCP3422_SRATE_60	0x1
>  #define MCP3422_SRATE_15	0x2
> @@ -38,13 +39,9 @@
>  #define MCP3422_PGA_8	3
>  #define MCP3422_CONT_SAMPLING	0x10
>  
> -#define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
> -#define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)
> -#define MCP3422_SAMPLE_RATE(config)	(((config) & MCP3422_SRATE_MASK) >> 2)
> -
> -#define MCP3422_CHANNEL_VALUE(value) (((value) << 5) & MCP3422_CHANNEL_MASK)
> -#define MCP3422_PGA_VALUE(value) ((value) & MCP3422_PGA_MASK)
> -#define MCP3422_SAMPLE_RATE_VALUE(value) ((value << 2) & MCP3422_SRATE_MASK)
> +#define MCP3422_CHANNEL(config)		FIELD_GET(MCP3422_CHANNEL_MASK, config)
> +#define MCP3422_PGA(config)			FIELD_GET(MCP3422_PGA_MASK, config)
> +#define MCP3422_SAMPLE_RATE(config)	FIELD_GET(MCP3422_SRATE_MASK, config)

Drop these 3 macros and use FIELD_GET() inline instead just as you've done for the prep side.

>  
>  #define MCP3422_CHAN(_index) \
>  	{ \
> @@ -138,10 +135,10 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  
>  	if (req_channel != MCP3422_CHANNEL(adc->config)) {
>  		config = adc->config;
> -		config &= ~MCP3422_CHANNEL_MASK;
> -		config |= MCP3422_CHANNEL_VALUE(req_channel);
> -		config &= ~MCP3422_PGA_MASK;
> -		config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
> +
> +		FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
> +		FIELD_MODIFY(MCP3422_PGA_MASK, &config, adc->pga[req_channel]);
> +
>  		ret = mcp3422_update_config(adc, config);
>  		if (ret < 0) {
>  			mutex_unlock(&adc->lock);
> @@ -211,10 +208,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
>  			if (val2 == mcp3422_scales[sample_rate][i]) {
>  				adc->pga[req_channel] = i;
>  
> -				config &= ~MCP3422_CHANNEL_MASK;
> -				config |= MCP3422_CHANNEL_VALUE(req_channel);
> -				config &= ~MCP3422_PGA_MASK;
> -				config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
> +				FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
> +				FIELD_MODIFY(MCP3422_PGA_MASK, &config, adc->pga[req_channel]);
>  
>  				return mcp3422_update_config(adc, config);
>  			}
> @@ -241,10 +236,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
>  			return -EINVAL;
>  		}
>  
> -		config &= ~MCP3422_CHANNEL_MASK;
> -		config |= MCP3422_CHANNEL_VALUE(req_channel);
> -		config &= ~MCP3422_SRATE_MASK;
> -		config |= MCP3422_SAMPLE_RATE_VALUE(temp);
> +		FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
> +		FIELD_MODIFY(MCP3422_SRATE_MASK, &config, temp);
>  
>  		return mcp3422_update_config(adc, config);
>  
> @@ -377,9 +370,9 @@ static int mcp3422_probe(struct i2c_client *client)
>  
>  	/* meaningful default configuration */
>  	config = (MCP3422_CONT_SAMPLING
> -		| MCP3422_CHANNEL_VALUE(0)
> -		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
> -		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
> +		| FIELD_PREP(MCP3422_CHANNEL_MASK, 0)
> +		| FIELD_PREP(MCP3422_PGA_MASK, MCP3422_PGA_1)
> +		| FIELD_PREP(MCP3422_SRATE_MASK, MCP3422_SRATE_240));
>  	err = mcp3422_update_config(adc, config);
>  	if (err < 0)
>  		return err;

