Return-Path: <SRS0=yggj=RI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00269C4360F
	for <linux-iio@archiver.kernel.org>; Tue,  5 Mar 2019 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB60820842
	for <linux-iio@archiver.kernel.org>; Tue,  5 Mar 2019 21:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfCEVHS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:07:18 -0500
Received: from lists.gateworks.com ([108.161.130.12]:3940 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCEVHR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Mar 2019 16:07:17 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1h1Gtw-0002ww-S3; Tue, 05 Mar 2019 12:43:00 -0800
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id 5ECB51A430ED; Tue,  5 Mar 2019 12:32:56 -0800 (PST)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device binding
Date:   Tue,  5 Mar 2019 12:32:51 -0800
Message-Id: <20190305203252.13647-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20190305203252.13647-1-rjones@gateworks.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 52ee4ba..7f24b33 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -49,6 +49,7 @@ Accelerometers:
 - st,lis2dw12
 - st,lis3dhh
 - st,lis3de
+- st,lis2de12-accel
 
 Gyroscopes:
 - st,l3g4200d-gyro
-- 
2.9.2

