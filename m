Return-Path: <MAILER-DAEMON>
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, Dan
 Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell
	<ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F.
 Davis" <afd@ti.com>
Subject: [PATCH v4 0/4] iio: AFE4404 Heart Rate Monitor and Bio-Sensing
Date: Mon, 25 Jan 2016 11:28:57 -0600
Message-ID: <1453742941-12086-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This series adds the TI AFE4404 "Ultra-small, Integrated AFE for
Wearable, Optical Heart Rate Monitoring and Bio-Sensing".

Changes from v3:
 - Removed attempt to factor out common code
 - Rebased on v4.5-rc1
 - Small fixes

Changes from v2:
 - Added afe4403 driver to this series
 - Added patch to export needed IIO function
 - Table lookup for magic numbers
 - Other small fixes

Please see [0] for more background.

[0] http://www.spinics.net/lists/linux-iio/msg21619.html

Andrew F. Davis (4):
  Documentation: afe4404: Add DT bindings for the AFE4404 heart monitor
  iio: health: Add driver for the TI AFE4404 heart monitor
  Documentation: afe4403: Add DT bindings for the AFE4403 heart monitor
  iio: health: Add driver for the TI AFE4403 heart monitor

 .../ABI/testing/sysfs-bus-iio-health-afe440x       |  54 ++
 .../devicetree/bindings/iio/health/afe4403.txt     |  34 +
 .../devicetree/bindings/iio/health/afe4404.txt     |  30 +
 drivers/iio/health/Kconfig                         |  31 +-
 drivers/iio/health/Makefile                        |   2 +
 drivers/iio/health/afe4403.c                       | 698 +++++++++++++++++++++
 drivers/iio/health/afe4404.c                       | 665 ++++++++++++++++++++
 drivers/iio/health/afe440x.h                       | 193 ++++++
 8 files changed, 1706 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-health-afe440x
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4403.txt
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
 create mode 100644 drivers/iio/health/afe4403.c
 create mode 100644 drivers/iio/health/afe4404.c
 create mode 100644 drivers/iio/health/afe440x.h

-- 
2.7.0
