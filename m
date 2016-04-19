Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <alpine.DEB.2.02.1604121404050.4383@pmeerw.net>
References: <570CDFD0.7060702@intel.com>
	<alpine.DEB.2.02.1604121404050.4383@pmeerw.net>
Date: Tue, 19 Apr 2016 15:42:32 +0300
Message-ID: <CAEnQRZB+wt-cJ9Lz7tWsrPm4_M1=KXbm280xFqhaXNpj9c6y1w@mail.gmail.com>
Subject: Re: IIO driver for si114x
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>, Matt Ranostaj <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Peter, Matt,

On Tue, Apr 12, 2016 at 3:06 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
> Hello,
>
>> I want to add support for a si1145 light sensor. Some brief googling finds a
>> bunch of old (2012) patches for an si114x driver in drivers/iio/light. Here's
>> the link to the old thread:
>>
>> http://comments.gmane.org/gmane.linux.kernel.iio/5478

Best option for us here is to send patches based on Peter proposal.

>
> I have updated sources, not yet posted
> Matt Ranostay also indicated that he'd be willing to work on the device

Matt did you already have some work on this?
>
>> I'm willing to do the work to get support for this in upstream. I guess the
>> best way to do that would be to apply the most recent source I can find to my
>> local tree, test it on my device and repost on the list for review, right? I
>> can't find anything newer than 2012 though.
>
> the si114x is a rather complicated device with many controls, for example
> the output current of the LEDs
>
> I think this issue also surfaced for another proximity driver recently...
