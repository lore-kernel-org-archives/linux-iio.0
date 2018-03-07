Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964798AbeCGUaC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 15:30:02 -0500
Date: Wed, 7 Mar 2018 20:29:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 01/11] Staging: iio: accel: Prefer alphabetical sequence
 of header files
Message-ID: <20180307202957.4fa33eb0@archlinux>
In-Reply-To: <1520236170-14668-2-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
        <1520236170-14668-2-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  5 Mar 2018 13:19:20 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Arrange header files in alphabetical sequence to improve readability.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
One general comment - when naming a patch it will form the description
in the git short log or on the various web interfaces etc. It's 
really useful to actually say which driver it is.

I've fixed that up by adding adis16201: in the appropriate place.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16201.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 2ebd275..0f6a204 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -7,13 +7,13 @@
>   */
>  
>  #include <linux/delay.h>
> -#include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
> -#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

