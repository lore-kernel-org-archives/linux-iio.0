Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41906 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965400AbcJYQ3a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 12:29:30 -0400
Subject: Re: [PATCH] iio: maxim_thermocouple: detect invalid storage size in
 read()
To: Arnd Bergmann <arnd@arndb.de>
References: <20161025155538.38037-1-arnd@arndb.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        sayli karnik <karniksayli1995@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <049cdec2-67c5-3311-83b7-d9d7e2779ce8@kernel.org>
Date: Tue, 25 Oct 2016 17:29:27 +0100
MIME-Version: 1.0
In-Reply-To: <20161025155538.38037-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 16:55, Arnd Bergmann wrote:
> As found by gcc -Wmaybe-uninitialized, having a storage_bytes value other
> than 2 or 4 will result in undefined behavior:
> 
> drivers/iio/temperature/maxim_thermocouple.c: In function 'maxim_thermocouple_read':
> drivers/iio/temperature/maxim_thermocouple.c:141:5: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This probably cannot happen, but returning -EINVAL here is appropriate
> and makes gcc happy and the code more robust.
Agreed on all counts.
> 
> Fixes: 231147ee77f3 ("iio: maxim_thermocouple: Align 16 bit big endian value of raw reads")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Applied to the togreg branch of iio.git. Initially pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index 066161a4bccd..f962f31a5eb2 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -136,6 +136,8 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
>  		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
>  		*val = be32_to_cpu(buf32);
>  		break;
> +	default:
> +		ret = -EINVAL;
>  	}
>  
>  	if (ret)
> 

