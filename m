Return-Path: <SRS0=AU7e=RJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF283C10F00
	for <linux-iio@archiver.kernel.org>; Wed,  6 Mar 2019 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECE520661
	for <linux-iio@archiver.kernel.org>; Wed,  6 Mar 2019 11:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="ohMKKSde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfCFLM7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:12:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39215 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbfCFLMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Mar 2019 06:12:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so9987563edc.6
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2019 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ou+uYUfe21KQvShwFfjSgk1lTlPUbyeUE0c8BFU5pzA=;
        b=ohMKKSdeSm8YddG5u+fHRRu+AsNlEbFGI7ONNyiR6e+siGjEpc8D8UP4Leq3JYTvkX
         PkPOf4P+oJqBWTlkDXnAONiSnP3/t6muPkybKtqOsHzSw14gP33djGLKMLWZoEAaXKJZ
         y1tJhqCERXBU4Bhf8JtLBbk4nZS0gT0715vQ84V/qVIX8aQH9x1hjL8zlPlOE6H6+VKb
         PA4Hc2yaFHkvwyuTxuxmNckb94mxvv0n/BZGGK4YOMaOIS/TbUbq0d6LEUCzAZDNdXOE
         DmbPWnv0BtkO+QiVVSn04QkWA62rLQkBFkKcIiaiVfe5Vu/tXs4IlyBfIVnZwOtvxtjE
         EhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ou+uYUfe21KQvShwFfjSgk1lTlPUbyeUE0c8BFU5pzA=;
        b=OabKvlCt9OdN6ixtdGaQxJ9uzPjGQIjU/BQzXgkRTfiPBGKhvtc1nTPvr/ivcwU6ms
         4gEiWtZ1l1I0pOkwnI+Wo6sOe6OhFM7s9LWA6rp/+mEG7Sio1X8Y1qsrP3E2FnquuVNV
         x6H21iRnE/RmDSZpqTe9gKLzmbkNbheySYqLaHMCBuA+1GxvLPOHMZlvE9P3C9SUzxhY
         SV6V2mLhyqsDbIVK2uF3nr4sSqj5CHQLjOOKdFmkKBmXoB06HTfywOoTynx5mcesm3fR
         TwDvgLFr3Z4yWqYNhLdysnnmKkm1gIwpBYWL9xPsuy9/qDPLgXodcBUd3rWLngKj2zYj
         +M8Q==
X-Gm-Message-State: APjAAAWuWkaUiGLxRtLnMBdtdjB0H0U8PdRmC35piBfPEpnwGJASyyOa
        3vq8DAB6ZKgfIFeev0wSqkyyDg==
X-Google-Smtp-Source: APXvYqwCCv7csnNhvhQhNOkqqUxyDvM29KCOy6mdzZIMpqluneX2ZReFH8S6i7ABQ32vYSsw29sF1A==
X-Received: by 2002:a50:b4db:: with SMTP id x27mr23421357edd.90.1551870752427;
        Wed, 06 Mar 2019 03:12:32 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 03:12:31 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
Date:   Wed,  6 Mar 2019 12:12:05 +0100
Message-Id: <20190306111208.7454-5-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

FlexTimer quadrature decoder driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
     - None
---
 .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
@@ -0,0 +1,18 @@
+FlexTimer Quadrature decoder counter
+
+This driver exposes a simple counter for the quadrature decoder mode.
+
+Required properties:
+- compatible:		Must be "fsl,ftm-quaddec".
+- reg:			Must be set to the memory region of the flextimer.
+
+Optional property:
+- big-endian:		Access the device registers in big-endian mode.
+
+Example:
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
-- 
2.19.1

