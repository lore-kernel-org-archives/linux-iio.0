Return-Path: <SRS0=b3IJ=CT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD35C433E2
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0AB20C09
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 18:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFnTYk3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIJSFd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgIJSFS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 14:05:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A3BC061573;
        Thu, 10 Sep 2020 11:05:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so4652077pgd.5;
        Thu, 10 Sep 2020 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbUyJpejCvA3QH4e+Y9L0OkTzMxPfcFa5isJNJNYA7E=;
        b=rFnTYk3kalLjbRQHngSb/t19D4EtEitgTtgTaWIoBT/vs85zoyWHRg0R5iKsQDM8fq
         UVNLyQurv0ZwippbcCdjNojPWIXGR35uIsowLwkOCiK6dWifkl3jsjZHkqyDr1xhZhKL
         +RQz0/LS9EUM9ZcrzNL+/StM0CIhmlpIXsck4gQ5WLrX0ep9rT2ubj5qKMAVuZVxvb3Z
         UzfBU/wdisoQcwBlJiRybtvPcTrMWHy+iuCprfzB16QbXOktzO/Mln6YIwVdxh15N/zp
         TgnTZKwcuTmLxqWYy4DikDwcUdk2bo82uhQ5tst1q6kQ/knDejt/isrmpFs/De3raBZu
         L/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbUyJpejCvA3QH4e+Y9L0OkTzMxPfcFa5isJNJNYA7E=;
        b=eLJBh9DzCBBcNrHsv06VPvc2HgRxALwtO/zmCzT2EokzNi9B+bFW8Qh/+/mOFTABUN
         T8dtFohv+5/4GDcj5TmKNfQRJJktCbirBZp+aFOUmT6YY3czUzqiPNcGmQrSgN6ULTPi
         exaYALRBFbyGsTTb06BYrHluYzJx4dmeQsjlLNghYZjURV4VFG4Y+a1SbX9DOI91hcPl
         5aDhkgv93xBuL2zUio1cslXxLTQBFZ4PBOCAt5Z6XZl24JKSwiDYSXrDTdgH9TOYQKjI
         05Ef0D3Jvvl6qtQEirbUnAkwVIheCv1r8uaoaahxMUO/5IwhGKAKld816xS2j5gZ1kiZ
         jsPg==
X-Gm-Message-State: AOAM531yFPyQYwdHKMKvJ6JiM7C9E+nFcwNwUNfsm1jv4xD5R05sDnqR
        FEo3jLfWAFEze1pRmIe/8g7lP7KA118=
X-Google-Smtp-Source: ABdhPJwrXbIa5IjH+meDBbNT3ln3vgWA7C+RElpoZ+bxyZNXiOlZC+Q/3NY5ishRbJ7b7cgMfXZCgQ==
X-Received: by 2002:aa7:9297:0:b029:13c:1611:653c with SMTP id j23-20020aa792970000b029013c1611653cmr6824116pfa.14.1599761117096;
        Thu, 10 Sep 2020 11:05:17 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6218:54d7:9928:e984:12bb:783d])
        by smtp.gmail.com with ESMTPSA id y29sm7252536pfq.207.2020.09.10.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:05:16 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [RESEND PATCH v3 0/3] iio: gyro: adxrs290: Add triggered buffer & debugfs support
Date:   Thu, 10 Sep 2020 23:34:47 +0530
Message-Id: <20200910180450.29696-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce DATA_RDY trigger for triggered buffer setup; this enables continuous
data capture. Additionally, add support for direct register access using the debugfs 
iio interface. 

The device-tree bindings documentation illustrates an example of using a GPIO irq
line to trigger a data capture.

Nishant Malpani (3):
  iio: gyro: adxrs290: Add triggered buffer support
  dt-bindings: iio: gyro: adxrs290: Add interrupts support
  iio: gyro: adxrs290: Add debugfs register access support

 .../bindings/iio/gyroscope/adi,adxrs290.yaml  |   6 +
 drivers/iio/gyro/Kconfig                      |   2 +
 drivers/iio/gyro/adxrs290.c                   | 237 ++++++++++++++++--
 3 files changed, 231 insertions(+), 14 deletions(-)

-- 
2.20.1

