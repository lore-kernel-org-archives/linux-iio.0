Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BC1B7910;
	Wed, 20 May 2026 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299950; cv=none; b=K55+VVsw+mgMMCPTBySc9e+0Uw7vxVweW1pQOf/ioo+KLwd4mjOovzS7kxUO/+xRaHHIqTn9A4GJ2/NfWg7usKMZXasDF1pC9RVQ8QDb5JE4gVsPpKa54w1NsnbG+76YEqlRZhR7WRq5Q+gudJx3uTE7bQY81YgyGxAkT4ieG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299950; c=relaxed/simple;
	bh=6y18J+7YszsN2fKLLeYDUO+n0+/1tmLXZT1WtdogAxo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rCo+BZgntqXgbY9CSMzvudNkCpb81DNi3cQlPbsfq3sCmKqipK43qmblvh6Id5N9Z+2YG2wgTMWoT4PrptLPk/D0yEn+bGA76gmaY6TC5ASIkKJKBs7ohm8D+aK5VSiUNenwGYiBkxlN7BsBG6Oz8Td8JGv13C9NLIRxQc9pLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=AJzcdXB+; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="AJzcdXB+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=6y18J+7YszsN
	2fKLLeYDUO+n0+/1tmLXZT1WtdogAxo=; h=date:subject:to:from;
	d=al2klimov.de; b=AJzcdXB+k9msldidOAvAYebCeL1Da0/R0CXptqBXicOrGxXIc2BI
	6etSZMXkAzOK2GpzkpgEgAwQIAf9QrsZIYwjSvqDcglEcHw/RhPVxgYCOgNwetCsQddIyj
	ZorVUi5SuPXz+iDzOfnU+YlUQN+qRwifetezgg619kRmtS/AJnEPq1FwyyIMu2l+l+ImXU
	beaKuu+/dUY6bhnRNYj14wDfVmOUMYOMWsW9MaFiblBux5jic43L0whv1HFtmH4nyqvbme
	L3YaU3VFTbeadSlLuVXR8GSPqGBgpKh+lij9rVvvZ1pMb7J4F+0UZhEI26L/1MrPeuqoH2
	0aGoYvZ0Xw==
Received: from cachy-ak (2a02-2455-18e9-e011-4d8a-aad2-c25c-50e5.dyn6.pyur.net [2a02:2455:18e9:e011:4d8a:aad2:c25c:50e5])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 0b7dd50d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 May 2026 17:59:07 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	David Heidelberg <david@ixit.cz>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: light: al3010: read both ALS ADC registers again
Date: Wed, 20 May 2026 19:58:49 +0200
Message-ID: <20260520175855.538098-1-grandmaster@al2klimov.de>
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
+	uint16_t raw;
 
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

