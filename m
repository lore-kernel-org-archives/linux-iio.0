Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-229.synserver.de ([212.40.185.229]:1245 "EHLO
	smtp-out-190.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751528AbbJDR1b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 13:27:31 -0400
Message-ID: <56116180.1010303@metafoo.de>
Date: Sun, 04 Oct 2015 19:27:28 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: Add a DMAengine framework based buffer
References: <1443797107-13391-1-git-send-email-lars@metafoo.de> <1443797107-13391-8-git-send-email-lars@metafoo.de> <56114EDA.70505@kernel.org>
In-Reply-To: <56114EDA.70505@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/2015 06:07 PM, Jonathan Cameron wrote:
> On 02/10/15 15:45, Lars-Peter Clausen wrote:
>> Add a generic fully device independent DMA buffer implementation that uses
>> the DMAegnine framework to perform the DMA transfers. This can be used by
>> converter drivers that whish to provide a DMA buffer for converters that
>> are connected to a DMA core that implements the DMAengine API.
>>
>> Apart from allocating the buffer using iio_dmaengine_buffer_alloc() and
>> freeing it using iio_dmaengine_buffer_free() no additional converter driver
>> specific code is required when using this DMA buffer implementation.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Clearly you have a FIXME in the code. Is this something we want to wait
> for or is the race short enough we can ignore it for now?


Yeah, that's a problem with the DMAengine API in general. All users, e.g.
ALSA, V4L, suffer from this problem. It needs to be fixed but it's not
critical. The race can happen, but it is really hard to trigger and also
depends a bit on the DMAengine driver implementation. I've not yet seen it
in the wild.

The note is a reminder to fix this once the proper API becomes available


>> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
>> new file mode 100644
>> index 0000000..ac0ca55
>> --- /dev/null
>> +++ b/include/linux/iio/buffer-dmaengine.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + * Copyright 2014-2015 Analog Devices Inc.
>> + *  Author: Lars-Peter Clausen <lars@metafoo.de>
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +
>> +#ifndef __IIO_DMAENGINE_H__
>> +#define __IIO_DMAENGINE_H__
>> +
>> +struct iio_buffer;
>> +struct devive;
> That seems unlikely to be right :)
> device?

Yes
