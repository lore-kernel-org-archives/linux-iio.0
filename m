Return-Path: <SRS0=Gvxw=OV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E5C04EB8
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB9D20839
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bC5J8Cb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB9D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeLLKSF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:18:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52255 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeLLKSE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Dec 2018 05:18:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4521675wml.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Dec 2018 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5cPT9GpxXrgDMs3kw5IDizeavtp1cLxDs1ZTvdIZdz4=;
        b=bC5J8Cb/CQucoJwy3nYWtDtVnsvSvrifYaIhS1dLDnGFpVqL/Xpq8U8+HdeLSEqQkZ
         buGQucrJJmkzZh2gEclTLhfNg7kXCaHDQmVADNVB4B6pLuTg9y6gGEqH6zUvdOtTyss2
         ZQC+bT6P/batiWMnLymqHBc+cij6WYQ3YXeEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5cPT9GpxXrgDMs3kw5IDizeavtp1cLxDs1ZTvdIZdz4=;
        b=h9SAgqqsfP3YxXT5s63uQwajts1o2kH2d3+nibpcC32SMp5Rsx+cyv77QWG2Fw1C80
         ce5WWyVh89B6+kRqJtnWtQZ7vQdLoOoreaHtkyn7YQO0wAqmuJHLejv+QEzUWPAg0Vd+
         REDO48pnip9DjBIBFYSsJtqpef4I6ZODRjsyR3zyZ4gAUj9qY0pFREN+0jQEJXVaENw7
         bf+jjPx6PJ+Hdn+4To5TCwQkVCtYXc6odj/a+CywasNFc/DQAkfNc/lm9Q2hRCc92VCw
         +LamJT6LkQDEvH15cUOlddv5zcIFaduH0+PrSGglL1WKUnHslXS37KinDp7jX87+vMhO
         F1eg==
X-Gm-Message-State: AA+aEWay3GULKCSf1ThSgSmcR261S84XdgsaL0lTdAyVKcMoamxO/+bH
        Ld00L/mzml2JAxZKhRoJVMTSyg==
X-Google-Smtp-Source: AFSGD/UE8kG8OHJ8N2Z4IRtb/u/nc5vLhFfgVyupf1J0TIGrt149TfXziZHVlyLWL6DodLiM1KyC5Q==
X-Received: by 2002:a1c:a84f:: with SMTP id r76mr5826388wme.16.1544609882818;
        Wed, 12 Dec 2018 02:18:02 -0800 (PST)
Received: from localhost ([49.248.93.253])
        by smtp.gmail.com with ESMTPSA id n17sm2179384wmc.5.2018.12.12.02.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:18:02 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, mka@chromium.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH v1 0/2] Expose thermal information for pms405 PMIC
Date:   Wed, 12 Dec 2018 15:47:53 +0530
Message-Id: <cover.1544599950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Expose the on-die temperature sensor on the pms405 PMIC through the
spmi-temp-alarm driver.

This series applies on top of the qcs404 DT series by Vinod[1]

[1] https://patchwork.kernel.org/cover/10675575/

Amit Kucheria (2):
  dt-bindings: iio: adc: Add binding for ADC on pms405 PMIC
  arm64: dts: pms405: Export PMIC temperature to thermal framework

 .../bindings/iio/adc/qcom,spmi-vadc.txt       |  1 +
 arch/arm64/boot/dts/qcom/pms405.dtsi          | 79 +++++++++++++++++++
 2 files changed, 80 insertions(+)

-- 
2.17.1

