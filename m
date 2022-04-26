Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6045EC433F5
	for <linux-iio@archiver.kernel.org>; Tue, 26 Apr 2022 13:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350684AbiDZNOT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350692AbiDZNOS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2022 09:14:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53C606E8;
        Tue, 26 Apr 2022 06:11:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s21so10713617wrb.8;
        Tue, 26 Apr 2022 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LEy+Ue17PZqCUHbRJqUlZDS57+AKNoDIEMCTOzZsirM=;
        b=Qd4lRkERQPMKrJ9lYUce+v+QLKbZsDJAku6Ra8COffAQNGenOj3lkgK6zAZ490cNBq
         phbxq3LDetuL2mhZgZAylyMxGKKrQCa8eme50Zs4rmSvZRzeyoYWzYKznJNDLiT0A6OM
         JTVWvKfNchSJ5SwdleRryzucdmOwsMxYWPQz4FIlg1tNBKf8MjFBmKAuvPig3dyIbHZM
         X5vH01xMKF5WTP+PSG+aouVXH52Rjuoq/Ksa4TPAdP/FEvZx1dWa735aOto4SDMwTIHe
         xoFFxY7yCbR7EbzOUweDIMzETuI7r3vLVq0Eq2AqcrvxkWWE4c2EegB8X0NUqDWUTxao
         4AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LEy+Ue17PZqCUHbRJqUlZDS57+AKNoDIEMCTOzZsirM=;
        b=I87fe9dICre6Q1Ze6dxy/FfOKhQQID9cqpEzcF7SGySmpaYHcyIjo85faTcwYsKDlK
         MO/KZBHCxmC/MYrH/YGtBdKhJWPTzmuZoWCcKi2ZiTdsLel21Pkonie3/0lZNyIRN6r9
         goO5WgAEhqiSgRy027acGUPrFxpHSy+gpC7MZeO2McS0ajbx2eruNSfxzOIzeoqFmLLu
         KrPCqMqB2itKFC4Delki3QBuwFLxp5xw6LGxZC+g5HCuMJ2m03gWaRWj3Zs2MRtZco3O
         ZCuR42uYZQi7Rr/Llmiw5dt6tXwjSi8awmK/qx3pZxIXAy23hySMajqL7Zk1QF9SxL1m
         byLw==
X-Gm-Message-State: AOAM530eGfEZIAYv+j2horS6ugeLGvFyNvL8igkTLILVbKCCFPo6hjMs
        JGiMxPhXLro+f/0tk4DkuKQ=
X-Google-Smtp-Source: ABdhPJyAVONtSIz54ZzKjTZMmtJ4wCHEGy/5DBhU9695T4VL6I3Dv2RJ0wnJRRd6gfE0z12sdxT/rQ==
X-Received: by 2002:a5d:6248:0:b0:20a:dd69:cf1c with SMTP id m8-20020a5d6248000000b0020add69cf1cmr7280460wrv.35.1650978669850;
        Tue, 26 Apr 2022 06:11:09 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:09 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 02/14] iio: document linear acceleration modifiers
Date:   Tue, 26 Apr 2022 15:10:50 +0200
Message-Id: <20220426131102.23966-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Introduce ABI documentation for new IIO modifiers used for reporting
"linear acceleration" measures.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d4ccc68fdcf0..aadddd43bf22 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -233,6 +233,15 @@ Description:
 		Has all of the equivalent parameters as per voltageY. Units
 		after application of scale and offset are m/s^2.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_z_raw
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		As per in_accel_X_raw attributes, but minus the
+		acceleration due to gravity.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_z_raw
-- 
2.17.1

