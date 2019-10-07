Return-Path: <SRS0=cTxg=YA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FEAC47404
	for <linux-iio@archiver.kernel.org>; Mon,  7 Oct 2019 07:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0161217D6
	for <linux-iio@archiver.kernel.org>; Mon,  7 Oct 2019 07:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="DV7OAT1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfJGH4l (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:56:41 -0400
Received: from first.geanix.com ([116.203.34.67]:47862 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfJGH4l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 03:56:41 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 477594A557;
        Mon,  7 Oct 2019 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1570434918; bh=hJtJvtotUuUI5yZjoV6tzEvEnllGmIu0GazFovYPlVk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DV7OAT1cosk8kje/hvYsE0dvfdgdWp+xbznGMLMnrseiRm2f78fuCCOYWx2NyZZqz
         PhxkGE/8Pk7uc8JBynfHhRSayFYUCiY9ilG9TzwndXufl6CR1kEzYk1LIOtOtzmS0C
         CJdHm9Ac/dZDjtYLhqhgA1vb+8NWdiUyNmL4aHEQM/rOJGPCUYgq8Lal9IFnb36uDp
         82Zidi8Rtgajh5cHUw2ZKoCvIHdGWHpJi/cAvD+Udn/RykRQKABqZLHrirBv3waTPo
         DFBVs3o9JaRSCpIQuW29PkAKmVKwAFSMJvmhv2rSdS+ZE+sRY0gj+fNQgVveOeYYOr
         /rILIRKfX9KkA==
Subject: Re: [PATCH 11/13] iio: imu: st_lsm6dsx: add missing kernel
 documenation
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, martin@geanix.com, rjones@gateworks.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
References: <cover.1570367532.git.lorenzo@kernel.org>
 <08d98185ff40de1b2183446d6da61fffcafb9b7f.1570367532.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <f211bb25-f90f-71b6-6df9-2bd03f3ba0b7@geanix.com>
Date:   Mon, 7 Oct 2019 09:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <08d98185ff40de1b2183446d6da61fffcafb9b7f.1570367532.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 06/10/2019 15.22, Lorenzo Bianconi wrote:
> Add missing kernel doc for st_lsm6dsx_hw data structure
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 5692ea695f04..40532f99ba4b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -345,6 +345,9 @@ struct st_lsm6dsx_sensor {
>    * @ts_sip: Total number of timestamp samples in a given pattern.
>    * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
>    * @buff: Device read buffer.
> + * @irq_routing: pointer to interrupt routing configuration.
> + * @event_threshold: wakeup event threshold.
> + * @enable_event: enabled event bitmask.
>    * @iio_devs: Pointers to acc/gyro iio_dev instances.
>    * @settings: Pointer to the specific sensor settings in use.
>    */
> 
