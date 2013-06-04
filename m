Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54973 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab3FDKiM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 06:38:12 -0400
Date: Tue, 4 Jun 2013 12:38:09 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com,
	balbi@ti.com
Subject: Re: [PATCH 1/5] drivers/iio: am335x_adc: cleanup on missing DT
 nodes
Message-ID: <20130604103809.GG1151@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
 <1369847397-27451-2-git-send-email-bigeasy@linutronix.de>
 <51AB8758.5010705@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51AB8758.5010705@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Jonathan Cameron | 2013-06-02 18:56:40 [+0100]:

>On 05/29/2013 06:09 PM, Sebastian Andrzej Siewior wrote:
>> Currently we leak indio_dev() if the DT has no "adc" node in it.
>> 
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>Given you are going to end up rerolling the original series
>(and it hasn't been taken by anyone yet) this wants to go
>in a new version of that not as a separate patch.

Yes, why not.

Sebastian
