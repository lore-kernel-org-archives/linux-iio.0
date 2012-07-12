Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45771 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab2GLT0x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jul 2012 15:26:53 -0400
Message-ID: <4FFF24F8.8040304@kernel.org>
Date: Thu, 12 Jul 2012 20:26:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: add adjd_s311 I2C digital color sensor driver
References: <1341265402-1617-1-git-send-email-pmeerw@pmeerw.net> <4FF29F85.6050900@metafoo.de>
In-Reply-To: <4FF29F85.6050900@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2012 08:30 AM, Lars-Peter Clausen wrote:
> On 07/02/2012 11:43 PM, Peter Meerwald wrote:
>> sensor has 4 channels (10-bit each, R/G/B and clear), sensitivity
>> and gain is controlled in the driver by ext_info integration_time
>> and CHAN_INFO_HARDWAREGAIN
>>
>> driver supports triggered buffer and IIO_CHAN_INFO_RAW to get the
>> sensor data
>>
>> patch depends on IIO_MOD_LIGHT_RED etc, the patch providing that
>> (http://permalink.gmane.org/gmane.linux.kernel.iio/4354) has not been
>> merged yet, a new proposal is following
>>
>> v4: address comments by Lars-Peter Clausen
>> * make sure trigger handler is exited with iio_trigger_notify_done()
>>   and IRQ_HANDLED
>> * kfree()/kalloc() -> krealloc()
>>
>> v3:
>> * fix warnings
>>
>> v2: address comments by Lars-Peter Clausen
>> * buffer allocation now in update_scan_mode instead of in trigger
>>   handler
>> * simplify trigger code (assume active_scan_mask is not empty, use
>>   for_each_set_bit, use iio_push_to_buffer)
>> * reorder entry in Makefile and Kconfig
>> * fix remove
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> 
> Looks good,
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Sorry Lars-Peter, I'd forgotten you'd done that for this earlier
version so didn't add it to v5 when merging.  Peter, if you make minor
changes people 'normally' don't mind if you carry there acked-by
etc on with it.
