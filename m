Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/4] iio: Fix spelling of illuminance in gp2ap020a00f driver
Date: Fri,  2 May 2014 17:54:49 +0200
Message-Id: <1399046089-6616-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
References: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/gp2ap020a00f.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 5ea4a03..04bdb85 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -5,13 +5,13 @@
  * IIO features supported by the driver:
  *
  * Read-only raw channels:
- *   - illiminance_clear [lux]
- *   - illiminance_ir
+ *   - illuminance_clear [lux]
+ *   - illuminance_ir
  *   - proximity
  *
  * Triggered buffer:
- *   - illiminance_clear
- *   - illiminance_ir
+ *   - illuminance_clear
+ *   - illuminance_ir
  *   - proximity
  *
  * Events:
-- 
1.9.1
