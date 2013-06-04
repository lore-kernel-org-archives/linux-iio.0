Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54906 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab3FDKYS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 06:24:18 -0400
Date: Tue, 4 Jun 2013 12:24:17 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 14/19] Documentation/DT bindings: add info for TI TSC
 ADC
Message-ID: <20130604102417.GD1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-15-git-send-email-bigeasy@linutronix.de>
 <51AB8568.9050104@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51AB8568.9050104@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:48:24 [+0100]:

>On 05/27/2013 08:12 PM, Sebastian Andrzej Siewior wrote:
>> The platform data structs are killed here because there are no users in
>> tree (nobody sets the structs up, the RO usage is beeing removed) and the
>> documentation about the parameters is saved here.
>The platform data removal has nothing to do with the rest of the patch.
>Please review the whole series to cleanup the patch divisions.

Well, I removed the platform data and moved the documentation .dts but
okay, I will add this along with the DT part.

Sebastian
