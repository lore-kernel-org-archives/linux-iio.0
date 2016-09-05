Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:7245 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965564AbcIHJut (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Sep 2016 05:50:49 -0400
From: Vaishali Thakkar <vaishali.thakkar@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Pavel Andrianov <andrianov@ispras.ru>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ldv-project@linuxtesting.org>
References: <8ad6537e-718a-4c5d-4f51-958e585b3727@ispras.ru> <bdc8ff42-d4a2-8701-45de-4c8ab6657571@kernel.org>
In-Reply-To: <bdc8ff42-d4a2-8701-45de-4c8ab6657571@kernel.org>
Subject: Re: A potential race in drivers/iio/adc/vf610_adc.ko
Date: Mon, 5 Sep 2016 00:49:22 -0600
Message-ID: <57CD1572.4040004@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Saturday 03 September 2016 08:53 PM, Jonathan Cameron wrote:
> On 02/09/16 09:05, Pavel Andrianov wrote:
>>
> 
>> Hi!
> Hi Pavel,
>>
>> There is a potential race in drivers/iio/adc/vf610_adc.ko. Handlers
>> vf610_set_conversion_mode and vf610_write_raw are called via
>> device_attibute interface, but they are related to different
>> attributes, so may be executed in parallel. vf610_set_conversion_mode
>> acquires the mutex indio_dev->mlock, and vf610_write_raw does not.
>> Thus updating the structure 'info' may be performed simultaneously.
>>
>> Should vf610_write_raw also acquire the same mutex indio_dev->mlock?
>>
> 
> As Alison observed, mlock is not a general purpose lock for use by
> drivers. It's there to prevent state changes between direct reads
> (polled) and buffered/triggered reads (pushed).
> 
> The write raw simply sets the sampling frequency. That's not a problem
> whilst buffered capture is running or otherwise.  Interesting question
> of whether changing mode causes any trouble as well.  It's possible 
> something is undefined in the hardware during a mode change...
> 
> Anyhow, that covers mlock.  Next question: Is there a race condition in
> general?
> 
> Yes there definitely is as we have read modify write cycles
> on VF610_REG_ADC_CFG in both paths.  So what is needed is a local lock
> to protect these accesses.  Whilst in theory mlock could be used
> it should not be as it has a clearly stated purpose and using it
> for other purposes makes for much fiddlier and harder to read code!

Makes sense. What would be the best solution in this case? Should we
just introduce local lock for this module and use it for both or there
is anything we need to take care of while we have mlock for one?

> (as an aside IIRC there is no locking in sysfs attributes to prevent
> a single attribute being read twice at the same time.)
> 
> Jonathan
> 

-- 
Vaishali
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

