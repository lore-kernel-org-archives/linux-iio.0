Return-Path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 1/2] iio: Implement counter channel type and info constants
Date: Wed,  7 Sep 2016 13:55:30 -0400
Message-Id: <6a27560d27e0554b632e68b017427b8697419a26.1473265537.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1473265537.git.vilhelm.gray@gmail.com>
References: <cover.1473265537.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Quadrature encoders, such as rotary encoders and linear encoders, are
devices which are capable of encoding the relative position and
direction of motion of a shaft. This patch introduces several IIO
constants for supporting quadrature encoder counter devices.

  IIO_COUNT: Current count (main data provided by the counter device)

  IIO_CHAN_INFO_FLAGS: Counter flag states (e.g. underflows, overflows,
                       errors, etc.)
  IIO_CHAN_INFO_DIRECTION: Set high when counting up and reset low when
                           counting down
  IIO_CHAN_INFO_INDEX: Set high when index input is at active level
  IIO_CHAN_INFO_MODE: Count value encoding, counter range setting,
                      quadrature phase mode, etc.
  IIO_CHAN_INFO_PRESET: Counter preset value
  IIO_CHAN_INFO_PRESET_EN: Set high to preset counter on signal (e.g.
                           index input at active level)

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/industrialio-core.c | 7 +++++++
 include/linux/iio/iio.h         | 6 ++++++
 include/uapi/linux/iio/types.h  | 1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0528a0c..bfdb09d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -81,6 +81,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
+	[IIO_COUNT] = "count",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -151,6 +152,12 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
+	[IIO_CHAN_INFO_FLAGS] = "flags",
+	[IIO_CHAN_INFO_DIRECTION] = "direction",
+	[IIO_CHAN_INFO_INDEX] = "index",
+	[IIO_CHAN_INFO_MODE] = "mode",
+	[IIO_CHAN_INFO_PRESET] = "preset",
+	[IIO_CHAN_INFO_PRESET_EN] = "preset_enable",
 };
 
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b4a0679..13543fd 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -46,6 +46,12 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+	IIO_CHAN_INFO_FLAGS,
+	IIO_CHAN_INFO_DIRECTION,
+	IIO_CHAN_INFO_INDEX,
+	IIO_CHAN_INFO_MODE,
+	IIO_CHAN_INFO_PRESET,
+	IIO_CHAN_INFO_PRESET_EN,
 };
 
 enum iio_shared_by {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 22e5e58..e227039 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -40,6 +40,7 @@ enum iio_chan_type {
 	IIO_PH,
 	IIO_UVINDEX,
 	IIO_ELECTRICALCONDUCTIVITY,
+	IIO_COUNT,
 };
 
 enum iio_modifier {
-- 
2.7.3
