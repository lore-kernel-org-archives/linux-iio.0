Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45707 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbGSJfx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 05:35:53 -0400
Message-ID: <55AB6F77.7080900@kernel.org>
Date: Sun, 19 Jul 2015 10:35:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marex@denx.de>,
	=?windows-1252?Q?Kristina_Mart=9Aenko?=
	<kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 4/6] iio: mxs-lradc: remove unnecessary header includes
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com> <1437222646-8742-5-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-5-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/15 13:30, Stefan Wahren wrote:
> This patch removes the unnecessary header includes.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Applied.
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 763075b..21b0ccf 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -23,18 +23,13 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/sysfs.h>
> -#include <linux/list.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> -#include <linux/spinlock.h>
> -#include <linux/wait.h>
> -#include <linux/sched.h>
>  #include <linux/stmp_device.h>
>  #include <linux/bitops.h>
>  #include <linux/completion.h>
> -#include <linux/delay.h>
>  #include <linux/input.h>
>  #include <linux/clk.h>
>  
> 

