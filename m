Return-Path: <SRS0=JcFl=P3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B5C61CE8
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2BD2087E
	for <linux-iio@archiver.kernel.org>; Sat, 19 Jan 2019 20:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfASUsC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:48:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfASUsC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Jan 2019 15:48:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so18989227wrx.9
        for <linux-iio@vger.kernel.org>; Sat, 19 Jan 2019 12:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2px8/93ottbcGtT71HYaK8CPRc5LV3ZKHgNnSaHEeOM=;
        b=knVfpll0xSCAA7nYEQhAOiF235xFFzZaFNo8lSsrhD5iVRTAASu8eCgRPpmcT5w0kW
         XVCYJn2/zZbuXQ91EnuP511ZN7t0kuUngDPKkK/Njr89gfHdHjzb8WZhD4wdeAM0YfW8
         YwY3Y85dXb7fxT04TtlW70voSgS9dg+lVBq5S9yvTpXU7pwxDsIhIH2EODtk3HUAVFcm
         VRkQemBpuEX/KLncqI1YVuXzpgR+lRGxnchfR9EU9rUuz/k+RslSQ8w77OwqfcyleyZj
         rWvLFgY1jDVa9I3uoyJJAdcrC3joEJ9CU7aItrgMUsITFia4KjXt1mis1FDfzeSDed6m
         sefw==
X-Gm-Message-State: AJcUukcjml9MWsrLgSlw7S/8T3bDwscDHYxWXj0ZujS7C/+KAe0mpz0j
        OwJ9/h3KD/yjZ7p8BUYbDIVaKQ==
X-Google-Smtp-Source: ALg8bN67ttBW9dhrCDDMFZI3PWDjhAHT1R3xEZdx20PmlWXtY4R2iiLlS3I4pe/pgrM1xSMFdf42NQ==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr23404165wrr.285.1547930880306;
        Sat, 19 Jan 2019 12:48:00 -0800 (PST)
Received: from localhost.localdomain ([151.21.137.205])
        by smtp.gmail.com with ESMTPSA id k135sm48695244wmd.42.2019.01.19.12.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 12:47:59 -0800 (PST)
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        mario.tesi@st.com
Subject: [PATCH] dt-bindings: iio: pressure: add LPS22HH bindings
Date:   Sat, 19 Jan 2019 21:47:53 +0100
Message-Id: <75c2b56fcacf732d87cdfc11f947a1a275b95c6b.1547930719.git.lorenzo.bianconi@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547930719.git.lorenzo.bianconi@redhat.com>
References: <cover.1547930719.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix following checkpatch warnings:
WARNING: DT compatible string "st,lps22hh" appears un-documented -- check ./Documentation/devicetree/bindings/
		.compatible = "st,lps22hh",

WARNING: DT compatible string "st,lps22hh" appears un-documented -- check ./Documentation/devicetree/bindings/
		.compatible = "st,lps22hh",

Fixes: e5aab7b0d88d ("iio:st_pressure:initial lps22hh sensor support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index ddcb95509599..52ee4baec6f0 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -77,3 +77,4 @@ Pressure sensors:
 - st,lps22hb-press
 - st,lps33hw
 - st,lps35hw
+- st,lps22hh
-- 
2.20.1

