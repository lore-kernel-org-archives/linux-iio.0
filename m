Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424317F9
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475012; cv=none; b=OSwZbgLZ9osGQPRIVt1ZWcNt7MKT084POEJw+xqqLDPWYdbloPYLrClSigAyInyCOmBK3C1QvSFDBDTLyPe/4hpMh8LZOqQFwDT0IjjsICsuVpRB49pS67ZnkAykncodDu9xgONw84IdaPcrWSv0IQiu5gyRFnlsP3WR3bZLrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475012; c=relaxed/simple;
	bh=lzgftk261xH3rTWCohglAzl1zYA0EhxMErAwnaHLiWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FspHxoENAyYF48y4Kyr8wipFh4+cSs1PJH91mtj1k33IbM0/gf+xr6p306UqzSe71N0kT5S1G9Ik518zw8OtdQpyikkNpx7SO36mzr7qN4EE9vqzTVgN1O71K3uFxMYO5RnnoSqVGGfU0GwaZdjQIRNjDf0YpE0pSF0s3h2fX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id a46bec10-6aec-11ef-8ed1-005056bdf889;
	Wed, 04 Sep 2024 21:36:47 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: light: cm32181: Remove duplicate ACPI handle check
Date: Wed,  4 Sep 2024 21:36:46 +0300
Message-ID: <20240904183646.1219485-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cm32181_acpi_parse_cpm_tables() is a no-op if ACPI handle
is not available. Remove duplicate ACPI handle check at
the caller side.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/light/cm32181.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 9df85b3999fa..aeae0566ec12 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -217,8 +217,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
 	cm32181->lux_per_bit = CM32181_LUX_PER_BIT;
 	cm32181->lux_per_bit_base_it = CM32181_LUX_PER_BIT_BASE_IT;
 
-	if (ACPI_HANDLE(cm32181->dev))
-		cm32181_acpi_parse_cpm_tables(cm32181);
+	cm32181_acpi_parse_cpm_tables(cm32181);
 
 	/* Initialize registers*/
 	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {
-- 
2.46.0

