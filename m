Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5D8F6F
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX1aCVXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F67C433C8;
	Sun, 31 Dec 2023 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047745;
	bh=1SaETNdIZL7KKdVLS7xXDMccw4tEMdbpxBHfKZkl/VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nX1aCVXmVwUPu288BMGZI6qVqhKYvm7yZPqDKzwchonGZI7Rn40n96EFa1IaJUAqa
	 fDvC4fyfEZi3mKrKQWniaNbC24iipyFdq35YgY1Av3aUJdjBQ/Pc/vPB+xsVpaq6Ga
	 l+CKCpgOqjUbdyinxWqObF7rBNo9x0E/7NK0O2ugDSea4U2PuFDokQcfoP46DlhHOY
	 lDYd/oQu0Kjxx5bVBT+TqXWlQ9tXb6V/i8RBbOOlKcU9DTQSu5YvORUE/gXhTSUr3c
	 WEw5PeWJdhPI6TalRhmK07zVdnVPZlZHRMWCkZUafyH/L7DTPiE1K2BqNcSNp4KL5S
	 ZpfvR3Fx1FiiQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/24] iio: light: ltr501: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:04 +0000
Message-ID: <20231231183514.566609-15-jic23@kernel.org>
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

Avoiding unused variable warnings when using this macro adds
complexity that in simple cases like this one is not justified
for the small saving in data.

Include linux/mod_devicetable.h which includes the definition of
struct acpi_device_id (hence somewhat related to the main change)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/ltr501.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 061c122fdc5e..8c516ede9116 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/delay.h>
@@ -1639,7 +1640,7 @@ static struct i2c_driver ltr501_driver = {
 		.name   = LTR501_DRV_NAME,
 		.of_match_table = ltr501_of_match,
 		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
-		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
+		.acpi_match_table = ltr_acpi_match,
 	},
 	.probe = ltr501_probe,
 	.remove	= ltr501_remove,
-- 
2.43.0

