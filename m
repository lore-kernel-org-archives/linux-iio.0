Return-Path: <SRS0=WqhK=5F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0859FC4332B
	for <linux-iio@archiver.kernel.org>; Fri, 20 Mar 2020 14:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07EB2070A
	for <linux-iio@archiver.kernel.org>; Fri, 20 Mar 2020 14:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="QQ7sDGO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCTOxI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:53:08 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:46893 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTOxI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 10:53:08 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584715986;
        bh=nGR6FoC3zIPpZzmPkRZ9wSj5EwBjWj7KQoDXqXEv5xQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QQ7sDGO4ReAidEkVRw6RxDk7q3Yml34QyaAUkrINtF6zSQFdlWBBMC2aBrJjrimaS
         AlBpjAtt7N67IQNZPkkTWsO9CxZIROXJhkA3ML/A6exr1HTQ5WRPCLanTMFJJ+CI4X
         kqIZtaALPub3oxErn1hpOJrBDO+WOYDRQ9RPQs/oUiw03jd4tPlToN82nO15SkFRx7
         xqCGiO6INIQZl27YsPM+x7xGcSu+YNoaNH99epk/1YbsHPVeW2HKKetG8ejYlUfXKg
         HS4yYFOsp2dfNk9zksvUTUbhmiLvCjIFkelDL4tkKolsADHgMgfdWYUH+G/vXJiZuJ
         VDuXPeylfauMQ==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v4 0/2] Maxim MAX1241 driver
Date:   Fri, 20 Mar 2020 16:57:32 +0200
Message-Id: <20200320145734.8262-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello again,

Here's version 4 of a patch series which adds support for the Maxim
MAX1241, a 12-bit, single-channel, SPI-connected ADC.

Changelog so far:

v4:

* Dropped explicit documentation of SPI reg property
* Reordered patch series so that dt bindings come first

v3:

* Fixed silly copy-paste error in Kconfig description

v2:

* Removed useeless header includes
* Dropped needlessly verbose stuff in _read and _probe functions
* Dropped useless GPL notice
* Lowered log level of shdn pin status in probe function, now it's
  dev_dbg
* Added proper error checking for the GPIO shutdown pin
* remove now always returns zero (man, I've been wrong about this for
  *years* now...)
* Added regulator disable action, cleanup is now handled via devm
* Drop delay_usecs, use delay.value, delay.unit
* Drop config_of, of_match_ptr call
* Dropped IIO_BUFFER, IIO_TRIGGERED_BUFFER dependencies, set SPI_MASTER
  as dependency, fix indenting.
* DT binding: use correct id, add reg description (looks pretty
  standard), dropped spi-max-frequency, fixed dt_binding_check
  complaints (oops!)

All the best,
Alex

Alexandru Lazar (2):
  dt-bindings: iio: adc: Add MAX1241 device tree bindings in
    documentation
  iio: adc: Add MAX1241 driver

 .../bindings/iio/adc/maxim,max1241.yaml       |  61 ++++++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max1241.c                     | 206 ++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
 create mode 100644 drivers/iio/adc/max1241.c

-- 
2.25.2

