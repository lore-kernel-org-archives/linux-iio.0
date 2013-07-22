Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:34005 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756926Ab3GVIiG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2013 04:38:06 -0400
Received: by mail-ea0-f169.google.com with SMTP id h15so3639400eak.14
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2013 01:38:05 -0700 (PDT)
Date: Mon, 22 Jul 2013 09:37:58 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: sameo@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	koen@dominion.thruhere.net
Subject: Re: [PATCH 2/4] MFD: ti_tscadc: disable TSC config registers in adc
 mode
Message-ID: <20130722083758.GG4681@laptop>
References: <1374337656-6393-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374337656-6393-3-git-send-email-zubair.lutfullah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1374337656-6393-3-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 20 Jul 2013, Zubair Lutfullah wrote:

> From: "Patil, Rachna" <rachna@ti.com>
> 
> AFE Pen Ctrl and TouchScreen transistors enabling is not
> required when only ADC mode is being used, so check for availability of
> TSC driver before accessing control register.
> 
> Signed-off-by: Patil, Rachna <rachna@ti.com>
> Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
