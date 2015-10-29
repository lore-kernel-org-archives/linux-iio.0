Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:37275 "EHLO
	13.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbJ2MWE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2015 08:22:04 -0400
Received: from mail170.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 104181004036
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2015 13:05:10 +0100 (CET)
From: Nicola Corna <nicola@corna.info>
To: Wolfram Sang <wsa@the-dreams.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	Nicola Corna <nicola@corna.info>
Subject: [PATCH 4/5] i2c: add i2c_check_quirks helper function
Date: Thu, 29 Oct 2015 12:34:26 +0100
Message-Id: <1446118467-26453-4-git-send-email-nicola@corna.info>
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds a i2c_check_quirks helper function to check the quirk flags
of an i2c adapter, in a similar way to i2c_check_functionality.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 include/linux/i2c.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 9697002..51028f3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -617,6 +617,20 @@ static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
 	return (func & i2c_get_functionality(adap)) == func;
 }
 
+/**
+ * i2c_check_quirks() - Function for checking the quirk flags in an i2c adapter
+ * @adap: i2c adapter
+ * @quirks: quirk flags
+ *
+ * Return: true if the adapter has all the specified quirk flags, false if not
+ */
+static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
+{
+	if (!adap->quirks)
+		return false;
+	return (adap->quirks->flags & quirks) == quirks;
+}
+
 /* Return the adapter number for a specific adapter */
 static inline int i2c_adapter_id(struct i2c_adapter *adap)
 {
-- 
2.6.1

