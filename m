Return-Path: <SRS0=Oeur=RQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA7CC4360F
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DA22146E
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvir5drZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfCMSk2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45036 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfCMSk1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2019 14:40:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so3128408wrt.11
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2019 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83yOeT7jpEGLZ3WSC5kEEodmRHpZrlhkUDLCavBw4cY=;
        b=zvir5drZ11/HUH7v0W0a0qAk54wJo7Ss0hxC+PQOCiepzmeYB1ThKopUiNlLLBspMN
         79Tuieh6hbB/uh0AcxJYQIblp9LDy7ipQds5/wcVR4Lk8vgGmS7bM5p1pEv6gUer5cN+
         oWQi+Fws+ztLiva4iJ3YbBwT1rvwwez3Got1THFXwy9Rzi7tQ5dXS9iT68Wux/ODUoKV
         ZDGQKH1LKRZ4amAAr62aLuT8tVeJDldKWmHl/9vQp3WAlhRRwnKSuvzXxled9i9Tnviw
         0ZTrbP26UxvQ8Zb64hYzptsDoAtWEzn8zDBMmVMicEz3wM79qWk4uRgj1AojEvvHDSr/
         U+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83yOeT7jpEGLZ3WSC5kEEodmRHpZrlhkUDLCavBw4cY=;
        b=C6zVPt7mtOfxen1FMU8RMuGTgcIzRANMdieX19iGmNK8IEdiqltQQ2TcCZZ5t6lrUa
         zc3tzJXG5QlNNA5+DxrduhT6jIrcHkDGcsFotaccB7Z0Z0VQIfHsrQn8Q72QIMa302Q+
         f0ZBHMPwObta0xai9Eaj22GWhP9h4Srptd4zCoRKVTCiIcu9DY1iI6dgOio+pbNntJsY
         upBio15sNV3dIaIJgF3lv07OHenhv8OW6HNiNU4Vve8esXsO+XyX4jYQJdSbEq7MnvCV
         P2q+gYfJCECPs2P6fXxcrn+2scozJGeQREMKsuqwOY3i86oP6oHOJdt/h+OLu/tWKEmI
         1mHg==
X-Gm-Message-State: APjAAAXYhoOz+Wi5NYGfzIodpXlNJsCRd4Vai6NDrrn2bPK+thVxADqC
        NMFEoMv1y4PB4UdbVYyrfDlPuA==
X-Google-Smtp-Source: APXvYqzw9tWQ1v+7Tum1lfxQpaYJpJEE+YVrjpCftekPhaSTzvEhXtpZQ4SjHrYs4Gxvl3cBo/3bZQ==
X-Received: by 2002:a5d:6a0c:: with SMTP id m12mr10285212wru.57.1552502426207;
        Wed, 13 Mar 2019 11:40:26 -0700 (PDT)
Received: from arch-late.localdomain ([87.196.73.151])
        by smtp.gmail.com with ESMTPSA id p17sm3829660wmi.35.2019.03.13.11.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:40:25 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v3 6/6] MAINTAINERS: add entry for fxas21002c gyro driver
Date:   Wed, 13 Mar 2019 18:40:02 +0000
Message-Id: <20190313184002.2501-7-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313184002.2501-1-rui.silva@linaro.org>
References: <20190313184002.2501-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add me as maintainer of the nxp fxas21002c gyroscope driver.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8e0c9040736..a164bc9fc2d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10899,6 +10899,16 @@ F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	include/linux/nvmem-consumer.h
 F:	include/linux/nvmem-provider.h
 
+NXP FXAS21002C DRIVER
+M:	Rui Miguel Silva <rmfrfs@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/gyroscope/fxas21002c.txt
+F:	drivers/iio/gyro/fxas21002c_core.c
+F:	drivers/iio/gyro/fxas21002c.h
+F:	drivers/iio/gyro/fxas21002c_i2c.c
+F:	drivers/iio/gyro/fxas21002c_spi.c
+
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <fabio.estevam@nxp.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.20.1

