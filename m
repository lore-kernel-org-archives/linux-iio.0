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
Subject: [PATCH v2 0/2] iio: AFE4404 Heart Rate Monitor and Bio-Sensing
Date: Wed, 2 Dec 2015 13:57:18 -0600
Message-ID: <1449086240-13375-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hello all,

This series adds the TI AFE4404 "Ultra-small, Integrated AFE for
Wearable, Optical Heart Rate Monitoring and Bio-Sensing".

I've made changes too numerous to list based on comments in the
v1 thread[0]. The most substantial change is in the way parts
of this device are exposed to userspace as channels.

Please see [0] for more background.

Thanks,
Andrew

[0] http://www.spinics.net/lists/linux-iio/msg21619.html*

*Not the first message as that was flagged as spam by the lists.

Andrew F. Davis (2):
  Documentation: afe4404: Add DT bindings for the AFE4404 heart monitor
  iio: health: Add driver for the TI AFE4404 heart monitor

 .../ABI/testing/sysfs-bus-iio-health-afe4404       |  20 +
 .../devicetree/bindings/iio/health/afe4404.txt     |  27 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  25 +
 drivers/iio/health/Makefile                        |   6 +
 drivers/iio/health/afe4404.c                       | 619 +++++++++++++++++++++
 drivers/iio/health/afe440x.h                       | 168 ++++++
 8 files changed, 867 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-health-afe4404
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/afe4404.c
 create mode 100644 drivers/iio/health/afe440x.h

-- 
1.9.1
