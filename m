Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58397 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab2D3Ol2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2012 10:41:28 -0400
Message-ID: <4F9EA494.2020705@cam.ac.uk>
Date: Mon, 30 Apr 2012 15:41:24 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH 2/2] iio: call iio_device_unregister() in max517_remove()
References: <4F9E686F.3090703@metafoo.de> <1335795152-14507-1-git-send-email-pmeerw@pmeerw.net> <1335795152-14507-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1335795152-14507-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/30/2012 3:12 PM, Peter Meerwald wrote:
> Reported-by: Lars-Peter Clausen<lars@metafoo.de>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/dac/max517.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
> index 60aef18..672fa51 100644
> --- a/drivers/staging/iio/dac/max517.c
> +++ b/drivers/staging/iio/dac/max517.c
> @@ -264,6 +264,7 @@ exit:
>
>   static int max517_remove(struct i2c_client *client)
>   {
> +	iio_device_unregister(i2c_get_clientdata(client));
>   	iio_device_free(i2c_get_clientdata(client));
>
>   	return 0;

