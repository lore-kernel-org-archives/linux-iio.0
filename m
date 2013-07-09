Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45280 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab3GIVP4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2013 17:15:56 -0400
Message-ID: <51DC7D8B.6000704@kernel.org>
Date: Tue, 09 Jul 2013 22:15:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: staging: fix typo in ade758_ring.c
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net> <1373228646-5356-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2013 09:24 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
applied to the togreg branch of iio.git
> ---
>  drivers/staging/iio/meter/ade7758_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> index b29e2d5..7d5db71 100644
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ b/drivers/staging/iio/meter/ade7758_ring.c
> @@ -54,7 +54,7 @@ out:
>  	return ret;
>  }
>  
> -/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
> +/* Whilst this makes a lot of calls to iio_sw_ring functions - it is too device
>   * specific to be rolled into the core.
>   */
>  static irqreturn_t ade7758_trigger_handler(int irq, void *p)
> 
