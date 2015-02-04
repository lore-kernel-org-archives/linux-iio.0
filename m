Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60611 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162080AbbBDSkv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Feb 2015 13:40:51 -0500
Message-ID: <54D24FDE.7000908@kernel.org>
Date: Wed, 04 Feb 2015 16:59:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Nicholas Mc Guire <hofrat@osadl.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: qcom-spmi-iadc: cleanup wait_for_completion
 return handling
References: <1422866227-10484-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1422866227-10484-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/02/15 08:37, Nicholas Mc Guire wrote:
> This patch fixes two issues:
> * return type of wait_for_completion_timeout is unsigned long not int, 
>   rather than adding a dedicated variable the wait_for_completion_timeout
>   is moved into the condition directly
> * the timeout of wait_for_completion_timeout is in jiffies but the value
>   being passed was a unsigned long not converted to jiffies and thus was
>   dependent on the HZ settings which is probably not what you want.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Ivan, need your Ack / Reviewed-by on this one.

Looks superficially fine to me, but as Nicholas has observed, hardware
knowledge / testing required!

J
> ---
> 
> Note that the timeout value changed very significantly as wait was 
> initially in the range of 2 milliseconds, so this converts to 1 jiffies
> for HZ < 1000 and 2 jiffies for HZ=1000 - thus the timeout value changed
> by 3 orders of magnitude. This needs a review by someone that knows the
> details of the hardware to judge if this change is ok - in any case the
> timeout passed should go through usecs_to_jiffies or msecs_to_jiffis and
> to ensure it is no longer HZ dependent.
> 
> Patch was compile tested only for imx_v6_v7_defconfig + CONFIG_IIO=m
> CONFIG_COMPILE_TEST=y, CONFIG_SPMI=m, CONFIG_QCOM_SPMI_IADC=m
> 
> Patch is against 3.19.0-rc6 -next-20150130
> 
>  drivers/iio/adc/qcom-spmi-iadc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
> index b9666f2..61fb88d 100644
> --- a/drivers/iio/adc/qcom-spmi-iadc.c
> +++ b/drivers/iio/adc/qcom-spmi-iadc.c
> @@ -296,8 +296,8 @@ static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
>  	if (iadc->poll_eoc) {
>  		ret = iadc_poll_wait_eoc(iadc, wait);
>  	} else {
> -		ret = wait_for_completion_timeout(&iadc->complete, wait);
> -		if (!ret)
> +		if (!wait_for_completion_timeout(&iadc->complete, 
> +				usecs_to_jiffies(wait)))
>  			ret = -ETIMEDOUT;
>  		else
>  			/* double check conversion status */
> 

