Return-Path: <SRS0=YN3l=SN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C1DC10F11
	for <linux-iio@archiver.kernel.org>; Thu, 11 Apr 2019 00:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614EE20818
	for <linux-iio@archiver.kernel.org>; Thu, 11 Apr 2019 00:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfDKAgd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:36:33 -0400
Received: from lists.gateworks.com ([108.161.130.12]:4055 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDKAgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Apr 2019 20:36:32 -0400
X-Greylist: delayed 1447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Apr 2019 20:36:32 EDT
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1hENUf-0003Wh-Df; Wed, 10 Apr 2019 17:23:05 -0700
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id EE5ED1A42DD0; Wed, 10 Apr 2019 17:12:27 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device binding
Date:   Wed, 10 Apr 2019 17:12:08 -0700
Message-Id: <20190411001209.29488-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20190411001209.29488-1-rjones@gateworks.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
 <20190411001209.29488-1-rjones@gateworks.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 52ee4ba..0ef64a4 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -49,6 +49,7 @@ Accelerometers:
 - st,lis2dw12
 - st,lis3dhh
 - st,lis3de
+- st,lis2de12
 
 Gyroscopes:
 - st,l3g4200d-gyro
-- 
2.9.2

