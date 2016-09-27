Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49111 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933067AbcI0TTN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2016 15:19:13 -0400
Subject: Re: [PATCH] io: accel: mma7666: declare mma7660_nscale as static
To: Ico Doornekamp <ico@pruts.nl>
References: <20160926184027.5356-1-ico@pruts.nl>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7ed517e8-b5ec-7ad8-ebe0-6df82e846681@kernel.org>
Date: Tue, 27 Sep 2016 20:19:09 +0100
MIME-Version: 1.0
In-Reply-To: <20160926184027.5356-1-ico@pruts.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/09/16 19:40, Ico Doornekamp wrote:
> As reported by sparse
> 
> Signed-off-by: Ico Doornekamp <ico@pruts.nl>
Hi,

Already fixed - see the testing branch of iio.git.
I picked up a patch for this on Saturday from Wei Jongjun

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma7660.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 03beadf..3a40774 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -39,7 +39,7 @@
>  
>  #define MMA7660_SCALE_AVAIL	"0.467142857"
>  
> -const int mma7660_nscale = 467142857;
> +static const int mma7660_nscale = 467142857;
>  
>  #define MMA7660_CHANNEL(reg, axis) {	\
>  	.type = IIO_ACCEL,	\
> 

