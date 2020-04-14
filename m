Return-Path: <SRS0=scjX=56=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA3C2BA19
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 15:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B13D2076B
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586878480;
	bh=SN5ZTVK7nvLPl6VpFQWXAJDJJlaB2vSB6I6K2ZIHGnw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yFXiDQWGHDAkEEkPL/8L9/65VgI8NZKcKjKHp+tcEVSm2hs7teYlGi7JbWe0/zT8L
	 i8ePBhUEfZvhen8Kn4s75EUgd0OZkzij2qV2ZtzRENJHpy/KtUfX+gkzCzb+zmTefg
	 +Dgy0cqkrbhaCRikTa5XtTodjU/DjSoaMuTamrPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439777AbgDNPeb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgDNPe2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 11:34:28 -0400
Received: from localhost.localdomain (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF2E20678;
        Tue, 14 Apr 2020 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586878468;
        bh=SN5ZTVK7nvLPl6VpFQWXAJDJJlaB2vSB6I6K2ZIHGnw=;
        h=From:To:Cc:Subject:Date:From;
        b=ZTegi0bFhcqVvV+SAHuqGdklvjYdN09kY8GLnNLCtOG6TXMox7Trm3zktu3ssK0FI
         ToYhyRWCH1Ae/DfOlBtjUralfxCQS3vuDA6BaZFeSQRR4yadlwVmnZrV6fIT+Tvcco
         stpNeHRWCgSBibF7Za/u9oPB0HK/0nlQZE/OmHDY=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 0/3] Add Reset and Wakeup support for CCS811 
Date:   Tue, 14 Apr 2020 21:04:12 +0530
Message-Id: <20200414153415.957-1-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Hello,

This patchset adds external reset and wakeup support for CCS811 VOC
gas sensor. The nRESET and nWAKE pins available on the device are
utilised to provide these functionalities.

The patchset has been validated using CCS811 connected to STM32MP1 based
board over I2C.

While at it, the devicetree yaml binding and OF match table for this sensor
are also added.

Thanks,
Mani

Changes in v2:

* Fixed DT binding schema and switched to dual license (GPL/BSD)
* Returned actual error code from devm_gpiod_get_optional()
* Dropped of.h include and of_match_ptr()

Manivannan Sadhasivam (3):
  dt-bindings: iio: chemical: Add binding for CCS811 VOC sensor
  iio: chemical: Add support for external Reset and Wakeup in CCS811
  iio: chemical: Add OF match table for CCS811 VOC sensor

 .../bindings/iio/chemical/ams,ccs811.yaml     | 51 ++++++++++
 drivers/iio/chemical/ccs811.c                 | 95 +++++++++++++++++--
 2 files changed, 138 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml

-- 
2.17.1

