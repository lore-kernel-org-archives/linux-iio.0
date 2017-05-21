Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36757 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdEULLj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 07:11:39 -0400
Subject: Re: [PATCH v5 4/9] iio: light: rpr0521 magic number to sizeof() on
 value read
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org
References: <1495109577-29596-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1495109577-29596-5-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <30de204b-94d9-7114-7cac-f6d6731a0a31@kernel.org>
Date: Sun, 21 May 2017 12:11:37 +0100
MIME-Version: 1.0
In-Reply-To: <1495109577-29596-5-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/05/17 13:12, Mikko Koivunen wrote:
> Changed magic number to sizeof() on value read.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Applied.
> ---
> 
>   drivers/iio/light/rpr0521.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 9219819..38095d7 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -356,7 +356,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>   
>   		ret = regmap_bulk_read(data->regmap,
>   				       rpr0521_data_reg[chan->address].address,
> -				       &raw_data, 2);
> +				       &raw_data, sizeof(raw_data));
>   		if (ret < 0) {
>   			rpr0521_set_power_state(data, false, device_mask);
>   			mutex_unlock(&data->lock);
> 

