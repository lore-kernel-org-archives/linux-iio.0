Return-Path: <lars@metafoo.de>
Message-ID: <4F363F37.4010508@metafoo.de>
Date: Sat, 11 Feb 2012 11:13:11 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/4] staging:iio: Add missing event code extract macros
References: <1328897701-24032-1-git-send-email-lars@metafoo.de> <1328897701-24032-3-git-send-email-lars@metafoo.de> <20120210204531.GI4141@mwanda> <20120210204740.GA13116@mwanda>
In-Reply-To: <20120210204740.GA13116@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/10/2012 09:47 PM, Dan Carpenter wrote:
> On Fri, Feb 10, 2012 at 11:45:31PM +0300, Dan Carpenter wrote:
>> On Fri, Feb 10, 2012 at 07:15:00PM +0100, Lars-Peter Clausen wrote:
>>> Add macros for extracting whether the event is for a differential channel and
>>> the second channel number from the event code. These were the only two fields
>>> which did not have such an macro yet.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>>> ---
>>>  drivers/staging/iio/events.h |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
>>> index 416800e..c25f0e3 100644
>>> --- a/drivers/staging/iio/events.h
>>> +++ b/drivers/staging/iio/events.h
>>> @@ -97,7 +97,9 @@ enum iio_event_direction {
>>>  /* Event code number extraction depends on which type of event we have.
>>>   * Perhaps review this function in the future*/
>>>  #define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
>>> +#define IIO_EVENT_CODE_EXTRACT_CHAN2(mask) ((__s16)(((mask) >> 16) & 0xFFFF))
>>>  
>>>  #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
>>> +#define IIO_EVENT_CODE_EXTRACT_DIFF(mask) (((mask) >> 55) & 0x1)
>>>  
>>
>> Breaks the build.
>>
> 
> Oops.  This isn't a rename.  It doesn't break the build.  Why are
> we adding macros which nobody uses?

Patch 4 in this series adds a user.
