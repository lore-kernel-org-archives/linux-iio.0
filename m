Return-Path: <SRS0=j1Ua=6I=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79405C54FD0
	for <linux-iio@archiver.kernel.org>; Fri, 24 Apr 2020 22:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC6E2076C
	for <linux-iio@archiver.kernel.org>; Fri, 24 Apr 2020 22:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE9fLCA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDXWo6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgDXWo6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 18:44:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B382C09B049;
        Fri, 24 Apr 2020 15:44:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so4283232plp.9;
        Fri, 24 Apr 2020 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IctmcKVOOAVYgdyXKfTSzCCKWIaVQfFQKuxPl0Wscfk=;
        b=pE9fLCA/IEtAlUAL4sy61JNQke3INPN0IRoa8r6wOH5E8nm7VQcJThawifU7hhXA10
         BiJiGotppEzamIOzyK4nKJp25Tx6hW/47/XdSd7k4bbT+FaCCwz9sC1fwJrW6a0lOLdO
         1KaEkMMZY4ESNKvY9sURs3pGdRFphHbqswZMpwM6mfdMZQ5oEOg5U2GZSTUnA1w23emn
         YAostTvHFNVoMaljQSXVRJN9rCPoao7kjhRgnp27iwJQK4RwLWbN0bdao9K0vCO+D5zt
         SGMLoUPXRmJ8cAJNdJyvfPyigThnRdiiHbj+e78K62bwU9NHVvOkIcjM1c+D4+03V0Xu
         l3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IctmcKVOOAVYgdyXKfTSzCCKWIaVQfFQKuxPl0Wscfk=;
        b=mSv+AvG7eDwlKP86aOaD62K70DDhtXHHmidzUWeVHUvfhk9EJ5vyFWFIbscsK5n7CB
         ofMBc3YE3Yq/TAJOZ1eMel3A1BAoK6/WMG26ArbXppomdJn8/jClICgzhrG9gEru2J3q
         AFKAxQ/xyzagsmXW/f/XNhM8gQShdhnZbMipXHQdplYhABQbEXnK7oG9WHvDuF5sYhNb
         6TDCWEVxVg2G3fM9EiCETTffYgEQ6UE67nGmIyo3VojD0oBlVUmAQuF/WaI3A8sEcXTR
         Dc8/HiszwNAdpDPL/KISZzf4Cj6JGIV3MHAOtYxVqDfk99s0KqqPYNwp4ArrmH+Wc2dg
         bIxg==
X-Gm-Message-State: AGi0PuYFBhRrdKs/WqmTCMrSsuzuaixfkH1xE194BWnzO/fYg4+O+pRh
        6x2Q3yRNZa3gyw3vyoGTQ3M=
X-Google-Smtp-Source: APiQypJvJRRXiQFGKKHwjzs/zGzcW0IeH1EBSBzfuC6dzj8GgxlPR3r+kUCEGFgD6nMz2zCZJagTjQ==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr11984813plb.285.1587768297777;
        Fri, 24 Apr 2020 15:44:57 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:610b:e3c6:8c8d:27b8:7b5b:c4d9])
        by smtp.gmail.com with ESMTPSA id l137sm6748838pfd.107.2020.04.24.15.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:44:57 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, alexandru.Ardelean@analog.com,
        nish.malpani25@gmail.com
Subject: [PATCH 2/3] iio: accel: kxsd9-i2c: Use mod_devicetable.h and drop of_match_ptr macro
Date:   Sat, 25 Apr 2020 04:14:38 +0530
Message-Id: <20200424224439.5601-3-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424224439.5601-1-nish.malpani25@gmail.com>
References: <20200424224439.5601-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enables ACPI DSDT to probe via PRP0001 and the compatible property. Also
removes the ifdef protections for CONFIG_OF.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 drivers/iio/accel/kxsd9-i2c.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index b6f3de7ef8ea..b580d605f848 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -2,6 +2,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
@@ -36,15 +37,11 @@ static int kxsd9_i2c_remove(struct i2c_client *client)
 	return kxsd9_common_remove(&client->dev);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id kxsd9_of_match[] = {
 	{ .compatible = "kionix,kxsd9", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, kxsd9_of_match);
-#else
-#define kxsd9_of_match NULL
-#endif
 
 static const struct i2c_device_id kxsd9_i2c_id[] = {
 	{"kxsd9", 0},
@@ -55,7 +52,7 @@ MODULE_DEVICE_TABLE(i2c, kxsd9_i2c_id);
 static struct i2c_driver kxsd9_i2c_driver = {
 	.driver = {
 		.name	= "kxsd9",
-		.of_match_table = of_match_ptr(kxsd9_of_match),
+		.of_match_table = kxsd9_of_match,
 		.pm = &kxsd9_dev_pm_ops,
 	},
 	.probe		= kxsd9_i2c_probe,
-- 
2.20.1

