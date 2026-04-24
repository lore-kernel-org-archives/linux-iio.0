Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770042FD69A
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035023; cv=none; b=sL21Y8zI3GMukU7LjoW/h3d14cdlZIRASkdaw1yuEuWV8QlbIXpbfG2xYkjiZqs/oowOeaFlQ1gopFR7x7B7iWoaGMXi3iBa1/MG7pwf4qi6aa4Ze8f5omTj0yhmbGJkujivI2nrnHHPUcJPag6lyWut1JBR8CmwaiFzKo1y8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035023; c=relaxed/simple;
	bh=f3rlBhwVenlZ/psJn6rf/r/+cWtOKKTnzSyL4wOqUNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE//KPZ60j603Uxs51DT/8dZoTTCn5wlG4K5g+7buAt9GBLGctKHx2bgzPU0Iv8woKBc8PvWq2d1gFtXb7b1h5SgtuXPVjBVjG5WKqVA+nfauKUYE0lK2YRVCdUfPOpXJ48OUIQntGdprRsqsBLrKj6fZFkQemQSa98qAJL0kYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com; spf=pass smtp.mailfrom=ciziks.com; dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b=SohY3Auc; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciziks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b="SohY3Auc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciziks.com;
	s=protonmail; t=1777035013; x=1777294213;
	bh=4l311k7wgu2bsjapPiXpTnZR9wmIMoKhR/C2XfODuww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SohY3AucnuokbGoPC/IFP8MyT+3d91CiYw0hk+GO2pqfUEaOaQbEYsn9nopHJi7/e
	 NREkGf0YYEoNew1L6RplajYOTUygHk8jhiEcHmxiGJoKcltOkRkOaGTq4HtZF37yma
	 b518yFH3whUuSiEz2PoMgqpbKIdZPWJTOMRTix/sUGOBVWul5PwHJC0guW7Acvn59T
	 p6qoKqqgcS7epHw/AyCzCTXDkqdf6w8IsyPbq4eLqw41i+O7dBTPA/Hhs/f9XBG9Ag
	 ZfsZj5R+9Z3xpZdut40kD3irw6cAaiZb+p559Hiw68Vdu6QWTgX5XHWeYeOotzWrNK
	 sBfoV4J7u1c4w==
X-Pm-Submission-Id: 4g2CV92GZpz1DF6k
From: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: Matheus Giarola <matheusgiarola@usp.br>,
	Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 1/2] iio: adc: ad7280a: Extract chan->address bit fields into named local variables
Date: Fri, 24 Apr 2026 09:43:39 -0300
Message-ID: <20260424125001.17822-2-lucas@ciziks.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260424125001.17822-1-lucas@ciziks.com>
References: <20260424125001.17822-1-lucas@ciziks.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the upper and lower bytes of chan->address into named local
variables devaddr and ch across ad7280_read_raw(),
ad7280_show_balance_timer() and ad7280_store_balance_timer() to improve
readability and avoid inline bit manipulation in function calls.

Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Co-developed-by: Matheus Giarola <matheusgiarola@usp.br>
Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
Co-developed-by: Felipe Ribeiro de Souza <felipers@usp.br>
Signed-off-by: Felipe Ribeiro de Souza <felipers@usp.br>
---
v5:
  - Add preparatory patch extracting chan->address bit fields into
    named local variables, as suggested by Andy Shevchenko.
  - Link to v4: https://lore.kernel.org/linux-iio/20260423133322.13298-1-lucas@ciziks.com/

v4:
  - Improve readability in ad7280_show_balance_timer() by extracting
    chan->address bit fields into named local variables, as suggested by Andy Shevchenko.
  - Link to v3: https://lore.kernel.org/linux-iio/20260417131029.12568-1-lucas@ciziks.com/

v3:
  - Restore scoped_guard() in ad7280_show_balance_timer() instead of
    guard() to avoid holding the mutex during post-processing, as
    suggested by Andy Shevchenko.
  - Link to v2: https://lore.kernel.org/linux-iio/20260415160856.22231-1-lucas@ciziks.com/

v2:
  - Replace scoped_guard with guard as suggested by Andy Shevchenko (Code Legibility).
  - Fix indentation issues.
  - Link to v1: https://lore.kernel.org/linux-iio/20260415112602.3938-1-lucas@ciziks.com/
---
 drivers/iio/adc/ad7280a.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..7f43da8e3340 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -516,12 +516,13 @@ static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
 					 char *buf)
 {
 	struct ad7280_state *st = iio_priv(indio_dev);
+	u8 devaddr = chan->address >> 8;
+	u8 ch = chan->address & 0xFF;
 	unsigned int msecs;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad7280_read_reg(st, chan->address >> 8,
-			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
+	ret = ad7280_read_reg(st, devaddr, ch + AD7280A_CB1_TIMER_REG);
 	mutex_unlock(&st->lock);
 
 	if (ret < 0)
@@ -538,6 +539,8 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 					  const char *buf, size_t len)
 {
 	struct ad7280_state *st = iio_priv(indio_dev);
+	u8 devaddr = chan->address >> 8;
+	u8 ch = chan->address & 0xFF;
 	int val, val2;
 	int ret;
 
@@ -552,8 +555,7 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	mutex_lock(&st->lock);
-	ret = ad7280_write(st, chan->address >> 8,
-			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
+	ret = ad7280_write(st, devaddr, ch + AD7280A_CB1_TIMER_REG, 0,
 			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
 	mutex_unlock(&st->lock);
 
@@ -881,6 +883,8 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7280_state *st = iio_priv(indio_dev);
+	u8 devaddr = chan->address >> 8;
+	u8 ch = chan->address & 0xFF;
 	int ret;
 
 	switch (m) {
@@ -889,8 +893,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		if (chan->address == AD7280A_ALL_CELLS)
 			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
 		else
-			ret = ad7280_read_channel(st, chan->address >> 8,
-						  chan->address & 0xFF);
+			ret = ad7280_read_channel(st, devaddr, ch);
 		mutex_unlock(&st->lock);
 
 		if (ret < 0)
@@ -900,7 +903,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
+		if (ch <= AD7280A_CELL_VOLTAGE_6_REG)
 			*val = 4000;
 		else
 			*val = 5000;
-- 
2.47.3

