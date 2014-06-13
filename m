Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:65018 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbaFMRLy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jun 2014 13:11:54 -0400
Date: Fri, 13 Jun 2014 22:41:46 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
Subject: [PATCH] iio: adc: at91_adc: Correct call to input_free_device
Message-ID: <20140613171146.GA2831@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This error handling code can be reached before st->ts_input is
initialized, so it is safer to always use the original name, input_dev.

A simplified version of the semantic match that finds this problem is:

// <smpl>
@r exists@
local idexpression struct input_dev * x;
expression ra,rr;
@@

* x = input_allocate_device(...)
...  when != x = rr
     when != input_free_device(x,...)
     when != if (...) { ... input_free_device(x,...) ...}
if(...) { ... when != x = ra
     when forall
*     when != input_free_device(x,...)
 \(return <+...x...+>; \| return...; \) }

// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 3b5bacd..73b2bb5 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1114,7 +1114,7 @@ static int at91_ts_register(struct at91_adc_state *st,
 	return ret;
 
 err:
-	input_free_device(st->ts_input);
+	input_free_device(input);
 	return ret;
 }
 
-- 
1.9.1

