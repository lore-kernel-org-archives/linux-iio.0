Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0078.outbound.protection.outlook.com ([104.47.33.78]:56792
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754357AbdKGGty (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Nov 2017 01:49:54 -0500
From: David Frey <DFrey@sierrawireless.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: bmi160 drivers
Date: Tue, 7 Nov 2017 06:49:51 +0000
Message-ID: <CY1PR02MB2091620DAA142CD469AE357BC7510@CY1PR02MB2091.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I was working with a vendor kernel based on an older version of Linux (3.14=
) and I backported the bmi160 driver that I found in a recent stable versio=
n of Linux.  That worked fine.  More recently, I picked up another slightly=
 newer vendor kernel (3.18) for a slightly different product and I noticed =
that it already included a bmi160 driver.  I was surprised to discover that=
 it was a totally different driver.  The driver appears to have been writte=
n by BoschSensortec (who makes the bmi160 hardware) and is available on git=
hub here: https://github.com/BoschSensortec/drivers

The driver in the regular linux kernel (originally written by Daniel Baluta=
 and submitted to this mailing list) is around 800 lines of .c and .h files=
.  The Bosch driver is around 37000 lines of .c and .h files.  I'm not sure=
 how the drivers compare in terms of features.  It seems that the Bosch dri=
ver is a bit older (based on the commit logs on github).  So I'm wondering:

Why were two drivers written?
Was there a discussion about which driver to include in the Linux kernel?  =
(I couldn't find any discussion on this mailing list)

Thanks,
David Frey
