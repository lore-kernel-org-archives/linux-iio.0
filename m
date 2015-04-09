Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53702 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736AbbDIQ2m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 12:28:42 -0400
Message-ID: <5526A8B9.1010004@kernel.org>
Date: Thu, 09 Apr 2015 17:28:41 +0100
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
silly indeed.

Applied this one to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play.

Thanks,

Jonathan
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
>  
>  /* Register definitions. */
>  #define SX9500_REG_IRQ_SRC		0x00
> 

