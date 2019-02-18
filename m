Return-Path: <SRS0=AGAg=QZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF1AC4360F
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F33620851
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="oGtwGp0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389807AbfBROD4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:03:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46022 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389789AbfBRODz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Feb 2019 09:03:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id d9so13871618edh.12
        for <linux-iio@vger.kernel.org>; Mon, 18 Feb 2019 06:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GTpjAPx1fakrDr6iX7ZaByuauFa8vRSnm2YIwlrmcQE=;
        b=oGtwGp0cHyc/ThOhI0NGYWLVDSrVX2SWB9ZJ86TRWH4C14DlC7FmlBqmeHKpbD4ucE
         vy/cFD//qkNVp/7JweqiNyeeg6fDH7HUF9mA0hk3Qp+XvmGXydwbBtQScNcqt99PQqJj
         fXJiLwhkrLzTHy8oWETYAmZeDKsH/sLeZhett9YfcfNF3hxuBS6vcRFn1IuHqEM0GQrJ
         scnLF3d9dBAcbYPSfUy/wulNDGyhsraiJpy/A78BMb5aGPAuPBzsm9QQa9gq2UtvAHin
         5jYZqBKuzSOiKZeBUYrIuuIng+KsDiIFRHsTEbrGCCOO34hD2CMy1H1kiXUMQDAfUcYo
         cHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GTpjAPx1fakrDr6iX7ZaByuauFa8vRSnm2YIwlrmcQE=;
        b=iooHXMqNkYeVofqPFWCBV6jaXVSlOtrXnydABCTrtGyBvftU6YE5r4fEyfNMFqYUKW
         NnZY85NxRpU0p2PwKr2nl9ou7oatBkZoR+5Hnab9n6ck0cGTbRJirDVbj16ZzvQt/M+X
         sAQSzkyef8jae0vXTFAAyEeQk/WGqiJde0hjOrZnvRqLAlbgowCpANMYy6KuYSMUakL0
         TPd3TxGp/5il+Exl1hrLiE12s7T35CLcwmop47nFAV92qU5zySJWOo5uacSfDeFk8+/5
         1C/ntbovzgMtbostkziNqLq8DzhluScbw0ak3v4MqCujWYeGfXtk/vypqgpnHgh1ffSI
         OPZw==
X-Gm-Message-State: AHQUAuakHrX0RdQu/MGIVMvx6Q4g+gc9/UPkX8P5LU5npSFhKCzIwVnG
        sHEBWh+LHMG8WBtmAhB2xwm4mw==
X-Google-Smtp-Source: AHgI3IaGiJP5XG+ub4Q/7liQMN3rjPdmMOiO1kL3JJ7SmjuWWM5ZIcTeHoTOJT8m3tJlRpqM6BKEYA==
X-Received: by 2002:a17:906:1552:: with SMTP id c18mr8653338ejd.64.1550498633824;
        Mon, 18 Feb 2019 06:03:53 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:03:53 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 6/8] LS1021A: dtsi: add ftm quad decoder entries
Date:   Mon, 18 Feb 2019 15:03:19 +0100
Message-Id: <20190218140321.19166-6-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the 4 Quadrature counters for this board.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index ed0941292172..0168fb62590a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -433,6 +433,34 @@
 			status = "disabled";
 		};
 
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter1: counter@29e0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter2: counter@29f0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
+		counter3: counter@2a00000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
+
 		gpio0: gpio@2300000 {
 			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
-- 
2.17.1

