Return-Path: <SRS0=K6jb=SO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA11C10F0E
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E5C20850
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpKJpdRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDLQtM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:49:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42551 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfDLQtM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Apr 2019 12:49:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so12770545wrx.9
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2019 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NW4FHJVuyv1Xdt22HkzBW3/8jlCrIvjwbnytFoVpbYo=;
        b=XpKJpdRgl2XvbJ43WmgOUIVmWSibL4ujbmWZjwqLg+EgcJtVJRJz8g5gGtaCk9k9L7
         2u4jMmEfx3QC0iDmy3EZaq4+0hfXJnIeGCSmwADCKtU4HBIfKoSM5xs4s4LfMP8gAiph
         TQ6XTp4gmiWHw8wHMikjQkgaA2zvFi0/yjM2VJJ/BcRwyUHiA4HYWzOpMLSJCHRAfJQs
         jA9IN+TqTqUe2ZM8y3LKUX5BRzrA9QKWUE+qVwSlqv/eHlpm6cgL9PHKQg5oPW8DgCcn
         HXP++ulCmZAaz9+ZW8qe7JSuFEo1U6A+DPpIJh8E+qZ7RQaC4VVqXFUpp2tIchxtbVfB
         Ky/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NW4FHJVuyv1Xdt22HkzBW3/8jlCrIvjwbnytFoVpbYo=;
        b=IBAQshbcoLGFlcCg2PJ3gEMKxJ08t5dkqZvmrEAW6oR55RTmuZRevhQKsal4eEkmAD
         pzVH7SzDlgBgoU9pT7Tkeky0imoVPbK9ZuoroPd99hndNQ0nu0iCdds8PwGoico7pQ10
         J/xyOv3mn1hcqm0bppeo8/xFfpNTjqI225BhIPNdJtnbCeh05HHJsC0DZ546VPxgkJdr
         az0IQD4jAKTzT6S2KKt/HzNmh/zIcddZ67bM1MGe6FWHcoxaOuCJGo4ONETzxuppWiE9
         jNreu5Vay58PHxr3FQqlI/FGBN3C9pr9iz5NymCgu3wV2GDwtq0HdTght8w5UD/n4/cv
         ANoA==
X-Gm-Message-State: APjAAAXj8clENJBhnB2QTTN0VMwfqqKsIhPLc3oSMWZtavKiwoOiPz5r
        EdU+zcd6JzHXHDPu9MYye+Hzow==
X-Google-Smtp-Source: APXvYqzhYuIIid6UtQT8LCZMnbmg5SR/DMIOMddc/0HFE4HAHS4IW3QZ+NDeh4IkyQJWpHqlgFy/Gw==
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr477245wrm.221.1555087750068;
        Fri, 12 Apr 2019 09:49:10 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm73863141wrs.27.2019.04.12.09.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:49:09 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v6 0/6] iio: gyro: add core driver for fxas21002c
Date:   Fri, 12 Apr 2019 17:48:55 +0100
Message-Id: <20190412164901.2321-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
This series introduce a NXP fxas21002c tri axis gyroscope driver [0]
It add a core implementaiton plus an i2c and spi.

This device can be found in the warp7 board [1], where it was tested.

---
Cheers,
   Rui

v5->v6:
Jonathan Cameron:
  -  restore devm_ to some init calls
  -  remove blank line in .h header
  -  fix lock in trigger handler
  - use _chained

Rob Herring:
  - add reviewed by tag: 

v4->v5:
Jonathan Cameron:
  - remove init ret
  - change handle of iio register, buffer and trigger in probe and
   remove (I think this is what you mean, Jonathan)

v3->v4:
Tomasz Duszynski:
  - mention irq flags in bindings
  - add reference to drive-open-drain in bindings
  - fix headers files
  - drop comas in of_device_id sentinel
  - drop of_match_ptr
  - use probe_new

Jonathan Cameron:
  - disable vdd regulator in case of vddio fail
  - use devm_add_action_or_reset
  - simpler functions returns
  - remove noisy dev_info
  - remove EAGAIN from runtime_suspend

v2->v3:
Jonathan Cameron:
  - cacheline aligned (DMA safe buffer)
     Great presentation [2] and links in the presentation, thanks
  - global renaming, including filenames, fxas2100x->fxas21002c
  - provide spi info in dts bidings
  - Remove SPI_MASTER in Kconfig i2c patch and move it to right patch
  - remove extra blank line in comment
  - add break range_value_from_fs after found
  - in range_value_from_fs use local variable
  - remove mode check at mode_set
  - combine two if statements in mode_set
  - in scale_get return 0 and let caller to set IIO_VAL_FRACTIONAL
  - remove dev_err from vdd_io regulator get
  - handle regulator error path
  - devm_add_action
  - check unwind order
  - simplify data in _suspend and alike
  - disable regulators at suspend
  - error handling at _resume
  - return -EAGAIN at runtime_resume

Rob Herring:
   - Set label as gyroscope

- add interrupt to bindings
- add entry to maintainers


v1->v2:
Peter Meerwal-Stadler:
  - changed (c) to current year
  - add regmap include file in .h
  - fix comments s/cuttof/cutoff/
  - add more info in mutex comment
  - check value in range_fs_from_value
  - ret not checked in range_value_from_fs
  - move mode to enum type
  - remove line between value get and validation of value in all file
  - pre-write, regmap_field_write, post_write refactoring
  - check val2 and val == 0 in write raw
  - check in_anglvel_scale: 7.8125?
  - trigger_handler: 2 => sizeof(s16)
  - check buffer size
  - print %02% to output chip id
  - remove !! as state is bool
  - trigger probe return devm_iio_trigger_register
  - remove error msg in case of devm_iio_device_register
Fabio Estebam:
  - rename FXAS2100X to FXAS21002
  - change compatible nxp,fxas2100x to the exact support
  - add VDD and VDDIO regulators in bindings and driver



Rui Miguel Silva (6):
  iio: gyro: add DT bindings to fxas21002c
  iio: gyro: add core driver for fxas21002c
  iio: gyro: fxas21002c: add i2c driver
  iio: gyro: fxas21002c: add spi driver
  ARM: dts: imx7s-warp: add fxas21002c gyroscope
  MAINTAINERS: add entry for fxas21002c gyro driver

 .../bindings/iio/gyroscope/nxp,fxas21002c.txt |   31 +
 MAINTAINERS                                   |   10 +
 arch/arm/boot/dts/imx7s-warp.dts              |    7 +
 drivers/iio/gyro/Kconfig                      |   22 +
 drivers/iio/gyro/Makefile                     |    3 +
 drivers/iio/gyro/fxas21002c.h                 |  150 +++
 drivers/iio/gyro/fxas21002c_core.c            | 1006 +++++++++++++++++
 drivers/iio/gyro/fxas21002c_i2c.c             |   69 ++
 drivers/iio/gyro/fxas21002c_spi.c             |   70 ++
 9 files changed, 1368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
 create mode 100644 drivers/iio/gyro/fxas21002c.h
 create mode 100644 drivers/iio/gyro/fxas21002c_core.c
 create mode 100644 drivers/iio/gyro/fxas21002c_i2c.c
 create mode 100644 drivers/iio/gyro/fxas21002c_spi.c

-- 
2.21.0

