Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-220.synserver.de ([212.40.185.220]:1058 "EHLO
	smtp-out-220.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965445Ab3E2LZz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 May 2013 07:25:55 -0400
Message-ID: <51A5E5B3.80201@metafoo.de>
Date: Wed, 29 May 2013 13:25:39 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 19/19 v2] mfd/ti_am335x_tscadc: add private lock/unlock
 function for regmap read/write
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-20-git-send-email-bigeasy@linutronix.de> <20130529084642.GA18273@linutronix.de> <20130529111253.GR3660@sirena.org.uk>
In-Reply-To: <20130529111253.GR3660@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/29/2013 01:12 PM, Mark Brown wrote:
> On Wed, May 29, 2013 at 10:46:42AM +0200, Sebastian Andrzej Siewior wrote:
>> Without this, devm_regmap_init_mmio() creates & uses a simple
>> spin_lock() and this should be enough. Within the probe function the
>> registers are read and written in process context. Later they are
>> accessed from the ISR and lockdep complains because now the lock is
>> taken suddenly with IRQs enabled. Currently I don't see any other way to
>> keep lockdep quiet than doing this.
> 
> This is not a good place to make this change, there's nothing specific
> to the device here and in actual fact there's already a change in the
> works from Lars-Peter Clausen converting the spinlock to always use
> spin_lock_irqsave() so it should be resolved soon.  The thread was on
> lkml in the past few days.

Yes, this patch shouldn't be necessary in next/master anymore. For the
record the patch can be found here: https://patchwork.kernel.org/patch/2609721/

- Lars
