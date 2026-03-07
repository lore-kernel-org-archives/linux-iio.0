Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9C79CD;
	Sat,  7 Mar 2026 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889950; cv=none; b=q+Lb9hgsYg4m1eREab5WNzQ3EWiN2J46RWceSc3SgmXJ3xRdmyjbGeMXhlPkz56D37eERJ6F4agSS1v+UYb8phM2LHu5NpXYKK4SgUOnFYZ1I3UA/vOekrBiHKxxKfirvfbGXv4qa4Kg0Njm9VA3iBo1pZwgx3zXR1i7yya0efY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889950; c=relaxed/simple;
	bh=yY3Ajb+4TECSIEbMvEr/SMkDvCniVkmv5mueaMwyku4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJ3wO/dfWDLUG8tdAFrYJLwjQ4gV+U227qQ2jmbfkIMtG3TSSWMqaSXe3YfrXrTSGz1wwNCjMcZIvC/pL4HGiA3N4w9L5y8TK52/fIGh5cnce7O59Ld9nO34Y1LXJXbVRnqsfEdAez67pjXDSIHVu5lFBrTlrxabDptOj2qXuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmGgiNUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmGgiNUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E370C19422;
	Sat,  7 Mar 2026 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772889949;
	bh=yY3Ajb+4TECSIEbMvEr/SMkDvCniVkmv5mueaMwyku4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CmGgiNUlJ93btmdYyGwtmlRI78DqnPJSKt2nR+yDXeP/tr25pK4u9WGQj1o5DFIsS
	 HmDtEWjOh+n9mx9/l+gN9zPnIObMVyXJEMzhUmFqfv4a2Ny9woMHJPnDt2sqXIrYvd
	 UhtijhAf1QAIP7u8TBpafDbUreNCIQ4W1Gr8OT9zYoBoIsVhUONrMDV//bCVqLHQHV
	 zc0NyzpBShSPE+deALJ1teu9w/w25yMCs/boNQXYaQWd8Pl23sInrK20L/dQmWZIIu
	 7UIPwp1dPINc67g1vnu2g5McTri3wLUYI/T1w3GcxPT2I5TX+jWlCbDcTxHw8yPuI7
	 0dDTp0zkIQetw==
Date: Sat, 7 Mar 2026 13:25:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] iio: adc: ti-ads1119: Drop redundant error message
Message-ID: <20260307132542.629c7d21@jic23-huawei>
In-Reply-To: <20260303-ti-ads1119-2-v1-1-19d31e69ec7c@gmail.com>
References: <20260303-ti-ads1119-2-v1-1-19d31e69ec7c@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Mar 2026 01:07:29 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> devm_request_threaded_irq already prints an error message when failure,
> so the error message is redundant, drop it.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Hmm. I applied this already and for some reason didn't reply to say so.

So applied.

J
> ---
>  drivers/iio/adc/ti-ads1119.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index c9cedc59cdcd..1157e606bc64 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -740,8 +740,7 @@ static int ads1119_probe(struct i2c_client *client)
>  						NULL, IRQF_ONESHOT,
>  						"ads1119", indio_dev);
>  		if (ret)
> -			return dev_err_probe(dev, ret,
> -					     "Failed to allocate irq\n");
> +			return ret;
>  
>  		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
>  						  indio_dev->name,
> 
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260303-ti-ads1119-2-73294fc211a7
> 
> Best regards,

