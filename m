Return-Path: <SRS0=Obq9=BB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F0C433F4
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jul 2020 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFEC208E4
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jul 2020 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595438074;
	bh=nElaNXh083SqPfsMHAWTM5DuUhWEdDSGp78Oel7qlpY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RpPun7QaH/GiJZDvFtdCTtubQrKamHqaUpwZjGju6mCnJNuoAjrB8Utb/0fYxV1VK
	 eUVIuZZVzXzAE+RnTzazkIXk1v1eaVpRF2YHk1n/bNmu+ENtIlKNwWV70l6gVVss8o
	 JYkm93lG17wfHqRuq0afnyo0pNnOu/Kn+oD5hq6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbgGVROe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731569AbgGVRO2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 13:14:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC67206F5;
        Wed, 22 Jul 2020 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595438068;
        bh=nElaNXh083SqPfsMHAWTM5DuUhWEdDSGp78Oel7qlpY=;
        h=From:To:Cc:Subject:Date:From;
        b=oqHkshMzZ6u93F1knit4Y2PUi+AN456lAd0fEx6fNPynG4C3KRTttOk5lpqNqrc8X
         X71GK/VTEQQYm3+4gj9EwcUsWCJUzI73ff2XflrUePjn8cgPDEeqLemf1rsYgXP2mV
         v+uYxd/SZnXBbsnntk/JgjeYi0YLNaucDLBUgqaA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/3] dt-bindings: iio: adc: Maxim ADC yaml conversions
Date:   Wed, 22 Jul 2020 18:12:21 +0100
Message-Id: <20200722171224.989138-1-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These 3 are all fairly simple (I think) so should be uncontroversial.
My biggest question is with Jacopi and Akinobu are happy to be
explicitly listed as maintainers for these bindings.

Jonathan Cameron (3):
  dt-bindings: iio: adc: maxim,max11100 yaml conversion
  dt-bindings: iio: adc: maxim,max1118 yaml conversion
  dt-bindings: iio: adc: maxim,max9611 yaml conversions

 .../devicetree/bindings/iio/adc/max11100.txt  | 18 ------
 .../devicetree/bindings/iio/adc/max1118.txt   | 21 -------
 .../devicetree/bindings/iio/adc/max9611.txt   | 27 ---------
 .../bindings/iio/adc/maxim,max11100.yaml      | 49 +++++++++++++++
 .../bindings/iio/adc/maxim,max1118.yaml       | 59 +++++++++++++++++++
 .../bindings/iio/adc/maxim,max9611.yaml       | 49 +++++++++++++++
 6 files changed, 157 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max1118.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max9611.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml

-- 
2.27.0

