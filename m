Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55622 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751672AbdB0WFq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 17:05:46 -0500
Date: Mon, 27 Feb 2017 22:23:16 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: simran singhal <singhalsimran0@gmail.com>
cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: accel: Move header file
 content to source file
In-Reply-To: <20170227193815.GA32728@singhal-Inspiron-5558>
Message-ID: <alpine.DEB.2.20.1702272221550.2127@hadrien>
References: <20170227193815.GA32728@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
> index 7963d4a..210699e 100644
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ b/drivers/staging/iio/accel/adis16201_core.c
> @@ -20,7 +20,150 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>
> -#include "adis16201.h"
> +#ifndef SPI_ADIS16201_H_
> +#define SPI_ADIS16201_H_

I guess you wouldn't need the ifndef and define in the C file?  This is
usually used to guard against including a header file more than once.

julia
