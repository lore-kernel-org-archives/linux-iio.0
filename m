Return-Path: <SRS0=ocBO=SZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B63C10F14
	for <linux-iio@archiver.kernel.org>; Tue, 23 Apr 2019 10:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59F021773
	for <linux-iio@archiver.kernel.org>; Tue, 23 Apr 2019 10:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IBBBruDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfDWKk4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:40:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44030 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWKk4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Apr 2019 06:40:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so19537165wrx.10
        for <linux-iio@vger.kernel.org>; Tue, 23 Apr 2019 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btTL9Src8OMHiBtJIGeS5dbzyMMa/WPeso/IDgSPv7Q=;
        b=IBBBruDTaV2QUV09lzrP/sppkCNHJfChNXQQduOHBPduwO+bGelFjdjC2opy07gnt+
         LgAFX9YucxAixu3ZWzEcRy3HAgJrJrRS/VYToHENXWKWBVhAmtu6yLpKPJozdXQvHz4S
         kRJ3myAL/Xb1QcaUgTJ8JTAM1N8PiRkmUOziFLVelp7ZAob+kI7X561qEQ/BxXScqEX+
         OmEUcyBQ1Sp0/zlnw1X8osytDv6sfKreV89dHrm0wnSmvIzpOZhozuFl0O4wyeA1wrYw
         mzfL7FLrY9QfX8Qi3LmpLD6jZwuNM62j3am5xB3/bgS3TRpKDXU8rlAJftrDKJVIHsox
         Ai8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btTL9Src8OMHiBtJIGeS5dbzyMMa/WPeso/IDgSPv7Q=;
        b=aJwTJFDJF/ZF8RyU9FwecMPFY7p1SY6Q24npb2oLH6IefpGROlX7/kKHonew3r1Pj8
         3Hxl4pgJrVgcWhffnmn3MYAQbvKyekAavQeW/Qf0i5Meg+kPplGKh1IcBy2poquj3i8U
         hiq6wcdc3zyzgBULthhMqCFamoml1qbaYyvRyYGvsG/Q20CVrZbtG1O0su7GwHEDA7YH
         95LoNgeyAIQ6Rs8fbl9Fvm9QUORMPGyPOEu9nsacwKMKfh7eJKNkqNTh2zDhaUakHhVp
         QJnjXKCxmn1wDeJYtJTNrqqJdDKC50sfG2bAevNMBR0Znai2h3wwRhO0zDh9KWzuu5IO
         6kUw==
X-Gm-Message-State: APjAAAWuUg8NhsDtG9z83dCYU+d0OcFJSmzl/LzeN9nXY3RIPU5h8Aew
        EWdLbj512zXFIZiWY4hx5u1Gvg==
X-Google-Smtp-Source: APXvYqyYls1f85rWQ5VTem9Pji6VUfzQIQo2XWp6L/YMoLXfEkfRJOvgN3J4GF4mACN1GYUkrdiqcw==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr3904430wrm.21.1556016054381;
        Tue, 23 Apr 2019 03:40:54 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y5sm13329421wrw.23.2019.04.23.03.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 03:40:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 0/3] Add PAT9125 optical tracker driver
Date:   Tue, 23 Apr 2019 10:40:43 +0000
Message-Id: <1556016046-31231-1-git-send-email-amergnat@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PixArt Imaging PAT9125 is a miniature low power optical navigation chip using
LASER light source enabling digital surface tracking.

This device driver use IIO API to provide ponctual and/or buffered data.
The data is the delta value between two position traveled, depend on
CPI (Counts Per Inch) resolution setting chosen. The retrived data is
composed by two values, delta on the X and Y axis.

The devece support configuration through module parameter interface.

This patchset :
- Update vendor prefix
- Add the bindings for this device
- Add the device driver
- Add directory for optical tracker devices

Change since v1:
- Fix typo
- Rename some defines / variables
- Remove I2C client from driver structure
- Change type of delta_x and delta_y from s16 to s32 to simplify signed operations
- Add module parameter for axis resolution
- Replace "IIO_MOD_X_AND_Y" by "IIO_MOD_X" and "IIO_MOD_Y"
- Add sign extention macro
- Improve read value algorithm to avoid data loss
- Implement a trigger handler function which can work with any IIO trigger, independently of it own GPIO IRQ, to match with IIO requirement / behavior
- Replace iio push event function by iio trigger poll in GPIO IRQ handler
- Use triggered_buffer helpers to replace kfifo use, setup buffer, implement enable/disable setup buffer operations, IIO trigger allocation and reenable operations
- Remove useless "goto"
- Change GPIO IRQ handler from planified thread to IRQ thread
- Change GPIO IRQ trigger from low level and one shot to falling edge
- Add device unregister and buffer cleanup to driver remove function

Alexandre Mergnat (3):
  dt-bindings: Add pixart vendor
  dt-bindings: iio: ot: Add docs pat9125
  iio: Add PAT9125 optical tracker sensor

 .../devicetree/bindings/iio/ot/pat9125.txt    |  18 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/ot/Kconfig                        |  16 +
 drivers/iio/ot/Makefile                       |   6 +
 drivers/iio/ot/pat9125.c                      | 487 ++++++++++++++++++
 7 files changed, 530 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/ot/pat9125.txt
 create mode 100644 drivers/iio/ot/Kconfig
 create mode 100644 drivers/iio/ot/Makefile
 create mode 100644 drivers/iio/ot/pat9125.c

-- 
2.17.1

