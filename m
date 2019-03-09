Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2551FC43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 01:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C25204FD
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 01:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCIBOo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:14:44 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55565 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbfCIBOo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Mar 2019 20:14:44 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x291BhiH014171;
        Sat, 9 Mar 2019 02:14:16 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhknrys4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 09 Mar 2019 02:14:16 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A794934;
        Sat,  9 Mar 2019 01:14:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7AC52140C;
        Sat,  9 Mar 2019 01:14:15 +0000 (GMT)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Sat, 9 Mar
 2019 02:14:15 +0100
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1347.000; Sat, 9 Mar 2019 02:14:15 +0100
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Robert Jones <rjones@gateworks.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: RE: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device
 binding
Thread-Topic: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device
 binding
Thread-Index: AQHU05dsoL5QAYQjuUa31cW90B4/+qYCg0Jw
Date:   Sat, 9 Mar 2019 01:14:14 +0000
Message-ID: <2671a590a8394e76bd795c6bb187bfd1@SFHDAG2NODE1.st.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
 <20190305203252.13647-2-rjones@gateworks.com>
In-Reply-To: <20190305203252.13647-2-rjones@gateworks.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_21:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Denis Ciocca <denis.ciocca@st.com>

Thanks,
Denis


-----Original Message-----
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Robert Jones
Sent: Tuesday, March 5, 2019 12:33 PM
To: Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Robert Jones <rjones@gateworks.com>
Subject: [PATCH 1/2] dt-bindings: iio: accel: add LIS2DE12 sensor device binding

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

