Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36715 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbdEULG7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 07:06:59 -0400
Subject: Re: [PATCH v5 1/9] iio: light: rpr0521 disable sensor -bugfix
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org
References: <1495109577-29596-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1495109577-29596-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a3eae34c-1108-2e11-70e1-a01fbe0c16b3@kernel.org>
Date: Sun, 21 May 2017 12:06:57 +0100
MIME-Version: 1.0
In-Reply-To: <1495109577-29596-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/17 13:12, Mikko Koivunen wrote:
> Sensor was marked enabled on each call even if the call was for disabling
> sensor.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
I'm going to guess it 'kind of worked' before this and treat this
as a low urgency fix.  This is primarily to avoid having to delay
the non bug fix patches later in the series.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> Patch v2->v3 changes:
> whitespace change.
> 
>   drivers/iio/light/rpr0521.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 7de0f39..03504f6 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -197,7 +197,10 @@ static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
>   	if (ret < 0)
>   		return ret;
>   
> -	data->als_dev_en = true;
> +	if (status & RPR0521_MODE_ALS_MASK)
> +		data->als_dev_en = true;
> +	else
> +		data->als_dev_en = false;
>   
>   	return 0;
>   }
> @@ -212,7 +215,10 @@ static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
>   	if (ret < 0)
>   		return ret;
>   
> -	data->pxs_dev_en = true;
> +	if (status & RPR0521_MODE_PXS_MASK)
> +		data->pxs_dev_en = true;
> +	else
> +		data->pxs_dev_en = false;
>   
>   	return 0;
>   }
> 

