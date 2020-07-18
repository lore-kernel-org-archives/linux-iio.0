Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96326C433DF
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6634B2080D
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595086733;
	bh=YKGQuAKCtLNIOPX2N5LDWmW4wjTb6I6q8jLrpe152mM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E9V8xKVYJQzkKUBdHKLX09yxXW4dq9QSs+gP89yaDhYauCe/SbFlX/SqzSs4CF12S
	 4YVIiiYp58jKmcItJefdfz7ntoTEV2l5uHiSVfxKEzNv8oPWJkaaJBhekegReCe4zd
	 5uC56W5mJRT81JuKr3Q33oUA6HuXjrDqlm+5p01I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPix (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPiw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:38:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E1920734;
        Sat, 18 Jul 2020 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595086732;
        bh=YKGQuAKCtLNIOPX2N5LDWmW4wjTb6I6q8jLrpe152mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a4X+SM44X7wue93u46udrrVdTXhwD3mycjO94ZssMq0PCA8OdpH/vw6b49V1eUb3O
         M4SICr0bsHUdGR+5GTCJxAQT7SaJIi33g5y8qnpJxSjmMCd2M4S/Gc3G41QbWbWA+A
         PyQOo4tvo+oP2hGwF6dMWmCWGHj0t4nLCQfp3EKI=
Date:   Sat, 18 Jul 2020 16:38:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Nishant Kamat <nskamat@ti.com>, Balaji T K <balajitk@ti.com>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Girish S Ghongdemath <girishsg@ti.com>,
        Ambresh K <ambresh@ti.com>,
        Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>,
        Mikko Ylinen <mikko.k.ylinen@nokia.com>
Subject: Re: [PATCH 05/30] iio: adc: twl6030-gpadc: Fix some
 misdocumentation and formatting issues
Message-ID: <20200718163847.51e366fa@archlinux>
In-Reply-To: <20200717165538.3275050-6-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-6-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:13 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/twl6030-gpadc.c:110: warning: Function parameter or member 'ideal' not described in 'twl6030_gpadc_platform_data'
>  drivers/iio/adc/twl6030-gpadc.c:110: warning: Function parameter or member 'channel_to_reg' not described in 'twl6030_gpadc_platform_data'
> 
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Nishant Kamat <nskamat@ti.com>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: Graeme Gregory <gg@slimlogic.co.uk>
> Cc: Girish S Ghongdemath <girishsg@ti.com>
> Cc: Ambresh K <ambresh@ti.com>
> Cc: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
> Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/twl6030-gpadc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index f24148bd15de4..a19a6ce65e390 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -94,9 +94,9 @@ struct twl6030_gpadc_data;
>   * struct twl6030_gpadc_platform_data - platform specific data
>   * @nchannels:		number of GPADC channels
>   * @iio_channels:	iio channels
> - * @twl6030_ideal:	pointer to calibration parameters
> + * @ideal:		pointer to calibration parameters
>   * @start_conversion:	pointer to ADC start conversion function
> - * @channel_to_reg	pointer to ADC function to convert channel to
> + * @channel_to_reg:	pointer to ADC function to convert channel to
>   *			register address for reading conversion result
>   * @calibrate:		pointer to calibration function
>   */

