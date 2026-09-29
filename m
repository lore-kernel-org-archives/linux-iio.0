Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF83E5EF3
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707800; cv=none; b=HeCoZPZqGZFFF4o2PpiBTVfYdI5H+Pa1zy1aNleX74Tm06s223HTFrcm1MnZKvc8+gpOwwaD0LMMaWU3V7F5cUAznm8jKKtgreXDVGKBNnkeqWFVQbQ3Xy3KhPuRI2c6VdMYb0faDAO3bDQ+4m4jpQcpg0s66gxeNAws25oYAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707800; c=relaxed/simple;
	bh=IgggqRFRJHsrxTs4OuHEG4QNZQchSD/bszInjUcCjAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1FaC+ozc441YBMhml66ttil1Lw0+0Emujl2UyHhCK5XByvAISc5fBReTQQjJqhwn77mGDg/3MRhPWOaEF2rxI19GOPrXIQqIJZ+8yvTxlnB17FKo8kQdHwUGjkO91RP70RS9T0EyfP4xkNBSldnl0raIOuskmRhg8JOBCgSeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsXLKh1Q; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsXLKh1Q"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so2750136f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790707797; x=1791312597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nV5PAl/j9F5unHW2G98h/r8gEnFDBcnSeXzHKLdPuw=;
        b=CsXLKh1Q7BSI0scKH+kO40yk/NCIgzE9H/GbwtGaSH22HMH/qtX1j8wgDdXkYJmgwV
         lFKwyTqHCxd62IjhPhIZeQmoIbeBBtve0NFIE/tVmuqeAa9a2Fn3oZlaeqqq+j3OlXIk
         l814ssb2onCXdBVX8xQzcgrZgBnmtOc/PFPSpdNxElP12pciM+fgA6iMTAEi5gxqJsV0
         oJQBm26kTM3LZIIndhJ8XnrM9j+izUIpFINK1ifIMJ5iYoOBOjDJSr4t3z9ntCG8Lmee
         ck8BMt0gLZyp7WIzkyrY3vkqq8TpraA+V9PmCEbJ9GBQr5GNLWmbQ77rnIqzcalZECwB
         syzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707797; x=1791312597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8nV5PAl/j9F5unHW2G98h/r8gEnFDBcnSeXzHKLdPuw=;
        b=KVHsVExxjRmXPF9vONduQlFihZa4XapvZOpyMUhTh8vPVkeFOp50ucCjgPIVcPF6No
         WOhM0Eo8FZp9xakyv3rX2qUyq+eughTIIIlFuuFfr1C1Z/CoR0W4Meyp4AdQuBZLozFn
         NzriRpSID5v+Vj9GbZlnqKlbtNILfBquCbcdV5ueKIQdbqjlqTj3NkHFrPqtqLRV2lec
         db/VOXPHISUMRtHu6+MALDmN27/Pgl/9+l40Hi5CZfTrPO/j1yfnWp1UzjFGbp4qUf/a
         CQ9ozV5K3bjP9oPMSHdOg0oeMHRJm42wGQorJxOk70ahBjHMDeSHQ5B/vhvPutAYfI2m
         baZg==
X-Forwarded-Encrypted: i=1; AKwUvBzlmcV5WAdeibwaRKzuzvwi8mZQRKzqhgezmS0Yk4um+VIfB4uRk3q7JntYvodIGRjb4uWyAf+CKYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAlgg5XaAN93F+12oCHXz3bHtTjiAz6scQdD14IqVCTLEaM0M/
	dykLCQwrH+JlfhXU6xrSudfH+Buc9lki7NES6Y3Tw5zrZAjMatKtzBE3
X-Gm-Gg: AYBFou3SEy8Nr0u0BBlJDw3oD85Yn6u7MNfqVKmCLKjoiY6hczDgdWJcJz3lBTBl4vI
	fWLlURYGTPaGwunmJMaKw+0YPZiAUzI7XHJWgo+LcixU/cZwDM5779lr96JfCnHCc4XeFG+2Rtt
	mlTKc/upkQHfausXSpgeCXffuvgDWXEooqRLuXm/TwOFQpFlsI+5MkcVynjYd2iRv6UscejqCD/
	nFS4lninUcCLXmX3+bdXsXsXY59hif+CuXH5hgeY/PX8v0Zga1szSONQW+2XQ34MrhIunsACbkY
	H99WVz0yz63oBV+DvgzPxjgWcvlDmR/7EQ1C5WJVvB/XMDm9mH/h5mOImvTGQUgHL6q9rQ1h2Us
	nUROfzEu51q/Ikf8LYYcKJyhzILoQP04h0JuxXBZYx87AaTWNS8MQCRsUJJ1uge77V8F4/YpbR3
	kMrk8xoCjEed/CQeV1J15QmDIBh4u0XQ77mvQG+mXoNlXlh8oiKivhtxN2W2J2deNTi6XquNV+d
	wQJXYqtuA4GEn+yEou0aCn4SDIAo3jj
X-Received: by 2002:adf:e00f:0:20b0:488:8384:c367 with SMTP id ffacd0b85a97d-48afe791c99mr265325f8f.12.1790707796878;
        Tue, 29 Sep 2026 11:49:56 -0700 (PDT)
Received: from fedora ([154.182.121.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48afe6b8d1esm452569f8f.30.2026.09.29.11.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:49:56 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	error27@gmail.com,
	narcisaanamaria12@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH 2/3] staging: iio: accel: adis16203: add missing spi_device_id table
Date: Tue, 29 Sep 2026 21:48:59 +0300
Message-ID: <20260929184900.39515-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently relies on OF/DT matching but lacks an SPI device
ID table. This prevents module auto-loading on systems without device
tree support.

Add the spi_device_id table to resolve this and ensure the driver loads
properly across all supported platforms.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index eddb786d4747..905485fd556f 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -11,6 +11,7 @@
 #include <linux/iio/imu/adis.h>
 
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
@@ -292,12 +293,19 @@ static const struct of_device_id adis16203_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, adis16203_of_match);
 
+static const struct spi_device_id adis16203_id[] = {
+	{ "adis16203", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adis16203_id);
+
 static struct spi_driver adis16203_driver = {
 	.driver = {
 		.name = "adis16203",
 		.of_match_table = adis16203_of_match,
 	},
 	.probe = adis16203_probe,
+	.id_table = adis16203_id,
 };
 module_spi_driver(adis16203_driver);
 
-- 
2.54.0

