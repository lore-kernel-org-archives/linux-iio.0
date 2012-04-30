Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58104 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab2D3OlK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2012 10:41:10 -0400
Message-ID: <4F9EA482.2030204@cam.ac.uk>
Date: Mon, 30 Apr 2012 15:41:06 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH 1/2] iio: replace strict_strtol() with kstrtol() in max517
 driver
References: <4F9E686F.3090703@metafoo.de> <1335795152-14507-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1335795152-14507-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This one doesn't really matter as it'll get eaten up in a conversion to 
chan_spec shortly
anyway.  But it is an improvement even if a temporary one so what the 
heck...

On 4/30/2012 3:12 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/dac/max517.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
> index a3f588df..60aef18 100644
> --- a/drivers/staging/iio/dac/max517.c
> +++ b/drivers/staging/iio/dac/max517.c
> @@ -67,7 +67,7 @@ static ssize_t max517_set_value(struct device *dev,
>   	int res;
>   	long val;
>
> -	res = strict_strtol(buf, 10,&val);
> +	res = kstrtol(buf, 10,&val);
>
>   	if (res)
>   		return res;

