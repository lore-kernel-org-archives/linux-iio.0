Return-Path: <SRS0=nsy0=OF=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: humidity: hts221: add entry in MAINTAINERS file
Date: Mon, 26 Nov 2018 10:05:55 +0100
Message-Id: <284ef543279ecc56944011fe1082d9a46f87d9ea.1543222885.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1543222885.git.lorenzo.bianconi@redhat.com>
References: <cover.1543222885.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Add entry for hts221 temperature/humidity driver in MAINTAINERS file

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4d94fb0666d..d904229ceffb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6792,6 +6792,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/touchscreen/htcpen.c
 
+HTS221 TEMPERATURE-HUMIDITY IIO DRIVER
+M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+L:	linux-iio@vger.kernel.org
+W:	http://www.st.com/
+S:	Maintained
+F:	drivers/iio/humidity/hts221*
+F:	Documentation/devicetree/bindings/iio/humidity/hts221.txt
+
 HUAWEI ETHERNET DRIVER
 M:	Aviad Krawczyk <aviad.krawczyk@huawei.com>
 L:	netdev@vger.kernel.org
-- 
2.19.1
