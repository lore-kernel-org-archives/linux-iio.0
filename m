Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57167 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966130Ab3E2Ob1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 May 2013 10:31:27 -0400
Message-ID: <51A61137.7060408@linutronix.de>
Date: Wed, 29 May 2013 16:31:19 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 19/19 v2] mfd/ti_am335x_tscadc: add private lock/unlock
 function for regmap read/write
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-20-git-send-email-bigeasy@linutronix.de> <20130529084642.GA18273@linutronix.de> <20130529111253.GR3660@sirena.org.uk> <51A5E5B3.80201@metafoo.de>
In-Reply-To: <51A5E5B3.80201@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/29/2013 01:25 PM, Lars-Peter Clausen wrote:
>> This is not a good place to make this change, there's nothing specific
>> to the device here and in actual fact there's already a change in the
>> works from Lars-Peter Clausen converting the spinlock to always use
>> spin_lock_irqsave() so it should be resolved soon.  The thread was on
>> lkml in the past few days.
> 
> Yes, this patch shouldn't be necessary in next/master anymore. For the
> record the patch can be found here: https://patchwork.kernel.org/patch/2609721/

Ah good good good. So this one can dropped. Thank you.

> - Lars

Sebastian
