Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557165;
	b=iy08drU3RnimFSqMSd4ehb4PLjpkwKCf95qo6/9m2vD5KqL+Qy7MM3o6hZMSyau7Mp40
	 /bNUy5dpnH+po3KCCPKSfITRZPw6jUXCNoFEax6WeZk/z4TnIU5k9eyFjsRhKt0SaLYh4
	 uJJWZskA/0Ixlib7mtNWnpJxi47ZuOJ1beypg312i1+6CvapfbGD7GFrjdDApQ+GylamR
	 wbUQmUUjcQOrSLxz4s5CMuKXfmK/PX0HxPjU/htPzR/4690grW3jxwc27ip/3jRjZX5em
	 JMggpQpqXJYVZWwwZ6NkxLpG8+EfTGbrh8ksn5asX21SAGRc2lIMPga3ZKkoJ1Dnqhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557165;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WsoBtPLZ/wICL+nBq/TAYapDiPOQ5oe4SwX5gG6ou7o=;
	b=e1T77meuuAzrb/lCRseOxveyPgQfZXl5sV9hGEhgUXsGjx7MeWToamm+oVm5DM16JQer
	 FpsLRt0rffQstijdAJjsDZbpeJzfKxecqK8ufyyhVJzfy76RXIcPQY+f0vsFsiXP94Usa
	 mOMJewc0Jw57lRqM2n0F87pm3l+X5953AKg+Ka23Cg/LSy5ilwQZ5o6+6HzzZB084SBkH
	 /IxkUqt+iqwLAZYLDHWUbjfHcFBKJBK66AnYQAi8it1f3HO04f/ddRRNFJfi69kU9QlRO
	 AUWttA7osO5pCbBHKd9N8X8zqYtsIkT1fhJkf1Tv85fiTar1896UdGZxNh3l6LTXCBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KN9zAsHE;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B3606A321;
	Fri, 13 Nov 2026 08:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 332B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KN9zAsHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=KN9zAsHEwJgOJNXF4UVrVdk/vfaXZw7qSKbqmTni1oS1pwXfDZ2EI/lwpala7dZc6WT1rMkJ0LAyT
	 9bQyIwPXdLc7STa6UYUFDscNE3/OD/tt/HAsR16Q3Fk0DwnCzFbx9E7ri+PiJAD/06JbxZwWzpinNU
	 2RvhBqWQG7oEmYzg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af6c4e7aec-89b27;
	Fri, 13 Nov 2026 16:05:59 +0800 (CST)
X-RM-TRANSID:2ee46af6c4e7aec-89b27
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af6c4e63d1-1ddd9;
	Fri, 13 Nov 2026 16:05:59 +0800 (CST)
X-RM-TRANSID:2ee96af6c4e63d1-1ddd9
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andriy.shevchenko@intel.com,
	crofts@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v4] iio: temperature: mcp9600: Avoid overflow when scaling thresholds
Date: Fri, 13 Nov 2026 16:04:56 +0800
Message-ID: <20261113080558.173889-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mcp9600_write_thresh() scales the integer part by 1000000 in int
arithmetic before clamping to the supported temperature range. The
multiplication can overflow, so a request such as 3000 degrees can
select the lower threshold instead of the upper threshold.

Cast MICRO to s64 before multiplying so that scaling and the fractional
addition or subtraction use signed 64-bit arithmetic. Let the existing
per-junction bounds clamp the result. Use MICRO consistently and use
div_s64() for the final conversion to support 32-bit architectures.

Fixes: dea750f8015b ("iio: temperature: mcp9600: add threshold events support")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v4:
- Use signed 64-bit arithmetic instead of clamping the integer part before
  scaling, as suggested by Jonathan Cameron.
- Use MICRO for both scaling and conversion back to the register value,
  with div_s64() for the final signed division on 32-bit architectures.

Changes in v3:
- Use clamp() instead of clamp_val(); all operands are int (Andy Shevchenko).

Changes in v2:
- Use MICRO from <linux/units.h>, cast to int to preserve
  signed division for the negative temperature limit (Andy Shevchenko).

 drivers/iio/temperature/mcp9600.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index b0ff0c7b4891..a7a37687bccc 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -15,8 +15,10 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/units.h>
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -319,7 +321,8 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 {
 	struct mcp9600_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	int s_val, i;
+	s64 s_val;
+	int i;
 	s16 thresh;
 	u8 hyst;
 
@@ -327,8 +330,8 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		/* Scale value to include decimal part into calculations */
-		s_val = (val < 0) ? ((val * 1000000) - val2) :
-				    ((val * 1000000) + val2);
+		s_val = (val < 0) ? ((val * (s64)MICRO) - val2) :
+				    ((val * (s64)MICRO) + val2);
 		if (chan->channel2 == IIO_MOD_TEMP_AMBIENT) {
 			s_val = max(s_val, MCP9600_MIN_TEMP_COLD_JUNCTION_MICRO);
 			s_val = min(s_val, MCP9600_MAX_TEMP_COLD_JUNCTION_MICRO);
@@ -341,7 +344,7 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 		 * Shift length 4 bits = 2(15:2) + 2(0.25 LSB), temperature is
 		 * stored in two’s complement format.
 		 */
-		thresh = (s16)(s_val / (1000000 >> 4));
+		thresh = (s16)div_s64(s_val, MICRO >> 4);
 		return i2c_smbus_write_word_swapped(client,
 						    MCP9600_ALERT_LIMIT(i + 1),
 						    thresh);
-- 
2.51.0



