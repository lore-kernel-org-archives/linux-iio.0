Return-Path: <SRS0=IeKv=CP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED458C10DAA
	for <linux-iio@archiver.kernel.org>; Sun,  6 Sep 2020 15:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA14620714
	for <linux-iio@archiver.kernel.org>; Sun,  6 Sep 2020 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599405881;
	bh=bTdXw0tG/utEdt1OtJMdHMHIzVmsX7ZvrSFaULRmmXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BOy0VkB9m6w0SE22VfcAbD0AJKKbrTDzVJRJAOAPBuTi0Yq4WLS2y73Zs4vTbT8EF
	 ShdBmDD6zhaJdwpFCzZLs2Y632hX7TeK4xboXYk4JHFUlMx+/vUm7wf2mRxW9xgwCS
	 r8a5WDHX7GUdp9xwIgot6JI82JMJ9kDfTHwDLiC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgIFPYh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbgIFPYM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:24:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4CB20714;
        Sun,  6 Sep 2020 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599405851;
        bh=bTdXw0tG/utEdt1OtJMdHMHIzVmsX7ZvrSFaULRmmXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p8PzqMuJggnHdx4w4af4fzwHMuLiEu8jK9B0JDVldRYqLN/eiQdZp39zy1pnJDCvc
         XBnl1QYCUWkSb8ZL8GCsfri8l5ulRxkyx8XI0N6S5Sa1aFzbwUVNyW5K1XGYaFmseL
         Ki3XvFm1LyBP+TvdiqbDSfWc5bWuCo6gDE7H97+0=
Date:   Sun, 6 Sep 2020 16:24:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, peress@chromium.org, enric.balletbo@collabora.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Documentation: ABI: iio: Use What: consistently
Message-ID: <20200906162407.2173a5d6@archlinux>
In-Reply-To: <20200901030017.3221295-2-gwendal@chromium.org>
References: <20200901030017.3221295-1-gwendal@chromium.org>
        <20200901030017.3221295-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 20:00:15 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Change "[w|W]hat[:| ]" to What: for consistency.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> No changes since v1
Already applied from v1

Jonathan

>  Documentation/ABI/testing/sysfs-bus-iio | 48 ++++++++++++-------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index c3767d4d01a6f..47df16c87862d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -401,21 +401,21 @@ Description:
>  		Hardware applied calibration offset (assumed to fix production
>  		inaccuracies).
>  
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
> -What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
> -what		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
> -what		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
> @@ -483,7 +483,7 @@ Description:
>  		If a discrete set of scale values is available, they
>  		are listed in this attribute.
>  
> -What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
> @@ -750,9 +750,9 @@ What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
>  What:		/sys/.../events/in_tempY_raw_thresh_rising_value
>  What:		/sys/.../events/in_tempY_raw_thresh_falling_value
>  What:		/sys/.../events/in_illuminance0_thresh_falling_value
> -what:		/sys/.../events/in_illuminance0_thresh_rising_value
> -what:		/sys/.../events/in_proximity0_thresh_falling_value
> -what:		/sys/.../events/in_proximity0_thresh_rising_value
> +What:		/sys/.../events/in_illuminance0_thresh_rising_value
> +What:		/sys/.../events/in_proximity0_thresh_falling_value
> +What:		/sys/.../events/in_proximity0_thresh_rising_value
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -830,11 +830,11 @@ What:		/sys/.../events/in_tempY_thresh_rising_hysteresis
>  What:		/sys/.../events/in_tempY_thresh_falling_hysteresis
>  What:		/sys/.../events/in_tempY_thresh_either_hysteresis
>  What:		/sys/.../events/in_illuminance0_thresh_falling_hysteresis
> -what:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
> -what:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
> -what:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
> -what:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
> -what:		/sys/.../events/in_proximity0_thresh_either_hysteresis
> +What:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
> +What:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
> +What:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
> +What:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
> +What:		/sys/.../events/in_proximity0_thresh_either_hysteresis
>  KernelVersion:	3.13
>  Contact:	linux-iio@vger.kernel.org
>  Description:

