Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:56266 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629AbbG0Wtk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:49:40 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 2/7] iio:accel:stk8312: check for invalid value
Date: Tue, 28 Jul 2015 00:49:22 +0200
Message-Id: <f406a1b129207e44ed3c6a07a8d44e16f6f3f74f.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Revision 1.2 of the datasheet recommends on page 22 to only write non-zero
values read from OTP register 0x70 into AFECTRL register.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/stk8312.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index c2bd1444d6da..6592be8e6377 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -150,6 +150,8 @@ static int stk8312_otp_init(struct stk8312_data *data)
 		goto exit_err;
 
 	ret = i2c_smbus_read_byte_data(client, STK8312_REG_OTPDATA);
+	if (ret == 0)
+		ret = -EINVAL;
 	if (ret < 0)
 		goto exit_err;
 
-- 
2.4.6

