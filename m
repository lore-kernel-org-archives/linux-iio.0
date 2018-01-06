Return-Path: <SRS0=fQ2w=EB=tobin.cc=me@kernel.org>
From: "Tobin C. Harding" <me@tobin.cc>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: add kernel-doc for field @owner
Date: Sun,  7 Jan 2018 08:56:05 +1100
Message-Id: <1515275766-31302-2-git-send-email-me@tobin.cc>
In-Reply-To: <1515275766-31302-1-git-send-email-me@tobin.cc>
References: <1515275766-31302-1-git-send-email-me@tobin.cc>
List-ID: <linux-iio@vger.kernel.org>

When building kernel documentation sphinx emits the following warning

	warning: No description found for parameter 'owner'

Add description for struct member 'owner'.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 include/linux/iio/trigger.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 7d5e44518379..390789d43369 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -43,6 +43,7 @@ struct iio_trigger_ops {
 /**
  * struct iio_trigger - industrial I/O trigger device
  * @ops:		[DRIVER] operations structure
+ * @owner:		[INTERN] owner of this driver module
  * @id:			[INTERN] unique id number
  * @name:		[DRIVER] unique name
  * @dev:		[DRIVER] associated device (if relevant)
-- 
2.7.4
