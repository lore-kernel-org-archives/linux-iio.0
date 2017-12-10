Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbdLJTgH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 14:36:07 -0500
Date: Sun, 10 Dec 2017 19:36:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/45] drivers: iio: gyro: remove duplicate includes
Message-ID: <20171210193602.778a160b@archlinux>
In-Reply-To: <1512439222-15714-1-git-send-email-pravin.shedge4linux@gmail.com>
References: <1512439222-15714-1-git-send-email-pravin.shedge4linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  5 Dec 2017 07:30:19 +0530
Pravin Shedge <pravin.shedge4linux@gmail.com> wrote:

> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
> 
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
Applied.  Thanks,

Jonathan
> ---
>  drivers/iio/gyro/bmg160_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 1504617..63ca316 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -27,7 +27,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/regmap.h>
> -#include <linux/delay.h>
>  #include "bmg160.h"
>  
>  #define BMG160_IRQ_NAME		"bmg160_event"

