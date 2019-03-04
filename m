Return-Path: <SRS0=hh5H=RH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E63C4360F
	for <linux-iio@archiver.kernel.org>; Mon,  4 Mar 2019 11:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2289520663
	for <linux-iio@archiver.kernel.org>; Mon,  4 Mar 2019 11:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1XiiH+DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfCDLMV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:12:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40745 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCDLMV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2019 06:12:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so5072717wrp.7
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2019 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kt+Hk5/oMuNB0FtHQXSEVhQxJl+kK6ZHXguTCM5Bsq8=;
        b=1XiiH+DHPD22LPCcQOXYW8hkyG8hMpajX3zQzlFpBqGikf6VFZIvjCVrhh7LcxOu9l
         mINZ35XkSO/p1k/VZbvjpsuAqK/OU7cKotpvnsPxR02YjaQV2RVGXKpjFgG0m/mI7suu
         VaZzbhGfZ9bbuOC5oFrOv1FLrlcFugLCpT6SUVXpTTu18ipBBUOBHrhphKovtKBAWP+d
         PW8sWJil70g2PZr66NACwQaUWGYQ5BiVDiGJsDokkdPowIWlEXB1YVJVJZktUo47Jscu
         BNFjowVmpcHAa7UsBdj49RSbwE5ff+DWZHlHnu0/FAQMNpKpM2bzRmam+oSGwYoAOGLY
         SKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kt+Hk5/oMuNB0FtHQXSEVhQxJl+kK6ZHXguTCM5Bsq8=;
        b=YWbfJcmalGPWryzDwygWGu3nE4S5VuxfyM9t55rwusWUkXAKQvwTdR5abpC6R0V8Ym
         LjYKI3V0yPPPG7GDNwOIUXxCCfkRKdkqjuvinLLM04ITbpuDcOrZDG191+FNt+TqkOn/
         EUXnhCV+1YCyMAYml6iiG1+UskmYrOSywYg1iV1wOHiEl9fjPBj9vk/eAqydpxsz1koe
         15JtdGrPQepkQNI6FvYQyVDLDk7NNO7FdzYlfGaZWnL5YUN/egxRYxPFNlcIz9jJL28B
         WESIi4RRezOfH+joVLnadLB5rJ6V0NmFo7Dh8x+cpewtxOdKwqISmLPfIgumdXf/0w+N
         8Pjg==
X-Gm-Message-State: APjAAAXtBdRhjiYck0aROzJn1tiKHbv9O/tCxosbGsWzZHtDTw8JkMsn
        F99DanKj4mOTLTs9CBXZTwVkz+L5W07RXQ==
X-Google-Smtp-Source: APXvYqxmtZiRHWjqyZ8LPaJKvzRXF1dSEQP7xsRNBQUM9LjMtG2cTEOoWkUweH2jMjpiSNfewul6Ng==
X-Received: by 2002:adf:f388:: with SMTP id m8mr12993720wro.133.1551697939218;
        Mon, 04 Mar 2019 03:12:19 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x22sm37727402wmc.19.2019.03.04.03.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 03:12:18 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-iio@vger.kernel.org, martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add Meson SAR ADC support for G12A
Date:   Mon,  4 Mar 2019 12:12:15 +0100
Message-Id: <20190304111217.882-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These patches adds SAR ADC support for the G12A SoCs, using
the same setup/configuration as AXG and GXL.

The only change is the clocks, they are now handled by the AO
Clock Controller, but it doesn't change the bindings or the driver.

Neil Armstrong (2):
  dt-bindings: iio: adc: document the Meson G12A support
  iio: adc: meson-saradc: add support for Meson G12A

 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt  | 1 +
 drivers/iio/adc/meson_saradc.c                            | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.20.1

