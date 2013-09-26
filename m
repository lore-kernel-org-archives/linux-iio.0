Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:34927 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab3IZH1v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2013 03:27:51 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so315591eek.37
        for <linux-iio@vger.kernel.org>; Thu, 26 Sep 2013 00:27:50 -0700 (PDT)
Date: Thu, 26 Sep 2013 08:27:41 +0500
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, zubair.lutfullah@gmail.com,
	lars@metafoo.de, fengguang.wu@intel.com, Russ.Dill@ti.com,
	kbuild-all@01.org
Subject: Re: [PATCH] iio:ti_am335x_adc ensure that IIO_KFIFO_BUF is not
 selected witout IIO_BUFFER
Message-ID: <20130926032739.GA3374@gmail.com>
References: <1380141441-9133-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380141441-9133-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Sep 25, 2013 at 09:37:21PM +0100, Jonathan Cameron wrote:
> This avoids build problems such iio_push_to_buffers* not being defined.

Apologies for the tiny blooper causing such a fuss.
Zubair

> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8b88518..2209f28 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -177,6 +177,7 @@ config TI_ADC081C
>  config TI_AM335X_ADC
>  	tristate "TI's AM335X ADC driver"
>  	depends on MFD_TI_AM335X_TSCADC
> +	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	help
>  	  Say yes here to build support for Texas Instruments ADC
> -- 
> 1.8.4
> 
