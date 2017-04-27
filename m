Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37668 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdD0Fc2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 01:32:28 -0400
Subject: Re: [PATCH] iio: core: Fix suspicious sizeof usage
To: Orson Zhai <orson.zhai@spreadtrum.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1493083016-20571-1-git-send-email-orson.zhai@spreadtrum.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bb016559-2e5b-168f-fdf6-9d127cc3d293@kernel.org>
Date: Thu, 27 Apr 2017 06:32:22 +0100
MIME-Version: 1.0
In-Reply-To: <1493083016-20571-1-git-send-email-orson.zhai@spreadtrum.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/04/17 02:16, Orson Zhai wrote:
> Pointer size is variours in different system, say 32bit for 4 and 64bit
> for 8. The 'sizeof(infomask)' may lead to wrong bit numbers.
> 
> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
That's certainly been there a while.  oops.

Anyhow, whilst clearly garbage, it doesn't actually have an effect
at the moment due to the relatively small number of bits that can be
set and the fact this is limited by 32 bit platforms anyway.

So applied to the togreg branch of iio.git and pushed out as
testing for the auto builders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 3ff91e0..795f53c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1089,7 +1089,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
>  {
>  	int i, ret, attrcount = 0;
>  
> -	for_each_set_bit(i, infomask, sizeof(infomask)*8) {
> +	for_each_set_bit(i, infomask, sizeof(*infomask)*8) {
>  		if (i >= ARRAY_SIZE(iio_chan_info_postfix))
>  			return -EINVAL;
>  		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
> @@ -1118,7 +1118,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
>  	int i, ret, attrcount = 0;
>  	char *avail_postfix;
>  
> -	for_each_set_bit(i, infomask, sizeof(infomask) * 8) {
> +	for_each_set_bit(i, infomask, sizeof(*infomask) * 8) {
>  		avail_postfix = kasprintf(GFP_KERNEL,
>  					  "%s_available",
>  					  iio_chan_info_postfix[i]);
> 

