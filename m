Return-Path: <mporter@konsulko.com>
Date: Tue, 4 Aug 2015 13:34:17 -0400
From: Matt Porter <mporter@konsulko.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Linux IIO List <linux-iio@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] MAX6675 IIO temperature driver
Message-ID: <20150804173417.GN15004@beef>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
 <897A4C3B-DF7E-4AEE-A117-00CCB510F4DD@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <897A4C3B-DF7E-4AEE-A117-00CCB510F4DD@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 04, 2015 at 05:52:17PM +0100, Jonathan Cameron wrote:
> 
> 
> On 3 August 2015 21:56:47 BST, Matt Porter <mporter@konsulko.com> wrote:
> >This series adds a driver for the MAX6675 SPI thermocouple converter.
> >The device supports temperature measurements via type-K thermocouples
> >and implements cold-junction compensation within the part. The
> >datasheet
> >can be found at http://datasheets.maximintegrated.com/en/ds/MAX6675.pdf
> For a device like this where perhaps it's position wrt iio/hwmon boundary is unclear
> I want to see an argument for why IIO makes more sense in the cover letter + cc
>  at least the hwmon MAINTAINERS if not the list...

Will do. Just to summarize here, the typical use case for this type of
thermocouple converter involves sample rates that are relatively high
compared to what the hwmon interface can support. The upcoming hrtimer
trigger will match up well with this to support fine-grained
periodic samples. I'll add this in the v2 cover latter.

-Matt

> >Matt Porter (3):
> >  iio: temperature: add max6675 dt binding
> >  iio: temperature: add max6675 thermocouple converter driver
> >  MAINTAINERS: add max6675 driver
> >
> > .../bindings/iio/temperature/max6675.txt           |  19 +++
> > MAINTAINERS                                        |   7 +
> > drivers/iio/temperature/Kconfig                    |  11 ++
> > drivers/iio/temperature/Makefile                   |   1 +
> >drivers/iio/temperature/max6675.c                  | 155
> >+++++++++++++++++++++
> > 5 files changed, 193 insertions(+)
> >create mode 100644
> >Documentation/devicetree/bindings/iio/temperature/max6675.txt
> > create mode 100644 drivers/iio/temperature/max6675.c
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
