Return-Path: <SRS0=Akxs=KD=gmail.com=maxime.roussinbelanger@kernel.org>
From: =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
	=?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Subject: [PATCH v3 1/2] iio: Add modifier for DUV light
Date: Thu, 19 Jul 2018 16:26:24 -0400
Message-Id: <20180719202625.25060-1-maxime.roussinbelanger@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
 drivers/iio/industrialio-core.c         | 1 +
 include/uapi/linux/iio/types.h          | 1 +
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index fee35c00cc4e..23b213f87cf5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1263,13 +1263,15 @@ What:		/sys/.../iio:deviceX/in_intensityY_raw
 What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
 What:		/sys/.../iio:deviceX/in_intensityY_both_raw
 What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
+What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
 KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Unit-less light intensity. Modifiers both and ir indicate
 		that measurements contains visible and infrared light
 		components or just infrared light, respectively. Modifier uv indicates
-		that measurements contain ultraviolet light components.
+		that measurements contain ultraviolet light components. Modifier duv
+		indicates that measurements contain deep ultraviolet light components.
 
 What:		/sys/.../iio:deviceX/in_uvindex_input
 KernelVersion:	4.6
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index fc340ed3dca1..66aba36d7fe1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -104,6 +104,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 22e5e589a274..bf037a267c7d 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -80,6 +80,7 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
+	IIO_MOD_LIGHT_DUV,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index d9b7e0f306c6..328c66d8a892 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -95,6 +95,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
@@ -176,6 +177,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_MOD_LIGHT_GREEN:
 	case IIO_MOD_LIGHT_BLUE:
 	case IIO_MOD_LIGHT_UV:
+	case IIO_MOD_LIGHT_DUV:
 	case IIO_MOD_QUATERNION:
 	case IIO_MOD_TEMP_AMBIENT:
 	case IIO_MOD_TEMP_OBJECT:
-- 
2.18.0
