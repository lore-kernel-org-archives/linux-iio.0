Return-Path: <SRS0=n4Xm=XI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791FC49ED7
	for <linux-iio@archiver.kernel.org>; Fri, 13 Sep 2019 06:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEC42089F
	for <linux-iio@archiver.kernel.org>; Fri, 13 Sep 2019 06:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="esptql2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfIMGId (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Sep 2019 02:08:33 -0400
Received: from first.geanix.com ([116.203.34.67]:40112 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMGId (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Sep 2019 02:08:33 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 9AE156508B;
        Fri, 13 Sep 2019 06:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568354866; bh=I8wH6lTdnfwAYU6l/FQY0SaxmWqeBXJS9tm2JhgLbI0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=esptql2biogPx2HRB9VbI9N8JKmVXCnDxGiYN2epNUJmqjyXKt1j4CXci6VVe18++
         hUfuRxN6mt9MBlP/dt/VzwyS1q37E2ZWX68+WvxuBbz/axUH6tx0B5mIkOSw+c3QUr
         ZwwadLX0Fq7kEIXIWxI026CbWHYw08GsccNjEr1P7MyR7nNY4piEkOa+R9nQKGRWa0
         rFuUCZ2fa6TwQU0AtPfC1CUcE5VefOCCtjjsLom0v9GYWl60mkrHWCkdmijjU6bOP0
         Byn3WKMsTcww4Gck5FdOanfKWGaibJKI8gLgnOUpZNkRHOKtVYJW3MYQ0Mvfp7ZxAw
         N/6LZgpGs30mg==
Subject: Re: [PATCH v7 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
References: <20190912070614.1144169-1-sean@geanix.com>
 <20190912070614.1144169-4-sean@geanix.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <6eb3a60f-0712-4ad7-fe3c-fd76a3ea135f@geanix.com>
Date:   Fri, 13 Sep 2019 08:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190912070614.1144169-4-sean@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 12/09/2019 09.06, Sean Nyekjaer wrote:
> This add ways for the SoC to wake from accelerometer wake events.
> 
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v4:
>   * More devices supports wakeup
> 
> Changes since v5:
>   * None
> 
> Changes since v6:
>   * None
> 
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 4198ba263d03..f79978a2870f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1858,6 +1858,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>   			return err;
>   	}
>   
> +	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
> +		device_init_wakeup(dev, true);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL(st_lsm6dsx_probe);
> @@ -1876,6 +1879,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>   		if (!(hw->enable_mask & BIT(sensor->id)))
>   			continue;
>   
> +		if (device_may_wakeup(dev) && i == ST_LSM6DSX_ID_ACC) {
> +			/* Enable wake from IRQ */
> +			enable_irq_wake(hw->irq);
> +			continue;
> +		}
> +
>   		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
>   		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
>   		    sensor->id == ST_LSM6DSX_ID_EXT2)
> @@ -1908,6 +1917,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>   		if (!(hw->suspend_mask & BIT(sensor->id)))
>   			continue;
>   
> +		if (device_may_wakeup(dev) && i == ST_LSM6DSX_ID_ACC) {
> +			disable_irq_wake(hw->irq);
> +			continue;
> +		}
> +
This section needs to move above:
 >   		if (!(hw->enable_mask & BIT(sensor->id)))
In the current configuration it will never be reached in event only mode

With the bug mentioned above fixed, have tested suspend/wake with and 
without FIFO enabled.
