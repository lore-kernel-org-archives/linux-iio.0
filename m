Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5343AC61DA4
	for <linux-iio@archiver.kernel.org>; Mon,  6 Feb 2023 06:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBFGhV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 6 Feb 2023 01:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjBFGhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2023 01:37:19 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAE8193E5;
        Sun,  5 Feb 2023 22:37:06 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 431B743395;
        Mon,  6 Feb 2023 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675665424;
        bh=F4jlG/Oq76oS3Jh4bMwzJOE22LqpPfSLc/tM7zhROwk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=X6oSj9ghps96EJ2s5+ysoV6SSxGmOnZ4nhdwKa59aymdjjONS+UgmqA1lEiu9zVy/
         ezeflh9pVhUAq/KifaYNi3G4FboHutGjy4DnGcRX4ryrWhHKX1j97ymj7e1HDukOy7
         ZnM2TbprAYOW9BbHEyTNQy1a4F9L36c0Vf+cN2QCjepAo4u0NslCXtJKP8RHQUWqWa
         1SJvKp+Pz/PQ8qK4wrLvxABRPS3KwVdcHYayldpPB7E+3uN8SIv8TYT4A2YrBNIR/R
         RzmkDKdOfjs9q5nBr9Nu26qLBwtooYvFHfvEmHkvT68dD1jizNdFLm3S6WlV16wqAL
         3H2kgC1HhM+Bg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     hdegoede@redhat.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: cm32181: Unregister second I2C client if present
Date:   Mon,  6 Feb 2023 14:36:16 +0800
Message-Id: <20230206063616.981225-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a second client that talks to the actual I2C address was created in
probe(), there should be a corresponding cleanup in remove() to avoid
leakage.

So if the "client" is not the same one used by I2C core, unregister it
accordingly.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iio/light/cm32181.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index b1674a5bfa368..37439e103d273 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -488,6 +488,15 @@ static int cm32181_probe(struct i2c_client *client)
 	return 0;
 }
 
+static void cm32181_remove(struct i2c_client *client)
+{
+	struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
+
+	/* Unregister the dummy client */
+	if (cm32181->client != client)
+		i2c_unregister_device(cm32181->client);
+}
+
 static int cm32181_suspend(struct device *dev)
 {
 	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
@@ -531,6 +540,7 @@ static struct i2c_driver cm32181_driver = {
 		.pm = pm_sleep_ptr(&cm32181_pm_ops),
 	},
 	.probe_new	= cm32181_probe,
+	.remove		= cm32181_remove,
 };
 
 module_i2c_driver(cm32181_driver);
-- 
2.34.1

