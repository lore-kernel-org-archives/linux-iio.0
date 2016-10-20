Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/4] IIO wrapper drivers, dpot-dac and envelope-detector
Date: Thu, 20 Oct 2016 11:25:58 +0200
Message-ID: <1476955562-13673-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi!

These two drivers share the fact that they wrap another iio channel,
and I use the first in combination with the second, which is why I'm
submitting them as a pair.

The first driver is a simple wrapper converting an iio dpot into an
iio dac. It only changes the unit and scale. It also does not add any
fancy iio buffer support that I don't need. I suppose that can be
added. By someone else :-)

Please look over the scale conversion, notably for the fractional log2
case that I don't need myself, so is untested. Maybe I should just
remove it?

Also, is there some agreed-upon way to dig out the maximum value from
an iio channel? If so, "dpot-dac,max-ohms" can be eliminated from the
dt bindings, which would have been nice...

I'm also wondering if I'm somehow abusing the regulator? I only added
it to get rid of a "dpot-dac,max-voltage" thing from the dt bindings.
It feels right though, but maybe I should do more with it than check
its voltage? What?

The second driver (the envelope detector) is more involved. It also
explains why I need the dpot-dac driver. I wanted the envelope
detector to be generic and work with any dac, but I had a dpot...

The envelope detector was previously discussed late last year [1],
and this is what I came up with instead of that mess.

There are a couple of things to be said about the envelope detector,
one question is where it should live? I placed it in the adc directory,
but maybe it deserves an iio directory of its own? I'm also a bit
worried that the name is a wee bit too generic. But what is a good
name? I don't want it to be too long like dac-comp-envelope-detector
and something like dac-comp-env-det is just unreadable. Naming is
difficult... And suggestions?

Another thing is that I'm not 100% satisfied with the fact that you
have to decide at instantiation if you are going to invert the search
or not (search from below). But in order for that to be selectable
at runtime with a channel attribute of some sort, I need to be able
to rebind the interrupt to the other edge and I want to do that
without releasing the irq and grabbing it again (someone might
otherwise steal the irq, making the driver lose the irq all together).
I don't see any API to change the irq trigger condition. Is there
such a thing?

Anyway, despite all the above questions and remarks, this works for
me. Please consider applying.

Cheers,
Peter

[1] http://www.gossamer-threads.com/lists/linux/kernel/2320755

Peter Rosin (4):
  dt-bindings: iio: document dpot-dac bindings
  iio: dpot-dac: DAC driver based on a digital potentiometer
  dt-bindings: iio: document envelope-detector bindings
  iio: envelope-detector: ADC driver based on a DAC and a comparator

 .../bindings/iio/adc/envelope-detector.txt         |  65 +++++
 .../devicetree/bindings/iio/dac/dpot-dac.txt       |  43 +++
 MAINTAINERS                                        |  14 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/envelope-detector.c                | 305 +++++++++++++++++++++
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/dpot-dac.c                         | 219 +++++++++++++++
 9 files changed, 668 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
 create mode 100644 drivers/iio/adc/envelope-detector.c
 create mode 100644 drivers/iio/dac/dpot-dac.c

-- 
2.1.4
