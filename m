Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47232 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbGSNGo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 09:06:44 -0400
Message-ID: <55ABA0E2.8030301@kernel.org>
Date: Sun, 19 Jul 2015 14:06:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Jonathan Bell <jonathan@raspberrypi.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCHv3 2/4] iio: dht11: add comment to make checkpatch.pl --strict
 happy
References: <55991FEA.50703@kernel.org> <1436276371-7480-1-git-send-email-harald@ccbib.org> <1436276371-7480-2-git-send-email-harald@ccbib.org>
In-Reply-To: <1436276371-7480-2-git-send-email-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/15 14:39, Harald Geyer wrote:
> Explain why the driver needs a mutex.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/dht11.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index 343d26a..bb5ad57 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -63,6 +63,7 @@ struct dht11 {
>  	int				irq;
>  
>  	struct completion		completion;
> +	/* The iio sysfs interface doesn't prevent concurrent reads: */
>  	struct mutex			lock;
>  
>  	s64				timestamp;
> 

