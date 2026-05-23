Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9F389107;
	Sat, 23 May 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536759; cv=none; b=mR3xkcD3ySlzmMbRJtet3Pybf+GgrSKk+Z8MSKXzDtYj1hkORG7Gdt65DnIJX1LM5vsAAKe4ZaF6uC5yjRpEVeLp2NEj0IuGdyvV3aglKmqsS6uffDMABB6IQUC9HdGi98RZ3Xw7OQYmDwBsLrJoJYBxhkira1cVMdUcAZnfDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536759; c=relaxed/simple;
	bh=RhvNeUq6ka1FwLzlHsoNgKC02NYaXOKpyuGJBTZNN7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mgegs8LHfZl4/wM7jdQPnntJEvp6SfzOQuAAGU1jK7MWMiG2aJZLXObcy5DkRbLey1B/WoU76RLREy7XXsWfMy25kLxjfgLYu3qrV6Wv971PHmHMxdNJl59W6X5E78+FsYbmoo6lxbuCl8uFTxEGYTV8qkG3Jp91z7LZA316WlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=G+IrPa4W; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="G+IrPa4W"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=RhvNeUq6ka1F
	wLzlHsoNgKC02NYaXOKpyuGJBTZNN7Y=; h=references:in-reply-to:date:
	subject:to:from; d=al2klimov.de; b=G+IrPa4WkkHA0jMgv4Iexfm7OZKdke6DzgI
	whTm9Ts+GEtApYfIicYzwgHftDpUXsy3I8ae95pj+yTI8jer8kgDFLv+gxmLzedq/k/ycE
	x0zYmBjiC5V5dJD6apU71II+eLjYC4YRw7kYIzrmpfUdqDTCzjkvAbPEI/yoXQxso2PZjE
	/MBdFwW2dWL3Jt2Tio9HJZstDmqNp0nXMcZZyNM+m3Kq6J+JiL2EIiRQ1pdXI0oXiqoxlt
	g0AQUJGD9ZZyx31D2XREX1l9V/E4NlRjGvQX65RpuPEnUWiL5hHk0YZiM8SQQZcTTXR9+v
	Lwl8yPEYM/jm/Cqo4qfgq7yjbtQ==
Received: from cachy-ak (2a02-2455-18e9-e011-4d8a-aad2-c25c-50e5.dyn6.pyur.net [2a02:2455:18e9:e011:4d8a:aad2:c25c:50e5])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 3a2d0a78 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sat, 23 May 2026 11:45:55 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	David Heidelberg <david@ixit.cz>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: light: al3320a: read both ALS ADC registers again
Date: Sat, 23 May 2026 13:44:58 +0200
Message-ID: <20260523114505.73601-2-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523114505.73601-1-grandmaster@al2klimov.de>
References: <20260523114505.73601-1-grandmaster@al2klimov.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

al3320a_read_raw() used to read two adjacent registers
until the driver was modernized using the regmap framework.
That cleanup accidentally replaced the 16-bit word read
with a single byte read. I'm reverting latter.

Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 v2: use __le16, not uint16_t

 drivers/iio/light/al3320a.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 63f5a85912fc..f40b8b36f22d 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -135,7 +135,8 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	struct al3320a_data *data = iio_priv(indio_dev);
-	int ret, gain, raw;
+	int ret, gain;
+	__le16 raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -144,11 +145,12 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
 		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
 		 */
-		ret = regmap_read(data->regmap, AL3320A_REG_DATA_LOW, &raw);
+		ret = regmap_bulk_read(data->regmap, AL3320A_REG_DATA_LOW,
+				       &raw, sizeof(raw));
 		if (ret)
 			return ret;
 
-		*val = raw;
+		*val = le16_to_cpu(raw);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.54.0
