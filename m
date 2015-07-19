Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45689 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbbGSJe4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 05:34:56 -0400
Message-ID: <55AB6F3F.90605@kernel.org>
Date: Sun, 19 Jul 2015 10:34:55 +0100
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
Subject: Re: [PATCH 3/6] iio: mxs-lradc: add missing include
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com> <1437222646-8742-4-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-4-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/15 13:30, Stefan Wahren wrote:
> This patch adds the missing include for mutex handling.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Applied to the togreg branch of iio.git

Jonathan
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 386a44d..763075b 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -26,6 +26,7 @@
>  #include <linux/list.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
> 

