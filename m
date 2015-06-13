Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <557BEB9D.2000800@gmx.de>
References: <cover.1433721755.git.knaack.h@gmx.de>
	<52e7c9b1da4e0918722cc993bd3b25287f342e55.1433721755.git.knaack.h@gmx.de>
	<CAEnQRZALJLbyQ9e5_JVr5xi+kH+pEGfPDGisay+C=b0n9XJM8A@mail.gmail.com>
	<557BEB9D.2000800@gmx.de>
Date: Sat, 13 Jun 2015 11:46:04 +0300
Message-ID: <CAEnQRZBd-1YdFSkG9=3Zhh8K07VWte+2aEDL4ucDOjwtvjR_0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tools:iio:iio_event_monitor: check if event is
 fully read
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 13, 2015 at 11:36 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Daniel Baluta schrieb am 10.06.2015 um 22:16:
>> On Wed, Jun 10, 2015 at 10:51 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>> Check that the read event is of the expected size.
>>>
>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>> ---
>>>  tools/iio/iio_event_monitor.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>>> index 016760e..2559fba 100644
>>> --- a/tools/iio/iio_event_monitor.c
>>> +++ b/tools/iio/iio_event_monitor.c
>>> @@ -299,6 +299,12 @@ int main(int argc, char **argv)
>>>                         }
>>>                 }
>>>
>>> +               if (ret != sizeof(event)) {
>>> +                       printf("Reading event failed!\n");
>>> +                       ret = -EIO;
>>> +                       break;
>>> +               }
>>> +
>>
>> For a test program this should be good enough, not sure if it does make sense
>> to read until we get all data.
>
> Not sure, if I get your intention here. But as Jonathan suggested, something
> went seriously wrong, if the sizes don't match here. Reading further, until
> the desired size is reached could result in receiving the missing data, or
> getting already partial data from the next event. I would leave it as is for
> now and see if anyone ever gets this error. Then we can still dig deeper.

Ok.

>
>>
>> Also, we should print the error at stderr.
>>
>
> I basically agree on this one, but since the majority of the error messages
> in this file are currently just printed to stdout, I would prefer to take it
> as is (for consistency) and have a follow-up patch to send all error messages
> to stderr.

I've also noticed this. So I agree with you, a follow up patch would be better.

Cristina can do this, if you haven't already started working on it.

As a part of Outreachy Program [1] we are also investigating these user space
tools plus the IIO dummy driver which hopefully at the end it will be moved
out of staging.


Daniel.

[1] http://kernelnewbies.org/OutreachyIntro
