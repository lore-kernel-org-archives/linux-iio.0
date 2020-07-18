Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1422FC433E0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D212080D
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595085453;
	bh=BKNVe9fgnfqAHXaTZBDQXkmm6++oSD277VPzoltC4t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vN4D+nj0qEeruuRtYMyBZDE8M2REgASn0RiU0KqC+qHB9SHnKtenq2X5BDCAGeHjq
	 ZT1k9ADadR1BMJ3jemrynV+0ITwyGC/EIZpkrlr43/2I74heFXlUT/G/udYEWsIUc/
	 9JY1oFwnOa0qiNx969BBh3ZZuqkGGXAN/ca9KwSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGRPRd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPRd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:17:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB1C20775;
        Sat, 18 Jul 2020 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595085452;
        bh=BKNVe9fgnfqAHXaTZBDQXkmm6++oSD277VPzoltC4t8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s42pLxPyMt7gImBXNBgaVoHkq3TeaCW/j6jzSa/ngTX3ouORea9/7T4obK+xxcFZJ
         zwjJ1UTz+O8poGCWD8KjlEKsJVVqhf6bsFpJuTdvpoz98p6EQHJVk1gNIjyoN+xOaE
         ya6eEJwLSRSYeWCAuUh0csSMLHUWb56e6GqCmvtY=
Date:   Sat, 18 Jul 2020 16:17:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 29/30] iio: imu: kmx61: Fix formatting in kerneldoc
 function headers
Message-ID: <20200718161728.2faa55f2@archlinux>
In-Reply-To: <20200716135928.1456727-30-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-30-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:27 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'data' not described in 'kmx61_set_mode'
>  drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'mode' not described in 'kmx61_set_mode'
>  drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'device' not described in 'kmx61_set_mode'
>  drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'update' not described in 'kmx61_set_mode'
>  drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'data' not described in 'kmx61_set_power_state'
>  drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'on' not described in 'kmx61_set_power_state'
>  drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'device' not described in 'kmx61_set_power_state'
> 
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.
Thanks,

Jonathan

> ---
>  drivers/iio/imu/kmx61.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index e67466100aff4..d0cee2e09884d 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -312,10 +312,10 @@ static int kmx61_convert_wake_up_odr_to_bit(int val, int val2)
>  
>  /**
>   * kmx61_set_mode() - set KMX61 device operating mode
> - * @data - kmx61 device private data pointer
> - * @mode - bitmask, indicating operating mode for @device
> - * @device - bitmask, indicating device for which @mode needs to be set
> - * @update - update stby bits stored in device's private  @data
> + * @data: kmx61 device private data pointer
> + * @mode: bitmask, indicating operating mode for @device
> + * @device: bitmask, indicating device for which @mode needs to be set
> + * @update: update stby bits stored in device's private  @data
>   *
>   * For each sensor (accelerometer/magnetometer) there are two operating modes
>   * STANDBY and OPERATION. Neither accel nor magn can be disabled independently
> @@ -718,9 +718,9 @@ static int kmx61_setup_any_motion_interrupt(struct kmx61_data *data,
>  
>  /**
>   * kmx61_set_power_state() - set power state for kmx61 @device
> - * @data - kmx61 device private pointer
> - * @on - power state to be set for @device
> - * @device - bitmask indicating device for which @on state needs to be set
> + * @data: kmx61 device private pointer
> + * @on: power state to be set for @device
> + * @device: bitmask indicating device for which @on state needs to be set
>   *
>   * Notice that when ACC power state needs to be set to ON and MAG is in
>   * OPERATION then we know that kmx61_runtime_resume was already called

