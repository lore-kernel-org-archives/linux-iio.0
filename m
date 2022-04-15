Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CA1C4332F
	for <linux-iio@archiver.kernel.org>; Fri, 15 Apr 2022 08:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351575AbiDOIxD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 15 Apr 2022 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351534AbiDOIxB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2022 04:53:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3886B8236;
        Fri, 15 Apr 2022 01:50:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aferraris)
        with ESMTPSA id 6CF7B1F4024A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650012631;
        bh=97YXroeyDkQDT1z2Pkh9zbKqmO8YB3LrWCRnc+QZ/pM=;
        h=From:To:Cc:Subject:Date:From;
        b=R2iZCUxGUtu51GfEP0us/6f4qXcMLzQUz4z5gsV+kZcoCX6/2/MGpifOLm+uACjDc
         iIFgc3f2RBhEAbES2LCrGBnvZ//5oGNxGm43lQgQq4RMUkdRoscVKdcJ+A98raArmf
         nFoHcIIpWCYW8S4mzAVaJuribMeSFM26QCk33nhlQtnkCwdUVIRj0+pDW5PLtB1oGT
         PmQLHI2AWzUNEiPKkyTJ5luYBJXBgoEA3G2/IHZI9dY7lZ7/3Jnupyohr/T+I+jKcz
         wqfiynzKAea2LTqmj1H9DJ50JlCJigOmF/w+7MKgXrH/z9DXyKsX4Ga3/F+VNkySLL
         RFO9WmNBN2S8g==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 0/2] iio: stk3310: Export near level property for proximity sensor
Date:   Fri, 15 Apr 2022 10:50:16 +0200
Message-Id: <20220415085018.35063-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Userspace tools like iio-sensor-proxy need to be instructed the value from
which they should consider an object is "near". This threshold can be
exported through the sysfs ABI based on the "proximity-near-level"
device-tree property.

This patchset implements this property for the stk3310 driver and adds the
necessary bits to export its value to userspace. It is based on similar
changes applied to the vcnl4000 and ltr501 drivers.

Arnaud Ferraris (2):
  dt-bindings: iio: light: stk33xx: Add proximity-near-level
  iio: stk3310: Export near level property for proximity sensor

 .../bindings/iio/light/stk33xx.yaml           |  6 +++++
 drivers/iio/light/stk3310.c                   | 26 +++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.35.1
