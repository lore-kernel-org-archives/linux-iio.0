Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33380 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbbDRS7K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 14:59:10 -0400
Message-ID: <5532A97A.4090201@kernel.org>
Date: Sat, 18 Apr 2015 19:59:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: sx9500: rename GPIO interrupt pin
References: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com> <1428065254-6444-4-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428065254-6444-4-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/15 13:47, Vlad Dogaru wrote:
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
For some reason I missed this before... 
> ---
>  drivers/iio/proximity/sx9500.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 94c56f3..13b174c 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -31,7 +31,8 @@
>  
>  #define SX9500_DRIVER_NAME		"sx9500"
>  #define SX9500_IRQ_NAME			"sx9500_event"
> -#define SX9500_GPIO_NAME		"sx9500_gpio"
> +
> +#define SX9500_GPIO_INT			"interrupt"
You've changed the define as well as the name that broke the build so
I've changed it back again as a fix-up for this patch.

Your v3 patch 2 will uses the new name... I might fix it up
to change the name of the define there if I'm happy with the
rest of that patch.

J
>  
>  /* Register definitions. */
>  #define SX9500_REG_IRQ_SRC		0x00
> 

