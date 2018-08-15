Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33089 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHOX5Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 19:57:24 -0400
Subject: Re: [PATCH v2 4/7] iio: chemical: bme680: change MSK->MASK in
 #defines
To: linux-iio@vger.kernel.org
Cc: jic23@vger.kernel.org, himanshujha199640@gmail.com
References: <20180815203835.21079-1-dpfrey@gmail.com>
 <20180815203835.21079-5-dpfrey@gmail.com>
From: David Frey <dpfrey@gmail.com>
Message-ID: <ac666b9e-0767-fa08-58e6-2ea9cd3c7f91@gmail.com>
Date: Wed, 15 Aug 2018 14:03:31 -0700
MIME-Version: 1.0
In-Reply-To: <20180815203835.21079-5-dpfrey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8/15/2018 1:38 PM, David Frey wrote:

<snip>

> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 49bb6b84f181..d62cb88af481 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c

When splitting the patches apart, I screwed this one up slightly.  The 
patch should also include this hunk:

> @@ -206,7 +206,7 @@ static int bme680_read_calib(struct bme680_data *data,
>                 return ret;
>         }
>         calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> -                       (tmp_lsb & BME680_BIT_H1_DATA_MSK);
> +                       (tmp_lsb & BME680_BIT_H1_DATA_MASK);
> 
>         ret = regmap_read(data->regmap, BME680_H2_MSB_REG, &tmp_msb);
>         if (ret < 0) {

What is the correct course of action in the situation?  Should I resend 
just this one patch immediately?  Would it get a new version number 
"[PATCH v3 4/7]"?  I think the version number refers to the whole patch 
series, so it seems wrong to bump the revision of one patch and not 
transmit the whole series.

Thanks,
David Frey
