Return-Path: <SRS0=dXrR=P6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2AAC37155
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E67217D6
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="keX0n0PJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAVCEu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:04:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42157 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfAVCEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 21:04:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so10943750pfr.9
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 18:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A5S4IBP0wL4Wp45lAk4Vx9FHPG78i64RpUvUAmANBbM=;
        b=keX0n0PJLRDWTAYQtXV7nGuK12sjngmi9oXCHHIANwFvBuR8ZYJEWeZTh5cxR3V80B
         CJuQcixiwMqKGyp3dHpgWMBCe2v+MN1LzutvArBvPfcQRJhv3k51v+2Vq9AlFBZIo/eC
         ZDGoXXhumhLAgGJy20fDvB1vMycyA3uM9QPbsgG003ldk3nQBVs0FOUdHOBX85zkU/FJ
         wlPAh48dq1EjervCJNDmsefn03b6ne5K3uViNJTzUO1lvZ/MO8Bs6zo05NDowJ84e73S
         L5hI+3Jw0fRYuY6RJQx1Qj/YJW1qCn2N82Oxm1GlQF0F1y2mYp4vt3TpyXyOHFvRaqP3
         jYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A5S4IBP0wL4Wp45lAk4Vx9FHPG78i64RpUvUAmANBbM=;
        b=lbkGHWF1pElO2pD3HfrRdecX8sf8N1X5YuV74n12AKgt2HConCj3FeGc6bcQ5TS67I
         yvOFsGlUcWntIseED9x0ZwXEMrRxgR+VXekXicl2uGOOx8HXcwzmuiIv3KjnFmzM2cwm
         y4VG7Q+v+9SxEjA2/py9m9L2KHjqK2npcntTFSYVCUxK4nbtbQosf/IWXRcVe6qTeNux
         53vakqBOrtPRU1E26zHqDb8rj6KfGddSKvulXLCAZ/L5JXvBRmc7cVCcgjMfRulRnkQU
         XoyQz9+FNuilQ0KpAykvvRL4JmiM3P39EcvyuKndeST+3LVfZkNGMY9JBrh0xASfkvyT
         +ohw==
X-Gm-Message-State: AJcUuke8kIwuE9r7/qqZ0bBMRU6ycj0aJa58st3uV0+YCR604R//84vo
        R3+kKLkBcHQcCrY7gERbsJuEqS31/yM=
X-Google-Smtp-Source: ALg8bN4TP9jXNTjg1S5Z0h5Ba8ENVoBPg5SIY72syUxLfJVg+Ssu5TP078poQx1swmn6fxLybOk8vw==
X-Received: by 2002:a65:4646:: with SMTP id k6mr25185414pgr.153.1548122688677;
        Mon, 21 Jan 2019 18:04:48 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id n21sm19759404pfg.84.2019.01.21.18.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:04:48 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org, Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v2 4/6] dt-bindings: document open-drain property
Date:   Mon, 21 Jan 2019 18:04:29 -0800
Message-Id: <20190122020431.5338-4-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190122020431.5338-1-martin@martingkelly.com>
References: <20190122020431.5338-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

We have added an optional boolean property for configuring a BMI160
interrupt pin as open-drain, as opposed to the default push-pull, so
document this.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 Documentation/devicetree/bindings/iio/imu/bmi160.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
index 1aec19997fb5..7eb4b6016404 100644
--- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
+++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
@@ -12,6 +12,8 @@ Optional properties:
  - interrupts : interrupt mapping for IRQ
  - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
    input, set to "INT2" if INT2 pin should be used instead
+- bmi160,open-drain : set if the specified interrupt pin should be configured as
+  open drain. If not set, defaults to push-pull.
 
 Examples:
 
-- 
2.11.0

