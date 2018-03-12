Return-Path: <SRS0=IJUW=GC=axentia.se=peda@kernel.org>
Subject: Re: [PATCH 2/2] iio: potentiometer: mcp4018: driver for Microchip
 digital potentiometers
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20180308195830.16348-1-peda@axentia.se>
 <20180308195830.16348-3-peda@axentia.se> <20180310161511.66d2ef97@archlinux>
From: Peter Rosin <peda@axentia.se>
Message-ID: <89822e7a-569a-43b9-46bd-d9b65b895cab@axentia.se>
Date: Mon, 12 Mar 2018 15:32:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180310161511.66d2ef97@archlinux>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 2018-03-10 17:15, Jonathan Cameron wrote:
> On Thu,  8 Mar 2018 20:58:30 +0100
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Add support for Microchip digital potentiometers and rheostats
>> 	MCP4017, MCP4018, MCP4019
>>
>> They all have one wiper with 128 steps and come in 5, 10, 50 and 100 kOhm
>> variations.
>>
>> Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22147a.pdf
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> Nice little driver.
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Thanks, and thanks for taking it quickly before the bike-shedding got
started. I worried a bit about that, when the driver is so small and
trivial... :-)

Cheers,
Peter
