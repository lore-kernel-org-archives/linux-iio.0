Return-Path: <SRS0=gFHn=OW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5969C65BAE
	for <linux-iio@archiver.kernel.org>; Thu, 13 Dec 2018 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C46520849
	for <linux-iio@archiver.kernel.org>; Thu, 13 Dec 2018 14:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=elementarea-net.20150623.gappssmtp.com header.i=@elementarea-net.20150623.gappssmtp.com header.b="wn2wxo1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C46520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elementarea.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeLMOoK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:44:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45891 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeLMOoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Dec 2018 09:44:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so2198244edb.12
        for <linux-iio@vger.kernel.org>; Thu, 13 Dec 2018 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=h2JlNyDoxsXlz2lbzn1cjh+9pV2K5+5zXFQeLooHKTs=;
        b=wn2wxo1EKXs5LGb5XlDQCcEC0wnrNf4g2TYY6LpfeI0HpnHnt1w93EBClyjlJBlUEi
         5uuyfDGy9lvvuVH6KwZ0CcMJD7Fxxlq1wg6wHb/v2G64VeRZF/9B8CbNwQ4C/+QGDS+o
         FGkSS5WJODH0NQjIzOo77yAOyk2Z/y2AwoIlLro+bqTxWL/h83M7ndg9cK4bKOwd5WbU
         xwP4jl/0dtEnGuMVjOsdNR8HwPdK8cQbt1L3vhuLfc/zuLmalti+q4WMrvl2wtZ/gVkp
         /FUsmppalLq6haVhutw1TkAd7KoTgrAhJCO4XMPMMesq/sMJaw+JQ+V2rfHqPZpSCmP3
         avKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h2JlNyDoxsXlz2lbzn1cjh+9pV2K5+5zXFQeLooHKTs=;
        b=RwNhzsh9JiqhbhBY844Umr3luyjWlQJFDonmfsdpK72louHNWJbYzUbzFSWtZAzu4u
         9ERrgWlRsYq3TYu5XKINLr6eWpGGYqNhQ7hUp/Ou/mqG3SRxsc2zdlxGTFpVw3juX+GT
         ys+NHaA9K5Xk4ToT9EtNpcIKddEt3D2THEa54V9h8GIWz5Xa9bOTd3ptjqBijsBQO72z
         gFsY2Jy4285t4cDpVvkmSw29YsxtAxqI9IE8ynoB2KVluLpZvJBGeTo5FcWxDwoy0bei
         M9JsqQisa7kDEvujZ/p3GemWSa6NTmHcFrEfCLeOGCbP1L201JhRPXoFURBRbkve2siX
         XUEg==
X-Gm-Message-State: AA+aEWbwNoaRyJ5uf30ezd/3TgvbbBcAycHrRVoCjr26+bVZilV0N50/
        S61uiZFVSZF9N1TVDO8YW66y5Q==
X-Google-Smtp-Source: AFSGD/XjPBMT6M23mYKO71Rb2A+D65o6NS98uMkmvSBeIlQ0NnnKnSyglwEvWfsC0FAKhDd2w3hr+g==
X-Received: by 2002:a50:f098:: with SMTP id v24mr22753937edl.78.1544712247950;
        Thu, 13 Dec 2018 06:44:07 -0800 (PST)
Received: from ch-sta-l-li0012.sensirion.lokal ([209.206.26.1])
        by smtp.gmail.com with ESMTPSA id q16sm656290eds.60.2018.12.13.06.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 06:44:07 -0800 (PST)
From:   Andreas Brauchli <a.brauchli@elementarea.net>
X-Google-Original-From: Andreas Brauchli <andreas.brauchli@sensirion.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: [PATCH v3 0/3] iio: chemical: sgp30: Support Sensirion Gas Sensors
Date:   Thu, 13 Dec 2018 15:43:21 +0100
Message-Id: <20181213144323.24820-1-andreas.brauchli@sensirion.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minimal SGP30/SGPC3 driver

Changes to v2:
* Strip all calibration params to give time to determine the preferred way
  of adding those to IIO. The sensor remains fully functional, just without
  humidity compensation, baseline support for resuming measurements, ...
* Split DT bindings into own commit
* SPDX License header
* Style and whitespace changes

(Different sender due to corporate server molesting emails)

Andreas Brauchli (3):
  iio: Add modifiers for ethanol and H2 gases
  iio: chemical: sgp30: Support Sensirion SGP30/SGPC3 sensors
  iio: chemical: sgp30: add device tree support

 Documentation/ABI/testing/sysfs-bus-iio       |   4 +
 .../bindings/iio/chemical/sensirion,sgp30.txt |  15 +
 drivers/iio/chemical/Kconfig                  |  13 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sgp30.c                  | 603 ++++++++++++++++++
 include/uapi/linux/iio/types.h                |   2 +
 tools/iio/iio_event_monitor.c                 |   4 +
 7 files changed, 642 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
 create mode 100644 drivers/iio/chemical/sgp30.c

-- 
2.17.1

