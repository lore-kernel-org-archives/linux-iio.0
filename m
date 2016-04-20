Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEnQRZB+wt-cJ9Lz7tWsrPm4_M1=KXbm280xFqhaXNpj9c6y1w@mail.gmail.com>
References: <570CDFD0.7060702@intel.com> <alpine.DEB.2.02.1604121404050.4383@pmeerw.net>
 <CAEnQRZB+wt-cJ9Lz7tWsrPm4_M1=KXbm280xFqhaXNpj9c6y1w@mail.gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 19 Apr 2016 20:16:24 -0700
Message-ID: <CAKzfze-CsKBN9L2TbSirWR4Hau1Kfwj7dscwqj8hj9QBZ=W+5w@mail.gmail.com>
Subject: Re: IIO driver for si114x
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Crestez Dan Leonard <leonard.crestez@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 19, 2016 at 5:42 AM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> Hi Peter, Matt,
>
> On Tue, Apr 12, 2016 at 3:06 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
>> Hello,
>>
>>> I want to add support for a si1145 light sensor. Some brief googling finds a
>>> bunch of old (2012) patches for an si114x driver in drivers/iio/light. Here's
>>> the link to the old thread:
>>>
>>> http://comments.gmane.org/gmane.linux.kernel.iio/5478
>
> Best option for us here is to send patches based on Peter proposal.
>
>>
>> I have updated sources, not yet posted
>> Matt Ranostay also indicated that he'd be willing to work on the device
>
> Matt did you already have some work on this?
>>
Nope. But I probably can do some Tested-By if I dig out this sensor.

>>> I'm willing to do the work to get support for this in upstream. I guess the
>>> best way to do that would be to apply the most recent source I can find to my
>>> local tree, test it on my device and repost on the list for review, right? I
>>> can't find anything newer than 2012 though.
>>
>> the si114x is a rather complicated device with many controls, for example
>> the output current of the LEDs
>>
>> I think this issue also surfaced for another proximity driver recently...
