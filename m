Return-Path: <SRS0=2VwP=SV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44021C282DA
	for <linux-iio@archiver.kernel.org>; Fri, 19 Apr 2019 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D82B20449
	for <linux-iio@archiver.kernel.org>; Fri, 19 Apr 2019 19:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWvn93Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfDSTtS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:49:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33546 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfDSTtQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Apr 2019 15:49:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so5478222ljc.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Apr 2019 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZOcIlmLX3dga3jTDS2BWmUruJ92jKqSe7euCMBLjCRU=;
        b=aWvn93ZkgDGPEdmb+I28dgJGEg9Hy6rj2Y5m7T81ynPg3AY10JXm0MbivTQNnqMH49
         czsH0I9RJADGadilAqmg+NvlqomRYkui7SKAFB75cm5QPOLRei4t5Md92z7wqZP6/4CX
         Im7xuKx+fa/W6o4ItWkCf2f9D/QxoXeAVdqW6eCLjtEQiJawPHqH7r6dpmjNxhvTEjTg
         tNyD1U9+cZafmG8hki7Zkf6XxLt1meDs1c0C7c8HNCBLTODeQ8o4Yhh4u4NKCT3ik8lW
         0+9t65io14Bz6Hpx5kSP/Co317BncjyU4ZI98M5RqPHIl+wCLxhR5Gbz/hCfr8XtaZp9
         vnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZOcIlmLX3dga3jTDS2BWmUruJ92jKqSe7euCMBLjCRU=;
        b=RCB9gGf2YI+ht+d0Pk3vNueGyZJLFo1T1lWgefkTlDZpzwIjCLp4cGuopKGHuW5z3Q
         AzoIZuDqqvQx40WyTWE9L+EpsZIEQ2X2aGK1AwOuJmusjchI2M+CMkgkzYvQAaCsHnyJ
         EbWfOGV/TMxOfmJTV+/xV6yWYUB/9ZjjF6LoavdXDqmj7P+6gmqgMwtIex1CFxGrCuie
         j8uykLx/k4FYoBRybQNMmq67IzFHylBfmSawFmWa518NPqR+nIL4pyMRXkdPfv01QtVE
         TsezyJ5OvDKyPQBbtJWiIzO0bNLIDLlqZRyHBrZx0tXmDkHKETZHm2LQdwfPD8zENxA0
         K/rg==
X-Gm-Message-State: APjAAAXb2LjpZKyOLDQgKZtUXc7lXvVksRguPh55kdG0njEFuOiZWDR2
        vrUcdjX8Uz0KG7Yju0yoxPEJBRhZ58p1vA==
X-Google-Smtp-Source: APXvYqxfOZxLV/zvPjJ3HDv+Qm8aEBXwsIVVcaDkDDDIErHgHKDRZiXaoKtL3ULYH98YlsfKbR1Dsw==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr1594542lji.130.1555663022982;
        Fri, 19 Apr 2019 01:37:02 -0700 (PDT)
Received: from localhost.localdomain (93-96-157.netrun.cytanet.com.cy. [93.109.96.157])
        by smtp.gmail.com with ESMTPSA id q23sm876477ljj.44.2019.04.19.01.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 01:37:01 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org
Subject: [PATCH] drivers: iio: accel: Switch hardcoded function name with a reference to __func__ making the code more maintainable
Date:   Fri, 19 Apr 2019 11:36:51 +0300
Message-Id: <1555663011-8401-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It fixes the following checkpatch.pl warning:

WARNING: Prefer using '"%s...", __func__' to using function's name, in a
string

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 2 +-
 drivers/iio/accel/kxcjk-1013.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index b4e2d9b..44d7c49 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -394,7 +394,7 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 
 	if (ret < 0) {
 		dev_err(dev,
-			"Failed: bmc150_accel_set_power_state for %d\n", on);
+			"Failed: %s for %d\n", __func__, on);
 		if (on)
 			pm_runtime_put_noidle(dev);
 
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a5c9d3d..cbcf3ee0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -451,7 +451,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
-			"Failed: kxcjk1013_set_power_state for %d\n", on);
+			"Failed: %s for %d\n", __func__, on);
 		if (on)
 			pm_runtime_put_noidle(&data->client->dev);
 		return ret;
-- 
2.7.4

