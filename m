Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40103 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbbJKJcH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 05:32:07 -0400
Subject: Re: [PATCH] iio: bmc150: Fix type of step transfer variable
To: Markus Pargmann <mpa@pengutronix.de>
References: <201510032331.iV9fviPZ%fengguang.wu@intel.com>
 <1444156299-14316-1-git-send-email-mpa@pengutronix.de>
Cc: "linux-iio @ vger . kernel . org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A2C92.5060006@kernel.org>
Date: Sun, 11 Oct 2015 10:32:02 +0100
MIME-Version: 1.0
In-Reply-To: <1444156299-14316-1-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/15 19:31, Markus Pargmann wrote:
> regmap_get_raw_read_max() returns type size_t. Also the later dev_err()
> already uses the correct printk format "%zu".
> 
> This patch changes the type of 'step' to size_t.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> Hi,
> 
> this problem was reported by the kbuild robot. This should fix the warning. I
> am not sure if the patches are already in some public tree, otherwise this
> could directly be squashed into the commit directly.
> 
> Thanks,
> 
> Markus
I'm not sure what happened here.  I haven't touched the tree since this report,
but the type is already size_t in my local tree. 

Anyhow, the issues seems not to exist anymore for some reason.

J
> 
> 
>  drivers/iio/accel/bmc150-accel-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 614cf61f0110..dc89cf8b7603 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -891,7 +891,7 @@ static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
>  	int ret;
>  	int total_length = samples * sample_length;
>  	int i;
> -	int step = regmap_get_raw_read_max(data->regmap);
> +	size_t step = regmap_get_raw_read_max(data->regmap);
>  
>  	if (!step || step > total_length)
>  		step = total_length;
> 

