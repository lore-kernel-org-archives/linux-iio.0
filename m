Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:36676 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeGADAv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 23:00:51 -0400
From: David Lechner <david@lechnology.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: add channel type for frequency
Date: Sat, 30 Jun 2018 21:59:53 -0500
Message-Id: <20180701025953.3561-1-david@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds a new type for frequency to the IIO channel type enumeration.

Units are in Hz.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/uapi/linux/iio/types.h  | 1 +
 tools/iio/iio_event_monitor.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 19bdf3d2962a..f3c2c9e4b997 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_COUNT] = "count",
 	[IIO_INDEX] = "index",
 	[IIO_GRAVITY]  = "gravity",
+	[IIO_FREQUENCY] = "frequency",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 4213cdf88e3c..9fee86e2046f 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -44,6 +44,7 @@ enum iio_chan_type {
 	IIO_COUNT,
 	IIO_INDEX,
 	IIO_GRAVITY,
+	IIO_FREQUENCY,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b61245e1181d..c3ef20057d52 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_GRAVITY] = "gravity",
+	[IIO_FREQUENCY] = "frequency",
 };
 
 static const char * const iio_ev_type_text[] = {
-- 
2.17.1

