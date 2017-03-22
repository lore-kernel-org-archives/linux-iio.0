Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48472 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753502AbdCVUWq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:22:46 -0400
Subject: Re: [PATCH 2/2] staging: ade7754: Clean up #includes
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1490022905-18422-1-git-send-email-singhalsimran0@gmail.com>
 <1490022905-18422-3-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d89c2e2f-cfe7-9696-f765-bce71cc46dd6@kernel.org>
Date: Wed, 22 Mar 2017 20:22:38 +0000
MIME-Version: 1.0
In-Reply-To: <1490022905-18422-3-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 15:15, simran singhal wrote:
> Alphabetize and separate kernel and subsystem headers.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7754.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index 42f7b06..fea93d7 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -6,18 +6,17 @@
>   * Licensed under the GPL-2 or later.
>   */
>  
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
>  #include <linux/delay.h>
> -#include <linux/mutex.h>
>  #include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
> -
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include "meter.h"
> 

