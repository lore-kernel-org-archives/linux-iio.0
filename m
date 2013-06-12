Return-Path: <bigeasy@linutronix.de>
Message-ID: <51B8370D.1090102@linutronix.de>
Date: Wed, 12 Jun 2013 10:53:33 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio/kern: consider the case where channel number > number
 of channels
References: <1370878955-31880-1-git-send-email-bigeasy@linutronix.de> <51B7809A.1030804@kernel.org> <20130611204416.GA13883@roeck-us.net> <51B791D1.9020105@metafoo.de>
In-Reply-To: <51B791D1.9020105@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/11/2013 11:08 PM, Lars-Peter Clausen wrote:
>>> This doesn't work in general.  The index is not the same as channel
>>> (or any other form of index present). Note that modified channels may
>>> all have channel set to 0  (accel_x, accel_y etc for instance).
>>>
>>> The index refers directly into those channels registered.
>>> Is it possible for channels to move at runtime between the two units?
>>> I would imagine not as this is very much a case of wiring.
>>>
>>> Thus we have a fairly messy bit if interdependence in the device
>>> tree but it should work.
>>>
>>> I don't actually have much / any real experience of device tree configurations
>>> and this is Guenter's code, hence I have cc'd him.
>>>
>>> Note that it is acceptable and relatively common to have missing
>>> values in scan_index but that isn't really relevant here.
>>>
>>> Jonathan
>>
>> Too long ago since I looked into that, but this code changes the API
>> from "get nth channel" to "channel with channel index n".
>> Not really sure I understand why that should be necessary.
>>
> 
> yea, this will definitively not work channels of different types will
> usually have the same channel numbers.

I see. I've been looking at the Documentation. It says "IIO specifier"
for the second argument. Now I assumed it is referred to the channel
number and not the order of channel registration. The "read" requests
(in the drivers I checked) checked the channel's number in order to
associate the request with the wire. I see now some use the "address"
field.
So it kind of looked like a bug where one did not assume that the
channel number could start at != 0. It is either the documentation or
me reading it. I guess it is the latter. Anyway, if this is the
intention of the parameter, just drop the patch and everything is fine
:)

Sebastian
