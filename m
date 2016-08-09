Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:58658 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165AbcHIJ6V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 9 Aug 2016 05:58:21 -0400
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: Protect FIFO1 from
 concurrent access
To: Matt Ranostay <mranostay@gmail.com>
References: <20160808110501.29586-1-vigneshr@ti.com>
 <20160808110501.29586-2-vigneshr@ti.com>
 <CAKzfze92jp-O1Zy_9gpFTjPdE4Oq_Tt26dAe7854jD30oAEKvg@mail.gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lee Jones <lee.jones@linaro.org>,
	"Andrew F . Davis" <afd@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux OMAP List <linux-omap@vger.kernel.org>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <a2b89956-5a1a-d311-8f5c-84ce2378c2e9@ti.com>
Date: Tue, 9 Aug 2016 15:27:49 +0530
MIME-Version: 1.0
In-Reply-To: <CAKzfze92jp-O1Zy_9gpFTjPdE4Oq_Tt26dAe7854jD30oAEKvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Tuesday 09 August 2016 03:21 PM, Matt Ranostay wrote:
> On Mon, Aug 8, 2016 at 4:05 AM, Vignesh R <vigneshr@ti.com> wrote:
>> It is possible that two or more ADC channels can be simultaneously
>> requested for raw samples, in which case there can be race in access to
>> FIFO data resulting in loss of samples.
>> If am335x_tsc_se_set_once() is called again from tiadc_read_raw(), when
>> ADC is still acquired to sample one of the channels, the second process
>> might be put into uninterruptible sleep state. Fix these issues, by
>> protecting FIFO access and channel configurations with a mutex. Since
>> tiadc_read_raw() might take anywhere between few microseconds to few
>> milliseconds to finish execution (depending on averaging and delay
>> values supplied via DT), its better to use mutex instead of spinlock.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/iio/adc/ti_am335x_adc.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index 8a368756881b..bed9977a1863 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -32,6 +32,7 @@
>>
>>  struct tiadc_device {
>>         struct ti_tscadc_dev *mfd_tscadc;
>> +       struct mutex fifo1_lock; /* to protect fifo access */
> 
> Are there more than one FIFOs, or even possible? Just wondering the
> number indexing here..

ADC IP as such as two FIFOs: FIFO0 and FIFO1. FIFO0 is dedicated for
touchscreen channels and FIFO1 is used for ADC channels. Its not
possible to use FIFO0 for ADC, but to match h/w register naming, I used
above name for mutex.

-- 
Regards
Vignesh
