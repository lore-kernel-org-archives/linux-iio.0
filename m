Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:26929 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbcE0PP4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 27 May 2016 11:15:56 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Support software triggers
To: Doru Gucea <doru.gucea@intel.com>, jic23@kernel.org
References: <1464265414-8395-1-git-send-email-doru.gucea@intel.com>
Cc: daniel.baluta@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, lucas.demarchi@intel.com, cmo@melexis.com,
	linux-iio@vger.kernel.org
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <7b5bc17a-04eb-ce3b-81eb-a7378d0921e5@intel.com>
Date: Fri, 27 May 2016 18:15:35 +0300
MIME-Version: 1.0
In-Reply-To: <1464265414-8395-1-git-send-email-doru.gucea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/26/2016 03:23 PM, Doru Gucea wrote:
> In order to support software triggers (e.g.: hr-based trigger) the
> operations from trigger enable/disable are moved to buffer enable/
> disable.
> 
> This also allows us to remove the mutex from inv_mpu6050_read_fifo:
> inv_reset_fifo can't access in parallel shared fields because the
> buffers must be enabled prior to reading data.
>
> A benefit of removing the mutex is that we avoid a deadlock at
> buffer wqdisable time. The scenario was the following:
> (1) at buffer disable time the indio_dev->mlock is acquired
> (2) free_irq is called and waits for IRQs completion
> (3) inv_mpu6050_read_fifo tries to acquire the indio_dev->mlock

I'm not sure this is safe, it seems to me that inv_reset_fifo assumes
mlock is taken and this needs to be assured. I think properly removing
the irq disabling deadlock require either using something other than
mlock or not calling inv_reset_fifo from the interrupt at all. The
latter seems preferable to me. But this issue should be handled
separately from software trigger support.

Another issue is that the fifo is filled at the sampling frequency
configured in device registers and this can be different from the
sampling frequency configured on the software trigger. It seems to me
that the user needs to manually ensure that they are identical.

Even if they are identical the timer ticks might not match perfectly.
When reading from the fifo all available samples are handled.

If device frequency is set too high you will push multiple samples to
userspace, all but one of them with bad timestamps. It's also possible
to find zero samples if device frequency is set higher than timer frequency.

-- 
Regards,
Leonard
