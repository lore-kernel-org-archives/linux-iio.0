Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B2155757;
	Sat, 31 Jan 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877018; cv=none; b=ta1eTRKPmZXa2twIg+I/TtZ/6HvUm70m+9ohanlnq6HzXeigk431ziHmCVRwrLnYJjzbCIX8Q+lyqdrCvxPZQadRoUyZCGwC4J4tNgT8g1GkIN5MlPxC4ecf7Vmp/X6PNgF7GI+KsSYfFQTSUsdu/Tc5owignJAs3vKQKl2PKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877018; c=relaxed/simple;
	bh=f0IaujP7pkRE6cQmdI4ypIQTQ2QjK6ZF6VdpufpHklM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQL1dX1GXUGqpJVPwnBg/++UqXHhkRb65RbiKElykwM7AoldunWWqpWZ2eRSCedTC2eLqizP91aHYaq+ZO5f8DTiJzFsss6L5nvHiw8RsHC4VkeK9O2hwCCTgtn0v8BZJYRtpQnS2HHzFSO94au1kXqGFhFAGLLyZ7r1/h+/nbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t15OryIv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t15OryIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3A2C4CEF1;
	Sat, 31 Jan 2026 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769877017;
	bh=f0IaujP7pkRE6cQmdI4ypIQTQ2QjK6ZF6VdpufpHklM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t15OryIvE03qChiSPdtmXkrUpjWHmLqvbgJt7/JCT6ZC7nkDWW361tuH6uYHtsw8R
	 ZqwTsoILz9p0l0FcxN4CyJAZN7laDW2sgktapsQmC5H70vB6yj/osDGKTjHP6eHsff
	 YXJ1Na0g43bFI15OxyXXRlT4SVI+0Jl0OuIhEbnW+as+CKtZpVTK1nNW0RxPISuc9n
	 n9aiRyK7l1xlep6tYrGqOe+FdRDKQybTg03VVtZ92CoCU2phfW/+8y7H6Iz8fiqMNz
	 ovI15zyjCoo5EXC+71+JAxjwPdgHQv+xBtzS80jHr+oeGCCmoJfe4YPKmzJwlu2lM0
	 82r0AXJQvzwnQ==
Date: Sat, 31 Jan 2026 16:30:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andrew Ijano
 <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list),
 kernel-janitors@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH next 2/4] iio: sca3000: switch IRQ handling to devm
 helpers
Message-ID: <20260131163011.070a80ee@jic23-huawei>
In-Reply-To: <20260130214323.236389-3-harshit.m.mogalapalli@oracle.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
	<20260130214323.236389-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 13:43:09 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Convert the threaded IRQ registration to devm_request_threaded_irq() so
> that the probe and remove paths can drop manual freeing of irqs.
> 
> No functionality change.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Hi Harshit,

Minor formatting update needed. See inline.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3000.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index afe6ef61a53b..0210c716cf38 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1473,8 +1473,7 @@ static int sca3000_probe(struct spi_device *spi)
>  		return ret;
>  
>  	if (spi->irq) {
> -		ret = request_threaded_irq(spi->irq,
> -					   NULL,
> +		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
>  					   &sca3000_event_handler,
Update the indent to keep these after the (
That is:
		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
 						&sca3000_event_handler,
						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
						"sca3000",
etc



>  					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					   "sca3000",
> @@ -1484,23 +1483,17 @@ static int sca3000_probe(struct spi_device *spi)
>  	}
>  	ret = sca3000_clean_setup(st);
>  	if (ret)
> -		goto error_free_irq;
> +		return ret;
>  
>  	ret = sca3000_print_rev(indio_dev);
>  	if (ret)
> -		goto error_free_irq;
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_irq;
> +		return ret;
>  
>  	return 0;
> -
> -error_free_irq:
> -	if (spi->irq)
> -		free_irq(spi->irq, indio_dev);
> -
> -	return ret;
>  }
>  
>  static int sca3000_stop_all_interrupts(struct sca3000_state *st)
> @@ -1530,8 +1523,6 @@ static void sca3000_remove(struct spi_device *spi)
>  
>  	/* Must ensure no interrupts can be generated after this! */
>  	sca3000_stop_all_interrupts(st);
> -	if (spi->irq)
> -		free_irq(spi->irq, indio_dev);
>  }
>  
>  static const struct spi_device_id sca3000_id[] = {

