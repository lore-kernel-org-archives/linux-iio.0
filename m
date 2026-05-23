Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CB2BFC60;
	Sat, 23 May 2026 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536733; cv=none; b=BqjZ1RAAAHdN+eJ5VcuWwtfZM8wBr4yhypPjNMjOf4E8Xvu/IxbZOvgu1LiokIil9XtiOX7Lv/o9z544DACIPQ6not3rRt8WYFWz3qAqmyp1r3zDgKHMTIUCrVJ2nHHA7DCrqAzaMyLyFboht+hxTbTs/hmOipNQcMlNKsi+F24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536733; c=relaxed/simple;
	bh=NLCDKnRJ6sWNAIoKR5b+/Gi+XrYUm3tMWoWcFlelzg0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QvoVpQeGmU0bBjMJIiNk/tRXh90/6lXHmVNGJfwYlRX6K6J70jYajO8H8SE8LUXIlR7G+G4Fig+U7TTS3ORT5kIEc1c7UrvGbmjVyntlQdSohm0Ds+2mniS+2KLAwzMtdHflvJ4VuZRW1IapBhS9UHhRGWbrCF//7P3LyxYV55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=efiRCArb; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="efiRCArb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=NLCDKnRJ6sWN
	AIoKR5b+/Gi+XrYUm3tMWoWcFlelzg0=; h=date:subject:to:from;
	d=al2klimov.de; b=efiRCArbgz4cnEbi4Npe6k8DYtsPb146gYAvdbM7CCVtwkN92zQ9
	3Fi+KRQ+p5/UkLLhMnN9m8Cy78Sa3QTGXcqpAvfTIwIhKhBGFI8Its0JBXnRRltyAOjLZ/
	jxk6JDSb27mbuB1L/kRlRsns1hiT4El5Tb2m+siIVS/DkV3yIyjZGvNuMHJGeZ1by07JbI
	PLuoQVF+dl0101Wrb8pH6mUtHT25AfUBOyL+FYw/ACD7aMStyelXjm8658b3uR1FUXuXZP
	nAm0hKkx5+MOYlSBA0HPcn/MdydOCo480F1QvpU3DgxeWobtRW9MHxiCWAUMIhv17np6nw
	XsiNARUV/w==
Received: from cachy-ak (2a02-2455-18e9-e011-4d8a-aad2-c25c-50e5.dyn6.pyur.net [2a02:2455:18e9:e011:4d8a:aad2:c25c:50e5])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 460fbb46 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sat, 23 May 2026 11:45:28 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	David Heidelberg <david@ixit.cz>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: light: al3010: read both ALS ADC registers again
Date: Sat, 23 May 2026 13:44:57 +0200
Message-ID: <20260523114505.73601-1-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

al3010_read_raw() used to read two adjacent registers
until the driver was modernized using the regmap framework.
That cleanup accidentally replaced the 16-bit word read
with a single byte read. I'm reverting latter.

Fixes: 0e5e21e23dd6 ("iio: light: al3010: Implement regmap support")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 v2: use __le16, not uint16_t

 drivers/iio/light/al3010.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 0932fa2b49fa..1800776d725e 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -111,7 +111,8 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int ret, gain, raw;
+	int ret, gain;
+	__le16 raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -120,11 +121,12 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3010_REG_DATA_LOW
 		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
 		 */
-		ret = regmap_read(data->regmap, AL3010_REG_DATA_LOW, &raw);
+		ret = regmap_bulk_read(data->regmap, AL3010_REG_DATA_LOW,
+				       &raw, sizeof(raw));
 		if (ret)
 			return ret;
 
-		*val = raw;
+		*val = le16_to_cpu(raw);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.54.0
