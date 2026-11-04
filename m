Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757696;
	b=osX4m+L9bGAdjbTuNC9ggG/4DbFtXRAXTpjLeq8qBQ2TAvCCSv43lkADdBnddyJNS20F
	 iljA56vfkacvbKcOMA12rI25Ugfu5VHNClUM8WjSLsENY6kFYMRo7FOPCq1hafKZGOV9l
	 rWsN9aMPqPxvQhisqVX22YOmrydhsz8Lb/BOcVN/Nx8hydtLlvThRrrN/YNsYPkgSLM3k
	 nHEkw2rrQzTdM4sCNc/H5L6hDU4HcsowT/zQSG9Kg2EmjwgTXoSxZNbFhkxhtLGQGXGr/
	 ZwcCUxwWV3P3gk7+r6lJYO8l8nn/TJNd/XdCs5HnbXdofqbGlg/JroJhafptc18puvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757696;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=d3tRwg+6kmWQPvDHfDb0iceVZog2ETjF6XYA5PmVuHA=;
	b=geGYTI07HDzYJTlzgzISiW5iRWsOwVMUNJyNu3TMRYjgGRRbPZDnt59cYNVpur01LISA
	 qQ8nRQZgNUfx619t6jGP5nXLnIpwayg1K0OexNW1rUV94LtSnnsZgq/7LQDlNljrzOMS7
	 vyexQngB3BezBfjWAC/AXUC6hAuiGm1F3Hb7PhK36LvIpF/7EcnVMVFXxqXOtnxE+8faJ
	 dCq3atxYgit9sNnBPZ7e8i/ykrARC9MMI6gANC0wrbGRCQ014Q+nQ0P4LNSZFT3cf1loy
	 61Gjoh069GbfXkdqzAtfDs+eIbU/O+3WrixR8MN9p/ls1vurgmSSJLseXM7MitOaNNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDP5Vhmb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E5606A31B;
	Wed,  4 Nov 2026 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDP5Vhmb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A011F000C1;
	Wed,  4 Nov 2026 02:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757695;
	bh=d3tRwg+6kmWQPvDHfDb0iceVZog2ETjF6XYA5PmVuHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GDP5VhmbB7nSGwNTGPLEyf3vLI8zxHVVBt1uzi91T/SK6RPMZqyv3oFq9Yq0GzmWh
	 CxOHnaklmwm8XGgCPNokFjzObbtRBo087K5X+3sZL4H3m1hOUVNanoZ2lkVAGUnAq3
	 tzgOp6gsDNIr7MSlFMzka493YKmMPnaLo2dXgmxruG4KvnQeeXThqJj44mX+hzrG4r
	 lP4ZzXQmxSS+SrIENPp5iuB/bWMF8SbNCLSyia5GtFN+OIRbv33L4F+GIL8arz4XfL
	 e5jigjCUUunBo2uvWCFa3m0K/lSJsxLGzh47m23fPnf/bqWvvMOhVAIi5L+WRp4Syo
	 trHXvDnQj8sXA==
Date: Wed, 4 Nov 2026 02:01:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [PATCH v3 2/2] iio: gyro: mpu3050: Fix runtime PM refcount leak
 in trigger enable path
Message-ID: <20261104020127.4a9d7a2d@jic23-hlaptop>
In-Reply-To: <20261103092002.1332-3-laixiangwu@cmss.chinamobile.com>
References: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
	<20261103092002.1332-3-laixiangwu@cmss.chinamobile.com>
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

On Tue,  3 Nov 2026 17:20:02 +0800
Xiangwu Lai <laixiangwu@cmss.chinamobile.com> wrote:

> From: laixiangwu <laixiangwu@cmss.chinamobile.com>
> 
> mpu3050_drdy_trigger_enable() calls pm_runtime_get_sync() when
> enabling the data ready trigger, but all five error returns in the
> enable path return directly without the matching
> pm_runtime_put_autosuspend(). The disable path, in contrast, drops
> the reference correctly.
> 
> As a result, a failed trigger enable leaves the runtime PM usage
> counter incremented and the sensor can never runtime suspend. It also
> leaves hw_irq_trigger set to true, claiming the hardware IRQ is in
> use when it is not.
> 
> Use pm_runtime_resume_and_get(), which does not leave the usage
> counter incremented when resume fails, and add an error label that
> drops the runtime PM reference and clears hw_irq_trigger so that a
> failed enable returns with the device in the same state as before
> the attempt.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>

Other than the missing error return I called out in the previous patch this
looks fine.

> ---
> 
> Changes in v3:
> - none; reposted in a new top-level thread.
> 
> Changes in v2:
> - Rebase the fix on a new precursor patch that splits the enable and
>   disable paths of mpu3050_drdy_trigger_set_state() into separate
>   helpers, as suggested by the reviewer, so the error label only
>   applies to the enable path.
> - Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync(),
>   as suggested by the reviewer; it also keeps the usage counter
>   balanced when the resume fails, so no manual
>   pm_runtime_put_noidle() is needed in the caller.
> 
> Link: https://lore.kernel.org/r/20261101092327.197-3-laixiangwu@cmss.chinamobile.com
> Link: https://lore.kernel.org/r/20261030084305.1660-1-laixiangwu@cmss.chinamobile.com
>  drivers/iio/gyro/mpu3050-core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d966911ab..fc305564d 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -957,20 +957,23 @@ static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
>  	unsigned int val;
>  	int ret;
>  
> -	pm_runtime_get_sync(mpu3050->dev);
> +	ret = pm_runtime_resume_and_get(mpu3050->dev);
> +	if (ret)
> +		return ret;
> +
>  	mpu3050->hw_irq_trigger = true;
>  
>  	/* Disable all things in the FIFO */
>  	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
>  	if (ret)
> -		return ret;
> +		goto err_put_pm;
>  
>  	/* Reset and enable the FIFO */
>  	ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
>  			      MPU3050_USR_CTRL_FIFO_EN |
>  			      MPU3050_USR_CTRL_FIFO_RST);
>  	if (ret)
> -		return ret;
> +		goto err_put_pm;
>  
>  	mpu3050->pending_fifo_footer = false;
>  
> @@ -982,12 +985,12 @@ static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
>  			   MPU3050_FIFO_EN_GYRO_ZOUT |
>  			   MPU3050_FIFO_EN_FOOTER);
>  	if (ret)
> -		return ret;
> +		goto err_put_pm;
>  
>  	/* Configure the sample engine */
>  	ret = mpu3050_start_sampling(mpu3050);
>  	if (ret)
> -		return ret;
> +		goto err_put_pm;
>  
>  	/* Clear IRQ flag */
>  	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
> @@ -1006,9 +1009,15 @@ static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
>  
>  	ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
>  	if (ret)
> -		return ret;
> +		goto err_put_pm;
>  
>  	return 0;
> +
> +err_put_pm:
> +	pm_runtime_put_autosuspend(mpu3050->dev);
> +	mpu3050->hw_irq_trigger = false;
> +
> +	return ret;
>  }
>  
>  /**

