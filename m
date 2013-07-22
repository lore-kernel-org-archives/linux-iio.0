Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46705 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756968Ab3GVIhD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2013 04:37:03 -0400
Received: by mail-ee0-f51.google.com with SMTP id e52so3597774eek.38
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2013 01:37:01 -0700 (PDT)
Date: Mon, 22 Jul 2013 09:36:51 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: sameo@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	koen@dominion.thruhere.net
Subject: Re: [PATCH 3/4] MFD: ti_tscadc: ADC Clock check not required
Message-ID: <20130722083651.GF4681@laptop>
References: <1374337656-6393-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374337656-6393-4-git-send-email-zubair.lutfullah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1374337656-6393-4-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 20 Jul 2013, Zubair Lutfullah wrote:

> From: "Patil, Rachna" <rachna@ti.com>
> 
> ADC is ideally expected to work at a frequency of 3MHz.
> The present code had a check, which returned error if the frequency
> went below the threshold  value. But since AM335x supports various
> working frequencies, this check is not required.
> Now the code just uses the internal ADC clock divider to set the ADC
> frequency w.r.t the sys clock.
> 
> Signed-off-by: Patil, Rachna <rachna@ti.com>
> Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c       |    6 +-----
>  include/linux/mfd/ti_am335x_tscadc.h |    1 -
>  2 files changed, 1 insertion(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
