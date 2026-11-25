Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634685;
	b=w+ZboHEX3efbNySF6ZZU+0UY0RZO1aQysnPNXycKD3JI+2KXu+1sfycAkUHrXPbn/H+t
	 YZuUF2nffl2/JOr97wYpJMuoh6p60PJ41q1aM1dk2IuTdA9y4NzfJP5+FeRFwpro08Qtj
	 +jEUnRcBa4NazxO76W819hW01ODrSHejqL/qDaAkU169HKh1t3opGZJ+AL4KeaXBXlK6/
	 PjTFLzyVMiEPSeMt35zh7VKvDTrzl4sXSWaOS2Zd5CxKA/YTvZnkSZ3dH3Ht8MBXpvyAI
	 zsGMY8dXE3GN7f9djrgHOJrMssS9GCqxSaynHQvNv0gCJiVMrGp5Uk4IuqKuu/t2ZbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634685;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=O1Y1zfRRifDbS6y7i9AKu96VQRKR4BKTyTffdJkTIUo=;
	b=Kx+SfOxx7/nVPnXBtav1g31mz2efqYVezyeLvL2olNhpOzui+AGa8k/G1ULQBgduPF4U
	 5h3M0vr9+vVgTIW/uhTEU3yg8AaZq4SsoffEpivebWKl/3oW5QK3CVGNXnfJGkW84sjIJ
	 nJSFhx4/AhaNTVA5epZYNWSJ5VtyP/lGMDL7ISIeJDafF35gzAIN8CjFFyiju2XIFlSmI
	 sND1bYsn+3c83shGWz2JncdunzSBVW02UuE0esnYhWsM0S6JDMghGe2o/NFjIp/EQzMjE
	 n4bgjIRBH5RX2Ra89iFoS6LH74WXpsPXUbHntXfAIG1tQaB+Qcnq1IOFm9rkzG0ywjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YwO/R6aQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B8606A334;
	Wed, 25 Nov 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwO/R6aQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6199E1F00A19;
	Wed, 25 Nov 2026 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634685;
	bh=O1Y1zfRRifDbS6y7i9AKu96VQRKR4BKTyTffdJkTIUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YwO/R6aQYrF9n0fTD2WpXN0HjQMFGRz9Etp26U325t7syj46IjismG3yTS3gdEsZP
	 UikMzXU/r0uS+QMWxcc9iDdaXhU3zbJfBxJGrIFp+mde5SpgyRViEBcJKYVQB6tYrM
	 XIVJz8bihMB0BSzOIJi8l/QhzyyjM0Wp8WS5HMf5mlRT5rD8fynU7wNT0HAn1eNJjh
	 2f+HyJ0Dl0nAB4nbV4efZNJgY2sQ18S8Cyxr9zEfdq0r00lK4jS61m4DtVPD1/AFAs
	 BG28BLiU+1kWp7pr3d4PG4EF6j290W9CaJ8k9/lpcGrsPnzauLwIN5sanFCGo+RPxR
	 8v3D90ERBiCnw==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:10 +0100
Subject: [PATCH 9/9] iio: gyro: st_gyro: apply iwyu principle
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-gyro-kernel-header-removal-v1-9-969b3e668d35@kernel.org>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
In-Reply-To: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nishant Malpani <nish.malpani25@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=2430;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=HMKaR5vw86IJegRT/oPvsrzkeaA/ISDdy6A5wSNxmso=;
 b=AyfnCXrvij/K9aS+QDD2z7KFO/irTk7QMuFcY370aggH7GdNJQ5htMSbXzOq06koTcm59hfIB
 FHs3gBo4PjABH1MvZb0261XKlECPfh50M/cl0MrNNWHqtchJZbM+84h
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch all kernel.h header and add/remove the remaining
headers in accordance with the IWYU principle.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/st_gyro_buffer.c | 1 -
 drivers/iio/gyro/st_gyro_core.c   | 7 +++++--
 drivers/iio/gyro/st_gyro_i2c.c    | 6 ++++--
 drivers/iio/gyro/st_gyro_spi.c    | 4 +++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 1ebfe7aa6c96..a58545bfa7f0 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -7,7 +7,6 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 7fd82cd707c7..1f0f5b12bdb8 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -7,11 +7,14 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/interrupt.h>
 #include <linux/sysfs.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index a587e9023ceb..b98b19d93b1c 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -7,9 +7,11 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
+
 #include <linux/iio/iio.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index c56331755b5c..b53e3d292a63 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -7,9 +7,11 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
+
 #include <linux/iio/iio.h>
 
 #include <linux/iio/common/st_sensors.h>

-- 
2.56.0

