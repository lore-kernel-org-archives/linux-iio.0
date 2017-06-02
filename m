Return-Path: <SRS0=OJSX=5H=ti.com=m-stecklein@kernel.org>
From: Michael Stecklein <m-stecklein@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F .
 Davis" <afd@ti.com>,
        Michael Stecklein <m-stecklein@ti.com>
Subject: [PATCH] iio: humidity: hdc100x: document compatible HDC10xx devices
Date: Fri, 2 Jun 2017 10:09:21 -0500
Message-ID: <1496416161-8180-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Include datasheet links to compatible HDC10xx devices.

Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
---

Tested on the HDC1080 but not the HDC1010 and HDC1050, however
their datasheets describe identical functionality.

 drivers/iio/humidity/hdc100x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index aa17115..ef17613 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -13,6 +13,12 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
+ * Datasheets:
+ * http://www.ti.com/product/HDC1000/datasheet
+ * http://www.ti.com/product/HDC1008/datasheet
+ * http://www.ti.com/product/HDC1010/datasheet
+ * http://www.ti.com/product/HDC1050/datasheet
+ * http://www.ti.com/product/HDC1080/datasheet
  */
 
 #include <linux/delay.h>
-- 
2.7.4
