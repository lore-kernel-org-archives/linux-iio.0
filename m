Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883923392C;
	Sat,  1 Aug 2026 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608901; cv=none; b=a1Nppc5+7hQloVx2VnoXcXsYjRAhDYagTGQ/7KwTtzgPYlP7HAOXsbOEym3flFPGhU1LyFQsAiriEAKrfhMBTb28yu15i8ERSBADbFOMVkEXAUJ9zXKDRRm7MpxgDm99tQFUFq7oiS9JWHYruSYyvhd9qlOOoKy+2opNbeSEbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608901; c=relaxed/simple;
	bh=T4Mxi4Cim0BsIc1nHGZLlofPXCmSua4eanBz18rPrl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvMda+7SUNaVspt642ghvhHZb9flqpJgOShgXS6DpWJROPVxWG/Sc27XhXrr960xxMuwSuJQt5bSHJGZ8IWn4re2/ZuN11DD0heIzQKOSFwTc+ZeV1zpC/4e0JSBIprQadraUooj+WiP9oEyAcZ3Km+/uB6RWMbXM4nrFWltD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep9uWX9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep9uWX9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282B11F00AC4;
	Sat,  1 Aug 2026 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608899;
	bh=HG2U8MykJzsiSMn9ycz7/qbc6oIXoF73xguh9yWH0UU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ep9uWX9dr8oFEl17K2DHu0KPKXGsH9ixeYBRWVTjApNSvRaGrlrHSg72mQDxKA5Ny
	 4E3NyfrxdL4k4qAC5LwArSksFbEoJ1+V/1PNZlJl0qmCWOmJFEehLRc8eEOBC0Z65g
	 YOG7/IYId5PctYNcN0p8o2d+tWNeG5RtYvzVjKjk/uYo92IABPRIhr8XOKz2lRpfU9
	 TLCKG9KrvCuG7hmWFakJ/E5rxtPE8eCY/3L4BhwjMU/R2Yhm9k/RThTiHeOiVEjveV
	 pNRXmekbKfQb6zZXxZAiMi49A0JI8u/YtA8ueMHVhBWNiesB+jlHapDHaZL6+fjVmG
	 S+kqzroYtAoJw==
Date: Sat, 1 Aug 2026 19:28:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: adc: ti-ads1015: use
 DEFINE_RUNTIME_DEV_PM_OPS()
Message-ID: <20260801192814.425330a9@jic23-huawei>
In-Reply-To: <20260727192102.37968-2-architanant5@gmail.com>
References: <20260727192102.37968-1-architanant5@gmail.com>
	<20260727192102.37968-2-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 00:50:57 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Replace the deprecated SET_RUNTIME_PM_OPS() with the modern
> DEFINE_RUNTIME_DEV_PM_OPS() macro. This allows for the removal of the
> macro automatically handles dropping unused functions when PM is
> disabled.
> 
> Update the driver struct to use pm_ptr() to avoid unused variable
> warnings.
> 
> Signed-off-by: Archit Anant <architanant5@gmail.com>
Hi Archit,

This looks fine but did make me look at the code that was being protected
and in particular ads1015_set_conv_mode()

A few things jump out about that which might make sense for further improvement
if you want to take them on.


> static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
> {
> 	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> 				  ADS1015_CFG_MOD_MASK,
> 				  mode << ADS1015_CFG_MOD_SHIFT);#

Use FIELD_PREP() here and drop the ADS1015_CFG_MOD_SHIFT macro.
That made me wonder how extensive _SHIFT macros are in this driver and the
answer is very!  Get rid of all of them in favour of FIELD_PREP()
and FIELD_GREP() and using the field masks.


> }
The other thing is the question of why this function exists at all
given with the value of mode inline it would be obvious what it is doing
without the wrapper and this is the only similar little helper function.

I'd squash it so we do the regmap_update_bits() calls directly instead
of via this helper function.

I did debate whether brining setting conv_invalid into the function made
sense but on balance I think not.

If you do make these changes, 1 patch for dropping all the _SHIFT
macros and replacing with FIELD_PREP() / FIELD_GET() and a second
patch to remove the helper function.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ti-ads1015.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 8a272af69f7d..9cd620b71429 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -1066,7 +1066,6 @@ static void ads1015_remove(struct i2c_client *client)
>  			 ERR_PTR(ret));
>  }
>  
> -#ifdef CONFIG_PM
>  static int ads1015_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -1087,12 +1086,11 @@ static int ads1015_runtime_resume(struct device *dev)
>  
>  	return ret;
>  }
> -#endif
>  
> -static const struct dev_pm_ops ads1015_pm_ops = {
> -	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
> -			   ads1015_runtime_resume, NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,
> +				 ads1015_runtime_suspend,
> +				 ads1015_runtime_resume,
> +				 NULL);
>  
>  static const struct ads1015_chip_data ads1015_data = {
>  	.channels	= ads1015_channels,
> @@ -1147,7 +1145,7 @@ static struct i2c_driver ads1015_driver = {
>  	.driver = {
>  		.name = ADS1015_DRV_NAME,
>  		.of_match_table = ads1015_of_match,
> -		.pm = &ads1015_pm_ops,
> +		.pm = pm_ptr(&ads1015_pm_ops),
>  	},
>  	.probe		= ads1015_probe,
>  	.remove		= ads1015_remove,

