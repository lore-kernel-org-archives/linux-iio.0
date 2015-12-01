Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48351 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbbLAROA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2015 12:14:00 -0500
Date: Tue, 1 Dec 2015 09:13:56 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO - First set of new drivers, core support and cleanups
 for the 4.5 cycle
Message-ID: <20151201171356.GC2714@kroah.com>
References: <5651D09C.6030209@kernel.org>
 <5651D1DA.9020903@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5651D1DA.9020903@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 22, 2015 at 02:31:54PM +0000, Jonathan Cameron wrote:
> 
> Hi Greg,
> 
> When this one and the fixes set I sent a few minutes ago merge you curiously
> get an issue with drivers/staging/iio/Kconfig.  The right resolution is
> to dump all the dummy driver stuff.
> 
> All the other changes related to that move and various automerge stuff that
> occurs looks fine to me.

Thanks for the merge info, that helped.

But, I'm now getting these build warnings that I don't think we had
before:

drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_complete_touch_event’:
drivers/staging/iio/adc/mxs-lradc.c:325:5: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     (((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
     ^
drivers/staging/iio/adc/mxs-lradc.c:734:7: note: in expansion of macro ‘LRADC_DELAY_TRIGGER’
       LRADC_DELAY_TRIGGER(1 << TOUCHSCREEN_VCHANNEL1) |
       ^
  LD [M]  drivers/staging/iio/accel/adis16201.o
drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_buffer_preenable’:
drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
 #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
                                          ^
drivers/staging/iio/adc/mxs-lradc.c:1308:29: note: in expansion of macro ‘LRADC_DELAY_TRIGGER_LRADCS_MASK’
  mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
                             ^
drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_buffer_postdisable’:
drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
 #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
                                          ^
drivers/staging/iio/adc/mxs-lradc.c:1327:29: note: in expansion of macro ‘LRADC_DELAY_TRIGGER_LRADCS_MASK’
  mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
                             ^

Can you fix those up?

thanks,

greg k-h
