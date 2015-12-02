Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37028 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbbLBWG5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2015 17:06:57 -0500
Date: Wed, 2 Dec 2015 14:06:57 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	maxime.ripard@free-electrons.com
Subject: Re: [PATCH] staging:iio:mxs-lradc Fix large integer implicitly
 truncated to unsigned warning
Message-ID: <20151202220657.GA17624@kroah.com>
References: <1449080685-4662-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1449080685-4662-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Dec 02, 2015 at 06:24:45PM +0000, Jonathan Cameron wrote:
> The change to using BIT(20) for one of the bit shifts resulted
> in a constant becoming unsigned. When combined with the existing
> signed constants in a couple of places, this caused possible trouble,
> hence the warnings:
> 
> drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_complete_touch_event’:
> drivers/staging/iio/adc/mxs-lradc.c:325:5: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>      (((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
>      ^
> drivers/staging/iio/adc/mxs-lradc.c:734:7: note: in expansion of macro ‘LRADC_DELAY_TRIGGER’
>        LRADC_DELAY_TRIGGER(1 << TOUCHSCREEN_VCHANNEL1) |
>        ^
>   LD [M]  drivers/staging/iio/accel/adis16201.o
> drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_buffer_preenable’:
> drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>  #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
>                                           ^
> drivers/staging/iio/adc/mxs-lradc.c:1308:29: note: in expansion of macro ‘LRADC_DELAY_TRIGGER_LRADCS_MASK’
>   mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
>                              ^
> drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_buffer_postdisable’:
> drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>  #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
>                                           ^
> drivers/staging/iio/adc/mxs-lradc.c:1327:29: note: in expansion of macro ‘LRADC_DELAY_TRIGGER_LRADCS_MASK’
>   mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
> 
> The simplest fix is to force LRADC_DELAY_TRIGGER_LRADCS_MASK to be
> a shift of an unsigned 0xff rather than a signed one.
> 
> This is ugly considering it is the only constant in the driver which
> is so forced, but it does deal with the issue.
> 
> Fixes: e0c961bdaf27 (iio: adc: mxs-lradc: Prefer using the BIT macro)
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Greg I guess the best bet might be if you pick this one up directly.
> If not I can queue it up for a pull request that will probably hit
> you on Sunday.  Don't mind either way!

I've queued it up now, no need to wait.

thanks for the fix,

greg k-h
