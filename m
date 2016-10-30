Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41613 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbcJ3MQv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 08:16:51 -0400
Subject: Re: [PATCH -next] iio: humidity: remove duplicated include from
 hts221_buffer.c
To: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1477757480-26388-1-git-send-email-weiyj.lk@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2c426e04-ee9c-741f-63de-f4062806a5c8@kernel.org>
Date: Sun, 30 Oct 2016 12:16:45 +0000
MIME-Version: 1.0
In-Reply-To: <1477757480-26388-1-git-send-email-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/10/16 17:11, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Applied to the togreg branch of iio.git.  Will push out later as testing once some
other build tests have finished so that the autobuilders can see what I've messed
up today!

Jonathan
> ---
>  drivers/iio/humidity/hts221_buffer.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 76b2e81..72ddcda 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -15,7 +15,6 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
> -#include <linux/interrupt.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

