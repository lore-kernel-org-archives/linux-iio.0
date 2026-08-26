Received: from out-zbxj-a74.jellyfish.systems (out-zbxj-a74.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926146EC61
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766907; cv=none; b=g18mUQPy3nIS1+Uy6AcUwxfKqpCK1w9HFTeNOhDGaAaDs3aT7e0jrpPLxt+Am4k6yNJuvRV19FcDHnteI4XT36gMUVPaF4gdymVwKoPBCAClsFcGi0Ovz3lWj7wSgmuRPxEFEidaie97weNNVRsxy+6Jtyk4g5Ui/paSIVwViiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766907; c=relaxed/simple;
	bh=5MUS+jSLenmtWtQm3/CNTEcXFg2KOODI/Ydn6oNWr4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4iTrOeX9lljOiFG1/DWn+JQRDtCsnECzMTUMYwbvIHNkptSbaHPTPcQpud2yS7bVfnoZhViRpV5Y7ZDCSGW/dkC2Gxfbp4eP+3FmrP//HHL+f8LyOdnAvWQp2Ii4o7ZZH5B+r+qs32JCoiqWVBmErRmBP6lytHR+7hVZd51esE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hVXN41gRtz8sWX;
	Wed, 26 Aug 2026 17:54:28 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH v2 3/5] iio: light: stk3310: move the data registers into the channel address
Date: Wed, 26 Aug 2026 19:54:07 +0200
Message-ID: <20260826175409.326131-4-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The RAW read selects its data register with a per-channel-type branch.
Record each channel's data register in its .address field and read
from there, so adding a channel does not grow the branch.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/iio/light/stk3310.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 5b5b6812edc7..156888969366 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -184,6 +184,7 @@ static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
 static const struct iio_chan_spec stk3310_channels[] = {
 	{
 		.type = IIO_LIGHT,
+		.address = STK3310_REG_ALS_DATA_MSB,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) |
@@ -191,6 +192,7 @@ static const struct iio_chan_spec stk3310_channels[] = {
 	},
 	{
 		.type = IIO_PROXIMITY,
+		.address = STK3310_REG_PS_DATA_MSB,
 		.info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) |
@@ -370,25 +372,20 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
-	u8 reg;
 	__be16 buf;
 	int ret;
 	unsigned int index;
 	struct stk3310_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
+	struct regmap *map = data->regmap;
 
 	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (chan->type == IIO_LIGHT)
-			reg = STK3310_REG_ALS_DATA_MSB;
-		else
-			reg = STK3310_REG_PS_DATA_MSB;
-
 		mutex_lock(&data->lock);
-		ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
+		ret = regmap_bulk_read(map, chan->address, &buf, sizeof(buf));
 		if (ret < 0) {
 			dev_err(&client->dev, "register read failed\n");
 			mutex_unlock(&data->lock);
-- 
2.55.0

