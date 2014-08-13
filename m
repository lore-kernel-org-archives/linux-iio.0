Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-102.synserver.de ([212.40.185.102]:1057 "EHLO
	smtp-out-102.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbaHMIrO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Aug 2014 04:47:14 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: Allow devices to specify that bits above the MSB are fully defined
Date: Wed, 13 Aug 2014 10:47:08 +0200
Message-Id: <1407919628-14409-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some devices which have less significant bits than the number of storage bits
(e.g. 14-bit data in a 16-bit word) still properly initialize the bits above the
MSB. For unsigned data this means the bits will be set to 0 and for signed data
the bits will be set to the extended sign bit. Having this information allows
userspace applications to skip the step of having to perform a manual sign
extension or masking of the upper bits. Especially when processing larger
quantities of data this can improve performance. This patch introduces two new
sign specifiers for the scan element type to allow drivers to describe this
behavior. A uppercase 'S' will be used for fully defined signed words and a
uppercase 'U' will be used for fully defined unsigned words.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 Documentation/ABI/testing/sysfs-bus-iio | 38 ++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d760b02..f104ef8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -885,23 +885,27 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Description of the scan element data storage within the buffer
 		and hence the form in which it is read from user-space.
-		Form is [be|le]:[s|u]bits/storagebits[>>shift].
-		be or le specifies big or little endian. s or u specifies if
-		signed (2's complement) or unsigned. bits is the number of bits
-		of data and storagebits is the space (after padding) that it
-		occupies in the buffer. shift if specified, is the shift that
-		needs to be applied prior to masking out unused bits. Some
-		devices put their data in the middle of the transferred elements
-		with additional information on both sides.  Note that some
-		devices will have additional information in the unused bits
-		so to get a clean value, the bits value must be used to mask
-		the buffer output value appropriately.  The storagebits value
-		also specifies the data alignment.  So s48/64>>2 will be a
-		signed 48 bit integer stored in a 64 bit location aligned to
-		a 64 bit boundary. To obtain the clean value, shift right 2
-		and apply a mask to zero the top 16 bits of the result.
-		For other storage combinations this attribute will be extended
-		appropriately.
+		Form is [be|le]:[s|S|u|U]bits/storagebits[>>shift].
+		be or le specifies big or little endian. s/S u/U specifies if
+		signed (2's complement) or unsigned. If the letter is lower case
+		(s or u) this means that the bits above the MSB in the word as
+		it is stored in memory are undefined and some devices may store
+		additional information in these bits. A application processing
+		such data should make sure to mask the upper bits out for
+		unsigned data and do proper sign extension for signed data. If
+		the letter is upper case (S or U) the bits above the MSB in the
+		word are fully defined. For unsigned data the upper bits are
+		guaranteed to be 0, for signed data they will contain the
+		extended sign bit. In both cases bits below the the LSB will be
+		undefined. bits is the number of bits of data and storagebits is
+		the space (after padding) that it occupies in the buffer. shift
+		if specified, is the shift that needs to be applied prior to
+		masking out unused bits. The storagebits value also specifies
+		the data alignment. So s48/64>>2 will be a signed 48 bit integer
+		stored in a 64 bit location aligned to a 64 bit boundary. To
+		obtain the clean value, shift right 2 and apply a mask to zero
+		the top 16 bits of the result. For other storage combinations
+		this attribute will be extended appropriately.
 
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_type_available
 KernelVersion:	2.6.37
-- 
1.8.0

