Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54822 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3FDKMH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 06:12:07 -0400
Date: Tue, 4 Jun 2013 12:12:02 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>, "Patil, Rachna" <rachna@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 07/19] iio: adc: am335x: Add DT support
Message-ID: <20130604101202.GA1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-8-git-send-email-bigeasy@linutronix.de>
 <51AB79CE.2000001@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51AB79CE.2000001@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Jonathan Cameron | 2013-06-02 17:58:54 [+0100]:

>On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
>> From: "Patil, Rachna" <rachna@ti.com>
>> 
>> Add DT support for client ADC driver.
>> 
>> [ panto@antoniou-consulting.com : use of_get_child_by_name
>> 	instead of of_find_node_by_name ]
>> 
>> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>> Signed-off-by: Patil, Rachna <rachna@ti.com>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> [bigeasy: shift the code to the left]
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>Acked-by: Jonathan Cameron <jic23@kernel.org>
>
>I would take this directly but then I'd imagine that will cause havoc
>when the later patches are applied and touch both iio and mfd.

Yeah, I have no idea what to do here since it would be best to grab the
series in one go. The fact that I hear nothing from input/mfd does not
make it easier :)

Sebastian
