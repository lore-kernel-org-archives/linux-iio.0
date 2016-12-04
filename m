Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34154 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbcLDK5G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2016 05:57:06 -0500
Subject: Re: [PATCH 1/1] iio: light: fix improper return value
To: Pan Bian <bianpan2016@163.com>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1480757057-3828-1-git-send-email-bianpan2016@163.com>
Cc: linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3c0b6176-65e8-0785-2259-5f2aac47d304@kernel.org>
Date: Sun, 4 Dec 2016 10:57:02 +0000
MIME-Version: 1.0
In-Reply-To: <1480757057-3828-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/12/16 09:24, Pan Bian wrote:
> In function cm3232_reg_init(), it returns 0 even if the last call to
> i2c_smbus_write_byte_data() returns a negative value (indicates error).
> As a result, the return value may be inconsistent with the execution
> status, and the caller of cm3232_reg_init() will not be able to detect
> the error. This patch fixes the bug.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188641
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/light/cm3232.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index fe89b68..263e972 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -119,7 +119,7 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
>  	if (ret < 0)
>  		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> 

