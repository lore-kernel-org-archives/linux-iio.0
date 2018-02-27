Return-Path: <SRS0=eWmn=FV=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 27 Feb 2018 10:46:51 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, kernel-janitors@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: dummy: Add correct tabs and spaces to Kconfig
Message-ID: <fc453a92429d06d769aa71072c5c0cbaa1c8d57a.1519738995.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1519738995.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Kconfig from iio/dummy does not follow the coding style recommendations.
According to the coding-style, Lines under a config definition are
indented with one tab, while help text is indented an additional two
spaces. This patch adds the proper tabulation and space.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/iio/dummy/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
index 5a29fbd3c531..85e13b2e35bf 100644
--- a/drivers/iio/dummy/Kconfig
+++ b/drivers/iio/dummy/Kconfig
@@ -9,20 +9,20 @@ config IIO_DUMMY_EVGEN
 	tristate
 
 config IIO_SIMPLE_DUMMY
-       tristate "An example driver with no hardware requirements"
-       depends on IIO_SW_DEVICE
-       help
-	 Driver intended mainly as documentation for how to write
-	 a driver. May also be useful for testing userspace code
-	 without hardware.
+	tristate "An example driver with no hardware requirements"
+	depends on IIO_SW_DEVICE
+	help
+	  Driver intended mainly as documentation for how to write
+	  a driver. May also be useful for testing userspace code
+	  without hardware.
 
 if IIO_SIMPLE_DUMMY
 
 config IIO_SIMPLE_DUMMY_EVENTS
-       bool "Event generation support"
-       select IIO_DUMMY_EVGEN
-       help
-         Add some dummy events to the simple dummy driver.
+	bool "Event generation support"
+	select IIO_DUMMY_EVGEN
+	help
+	  Add some dummy events to the simple dummy driver.
 
 config IIO_SIMPLE_DUMMY_BUFFER
 	bool "Buffered capture support"
-- 
2.16.2
