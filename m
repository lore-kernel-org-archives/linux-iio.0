Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC863264E5;
	Thu, 21 May 2026 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336673; cv=none; b=X4u4sA0Vnluv+LtGscfJZJL7slEa6Sf/HJuFQTO5QCpiNW0ho170rUpyLgFWba8LOPOgge5cp8xec0Au96k2hyY7O3JngM2lmFCmFcQi3HrTE58xjEU4vU0sjG4K6cYMzELYmhB5Lnbu3mTxmD0x4/NHpVTdsTDdjg1yW9GXTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336673; c=relaxed/simple;
	bh=YBe+bS4LEOW4T00jghMOiQVyyyR0FplXMWGMV7gvURc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hLivVi5JYQqKnU/LDoMNFuMeok2udnuuRyUc0dtRp2hj5DleTwjEVBCz1xA0p2N0BVrrUE6+qJMKdV0H7h2+6e2t8dlMaGZUdpXlwzFwW9mW9VGFgPZ85BkFgJmpc5nMEUYOwIxsCOEOPopTxzRfUzpzUV0S38achfxdPGWg+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=eUWWY/cn; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="eUWWY/cn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=YBe+bS4LEOW4
	T00jghMOiQVyyyR0FplXMWGMV7gvURc=; h=date:subject:to:from;
	d=al2klimov.de; b=eUWWY/cnqukhdi00s4h3h5mWthmxgil+twEHXtr0HoWXw1swlDge
	avBS3q84vcafFSuMEP1GgcpaxoYisd1/tp5U89mCK7f/b9irASXVVb2BSSTTEW+1JyaMkX
	mqxyCPRC1Zls/11MY0JaoMBFe4UeIRAE0KskYbBkKf2+6+3eQzBKFAityCOvF6Vhj8MvSd
	HG/BfvdaXFBMgl6Et/tgjudg+oAvWz5sfo+aX+RaGOBq9yEzzfneUPqZ2ghJgaayzJieRR
	W4ZVPOtpDwSzw1yqBz2kexl5lZypDQ2ojO+SRgz88EF1AjlrkMoM9htACjc0ckPCNLjAYG
	cE0MeZulGQ==
Received: from cachy-ak (2a02-2455-18e9-e011-4d8a-aad2-c25c-50e5.dyn6.pyur.net [2a02:2455:18e9:e011:4d8a:aad2:c25c:50e5])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 3f41a88a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 May 2026 04:11:09 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	David Heidelberg <david@ixit.cz>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: light: al3320a: read both ALS ADC registers again
Date: Thu, 21 May 2026 06:10:35 +0200
Message-ID: <20260521041041.542095-1-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
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
+	uint16_t raw;
 
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

