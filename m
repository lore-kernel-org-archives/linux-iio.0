Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5ED53;
	Thu,  7 Dec 2023 18:17:24 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vy1Y0Nm_1702001836;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vy1Y0Nm_1702001836)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 10:17:22 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] iio: light: isl76682: remove unreachable code
Date: Fri,  8 Dec 2023 10:17:15 +0800
Message-Id: <20231208021715.32450-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function isl76682_read_raw cannot execute return -EINVAL up to 145
lines, delete the invalid code.

drivers/iio/light/isl76682.c:145 isl76682_read_raw() warn: ignoring unreachable code.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7698
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/iio/light/isl76682.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
index 0a7c3b09c3c0..cf6ddee44ffc 100644
--- a/drivers/iio/light/isl76682.c
+++ b/drivers/iio/light/isl76682.c
@@ -142,7 +142,6 @@ static int isl76682_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		return -EINVAL;
 	case IIO_CHAN_INFO_SCALE:
 		for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
 			if (chip->range != isl76682_range_table[i].range)
-- 
2.20.1.7.g153144c

