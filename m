Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81304221555;
	Sat, 31 Jan 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877146; cv=none; b=NdLUmew9c1PCnqinZuHLHF7k3eQfuwaCrJxdxTqZ7OU4U+jml6voMKJqutzctFQa/vMEiIpuvPf0ROCm0FuHePZGu/GfyfLBPFAFPSSsTPjicIUIgdD1XaNz51ldZxgmRQadqlr1FODMcAbyEbz0F3uuc/Q3SS1fp4P8+flvNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877146; c=relaxed/simple;
	bh=jNCN/ylhyR8xcF0GdZxgHoqv4lMCbgrzQBSMlJStCfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py743GRbl8XeauncdJiIdrEQ18M+/+SbtsJlHyA6w4pcXbfO3C4jsmUyUv0Apm/54y6skX/8LdtDWJsiCbRMMZ98QEmXaxbXbs/MvBiHiKp1BT7qqrzmP0FfgTh6f+gB5cs/Uh6hOKegXSqcqnJHQXgapQnw7diyHmelAE/clo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en8hL0DZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en8hL0DZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE8DC4CEF1;
	Sat, 31 Jan 2026 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769877146;
	bh=jNCN/ylhyR8xcF0GdZxgHoqv4lMCbgrzQBSMlJStCfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=en8hL0DZwDneGlAM2uWSb48ZkCXWuMN8McgfW54WhjYKa2wL7jRQ+FodUS5N0YHrh
	 OxZrKlH524dEyJwt7XOwLdbwLwa0MYd1dPqNQKh7mkx8TAm5bSK8aJnpOYSJNb3iDY
	 TwYCJjSruWdmkIiiJmw9kSOsNMaNLNpifRKo1bQ/37O0UITc/aPzX27+KU1MIpevNh
	 05rtoYuqwAP+ea+1DTU9yDK379HGTkFvP9qjdbyy9tCq04E0iOySFlPdlPNUVzgz9X
	 wP75g6xHb1Ls7j9PDd24jNkk822lxuEGUweoGizKIc4bFGQpnRCb/HTwbGEJqqhtLq
	 Ki98lynnwMyFg==
Date: Sat, 31 Jan 2026 16:32:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andrew Ijano
 <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list),
 kernel-janitors@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH next 3/4] iio: sca3000: manage device registration with
 devm helper
Message-ID: <20260131163218.2a4b93e5@jic23-huawei>
In-Reply-To: <20260130214323.236389-4-harshit.m.mogalapalli@oracle.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
	<20260130214323.236389-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 13:43:10 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Convert the iio registration to use devm_* helpers so the probe no
> longer needs a separate cleanup path and remove callback can also drop
> the unregister.
> 
> No functional change intended.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

This results in the order of two bits of tear down being reversed.
It might be your intent but if so you need a clear description of
why it is fine to do this and why it is not a functional change.

Jonathan

> ---
>  drivers/iio/accel/sca3000.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 0210c716cf38..bf1957c7bc77 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1489,11 +1489,7 @@ static int sca3000_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static int sca3000_stop_all_interrupts(struct sca3000_state *st)
> @@ -1519,8 +1515,6 @@ static void sca3000_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	/* Must ensure no interrupts can be generated after this! */
>  	sca3000_stop_all_interrupts(st);

This changes the ordering.  Now we stop interrupts before removing the
userspace interfaces.  You probably need to reorder this and the next
patch so there is no intermediate broken point.

>  }

