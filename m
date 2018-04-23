Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bert.emutex.com ([91.103.1.109]:54300 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932522AbeDWVin (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Apr 2018 17:38:43 -0400
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Arteaga <javier@emutex.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dan O'Donovan <dan@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: adc128s052: reuse "compatible" for ACPI _DSD
Date: Mon, 23 Apr 2018 22:38:05 +0100
Message-Id: <20180423213805.12591-4-javier@emutex.com>
In-Reply-To: <20180423213805.12591-1-javier@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Dan O'Donovan <dan@emutex.com>

Allow this driver to be ACPI matched by DT compatible string (through
_DSD properties) when CONFIG_OF is disabled.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
[javier@emutex.com: edited the patch title and description]
Signed-off-by: Javier Arteaga <javier@emutex.com>
---
 drivers/iio/adc/ti-adc128s052.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index bc5096e98900..c823929db784 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -232,7 +232,7 @@ MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
-		.of_match_table = of_match_ptr(adc128_of_match),
+		.of_match_table = adc128_of_match,
 		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
 	},
 	.probe = adc128_probe,
-- 
2.17.0

