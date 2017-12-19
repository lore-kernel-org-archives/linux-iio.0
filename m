Return-Path: <SRS0=t+T8=DP=tobin.cc=me@kernel.org>
From: "Tobin C. Harding" <me@tobin.cc>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: add kernel-doc '@owner'
Date: Tue, 19 Dec 2017 17:17:50 +1100
Message-Id: <1513664270-29523-1-git-send-email-me@tobin.cc>
List-ID: <linux-iio@vger.kernel.org>

When building kernel documentation sphinx emits the following warning

	warning: No description found for parameter 'owner'

Add description for struct member 'owner'.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

I couldn't work out what DRIVER/INTERN were for so I took a guess.

 include/linux/iio/trigger.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 7d5e44518379..d884b5099cd0 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -43,6 +43,7 @@ struct iio_trigger_ops {
 /**
  * struct iio_trigger - industrial I/O trigger device
  * @ops:		[DRIVER] operations structure
+ * @owner:		[DRIVER] owner of this driver module
  * @id:			[INTERN] unique id number
  * @name:		[DRIVER] unique name
  * @dev:		[DRIVER] associated device (if relevant)
-- 
2.7.4
