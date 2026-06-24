Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1F2E717B;
	Wed, 24 Jun 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279516; cv=none; b=JqMaiATQ6AWLWSv1coY1i0xV8xjirXmAvg04lJEm5uogpSgTJ9Z/FuPjC68oA6cPKVnSnQLdzO2YDfnQkLUCUpD8HdcpBvqv/V629/cuqUME67BS9Ap7w73JGQrflBNHDbV2hiV+6kXEUhIoDET1wIyKByy446RljOSLeU5sPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279516; c=relaxed/simple;
	bh=qmsVc6VGf4kZtVzsD9xT+kVcEFKfrsfqMLfFsfCJpxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzrbCKSTrhrIZapOcv7q8yja+smfZ62p+SUiEyH3HKizxk0yecGBEji+M7T4Re/ERVG+Svd903/8COg2CzbjoaTG15M5r8og4R9QQHaHa6VrCh4gV+Cg+IH3Gdo1drFilRQcSNqAzx8pyDIV2hhqLK1cUGt4e5oX16E9BbbDjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAA3HONSbTtqL86sFQ--.23133S2;
	Wed, 24 Jun 2026 13:38:26 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Remi Buisson <remi.buisson@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] iio: imu: inv_icm45600: Use I2C match data
Date: Wed, 24 Jun 2026 13:38:23 +0800
Message-ID: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3HONSbTtqL86sFQ--.23133S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4DJF1UWr15WrWkXF13Jwb_yoWkZFX_Zr
	yrWa97Xr1Uur97Z3W7uw1rZr95KrWjkFnYvF1Iyw4fKrWkArs0yr9Y9ws0yF4UW3yjqFZ8
	Wr1DXr97Za1xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOgAwDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The I2C driver provides chip_info through both the OF match table and
the I2C id table, but probe reads it with device_get_match_data().  That
misses id-table driver_data for non-firmware I2C matches and can reject
a supported device with -ENODEV.

Use i2c_get_match_data() so the id-table chip_info is used when firmware
match data is not present.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
index 5ebc18121a11..c65e5501eee7 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
@@ -23,7 +23,7 @@ static int inv_icm45600_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
 		return -ENODEV;
 
-	chip_info = device_get_match_data(&client->dev);
+	chip_info = i2c_get_match_data(client);
 	if (!chip_info)
 		return -ENODEV;
 
-- 
2.50.1 (Apple Git-155)

