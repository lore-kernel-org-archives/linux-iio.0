Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5608F375.6030808@lysator.liu.se>
References: <1443018383-16578-1-git-send-email-peda@lysator.liu.se>
	<1443018383-16578-3-git-send-email-peda@lysator.liu.se>
	<56081053.2080209@kernel.org>
	<5608F375.6030808@lysator.liu.se>
Date: Mon, 28 Sep 2015 11:11:09 +0300
Message-ID: <CAEnQRZD-xAAWWD7De6KfNWA6OTCxX3t1Pw2Mv5HozPehvUCWnw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: mcp4531: Driver for Microchip digital potentiometers
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Sep 28, 2015 at 10:59 AM, Peter Rosin <peda@lysator.liu.se> wrote:
> On 2015-09-27 17:50, Jonathan Cameron wrote:
>> On 23/09/15 15:26, Peter Rosin wrote:
>>> From: Peter Rosin <peda@axentia.se>
>>>
>>> Add support for Microchip digital potentiometers and rheostats
>>>      MCP4531, MCP4532, MCP4551, MCP4552
>>>      MCP4631, MCP4632, MCP4651, MCP4652
>>>
>>> DEVICE   Wipers  Steps  Resistor Opts (kOhm)  i2c address
>>> MCP4531  1       129    5, 10, 50, 100        010111x
>>> MCP4532  1       129    5, 10, 50, 100        01011xx
>>> MCP4551  1       257    5, 10, 50, 100        010111x
>>> MCP4552  1       257    5, 10, 50, 100        01011xx
>>> MCP4631  2       129    5, 10, 50, 100        0101xxx
>>> MCP4632  2       129    5, 10, 50, 100        01011xx
>>> MCP4651  2       257    5, 10, 50, 100        0101xxx
>>> MCP4652  2       257    5, 10, 50, 100        01011xx
>>>
>>> Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22096b.pdf
>> Applied to the togreg branch of iio.git - initially pushed out as
>> testing for the autobuilders to play with it.
>>
>> If anyone wants to add reviewed-by / acked-by then as I'll be
>> rebasing sometime in next few days anyway there is still time!
>
> Great, thanks,
>
> but I don't see this where I expected it[1]. So, the question is if I'm
> too impatient, if am I looking in the wrong place or if you perhaps forgot
> to actually push it out? Or if something went totally wrong and the patches
> got lost...

Make sure you look for the testing branch. Also, do not worry about this.

Sometimes, Jonathan  pushes the patches locally to his setup and later
syncs with the remote repo.
