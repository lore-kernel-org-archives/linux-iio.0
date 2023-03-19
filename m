Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65987C761A6
	for <linux-iio@archiver.kernel.org>; Sun, 19 Mar 2023 18:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCSSrz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 19 Mar 2023 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCSSry (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2023 14:47:54 -0400
Received: from mail-108-mta67.mxroute.com (mail-108-mta67.mxroute.com [136.175.108.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204915CA0
        for <linux-iio@vger.kernel.org>; Sun, 19 Mar 2023 11:47:50 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta67.mxroute.com (ZoneMTA) with ESMTPSA id 186fb32f18d000edb4.005
 for <linux-iio@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Sun, 19 Mar 2023 18:47:45 +0000
X-Zone-Loop: 6cbea77e213038d1e31dbbdca910fa0228750b1f93fd
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
        From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=HAWoOm+ZxflWGZJgV9xgia88sCnGuTb7RfLy2KquJ2A=; b=g
        y0AM2SGpd60cPn2kzuI7pgnIRVN25yHGliHaXVv4L3hu+aJoX4WObOyB2ieb1OxsGcSEhJsxmCuZi
        Xci+rIA4FcqQS+UAtCc0SD0qMUHUTxIlZQiIEZvYdd9oJiTTNYnT2vInI0O/TY0XCC90iUTvq9Cau
        gGZ7/BRADkOoXGe8qCLSyxir1Nj2p9SaFT1ujm7XbH32VlYg3eN79CYhUGy/b5wOrBrU27w8HZegp
        xkCsYsvIM0tW9d6QiLR4Tc4yI0pn7MeftbOqd6UArVwsvx/pCzX3t5pZzQ5AxlPeToeECK9W7Sl83
        0j/mBfHTVMflGZqzjAgqmoQXkUCxq38kA==;
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: [PATCH 0/2] Add support for the MCP9600 thermocouple EMF converter
Date:   Sun, 19 Mar 2023 11:47:26 -0700
Message-Id: <20230319184728.49232-1-andrew.hepp@ahepp.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the MCP9600 thermocouple EMF converter.

Andrew Hepp (2):
  dt-bindings: iio: Add MCP9600 thermocouple EMF converter
  iio: temperature: Add MCP9600 thermocouple EMF converter

 .../iio/temperature/microchip,mcp9600.yaml    |  70 +++++++++
 drivers/iio/temperature/Kconfig               |  10 ++
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/mcp9600.c             | 145 ++++++++++++++++++
 4 files changed, 226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
 create mode 100644 drivers/iio/temperature/mcp9600.c

-- 
2.30.2

