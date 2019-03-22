Return-Path: <SRS0=R23/=RZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5CDC10F0E
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17F0218D3
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3eHeEYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfCVUoz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:44:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52516 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfCVUoz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Mar 2019 16:44:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so3397252wma.2
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2019 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dGwFLD8KFkvXmQH2c7u6bv9W3nTucVU6GeNsRsfqjT4=;
        b=a3eHeEYIExUwl0sxRCoH/fuEJkpF6kJeLovfZ4vh+RtVZTUvXR5P9ZyNe1gBS6nB5l
         Ynx/7/xH8IBt6wWhGRLlfapcYHB72di9EESSNKZlTKSGf8zaPWhK5V5XGCLOXgc7OLyE
         75fdkxyosr/Z6A0F0nFEXgNPM3D3+bNVc2faN0Gl/cMNkDMYI/R+3vUhGfXlHMDhSovW
         W42WGAQHTKJp+inmKsDtKQLPH9XtQKYZUQGXnu9RW4WABZLrAonzp6rC2omjkAl122jM
         bm/O6uca9khgrK7rcUvfDougW1zTtYYuqYICBAO+OAnIF3r8/8lanC4TckBs/DeIKILL
         4kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dGwFLD8KFkvXmQH2c7u6bv9W3nTucVU6GeNsRsfqjT4=;
        b=kp3X7QOZ0drLcmpXWzj6Civ8ByjGIIZW3pk/epPE04enUt9GGyc4W0dTL19kkFBGBa
         Ge6WffXSlLUAXd9ssMsPElptlrh1TTzYGFx/BsoD06zAh31zYjKNIPuoK6sktDDLM+JQ
         wH4RNVWkEu0YZ9kU+KdpNQY2fhbYyggonCQywaQE3kHFXd3A/K+OiWTCJeVaKdZ1puRl
         nhVqhjFKmUUVrhrAjO6qxmncnyecJb/JP7942bKh82elOWNqAcY0+YLnaY+BuF30smKD
         xLMKSR0cLSqDtB4CQKByWWEJaq98Gitf5s026Kp6O2jXTpZqe/FpGdcw0HDazsrWMQQT
         JyfA==
X-Gm-Message-State: APjAAAVEBJL+PDodpuc5D9lWWoojamnA7ajjj1Wc8ZH/MfgMmcSIQ3+7
        doxwC5hM3SPiLZ0WKbbm7A88K30X
X-Google-Smtp-Source: APXvYqwRCfc9pfTcXf82vImXne35pHe+jLHkShQt17LBZ67ZZg9EAalbEpt6eRTidpldhH0PG4cHLw==
X-Received: by 2002:a1c:f718:: with SMTP id v24mr4435015wmh.1.1553287493252;
        Fri, 22 Mar 2019 13:44:53 -0700 (PDT)
Received: from localhost.localdomain ([188.24.4.251])
        by smtp.gmail.com with ESMTPSA id a9sm10436565wmb.30.2019.03.22.13.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 13:44:52 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/5] iio: imu: adis16400: rename adis16400_core.c -> adi16400.c
Date:   Fri, 22 Mar 2019 22:44:41 +0200
Message-Id: <20190322204442.4035-4-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322204442.4035-1-ardeleanalex@gmail.com>
References: <20190322204442.4035-1-ardeleanalex@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

This change does a simple 1-to-1 rename of the adis16400_core.c file. Now
that the `adis16400_buffer.c` file was removed, everything can be moved
into a single driver file.
But first, this rename.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/Makefile                          | 1 -
 drivers/iio/imu/{adis16400_core.c => adis16400.c} | 0
 2 files changed, 1 deletion(-)
 rename drivers/iio/imu/{adis16400_core.c => adis16400.c} (100%)

diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index c9f85126fbe1..4a6958865504 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -4,7 +4,6 @@
 #
 
 # When adding new entries keep the list in alphabetical order
-adis16400-y             := adis16400_core.o
 obj-$(CONFIG_ADIS16400) += adis16400.o
 obj-$(CONFIG_ADIS16460) += adis16460.o
 obj-$(CONFIG_ADIS16480) += adis16480.o
diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400.c
similarity index 100%
rename from drivers/iio/imu/adis16400_core.c
rename to drivers/iio/imu/adis16400.c
-- 
2.17.1

