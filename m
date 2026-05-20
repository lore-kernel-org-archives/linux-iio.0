Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612F32B99F;
	Wed, 20 May 2026 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275849; cv=none; b=Sooq99wbWV9r8lPkGZZZD79Yvec81wpq2jjjNEL9q3rxeitA4CUI6uzsc4gBn03ClcZAcCODgjPIaL2bz2GTygEOTP4P6mDiLTEHOWimmRulo4j4MCGjxP2JWxxPw/66vPAKIHG9QdtqFnbyt9AOZqQ541ZqRfdqEv8s79VprmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275849; c=relaxed/simple;
	bh=GwRkeQmZ/PkOZ28Rjo7aBtWBmAR7ItvcwcM9ypDM//g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p97xxMKorEHVB3EYFPiHnXiezzUNToxQjJrTlGS+0IHuFQtRn1zR9S6zUZSTxojO6C7wTpkdqltqQSSMD7zewvG5UOf8hGJ+fw3Q+EAC0hPgKxIFp9Hu7dJMNT1JyeaBOzGqTy2wldH6S1vS/XgmyYw5rWxfZ+cyXvj3uEvZqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpgJP7uP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpgJP7uP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9021F0089D;
	Wed, 20 May 2026 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275848;
	bh=Bg8I3bFSXjHEDZhjETxbAKuUFzCkBXnkLamtthcmvm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YpgJP7uPg61CYTC7PGhdgR6mGAYtrPCfwOrIWPU4O5pXs2lwB3pzz43tL+nAy/DYE
	 5a96PeG6bNdq7+882mCpkaOx6jqFqtfHG5KFTLezbdYcZ+e9p+fhu6QJXJsZng1yOD
	 Qj+46XUGWHlHXN9hc8hz4tGxV1qQihXDkcVYmyTjZfF3kzBHXL1pVQZlUZEligp9rZ
	 GlZzAa7gg+7smS8Uir0XuR8wHfHM1Bg3WcwoNlN+oUZDII7GUWH9Xmoqs72pNcyCkn
	 SZjtLbTbCSkQuaE7UV/jTLN5zWuKjZ1ZvgdUAHV5YVN2gH0oN8aVu0W13g/XGTfy8v
	 V9Rr5txvYAWSQ==
Date: Wed, 20 May 2026 12:17:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Li Xinyu <xinyuili@126.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij
 <linusw@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: use devm_iio_trigger_register
Message-ID: <20260520121720.6f9374c5@jic23-huawei>
In-Reply-To: <20260520032447.1683688-1-xinyuili@126.com>
References: <20260520024153.1647951-1-xinyuili@126.com>
	<20260520032447.1683688-1-xinyuili@126.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 11:24:47 +0800
Li Xinyu <xinyuili@126.com> wrote:

> mpu3050_trigger_probe() allocates the DRDY trigger with
> devm_iio_trigger_alloc() but registers it with plain
> iio_trigger_register(). The remove callback calls free_irq()
> on the trigger but never calls iio_trigger_unregister(), so on
> module unload the trigger remains in the global trigger list
> while its memory is freed by devm, leaving a dangling entry.
> 
> Switch to devm_iio_trigger_register() so the registration is
> undone automatically in the same devm scope as the allocation.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Xinyu <xinyuili@126.com>
Look at the more general use of devm in this driver.

The rule of thumb for devm is that you can only use it from start of
probe() to the point where you first make a call that doesn't use it.
After that you must not use any devm calls.

Sometimes it is easy to use it for all of probe() which obviously obeys
that rule.

Also when you do switch to devm in a driver, there is normally a
reverse operation to remove in remove() and error paths().

There was a recent fix for a case similar to this but that was because
that driver did everything else with devm and didn't call the unwind
at all. It was a simple typo in the driver.

Jonathan


> ---
> Changes in v2:
> - Corrected the name format in Signed-off-by from "lixinyu" to proper
>   "Li Xinyu". Sorry for the mistake in v1. Thank you Maxime.
> ---
>  drivers/iio/gyro/mpu3050-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..bcfa83a46737 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1127,7 +1127,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  	mpu3050->trig->ops = &mpu3050_trigger_ops;
>  	iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
>  
> -	ret = iio_trigger_register(mpu3050->trig);
> +	ret = devm_iio_trigger_register(mpu3050->dev, mpu3050->trig);
>  	if (ret)
>  		goto err_iio_trigger;
>  

