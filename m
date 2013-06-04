Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54940 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3FDK2p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 06:28:45 -0400
Date: Tue, 4 Jun 2013 12:28:44 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 17/19] mfd / iio: ti_am335x_adc: rename device from
 tiadc to TI-adc
Message-ID: <20130604102844.GF1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-18-git-send-email-bigeasy@linutronix.de>
 <51AB85DB.2000305@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51AB85DB.2000305@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:50:19 [+0100]:

>On 05/27/2013 08:12 PM, Sebastian Andrzej Siewior wrote:
>> TI-adc reads a little better compared to tiadc.
>> While here add an alias so the driver is loaded on demand.
>> 
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>Acked-by: Jonathan Cameron <jic23@kernel.org>
>
>but you'll be wanting a few more acks on a name change...

It is a name change of a driver in tree (two to be exact) which can not
be used as of now and has no users. I can't imagine why someone should
complain.

Thanks for the review.

Sebatian
