Return-Path: <SRS0=eOSc=4P=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE57C35E1E
	for <linux-iio@archiver.kernel.org>; Thu, 27 Feb 2020 18:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A16D2468F
	for <linux-iio@archiver.kernel.org>; Thu, 27 Feb 2020 18:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="M4ms9jty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgB0Sbq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:31:46 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:51280 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgB0Sbp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Feb 2020 13:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yQkfOLNuqw0s/C4iIr73jm/g+t03fJKekg1eS9M/yZg=; b=M4ms9jty0MbPPPh6W6xA8Nd0NJ
        psoAwSI57Rqlb3yCjZaXgUWWjaL+EvmG9cAC+S8dL6WegGFydhncHyitGhusrelfjv4+oKdbJH2EJ
        3VREg3rcOCg67Bdfi0jbA4nHyKNyOr9nAYmQ9C/SwZh5Czv0gwdkSeqNVD2ii5amwDBU=;
Received: from p200300ccff13fd00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff13:fd00:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j7NwX-0006yB-Kh; Thu, 27 Feb 2020 19:31:29 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j7NwW-0003oO-WB; Thu, 27 Feb 2020 19:31:29 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v6 0/7] mfd: rn5t618: Add RTC/ADC support
Date:   Thu, 27 Feb 2020 19:31:05 +0100
Message-Id: <20200227183112.14512-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the variant RC5T619 the mfd has an RTC. This patchset adds
support for it. To do so it adds the missing register defines in 
rn5t618.h and general irq handling for that.
It seems that the IRQ definitions are the same except missing RTC
for the RN5T618 but due to missing ability to test that they are
not added here.
It also adds support for the ADC, it is available in both the
RN5T618 and RC5T619 but due to missing ability to test that,
the subdevice is only added for the RN5T618.

It was tested on the Kobo Clara HD.

Changes in v6:
- put together with ADC series
- also added cleanup i2_device_id patch to avoid merge
  conflicts

Changes in v5:
- static rn5t618_irq_init
- PLATFORM_DEVID_NONE
- added some Acked-Bys

Changes in v4:
- use macros for IRQ definitions
- merge rn5t618-core.c and rn5t618-irq.c

Changes in v3:
- alignment cleanup
- output cleanup, remove useless toggling of alarm flag in rtc probe
- updated bindings description, so patch 1/5 becomes 2/6 and so on

Changes in v2:
- no dead code in irq code
- various improvements and cleanups in rtc driver itself
 
Andreas Kemnade (7):
  dt-bindings: mfd: rn5t618: Document optional property interrupts
  mfd: rn5t618: add IRQ support
  mfd: rn5t618: add RTC related registers
  mfd: rn5t618: add more subdevices
  rtc: rc5t619: add Ricoh RC5T619 RTC driver
  iio: adc: rn5t618: Add ADC driver for RN5T618/RC5T619
  mfd: rn5t618: cleanup i2c_device_id

 .../devicetree/bindings/mfd/rn5t618.txt       |   4 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rn5t618-adc.c                 | 256 ++++++++++
 drivers/mfd/Kconfig                           |   1 +
 drivers/mfd/rn5t618.c                         | 119 ++++-
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-rc5t619.c                     | 444 ++++++++++++++++++
 include/linux/mfd/rn5t618.h                   |  26 +
 10 files changed, 862 insertions(+), 10 deletions(-)
 create mode 100644 drivers/iio/adc/rn5t618-adc.c
 create mode 100644 drivers/rtc/rtc-rc5t619.c

-- 
2.20.1

