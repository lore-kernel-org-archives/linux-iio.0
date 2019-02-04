Return-Path: <SRS0=dQzZ=QL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A01C282CB
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD31C214DA
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9KyE6ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfBDRA1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:00:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbfBDRA1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2019 12:00:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so676913wml.3
        for <linux-iio@vger.kernel.org>; Mon, 04 Feb 2019 09:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9qCpqJP82RdcTtRba0fR7RcEAMMQ60ffSXBQwSUjWE=;
        b=h9KyE6ZXlM2YU2lnlH+ueRSS5mlmESCUPuqJtlaF16l0w3MNC886AYlvXPdqfcII5m
         guuBv5u4uduqWZd0jh6ppg0pZ0GZvsI8VS8zu2uq/pZZ7e2lgmPyHotxIk7c1RpZbMJZ
         YdQqSHBhIKPP545R5HSdvtOzaP+X63h3TgMsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9qCpqJP82RdcTtRba0fR7RcEAMMQ60ffSXBQwSUjWE=;
        b=k7F4BV4m/2TqOR5deIX9vkprKPh7TUnYgEe56EL32z7VRlQOHUAF64moY+G4ceUZV6
         pc5O4JPudg61iH9jGneXIfxnQ/nXLXIjWDVrKfrZfZ7Tn9Su5yU5/tXdnSFrnJXhRkxB
         f/C2RSkrzNnmbVKfydKDd7zPqfwI7LltfYFzkMnZbaxIF5A8GMYe2DaCr1VZgS/Uk3mp
         CTpA7C+GjXvIv50iiV7QLDMQGZmaWQrtheRjLeAqj0g5gl9efW17LdV+WLt89UOflJlS
         +rleaiIxvwPxz95Tin4AmGbbdeO9SB7riAUQ6/e596DJ5Fx2dEc63WSXcTnF+XxRFQ7O
         Ldzw==
X-Gm-Message-State: AHQUAuZtcJtj/Yq4hKFq8oAGQwmr5SBYa13ifLf+HR2l++byiJH5DN6H
        p6hTM2rnXJ+JDl+KY5Ozlub5Rg==
X-Google-Smtp-Source: AHgI3IZoI2D+ABBarFO3A3oNBrnrnxYdJ23vbLBQM4nSZHT/K3T8F8h3GkXzwjjjiFx7QfQ26+m9zQ==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr240787wmi.57.1549299625223;
        Mon, 04 Feb 2019 09:00:25 -0800 (PST)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id i186sm19352297wmd.19.2019.02.04.09.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:00:24 -0800 (PST)
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
Subject: [PATCH 1/5] iio: gyro: add DT bindings to fxas2100x
Date:   Mon,  4 Feb 2019 17:00:08 +0000
Message-Id: <20190204170012.13617-2-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204170012.13617-1-rui.silva@linaro.org>
References: <20190204170012.13617-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the FXAS2100x gyroscope.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 .../bindings/iio/gyroscope/fxas2100x.txt           | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
new file mode 100644
index 000000000000..2aeef9aafec4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
@@ -0,0 +1,14 @@
+* NXP FXAS2100X Gyroscope device tree bindings
+
+http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
+
+Required properties:
+  - compatible : should be "nxp,fxas2100x"
+  - reg : the I2C address of the sensor
+
+Example:
+
+fxas2100x@20 {
+	compatible = "nxp,fxas2100x"
+	reg = <0x20>;
+};
-- 
2.20.1

