Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55948 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbdCDRqW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 12:46:22 -0500
Subject: Re: [PATCH v2 2/2] staging: iio: meter: ade7753: Clean up includes
To: Katie Dunne <kdunne@mail.ccsf.edu>,
        outreachy-kernel@googlegroups.com
References: <cover.1488553341.git.kdunne@mail.ccsf.edu>
 <20170303153837.GC29234@katie-Inspiron-5748>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a8c0e8bf-7efb-22ee-8079-c1649ec179ba@kernel.org>
Date: Sat, 4 Mar 2017 17:35:42 +0000
MIME-Version: 1.0
In-Reply-To: <20170303153837.GC29234@katie-Inspiron-5748>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/17 15:38, Katie Dunne wrote:
> Alphabetize header files.
> 
> Signed-off-by: Katie Dunne <kdunne@mail.ccsf.edu>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/meter/ade7753.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index 063ff27..dfd8b71 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -6,20 +6,19 @@
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
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> -
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/spi/spi.h>
>  #include "meter.h"
>  
>  #define ADE7753_WAVEFORM   0x01
> 

