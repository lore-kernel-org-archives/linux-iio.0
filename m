Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/3] iio: st_sensors: Disable DRDY at init time
Date: Fri, 13 May 2016 21:43:34 +0300
Message-Id: <52054a54539759100d9c926c78616858b12a2089.1463164919.git.leonard.crestez@intel.com>
In-Reply-To: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
In-Reply-To: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This fixes odd behavior after reboot.

The fact that we set the device to powerdown mode is not sufficient to
prevent DRDY being active because we might still have an unread sample.

Even if powerdown was sufficient keeping DRDY disabled while trigger is
not active is a good idea.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 928ee68..9e59c90 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -363,6 +363,11 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	if (err < 0)
 		return err;
 
+	/* Disable DRDY, this might be still be enabled after reboot. */
+	err = st_sensors_set_dataready_irq(indio_dev, false);
+	if (err < 0)
+		return err;
+
 	if (sdata->current_fullscale) {
 		err = st_sensors_set_fullscale(indio_dev,
 						sdata->current_fullscale->num);
-- 
2.5.5
