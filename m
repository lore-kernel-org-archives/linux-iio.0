Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34849 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcGMOnt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2016 10:43:49 -0400
Date: Wed, 13 Jul 2016 10:43:34 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: stx104: Store channel output state values as int
Message-ID: <20160713144334.GA24521@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The val parameter has a data type of int in the read_raw and write_raw
callbacks. The chan_out_states array should have elements of type int in
order to match the data type of the val parameter.

This patch fixes a possible integer overflow condition when the the int
pointer val is dereferenced to store the unsigned int chan_out_states
element in the read_raw callback.

Fixes: 97a445dad37a ("iio: Add IIO support for the DAC on the Apex Embedded Systems STX104")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/dac/stx104.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
index 792a971..b22b744 100644
--- a/drivers/iio/dac/stx104.c
+++ b/drivers/iio/dac/stx104.c
@@ -47,7 +47,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
  * @base:		base port address of the IIO device
  */
 struct stx104_iio {
-	unsigned chan_out_states[STX104_NUM_CHAN];
+	int chan_out_states[STX104_NUM_CHAN];
 	unsigned base;
 };
 
-- 
2.7.3

