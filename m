Return-Path: <lars@metafoo.de>
Message-ID: <4EAE9141.60506@metafoo.de>
Date: Mon, 31 Oct 2011 13:14:57 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
 Drivers <Drivers@analog.com>
Subject: Re: [PATCH v2 3/3] staging:iio:dac: Add AD5421 driver
References: <1319705074-3082-1-git-send-email-lars@metafoo.de> <1319705074-3082-3-git-send-email-lars@metafoo.de> <4EAE8660.2020604@cam.ac.uk>
In-Reply-To: <4EAE8660.2020604@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/31/2011 12:28 PM, Jonathan Cameron wrote:
> On 10/27/11 09:44, Lars-Peter Clausen wrote:
>> This patch adds support for the Analog Devices AD5421 Loop-Powered, 4mA to 20mA
>> DAC.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Feel free to send on to Greg as you've nailed everything I cared about.
> 
> I do wonder if we might be better with an explicit 'no_read' flag in the
> chan_spec for channels like this. That way we could assign more meaningful
> channel numbers?  Afterall, sooner of later we are going to have something
> with two temperature sensors that only generate events.
> 
> What do you think?

Makes sense, but I think we can add this when we have to add support for
such a device.

An alternative would be to make devices explicitly request raw attributes
through info_mask. But that would require touching all existing drivers again.

Could you also Ack "staging:iio: IIO_EVENT_CODE: Clamp channel numbers"?
I'll replace the s16 with __s16 before sending it on to Greg.


Thanks
- Lars
