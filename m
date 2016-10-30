Return-Path: <peda@axentia.se>
Subject: Re: [PATCH v3 6/8] iio: dpot-dac: DAC driver based on a digital
 potentiometer
To: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1477262381-7800-1-git-send-email-peda@axentia.se>
 <1477262381-7800-7-git-send-email-peda@axentia.se>
 <301ab064-cd90-d99d-a05a-8a50ba759c62@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <765d8fd2-4753-d3c7-32e0-e6cec9b9002d@axentia.se>
Date: Sun, 30 Oct 2016 15:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <301ab064-cd90-d99d-a05a-8a50ba759c62@kernel.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-10-30 14:33, Jonathan Cameron wrote:
> On 23/10/16 23:39, Peter Rosin wrote:
>> It is assumed that the dpot is used as a voltage divider between the
>> current dpot wiper setting and the maximum resistance of the dpot. The
>> divided voltage is provided by a vref regulator.
>>
>>                   .------.
>>    .-----------.  |      |
>>    | vref      |--'    .---.
>>    | regulator |--.    |   |
>>    '-----------'  |    | d |
>>                   |    | p |
>>                   |    | o |  wiper
>>                   |    | t |<---------+
>>                   |    |   |
>>                   |    '---'       dac output voltage
>>                   |      |
>>                   '------+------------+
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> Only a trivial suggestion to drop the devinfo about max ohms now it's
> exposed (effectively) via the dpot driver. (really minor though so don't bother
> respinning for that!)

*snip*

Right, I'm making that change locally so that it's not forgotten, and
feel free to squash that dropped line before pushing it out if you like,
in case there's no respin...

Cheers,
Peter
