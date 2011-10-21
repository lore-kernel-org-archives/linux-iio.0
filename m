Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] staging:iio: Add missing ioctl.h include to events.h
Date: Fri, 21 Oct 2011 12:59:37 +0200
Message-ID: <1319194778-7153-1-git-send-email-lars@metafoo.de>
In-Reply-To: <4EA14C87.2020606@metafoo.de>
References: <4EA14C87.2020606@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

We need ioctl.h for _IOR.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Followup to "staging:iio: header reorganization". Based on linux-iio/master
---
 drivers/staging/iio/events.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index 6867894..fbc198e 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -11,6 +11,8 @@
 #ifndef _IIO_EVENTS_H_
 #define _IIO_EVENTS_H_
 
+#include <linux/ioctl.h>
+
 /**
  * struct iio_event_data - The actual event being pushed to userspace
  * @id:		event identifier
-- 
1.7.6.3
