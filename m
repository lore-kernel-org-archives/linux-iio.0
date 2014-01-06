Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49144 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbaAFJfa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2014 04:35:30 -0500
Received: by mail-wi0-f172.google.com with SMTP id en1so2555644wid.5
        for <linux-iio@vger.kernel.org>; Mon, 06 Jan 2014 01:35:28 -0800 (PST)
Date: Mon, 6 Jan 2014 09:35:25 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mfd: ti_am335x_tscadc: Don't read back REG_SE
Message-ID: <20140106093525.GE23772@lee--X1>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
 <1387466911-3732-4-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1387466911-3732-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Dec 2013, Sebastian Andrzej Siewior wrote:

> The purpose of reg_se_cache has been defeated. It should avoid the
> read-back of the register to avoid the latency and the fact that the
> bits are reset to 0 after the individual conversation took place.
> 
> The reason why this is required like this to work, is that read-back of
> the register removes the bits of the ADC so they do not start another
> conversation after the register is re-written from the TSC side for the
> update.
> To avoid the not required read-back I introduce a "set once" variant which
> does not update the cache mask. After the conversation completes, the
> bit is removed from the SE register anyway and we don't plan a new
> conversation "any time soon". The current set function is renamed to
> set_cache to distinguish the two operations.
> This is a small preparation for a larger sync-rework.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/iio/adc/ti_am335x_adc.c           |  4 ++--
>  drivers/input/touchscreen/ti_am335x_tsc.c |  4 ++--

Just need Dmitry's Ack now.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
