Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56547 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278Ab3KMTbz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2013 14:31:55 -0500
Message-ID: <5283E1F8.3010402@kernel.org>
Date: Wed, 13 Nov 2013 20:32:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Minor kerneldoc fix for iio_trigger_write_current()
References: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net> <1384292987-6250-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1384292987-6250-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/13 21:49, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

thanks,
> ---
>  drivers/iio/industrialio-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index bf5e70a..021d735 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -318,7 +318,7 @@ static ssize_t iio_trigger_read_current(struct device *dev,
>   * iio_trigger_write_current() - trigger consumer sysfs set current trigger
>   *
>   * For trigger consumers the current_trigger interface allows the trigger
> - * used for this device to be specified at run time based on the triggers
> + * used for this device to be specified at run time based on the trigger's
>   * name.
>   **/
>  static ssize_t iio_trigger_write_current(struct device *dev,
> 
