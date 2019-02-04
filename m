Return-Path: <SRS0=dQzZ=QL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58ADC282C4
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DBA2087C
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXLmLh1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfBDRAY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:00:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50682 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfBDRAX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2019 12:00:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id z5so647973wmf.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Feb 2019 09:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1l0DdTx7+5LTaHp0JhnZkIqDV7jA15PuRVbExFibVY8=;
        b=BXLmLh1TPP4N+X6WDxKXDJExVeomB43tB/PdbEvMJf5q5eJITHjS5TGASfGtJGNqrz
         /19fjxBaqEht22sNwNnxzZPOTHdgKn+p4P5md+f5PytCBVAFNfo2Sq766pW/4LMncvdx
         VeQ7uTSKMHOKFP6/V2lGTRiRjogI75eu0xVO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1l0DdTx7+5LTaHp0JhnZkIqDV7jA15PuRVbExFibVY8=;
        b=XNsBu/krTJEXo9p5+rKGy9UAwTirg6AT+kq1qxHWsrK9dUTyyi+Iqz5uXMr8+3Doy7
         FL+Q9yicfQvX33GXFOwVRd6nljYiYd1d8X8oMxMMTUWEHXuQnJSb+jYbkoxUOy6F9REX
         uHAR43qY7MaOh7y6/AshfxXGXtY5OOFtyEdNVImHfHjWDewKalBLEhNW3w5TAkNjvO/Z
         WSDPbIHUdNL+kVprcfFJ6dx8SqustmtTXXcbesTFnxkSCOqM87J4UmMNDNc17xfo8HiN
         hjMBjee/nKm551nJsdhiaYVPmKPM1UNbP9tknPvgeW3L4Ni9OOWpy9n1zthKfrjLzgkx
         pmzg==
X-Gm-Message-State: AHQUAubq9MwPvTwpR9NlOVBIitYff8wnSo8m/X7ihxMotr+a675RFsNn
        K8/2bljalYEDtEQUSKHUEFu/+Q==
X-Google-Smtp-Source: AHgI3IZ51qiKBZFB0OTdqDyG60umCVFE89GXPlvNhRpG9N8os6/y1XwPMyChXSwPBp5eYQZ28vxHKg==
X-Received: by 2002:a1c:2088:: with SMTP id g130mr271176wmg.122.1549299621896;
        Mon, 04 Feb 2019 09:00:21 -0800 (PST)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id i186sm19352297wmd.19.2019.02.04.09.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:00:20 -0800 (PST)
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
Subject: [PATCH 0/5] iio: gyro: add fxas2100x driver
Date:   Mon,  4 Feb 2019 17:00:07 +0000
Message-Id: <20190204170012.13617-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
This series introduce a NXP fxas2100x family tri axis gyroscope driver [0]
It add a core implementaiton plus an i2c and spi.

This device can be found in the warp7 board [1], where it was tested.

---
Cheers,
   Rui

[0]: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
[1]: https://www.element14.com/community/community/designcenter/single-board-computers/warp7/overview

Rui Miguel Silva (5):
  iio: gyro: add DT bindings to fxas2100x
  iio: gyro: fxas2100x: add core driver for fxas2100x gyroscope
  iio: gyro: fxas2100x: add i2c driver
  iio: gyro: fxas2100x: add spi driver
  ARM: dts: imx7s-warp: add fxas2100x gyroscope

 .../bindings/iio/gyroscope/fxas2100x.txt      |  14 +
 arch/arm/boot/dts/imx7s-warp.dts              |   5 +
 drivers/iio/gyro/Kconfig                      |  22 +
 drivers/iio/gyro/Makefile                     |   3 +
 drivers/iio/gyro/fxas2100x.h                  | 149 +++
 drivers/iio/gyro/fxas2100x_core.c             | 930 ++++++++++++++++++
 drivers/iio/gyro/fxas2100x_i2c.c              |  73 ++
 drivers/iio/gyro/fxas2100x_spi.c              |  70 ++
 8 files changed, 1266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
 create mode 100644 drivers/iio/gyro/fxas2100x.h
 create mode 100644 drivers/iio/gyro/fxas2100x_core.c
 create mode 100644 drivers/iio/gyro/fxas2100x_i2c.c
 create mode 100644 drivers/iio/gyro/fxas2100x_spi.c

-- 
2.20.1

