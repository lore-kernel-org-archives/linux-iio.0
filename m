Return-Path: <SRS0=Oeur=RQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B45C43381
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CF7213A2
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLCepy8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfCMSk0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35798 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfCMSkZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2019 14:40:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id y15so323398wma.0
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2019 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ABacVTFYKOyRAzmYJteZEmqXfSALh7oSBIxWHFHOOY=;
        b=TLCepy8FOeVa9C2PtKhgNKA8Qho8pUF2h1J/3Wt6T/bNCMir5ikceLtQ3VcUze0ZZP
         wVeuiMTFRV9zJWkLZxCc/Goe6CJBUubXA1oz9VsgAKnfIYDkunNpi3pkbYnlA1de4s4S
         oHtI+Fdau2gb46AtPLxpzV6LNWtWDWry6VmmfljIbNdFqjB6WYw5xxHTV3FHT7smsgys
         LA5ujwQz+itRD9BmnuDWchNDxQl7DID7wcmIBrSqnwsgwUpZrwQ4vxcMvCff3bpw6vZG
         DawkszQk51K2x256gcUe+00sksHeCdjwhGMtHSDzfWRpacPE8br2aRqVpNaLRwySSxWt
         yNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ABacVTFYKOyRAzmYJteZEmqXfSALh7oSBIxWHFHOOY=;
        b=btbo7pBUGbV5XsymbKKOBOjx2ujQl9TMs6Zc5asO3jCXyE/pxdwA1P90LbQaZhrjzh
         uP3USx+FdKF2ZycJ6qZPtEhQSB8puTb3cbU+kMRGI/BTzwEk2t3uPSznvUJfeP14zAp3
         z1YZUG4sYrZ2g9QV7TZ5vv2DCJu0BcnC9rKAOCIxBHMFHvMqvUkZza64W7d7wT9rChME
         9ZLwJcYDDeNQrLE6SVHUQIEZI1m66R2jSGModpqxjQbmCPAXbMdFNHGvN4wLQg4TperJ
         3w2nG6WsPb7W5aFt0I8kzRTqIM6ujo3vq59inoFSZTL3fG1Z4QUkJvyHTs3WJWHPi6tE
         H56w==
X-Gm-Message-State: APjAAAVat9iPB7iQVS3r4IOhr4F0GCWrs5pgjmur9zDgHHODiUhFfzvo
        oX+BFVLTxqL4/w+hwFt/Yad35w==
X-Google-Smtp-Source: APXvYqzv1KtTsiTqPiV1Diak+Vzftdu39cWKjtNmVAmFRgBuHCxrTn9AyzuPhUGeMSRrP37eHorCSw==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr3175218wmh.112.1552502423609;
        Wed, 13 Mar 2019 11:40:23 -0700 (PDT)
Received: from arch-late.localdomain ([87.196.73.151])
        by smtp.gmail.com with ESMTPSA id p17sm3829660wmi.35.2019.03.13.11.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:40:23 -0700 (PDT)
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
Subject: [PATCH v3 5/6] ARM: dts: imx7s-warp: add fxas21002c gyroscope
Date:   Wed, 13 Mar 2019 18:40:01 +0000
Message-Id: <20190313184002.2501-6-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313184002.2501-1-rui.silva@linaro.org>
References: <20190313184002.2501-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add entry to enable the fxas21002c gyroscope in the warp7 board.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 arch/arm/boot/dts/imx7s-warp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 58d1a89ee3e3..bf853707b104 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -238,6 +238,13 @@
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
 	};
+
+	gyroscope@20 {
+		compatible = "nxp,fxas21002c";
+		reg = <0x20>;
+		vdd-supply = <&reg_peri_3p15v>;
+		vddio-supply = <&reg_peri_3p15v>;
+	};
 };
 
 &sai1 {
-- 
2.20.1

