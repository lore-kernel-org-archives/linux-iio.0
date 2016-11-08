Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0118.outbound.protection.outlook.com ([104.47.2.118]:12809
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932398AbcKHMP6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 07:15:58 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/8] IIO wrapper drivers, dpot-dac and envelope-detector
Date: Tue, 8 Nov 2016 12:58:50 +0100
Message-ID: <1478606339-31253-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

This is a respin with a handful of nitpicks fixed from v3. No major
changes. And a couple of acks was added too, thanks! I also added
Thomas Gleixner as Cc, since Jonathan was hoping for some comments
on the somewhat odd interrupt handling in patch 8/8 (but perhaps
plumbers-week isn't the best week to hope for that).


These two drivers share the fact that they wrap another iio channel,
and I use the first in combination with the second, which is why I'm
submitting them as a pair.

The first driver is a simple wrapper converting an iio dpot into an
iio dac. It only changes the unit and scale. It also does not add any
fancy iio buffer support that I don't need. I suppose that can be
added. By someone else :-)

The second driver (the envelope detector) is more involved. It also
explains why I need the dpot-dac driver. I wanted the envelope
detector to be generic and work with any dac, but I had a dpot...

But before those two new drivers, there is some infrastructure added
to provide available values for a channel.

One thing I still don't like is that the irq needs to be changed for cases
where it is only ever interesting with the 'invert' variant, and it may not
work to set up the irq the wrong way first. For the TSE-850, this does not
matter, since we have a mux on the envelope detector input and can make use
of both 'invert' and 'normal' for different signals (we could have gotten
by with only 'invert' since the only signals we are measuring that are
'normal' are also DC signals and can thus be detected both from below and
from above), but it is nice to have it both ways. The only way out of this
is a devicetree thing. I suppose it will have to be added by whomever needs
it whenever that is...

I also wonder if the "new" *_available ABI should perhaps be documented
for all variants directly in sysfs-bus-iio instead of doing it in a driver
specific maner that I did? But that can be fixed later by someone more
capable than me :-)

v3 -> v4
- gained acks from Rob for the three bindings patches
- gained ack from Daniel for the core _available patch (1/8)
- dropped the type argument from iio_read_avail_channel_raw(), since
  raw values are assumed to be of type IIO_VAL_INT anyway
- add some more words about what iio_read_avail_channel_raw() does
- rebased onto v4.9-rc4

dpot-dac:
- adjust to changed signature of iio_read_avail_channel_raw()
- one instance of s/the channels supports/the channel supports/
- drop surplus s64 cast in dpot_dac_channel_max_ohms()

envelope-detector
- the envelope-detector module is called envelope-detector


v2 -> v3
- add some missing @foo comments in iio.h in the initial forward ported patch
- killed some buffer overflow problems in the initial forward ported patch
- add inkern.c helpers for the new available attributes to avoid viral
  boilerplating in the future (also add support for finding max of
  IIO_AVAIL_LISTs of IIO_VAL_INTs)
- add ABI docs for new ABI of mcp4531 (out_resistance_raw_available)
  and an example in the commit message

dpot-dac:
- two more counts of s/assumed the that the/assumed that the/   *blush*
- add ABI docs for new ABI (out_voltageY_raw_available)

envelope detector:
- move device attributes 'compare_interval_ms' and 'invert' to extended
  channel attributes (out_altvoltage0_compare_interval and
  out_altvoltage0_invert) as they really are about the channel and not
  the device
- kill "dpot-dac,max-ohms = <100000>;" in the devicetree example


v1 -> v2
- provide out_resistanceX_raw_available channel attribute in mcp4531 dpot

dpot-dac:
- change Vref to vref
- the module will be called dpot-dac (in Kconfig help)
- removed a 'the'
- removed (s64) cast
- make the channel indexed, makes libiio find the channel (tested with 0.5)
- add a comment on how integer scale is converted to fractional scale
  and clarify the code a bit
- dig out max-ohms by looking at scale and maximum available raw value
  from the dpot channel and drop the 'dpot-dac,max-ohms' devicetree property
- provide out_voltageX_raw_available channel attribute

envelope-detector:
- change compatible from envelope-detector to axentia,tse850-envelope-detector
- remove envelope-detector,invert and envelope-detector,comp-interval-ms from
  devicetree and add them as iio device attributes instead
- make the channel indexed, makes libiio find the channel (tested with 0.5)
- reorder struct envelope to better indicate what is covered by read_lock
- add comment on interaction between envelope_detector_comp_latch (renamed
  from envelope_detector_latch) and envelope_detector_comp_isr (renamed
  from envelope_detector_isr)
- fixup a problem in envelope_detector_comp_latch where interrupts pending
  from when the interrupt has been disabled interferes with expected
  operation
- slight rewrite of the initial high/low assignments
- use a better name when requesting the interrupt
- dig out dac_max by looking at scale and maximum available raw value
  from the dac channel and drop the 'envelope-detector,dac-max' devicetree
  property

Cheers,
Peter

Jonathan Cameron (1):
  iio:core: add a callback to allow drivers to provide _available
    attributes

Peter Rosin (7):
  iio: inkern: add helpers to query available values from channels
  iio: mcp4531: provide range of available raw values
  dt-bindings: add axentia to vendor-prefixes
  dt-bindings: iio: document dpot-dac bindings
  iio: dpot-dac: DAC driver based on a digital potentiometer
  dt-bindings: iio: document envelope-detector bindings
  iio: envelope-detector: ADC driver based on a DAC and a comparator

 .../testing/sysfs-bus-iio-adc-envelope-detector    |  36 ++
 .../ABI/testing/sysfs-bus-iio-dac-dpot-dac         |   8 +
 .../testing/sysfs-bus-iio-potentiometer-mcp4531    |   8 +
 .../bindings/iio/adc/envelope-detector.txt         |  54 +++
 .../devicetree/bindings/iio/dac/dpot-dac.txt       |  41 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  17 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/envelope-detector.c                | 422 +++++++++++++++++++++
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/dpot-dac.c                         | 266 +++++++++++++
 drivers/iio/industrialio-core.c                    | 259 +++++++++++--
 drivers/iio/inkern.c                               | 104 +++++
 drivers/iio/potentiometer/mcp4531.c                | 104 +++--
 include/linux/iio/consumer.h                       |  28 ++
 include/linux/iio/iio.h                            |  46 +++
 include/linux/iio/types.h                          |   5 +
 19 files changed, 1346 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
 create mode 100644 drivers/iio/adc/envelope-detector.c
 create mode 100644 drivers/iio/dac/dpot-dac.c

-- 
2.1.4

