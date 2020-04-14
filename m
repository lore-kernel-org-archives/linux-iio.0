Return-Path: <SRS0=scjX=56=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8CC2BA19
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D8720774
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586889726;
	bh=EhY9S7dYktQbTuIZZ+wU/JMgDZdSEmh036QER0H/G2M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gHGN8f4wbhtwqu3AG9VS7yEe+KyJzxHqqrqVB+e1BDQB9PxABMVkuIqzkR6c1fe9Q
	 M+0L6ldgJIxIMXHApuubgwyU8mhdDzUrAJfMmhdnHbMJMpRb+CXzlEPGfZwH+DPkmm
	 H5YHmQm+KFN2hETEMQ+FglFp8B4GOKT3B8lvJs2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504167AbgDNSmE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504161AbgDNSmA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:42:00 -0400
Received: from localhost.localdomain (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E0920575;
        Tue, 14 Apr 2020 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586889720;
        bh=EhY9S7dYktQbTuIZZ+wU/JMgDZdSEmh036QER0H/G2M=;
        h=From:To:Cc:Subject:Date:From;
        b=U4ZF0K8SxXm5K4rBnwdSwk7lQv4BmApw+SQ1/NgzveVvzzZEZ00gZRpc6nY1IoG2l
         XCgHn+7N1x8iFSxpTXMaH6ZvERfoJo+wPSPt5lkc6sIdQrwytgD882sSKCA/RvByvU
         Da0zFbYLM+0tDK91cfVRWz6rjnkks2qjvxzdgagU=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 0/3] Add Reset and Wakeup support for CCS811
Date:   Wed, 15 Apr 2020 00:11:44 +0530
Message-Id: <20200414184147.4857-1-mani@kernel.org>
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

Changes in v3:

* Added ccs811_set_wake(false) to all error paths before calling it actually
* Added Andy's reviewed-by tag
* Added comment for reset procedure and dropped error print for gpio request

Changes in v2:

* Fixed DT binding schema and switched to dual license (GPL/BSD)
* Returned actual error code from devm_gpiod_get_optional()
* Dropped of.h include and of_match_ptr()

Manivannan Sadhasivam (3):
  iio: chemical: Add support for external Reset and Wakeup in CCS811
  iio: chemical: Add OF match table for CCS811 VOC sensor
  dt-bindings: serial: Add binding for software flow control in STM32
    UART

 .../bindings/serial/st,stm32-uart.yaml        |  15 ++-
 drivers/iio/chemical/ccs811.c                 | 112 ++++++++++++++++--
 2 files changed, 115 insertions(+), 12 deletions(-)

-- 
2.17.1

