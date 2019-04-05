Return-Path: <SRS0=FeK4=SH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33C4C4360F
	for <linux-iio@archiver.kernel.org>; Fri,  5 Apr 2019 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2987217D4
	for <linux-iio@archiver.kernel.org>; Fri,  5 Apr 2019 09:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="r/ZjpvBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDEJex (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:34:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34288 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfDEJex (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Apr 2019 05:34:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so9281612wmf.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Apr 2019 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fz9EPEHZSbLtHDD5+rIBQCaRRRyRpD3y58aszM7OC1M=;
        b=r/ZjpvBYAraw906oRFPytsbCsFtLER7NWdhTE/lL4LsI81FinGC3U4WChCLSbo+zCJ
         MVTplNBgCEZICA+TAlfuLdAXq26XRQkTANF4uhTgluM6+2MIfEZsRBa/lIJPb2iRUZMN
         EH3XSizxWy2RLGhjB13PAEtgF1AzFFuOY9d8proPEk5eTIPhOg1Rc3OO4DRDah3zAqNU
         IiMvv1C5FVILFeMX7vpDGu1zixJnT/WIs7Qe0zzU4J/HqB0ZfJ1FBXtigMYiHImi1Ion
         +WMIyMg5kcgsbbzM3TBELEItGQn8mEIO6B5yLwOPRrgKLmU0WfuJQ0zY7pN73jcqCaIq
         FPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fz9EPEHZSbLtHDD5+rIBQCaRRRyRpD3y58aszM7OC1M=;
        b=CRIzWJ7Ueymw0nftZuFGEHtq9VQ1STFF/lMGHWkTKOKU9rjXkQ4qXoUs/0mkub7JP/
         B5HeOa9h5sIS5y34PF2dgOV4jven5m0U36Y2NvEvm7QkTEh4gfWPFrECjePKJW+//vzy
         ILsqVmvH/81vNfc09RRl4sB0evpjXrqmlgmqGJlstO0HcP/OOjgAAMW1ksVeREuZMyA9
         nC6Qhas5f+Xbb6WUcchBkEXrnmtKXRUxjwBXyV40RmZc/B+jcBzHfv4YF6Jn0BHQZ7TF
         BsvSVfH8OljPcLHSIJzHXR26TuoLwwJZNALMPWTftWxLNE4Od/ejuTQrTdhsg7GKw3/Q
         ElHg==
X-Gm-Message-State: APjAAAXrtOOWLBN/kQxiHg6Wp6o5/nYIkQbrCkRXSHvmgSx+CJoItm0x
        FTyZ/+BaCLzYWLpmvmPycVcdCw==
X-Google-Smtp-Source: APXvYqz46289NmUfhiaVvoLkz5/puBjns4wtGK/R7y5t8anUa9l49SbrJo0UxzOkvnQxLFrG4rIFuA==
X-Received: by 2002:a1c:7d42:: with SMTP id y63mr7268106wmc.113.1554456891982;
        Fri, 05 Apr 2019 02:34:51 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t15sm1954128wmt.2.2019.04.05.02.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Apr 2019 02:34:51 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 0/3] Add PAT6125 optical tracker driver
Date:   Fri,  5 Apr 2019 09:34:27 +0000
Message-Id: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PixArt Imaging PAT6125 is a miniature low power optical navigation chip using
LASER light source enabling digital surface tracking.

This device driver use IIO API to provide ponctual and/or buffered data.
The data is the delta value between two position traveled, depend on
CPI (Counts Per Inch) resolution setting chosen. The retrived data is
composed by two values, delta on the X and Y axis.

Unfortunately, the device doesn't support "on-the-fly" configuration.

This patchset :
- Update vendor prefix
- Add the bindings for this device
- Add the device driver
- Add directory for optical tracker devices

Alexandre Mergnat (3):
  dt-bindings: Add pixart vendor
  dt-bindings: iio: ot: Add docs pat9125
  iio: Add PAT9125 optical tracker sensor

 .../devicetree/bindings/iio/ot/pat9125.txt         |  18 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/ot/Kconfig                             |  16 +
 drivers/iio/ot/Makefile                            |   6 +
 drivers/iio/ot/pat9125.c                           | 407 +++++++++++++++++++++
 7 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/ot/pat9125.txt
 create mode 100644 drivers/iio/ot/Kconfig
 create mode 100644 drivers/iio/ot/Makefile
 create mode 100644 drivers/iio/ot/pat9125.c

-- 
2.7.4

