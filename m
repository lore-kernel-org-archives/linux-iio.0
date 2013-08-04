Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44513 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3HDJWO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 05:22:14 -0400
Message-ID: <51FE2B5F.9070407@kernel.org>
Date: Sun, 04 Aug 2013 11:22:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 8/9] staging:iio:hmc5843: Drop unneeded #includes
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net> <1374939112-18237-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-9-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/27/13 16:31, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

I had my doubts about whether types.h should be included even
though it is obviously pulled in by lots of other headers.

The other two are fair enough as there are no direct uses of
kmalloc and friends or of init section markings.

> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 52d6340..0b24d7e 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -20,10 +20,7 @@
>  */
>  
>  #include <linux/module.h>
> -#include <linux/init.h>
>  #include <linux/i2c.h>
> -#include <linux/slab.h>
> -#include <linux/types.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/delay.h>
> 
