Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:53551 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1HLIme (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 04:42:34 -0400
Message-ID: <4E44E95F.6070402@cam.ac.uk>
Date: Fri, 12 Aug 2011 09:50:39 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: stufever@gmail.com
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	gregkh@suse.de, Wang Shaoyan <wangshaoyan.pt@taobao.com>
Subject: Re: [PATCH] staging: IIO: DAC: Delete useless label error_ret in
 ade7854.c
References: <1312655064-28311-1-git-send-email-wangshaoyan.pt@taobao.com>
In-Reply-To: <1312655064-28311-1-git-send-email-wangshaoyan.pt@taobao.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/06/11 19:24, stufever@gmail.com wrote:
> From: Wang Shaoyan <wangshaoyan.pt@taobao.com>
> 
>   drivers/staging/iio/meter/ade7854.c: In function 'ade7854_probe':
>   drivers/staging/iio/meter/ade7854.c:585: warning: label 'error_ret' defined but not used
> 
> The label error_ret is defined, but never used, so delete it to avoid annoying warning.
Have equivalent in our dev tree, but happy to see this version merge instead.
For reference, we have all sparse / coccinelle and smatch warnings fixed in iio-blue.git.

I'll be pushing the cleanup bits of that tree out sometime fairly soon.
> 
> Signed-off-by: Wang Shaoyan <wangshaoyan.pt@taobao.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/meter/ade7854.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index b82659f..ac3f9d5 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -582,7 +582,6 @@ error_unreg_dev:
>  	iio_device_unregister(indio_dev);
>  error_free_dev:
>  	iio_free_device(indio_dev);
> -error_ret:
>  	return ret;
>  }
>  EXPORT_SYMBOL(ade7854_probe);

