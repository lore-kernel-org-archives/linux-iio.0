Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0115.outbound.protection.outlook.com ([104.47.2.115]:41424
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935544AbcKQAWZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Nov 2016 19:22:25 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [RFC PATCH 0/7] mux controller astraction and iio/i2c muxes
Date: Thu, 17 Nov 2016 00:48:24 +0100
Message-ID: <1479340111-1259-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

This is work in progress, I'm asking for early feedback.

I have a piece of hardware that is using the same 3 GPIO pins
to control four 8-way muxes. Three of them control ADC lines
to an ADS1015 chip with an iio driver, and the last one
controls the SDA line of an i2c bus. We have some deployed
code to handle this, but you do not want to see it or ever
hear about it. I'm not sure why I even mention it. Anyway,
the situation has nagged me to no end for quite some time.

So, after first getting more intimate with the i2c muxing code
and later discovering the drivers/iio/inkern.c file and
writing a couple of drivers making use of it, I came up with
what I think is an acceptable solution; add a generic mux
controller driver that is shared between all instances, and
combine that with an iio mux driver and a new generic i2c mux
driver. The new i2c mux I called "simple" since it is only
hooking the i2c muxing and the new mux controller (much like
the alsa simple card driver does for ASoC).

My initial (private) version didn't add "mux" as a new bus,
but I couldn't get decent type-checking and nice devicetree
integration with that. It does however feel a bit rich to
add a new bus for something as small as mux controllers?

One thing that I would like to do, but don't see a solution
for, is to move the mux control code that is present in
various drivers in drivers/i2c/muxes to this new minimalistic
muxing subsystem, thus converting all present i2c muxes (but
perhaps not gates and arbitrators) to be i2c-mux-simple muxes.

I'm using an rwsem to lock a mux, but that isn't really a
perfect fit. Is there a better locking primitive that I don't
know about that fits better? I had a mutex at one point, but
that didn't allow any concurrent accesses at all. At least
the rwsem allows concurrent access as long as all users
agree on the mux state, but I suspect that the rwsem will
degrade to the mutex situation pretty quickly if there is
any contention.

Also, the "mux" name feels a bit ambitious, there are many muxes
in the world, and this tiny bit of code is probably not good
enough to be a nice fit for all...

This is all very fresh code and only lightly tested, but it
feels very promising! Now, go ahead and rip this to pieces...

Cheers,
Peter

Peter Rosin (7):
  dt-bindings: document devicetree bindings for mux-gpio
  misc: minimal mux subsystem and gpio-based mux controller
  iio: inkern: api for manipulating ext_info of iio channels
  dt-bindings: iio: iio-mux: document iio-mux bindings
  iio: multiplexer: new iio category and iio-mux driver
  dt-bindings: i2c: i2c-mux-simple: document i2c-mux-simple bindings
  i2c: i2c-mux-simple: new driver

 .../devicetree/bindings/i2c/i2c-mux-simple.txt     |  91 ++++++
 .../bindings/iio/multiplexer/iio-mux.txt           |  59 ++++
 .../devicetree/bindings/misc/mux-gpio.txt          |  76 +++++
 drivers/i2c/muxes/Kconfig                          |  12 +
 drivers/i2c/muxes/Makefile                         |   1 +
 drivers/i2c/muxes/i2c-mux-simple.c                 | 172 +++++++++++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/inkern.c                               |  40 +++
 drivers/iio/multiplexer/Kconfig                    |  17 ++
 drivers/iio/multiplexer/Makefile                   |   6 +
 drivers/iio/multiplexer/iio-mux.c                  | 313 +++++++++++++++++++++
 drivers/misc/Kconfig                               |   6 +
 drivers/misc/Makefile                              |   2 +
 drivers/misc/mux-core.c                            | 285 +++++++++++++++++++
 drivers/misc/mux-gpio.c                            | 105 +++++++
 include/linux/iio/consumer.h                       |   5 +
 include/linux/mux.h                                |  54 ++++
 18 files changed, 1246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-simple.txt
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
 create mode 100644 Documentation/devicetree/bindings/misc/mux-gpio.txt
 create mode 100644 drivers/i2c/muxes/i2c-mux-simple.c
 create mode 100644 drivers/iio/multiplexer/Kconfig
 create mode 100644 drivers/iio/multiplexer/Makefile
 create mode 100644 drivers/iio/multiplexer/iio-mux.c
 create mode 100644 drivers/misc/mux-core.c
 create mode 100644 drivers/misc/mux-gpio.c
 create mode 100644 include/linux/mux.h

-- 
2.1.4

