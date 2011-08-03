Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:38558 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab1HCJNi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2011 05:13:38 -0400
Message-ID: <4E39131F.3010305@cam.ac.uk>
Date: Wed, 03 Aug 2011 10:21:35 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
CC: gregkh@suse.de, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH] drivers:staging: remove the unused label
References: <1312362362-26767-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1312362362-26767-1-git-send-email-gaowanlong@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/11 10:06, Wanlong Gao wrote:
> remove the unused label error_ret in ad37854.c.
> 
I have equivalent queued up locally, but you posted first
which is fine by me.  Thanks!

Have also fixes for all current sparse / smatch and coccinelle
checker issues (bar one set of false positives).

> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
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

