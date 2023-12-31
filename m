Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976E8F74
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOoMo8OB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C2C433C9;
	Sun, 31 Dec 2023 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047723;
	bh=V9EzQJL3jNrtFJInUWiTGBP8hPvQMGNcWvChWubTNXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOoMo8OB7BShA+uvLjv7+GcN3Esw6hPtaQSdiUIpaV8Ahs1O4GPLKmRPIt9J0BV/8
	 +2BuBHIgP5qEcSLXS4eMI0EJf1GI1vi3A6bJLJSvLKDZPGPrPQ9xhmTwp0Rqdlah68
	 vMDg00oaEJshHeDXDDvnWXhXjE5/CzfGb5p9WBsBesfiUuKRhLL/1GqEonwtxt0bHY
	 zsi1D9vfMK+MGGclqKHFrLLf1rJKartXgessiJhT2VXjbB/aVV6jUfU3amWcPgoJSK
	 awfghOCfmsavnGGd4qjX9Ut6ENZnHCh5ahVFJYn2e31cQKfyppT+5PCdJfmQvCKJzL
	 sixdWex1B14DQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 01/24] iio: accel: da280: Stop using ACPI_PTR()
Date: Sun, 31 Dec 2023 18:34:51 +0000
Message-ID: <20231231183514.566609-2-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231183514.566609-1-jic23@kernel.org>
References: <20231231183514.566609-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In general using ACPI_PTR() leads to more fragile code for a very
minor saving in storage in the case of !CONFIG_ACPI so in IIO we
prefer not to use it if the only ACPI specific code is the acpi_device_id
table.

In this case will also suppress a unused variable warning.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302142222.vVU0E4eu-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/da280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 572bfe9694b0..d792d2d20344 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -186,7 +186,7 @@ MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
 static struct i2c_driver da280_driver = {
 	.driver = {
 		.name = "da280",
-		.acpi_match_table = ACPI_PTR(da280_acpi_match),
+		.acpi_match_table = da280_acpi_match,
 		.pm = pm_sleep_ptr(&da280_pm_ops),
 	},
 	.probe		= da280_probe,
-- 
2.43.0

