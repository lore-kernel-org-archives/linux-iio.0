Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57081 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab3FDR3W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 13:29:22 -0400
Date: Tue, 4 Jun 2013 19:29:20 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>, Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/19] mfd / input: ti_am335x_tsc: rename device from
 tsc to TI-tsc
Message-ID: <20130604172920.GA15142@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-17-git-send-email-bigeasy@linutronix.de>
 <20130604165035.GE26400@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130604165035.GE26400@core.coreip.homeip.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Dmitry Torokhov | 2013-06-04 09:50:35 [-0700]:

>> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
>> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
>> @@ -543,11 +543,12 @@ static struct platform_driver ti_tsc_driver = {
>>  	.probe	= titsc_probe,
>>  	.remove	= titsc_remove,
>>  	.driver	= {
>> -		.name   = "tsc",
>> +		.name   = "TI-tsc",
>
>Still quite generic... Why not call it "TI-am335x-tsc"?
TI-am335x-tsc it is. In that case I make a similar change to adc node.

>Thanks.

Sebastian
