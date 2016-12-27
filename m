Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from augustus.math.duke.edu ([152.3.25.8]:51310 "EHLO math.duke.edu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751667AbcL0Kcm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Dec 2016 05:32:42 -0500
Received: from debian-x1yoga (93-173-18-64.bb.netvision.net.il [93.173.18.64])
        (authenticated bits=0)
        by math.duke.edu (8.14.4/8.14.4) with ESMTP id uBR934SQ004929
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <linux-iio@vger.kernel.org>; Tue, 27 Dec 2016 04:03:07 -0500
Message-ID: <1482829384.2098.13.camel@math.duke.edu>
Subject: Regression in hid-sensor-hub
From: Rann Bar-On <rann@math.duke.edu>
To: linux-iio@vger.kernel.org
Date: Tue, 27 Dec 2016 11:03:04 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit d443a0aa3a291e5f78072f2fa464e03bc83fafad (HID: hid-sensor-hub:
clear memory to avoid random data) stops screen rotation from working
on my Lenovo Thinkpad X1 Yoga using iio-sensor-proxy. Reverting this
commit restores function.

See bug at https://github.com/hadess/iio-sensor-proxy/issues/124

I'd be happy to provide more info if someone tells me what to provide!

Cheers,
Rann
