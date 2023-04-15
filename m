Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F30EC77B7F
	for <linux-iio@archiver.kernel.org>; Sat, 15 Apr 2023 23:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDOXMV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 15 Apr 2023 19:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDOXMP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Apr 2023 19:12:15 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3170B1722;
        Sat, 15 Apr 2023 16:12:14 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PzTbt5gccz9sTd;
        Sun, 16 Apr 2023 01:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681600330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HD1lsfuCz1zmXZ1k8I21GKrPVmmS4V4XSfqP1z1rnxs=;
        b=sjkypoBSYfW52x1wEsowcVqy8/+6bm5LndsugsDDzeX/CLxqpRCjKTxG8Y4J0C2RL6kgPd
        elMyC3w0nZ9aRch+zQg7EtRFN9UsxnKs5XBrRKf8NRj4a1QExvRUbujgbSgb37Rw7QRO8i
        jdmMgJY48SRm9Up8uskffZdOXSGuMNBxB5COb/FN8h0vAsOdtbwLoEbt20XQ9ka4IUJp+3
        pRhMaBHDDd+0lx8PQIt4hi/4O0k+JHqitV6Mv14ik4QR+jK8utwm4CyVhWBQ2JbG1knjcN
        PWcsX/VCgwtETaHexkQUI4zZnCqjFA8mjfk/RXwUL/IaYtBkmnVhjcaCBwwfpQ==
From:   Marius Hoch <mail@mariushoch.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH v3 5/6] iio: Comment that the LSM303D also has the Magnetometer DRDY
Date:   Sun, 16 Apr 2023 01:11:29 +0200
Message-Id: <20230415231130.115094-6-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-1-mail@mariushoch.de>
References: <20230415231130.115094-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Per its datasheet, the LSM303D also features that
pin.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 include/linux/platform_data/st_sensors_pdata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
index 897051e51b78..a657830232ae 100644
--- a/include/linux/platform_data/st_sensors_pdata.h
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -15,7 +15,7 @@
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
  *	Available only for accelerometer, magnetometer and pressure sensors.
  *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
- *	Magnetometer DRDY is supported only on LSM9DS0.
+ *	Magnetometer DRDY is supported only on LSM9DS0 and LSM303D.
  * @open_drain: set the interrupt line to be open drain if possible.
  * @spi_3wire: enable spi-3wire mode.
  * @pullups: enable/disable i2c controller pullup resistors.
-- 
2.39.2

