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
Subject: [PATCH v3 0/5] iio: AFE4404 Heart Rate Monitor and Bio-Sensing
Date: Mon, 14 Dec 2015 16:35:56 -0600
Message-ID: <1450132561-5245-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hello all,

This series adds the TI AFE4404 "Ultra-small, Integrated AFE for
Wearable, Optical Heart Rate Monitoring and Bio-Sensing".

Changes from v2:
 - Added afe4403 driver to this series
 - Added patch to export needed IIO function
 - Table lookup for magic numbers
 - Other small fixes

Please see [0] for more background.

Thanks,
Andrew

[0] http://www.spinics.net/lists/linux-iio/msg21619.html*

*Note the first message as that was flagged as spam by the lists.

Andrew F. Davis (5):
  iio: Make IIO value formating function globally available.
  Documentation: afe4404: Add DT bindings for the AFE4404 heart monitor
  iio: health: Add driver for the TI AFE4404 heart monitor
  Documentation: afe4403: Add DT bindings for the AFE4403 heart monitor
  iio: health: Add driver for the TI AFE4403 heart monitor

 .../ABI/testing/sysfs-bus-iio-health-afe4403       |  52 ++
 .../ABI/testing/sysfs-bus-iio-health-afe4404       |  60 ++
 .../devicetree/bindings/iio/health/afe4403.txt     |  34 +
 .../devicetree/bindings/iio/health/afe4404.txt     |  30 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  37 ++
 drivers/iio/health/Makefile                        |   7 +
 drivers/iio/health/afe4403.c                       | 696 ++++++++++++++++++++
 drivers/iio/health/afe4404.c                       | 700 +++++++++++++++++++++
 drivers/iio/health/afe440x.h                       | 202 ++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/iio.h                            |   2 +
 13 files changed, 1823 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-health-afe4403
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-health-afe4404
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4403.txt
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/afe4403.c
 create mode 100644 drivers/iio/health/afe4404.c
 create mode 100644 drivers/iio/health/afe440x.h

-- 
2.6.4
