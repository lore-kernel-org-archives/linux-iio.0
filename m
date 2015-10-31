Return-Path: <MAILER-DAEMON>
From: "Andrew F. Davis" <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter
 Meerwald <pmeerw@pmeerw.net>
CC: <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F.
 Davis" <afd@ti.com>
Subject: [PATCH 0/2] iio: Heart Rate Monitors
Date: Sat, 31 Oct 2015 11:31:27 -0500
Message-ID: <1446309089-21094-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hello all,

This series adds the TI AFE4404 "Ultra-small, Integrated AFE for
Wearable, Optical Heart Rate Monitoring and Bio-Sensing".

This work is based on previous work by Dan Murphy [0] who is working
on other tasks at the moment, so I will be helping to continue
upstreaming this driver. This is more of a re-write than a continuation
and there are many changes so I am submitting this as a v1.

This device is very similar to the AFE4403 and I was originally planning
on pushing the two drivers together with common core functions in a
third file. The AFE4403 driver is still being tested so I merged common
code back into this driver, this is why this driver may seem a bit
unnecessarily modular. I will probably split this stuff back out when
I push the AFE4403.

I also had some issues with sysfs naming for the channels; this device
has three input channels from three LED stages and two ambient
channels based on the LED stages. This might have been be a good place
for using IIO modifiers[1], but we also have two differential channels
based on the ambient channels, and channels cannot have both modifiers
and be differential (the modifier is stored in the differential channel's
ID field?). So I used sysfs names that would be close to what they
would be if IIO supported these things.

[0] http://www.spinics.net/lists/linux-iio/msg18413.html
[1] IIO_MOD_TEMP_AMBIENT could be renamed IIO_MOD_AMBIENT as it can
also apply to LIGHT, PRESSURE, HUMIDITY, etc..

Thanks,
Andrew

Andrew F. Davis (2):
  Documentation: afe4404: Add DT bindings for the AFE4404 heart monitor
  iio: health: Add driver for the TI AFE4404 heart monitor

 .../ABI/testing/sysfs-bus-iio-health-afe4404       |  70 +++
 .../devicetree/bindings/iio/health/afe4404.txt     |  27 ++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  24 +
 drivers/iio/health/Makefile                        |   6 +
 drivers/iio/health/afe4404.c                       | 526 +++++++++++++++++++++
 drivers/iio/health/afe440x.h                       | 159 +++++++
 8 files changed, 814 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-health-afe4404
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/afe4404.c
 create mode 100644 drivers/iio/health/afe440x.h

-- 
1.9.1
