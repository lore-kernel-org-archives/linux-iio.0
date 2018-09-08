Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38535 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHRO7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Sep 2018 13:14:59 -0400
Date: Sat, 8 Sep 2018 17:59:13 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: zhong jiang <zhongjiang@huawei.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: remove unnecessary condition judgment in
 am2315_trigger_handler
Message-ID: <20180908122913.GA4445@himanshu-Vostro-3559>
References: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 08, 2018 at 06:57:36PM +0800, zhong jiang wrote:
> The iterator in for_each_set_bit is never null, therefore, remove
> the redundant conditional judgment.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/iio/humidity/am2315.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index 7d8669d..dc12e37 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -176,8 +176,7 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
>  		i = 0;
>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>  				 indio_dev->masklength) {
> -			data->buffer[i] = (bit ? sensor_data.temp_data :
> -						 sensor_data.hum_data);
> +			data->buffer[i] = sensor_data.temp_data;

No, this seems wrong!

We have buffer support to either take both readings(temp & humid)
simultaneously, or only single channel using specified scan mask.

Patch title should be:

"iio: humidity: am2315: .... .. "


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
