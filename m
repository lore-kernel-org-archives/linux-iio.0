Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58002 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbDJFvt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2015 01:51:49 -0400
In-Reply-To: <5526FE97.8070705@linux.intel.com>
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com> <212b45fac712e84a3cf0bc5955def7d1b683a6bd.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com> <CAEnQRZC=GtB7r=QG7DkDJOFz8bBQ-V+VD-DNkVG50-LubLMr8w@mail.gmail.com> <551C030E.1090309@metafoo.de> <CAEnQRZCsUiH_+GGxqPpLUDHVh_iu6O1QNTH5xdZuKojG11QZFQ@mail.gmail.com> <551C0B95.9080802@metafoo.de> <551C2EC4.1050208@linux.intel.com> <551C2F63.50609@metafoo.de> <551C41C0.2050609@linux.intel.com> <551C4562.9030607@linux.intel.com> <55265195.9080100@kernel.org> <5526FE97.8070705@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v1 2/3] iio: ltr501: Add interrupt rate control support
From: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 10 Apr 2015 06:51:43 +0100
To: sathyanarayanan.kuppuswamy@linux.intel.com,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@gmail.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Message-ID: <C91EC5E4-D042-41EE-94C8-191439F3F552@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 9 April 2015 23:35:03 BST, sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>Comments inline.
>
>On 04/09/2015 03:16 AM, Jonathan Cameron wrote:
>> On 01/04/15 20:22, sathyanarayanan kuppuswamy wrote:
>>>
>>> On 04/01/2015 12:06 PM, sathyanarayanan kuppuswamy wrote:
>>>>
>>>> On 04/01/2015 10:48 AM, Lars-Peter Clausen wrote:
>>>>> On 04/01/2015 07:45 PM, sathyanarayanan kuppuswamy wrote:
>>>>>>
>>>>>> On 04/01/2015 08:15 AM, Lars-Peter Clausen wrote:
>>>>>>> On 04/01/2015 05:02 PM, Daniel Baluta wrote:
>>>>>>>> On Wed, Apr 1, 2015 at 5:39 PM, Lars-Peter Clausen
><lars@metafoo.de> wrote:
>>>>>>>>> On 04/01/2015 04:04 PM, Daniel Baluta wrote:
>>>>>>>>> [...]
>>>>>>>>>>
>>>>>>>>>>> +static const struct iio_chan_spec_ext_info
>ltr501_ext_info[] = {
>>>>>>>>>>> +       {
>>>>>>>>>>> +               .name = "intr_persist",
>>>>>>>>>>> +               .read = ltr501_read_intr_prst,
>>>>>>>>>>> +               .write = ltr501_write_intr_prst,
>>>>>>>>>>> +               .shared = IIO_SHARED_BY_TYPE,
>>>>>>>>>>> +       },
>>>>>>>>>>> +       {},
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>> Would be nice to standardize persistence attribute
>>>>>>>>>> (IIO_CHAN_INFO_PERSISTENCE).
>>>>>>>>>
>>>>>>>>> If I understand the behavior correctly it causes that the
>event needs to be
>>>>>>>>> triggered at least n times before the event is reported by the
>chip. In my
>>>>>>>>> opinion 'persistence' is not a good term for that. I'm not
>sure what a
>>>>>>>>> better term is but I think it should go more in the direction
>of ratelimit
>>>>>>>>> or something.
>>>>>>>> I've seen this term used for many devices:
>>>>>>>>
>>>>>>>> *  TSL25911 ambient light sensor [1]
>>>>>>>>
>>>>>>>> [ One set of thresholds can be configured to trigger an
>interrupt only when
>>>>>>>>    the ambient light exceeds them for a configurable amount of
>time
>>>>>>>> (persistence)
>>>>>>>> ]
>>>>>>>>
>>>>>>>> * TAOS TCS34725 ambient light sensor [2]
>>>>>>>> [
>>>>>>>> The interrupt persistence filter allows the user to define the
>number
>>>>>>>> of consecutive
>>>>>>>>    out-of-threshold events necessary before generating an
>interrupt.
>>>>>>>> ]
>>>>>>>>
>>>>>>>> * Avago SAPDS-9950, Sensortek STK3310
>>>>>>>>
>>>>>>>> I think the TSL25911 datasheet best describes this parameter,
>as the
>>>>>>>> amount of time
>>>>>>>> that ambient light should exceed a threshold until an interrupt
>is
>>>>>>>> generated.
>>>>>>> Ok, that makes more sense. I misunderstood the initial
>description as that
>>>>>>> the signal would have to go first above the threshold then below
>the
>>>>>>> threshold, and this for a number of times. Whereas it needs to
>exceed the
>>>>>>> threshold for a certain amount of time before the event is
>triggered. If
>>>>>>> it goes below the threshold before the persistence interval no
>event is
>>>>>>> triggered and the counter is reset.
>>>>>> Yes, it needs to cross the threshold n number of times before a
>event is
>>>>>> generated.
>>>>> Wait. It needs to cross the threshold or it needs to stay above
>the threshold?
>>>> Following is the logic for this chip.
>>>>
>>>> If ( data > Upper_threshold or data  < Lower_threshold)
>>>>      generate_event()
>>> Missed to add <n> times logic
>>>
>>> If ( data > Upper_threshold or data  < Lower_threshold) {
>>>      increment_count;
>>>      if (count >= n) {
>>>          generate_event()
>>>          reset_count()
>>>      }
>>> }
>>>
>> So level rather than edge triggered.  Definitely what we put _period
>> in for in the first place.  Admittedly persistence might have been a
>better
>> name, but too late now! (dratted ABI compatibility)
>>
>> J
>But we cannot use period for this use case. According to _period ABI 
>description,
>It specifies the period of time for which the condition must be true
>for 
>getting a
>valid event. But here, we are checking for number of times a condition 
>must be
>true for generating a valid event.
But we are checking that condition at a known sampling rate I assume?
Hence 
period = persistence x 1/sampling frequency?

>
>Description:
>            Period of time (in seconds) for which the condition must be
>                 met before an event is generated. If direction is not
>                 specified then this period applies to both directions.
>
>>>>> -- 
>>>>> To unsubscribe from this list: send the line "unsubscribe
>linux-iio" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>
>>

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
