Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C2519DFE
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707808; cv=none; b=GzUhwFpdexUKiBeXhncDBbjB1nOTa/r/8ZBj4PeLoe11EGeAo1KGr3TygE9IoDZNygni/agrBoa11ZfS9iACsvsLip1y2a1Twv1Prpv3/6xxZfHOBadpgmUYtMBfhyw4PcA34RIE+YAmdAjxds4UiJ0Cu02XM+nY52Fl0xlIKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707808; c=relaxed/simple;
	bh=rME4CygQdMeBpELseslAXOMkF+9QTE2/B/8YQvY8mf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrhZCncrOueDIdBgHhK0OSdjQlDqwZDSqj3YKt7e8Mqfb4VRUq9XaT7Ab97QvQPx+D/k1AxeGiyU6cQbm077fV3lQGuinPrXnjHctcBmNRGf7Y7oWUH0jpu5pVqxNySFZB56yiLekCmIvsE4lkA8hU7BxMlaMLCSL/tR0zRzQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nuff7Y7n; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuff7Y7n"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-482f635552aso3563799f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790707804; x=1791312604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/s7A+PFwirZKBCyO0jb5R3037x6NgRD0oowhqjmVw1Q=;
        b=Nuff7Y7nUdqHepKVpkZq7IHtv/vg/cAjVLJDambMjWwj6pCachTswzSgmclQ1RJZjM
         D45Bpbnoc5QhMC8Ip6vC59L0CWilRjV/nvuWsYhWOCUUp9mm8kBmpsiuOP89HC5xHNqW
         EXx7LmnCANkjqpxS/8qWtgUedPBOWHcy4H8R4AxsKma5FMHLYGCg+d/HwUYmfTrt0zVm
         9hJP4QyaeAblrRiy9GS0nLWIjpvT9bHGMFohJ9hqkYXXl5GCbAHW95c+ZnUnHkf/xF38
         ckMRWf75LJmhyUUy+htkq9rzzD0suptKUgE8jzDwGtU6jiQZ50KdnBl0sunJ77n+iEOe
         Rw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707804; x=1791312604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/s7A+PFwirZKBCyO0jb5R3037x6NgRD0oowhqjmVw1Q=;
        b=SditMLW6qlmlcLDeZpUXP4rr/4bO7jZVb67+sCcm9P+EpjvBoU7rnO7uyltnBetaST
         ouyXrJ4FAyraSrJZp0p6c6Mq690Fl0QJYBATtnlnptPyjOeJBdz4oSYU6FesjYIVyc0B
         8Ids36dSNN0eC9PgEga83yUKIfT574EO8Sv+LZRPpHnwQPZLcWszQTFxWcTZLD3BTK8J
         iOuKyqKawmxCCYIUo5ef+qwJvhoxpFr+xegSXRE0zo8sxYcKgQUtE4AaeqVXQ1iSUi/8
         PVrT10dUfTUl0NCMC1UwMHESBshz8mz8sJZK6b1/t2IVPr+BccvWGob4ssFJSfEBGHY/
         kkwA==
X-Forwarded-Encrypted: i=1; AKwUvBwfIaFUVpjkMlKqCbJlNmzMkHuAsCa/19xHiNgqQjZiKI759jwfxXRDX4Fb1mm7K1SZYEGDQRVSR0U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHG8DUSYdlB7FO3JR9HaA9XpJOnkoj2mm8tbv2X1TCvXJpamxP
	buWngFhufGD6S5GmeDPY1t/SpbOTtxD0RGgUWbEob0GdC14lWLzXA1EM
X-Gm-Gg: AYBFou0CQhrgNQCt5lj5sgc/qcrmpAJC52+zyO2v4Lfby/JGxjJ7rfRvx9R6y3Fr/T8
	EmTFXd6khiX9HLh3REtQYDU394YxamHbuuO9/fX/Xg2G8qDgEttEriaIAVV380/uVbbinCWQ8Bx
	ojfcKsbsOTMkohokaaG2R7/yllZhVT2L495VLy7Cy8wznZBLI/LM11qrK52tG/EtHx4vO+XiVs7
	M23msKYnLQw/AAXU+MFf/5rNTN69dBqQ9NsJU2rF/t0J2jybxxAnrYSo/B5+R/fWWq+5c/uaOXu
	hlI8lpAepVcDBhGStgcRy930FvCRjHmiUIF9O5w33ifCNGJLoI1cc9FNYj4ATYlzYC5FtDyjuuH
	SGeran/06vaYXirIE2TcgLxe1oF9mwl3mkNCY+CiJLdB9L/SgP0hdFoKZjEbLTSV2Tmbu5rcK0b
	sRWQvt8f3hm+DqfbFKyr5QZXuuz1VPi8fwUwUfSJG0CC/5rgEzWf/5mMAaDSSLzaJwylGkR6v8U
	RICYXuxBBgdEju/jpWxCOCPhYmjE80=
X-Received: by 2002:a05:6000:22c5:b0:486:f856:1975 with SMTP id ffacd0b85a97d-48afe72ae94mr396451f8f.22.1790707803583;
        Tue, 29 Sep 2026 11:50:03 -0700 (PDT)
Received: from fedora ([154.182.121.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48afe6b8d1esm452569f8f.30.2026.09.29.11.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:50:03 -0700 (PDT)
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
Subject: [PATCH 3/3] staging: iio: accel: adis16203: clean up register definitions and drop redundant comments
Date: Tue, 29 Sep 2026 21:49:00 +0300
Message-ID: <20260929184900.39515-4-abdelnasserhussein11@gmail.com>
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

Drop redundant, single-line comments above register macros that provide
no additional value.

Vertically align the macro values with tabs to improve readability and
conform to standard kernel coding style.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 87 ++++-----------------------
 1 file changed, 13 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 905485fd556f..b0fa2701cbd1 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -17,105 +17,44 @@
 
 #define ADIS16203_STARTUP_DELAY 220 /* ms */
 
-/* Flash memory write count */
 #define ADIS16203_FLASH_CNT      0x00
-
-/* Output, power supply */
 #define ADIS16203_SUPPLY_OUT     0x02
-
-/* Output, auxiliary ADC input */
 #define ADIS16203_AUX_ADC        0x08
-
-/* Output, temperature */
 #define ADIS16203_TEMP_OUT       0x0A
-
-/* Output, x-axis inclination */
 #define ADIS16203_INCL_OUT       0x0C
-
-/* Incline null calibration */
 #define ADIS16203_INCL_NULL      0x18
-
-/* Alarm 1 amplitude threshold */
 #define ADIS16203_ALM_MAG1       0x20
-
-/* Alarm 2 amplitude threshold */
 #define ADIS16203_ALM_MAG2       0x22
-
-/* Alarm 1, sample period */
 #define ADIS16203_ALM_SMPL1      0x24
-
-/* Alarm 2, sample period */
 #define ADIS16203_ALM_SMPL2      0x26
-
-/* Alarm control */
 #define ADIS16203_ALM_CTRL       0x28
-
-/* Auxiliary DAC data */
 #define ADIS16203_AUX_DAC        0x30
-
-/* General-purpose digital input/output control */
 #define ADIS16203_GPIO_CTRL      0x32
-
-/* Miscellaneous control */
 #define ADIS16203_MSC_CTRL       0x34
-
-/* Internal sample period (rate) control */
 #define ADIS16203_SMPL_PRD       0x36
-
-/* Operation, filter configuration */
 #define ADIS16203_AVG_CNT        0x38
-
-/* Operation, sleep mode control */
 #define ADIS16203_SLP_CNT        0x3A
-
-/* Diagnostics, system status register */
 #define ADIS16203_DIAG_STAT      0x3C
-
-/* Operation, system command register */
 #define ADIS16203_GLOB_CMD       0x3E
 
 /* MSC_CTRL */
 
-/* Self-test at power-on: 1 = disabled, 0 = enabled */
-#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST      BIT(10)
-
-/* Reverses rotation of both inclination outputs */
-#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN       BIT(9)
-
-/* Self-test enable */
-#define ADIS16203_MSC_CTRL_SELF_TEST_EN         BIT(8)
-
-/* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16203_MSC_CTRL_DATA_RDY_EN          BIT(2)
-
-/* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16203_MSC_CTRL_ACTIVE_HIGH          BIT(1)
-
-/* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
-#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1        BIT(0)
+#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
+#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN	BIT(9)
+#define ADIS16203_MSC_CTRL_SELF_TEST_EN	BIT(8)
+#define ADIS16203_MSC_CTRL_DATA_RDY_EN		BIT(2)
+#define ADIS16203_MSC_CTRL_ACTIVE_HIGH		BIT(1)
+#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
 
 /* DIAG_STAT */
 
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16203_DIAG_STAT_ALARM2        BIT(9)
-
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16203_DIAG_STAT_ALARM1        BIT(8)
-
-/* Self-test diagnostic error flag */
-#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT 5
-
-/* SPI communications failure */
-#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT      3
-
-/* Flash update failure */
-#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT     2
-
-/* Power supply above 3.625 V */
-#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1
-
-/* Power supply below 2.975 V */
-#define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0
+#define ADIS16203_DIAG_STAT_ALARM2		BIT(9)
+#define ADIS16203_DIAG_STAT_ALARM1		BIT(8)
+#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT	5
+#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT	3
+#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT	2
+#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT	1
+#define ADIS16203_DIAG_STAT_POWER_LOW_BIT	0
 
 /* GLOB_CMD */
 
-- 
2.54.0

