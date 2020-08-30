Return-Path: <SRS0=4tHJ=CI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090CC433E2
	for <linux-iio@archiver.kernel.org>; Sun, 30 Aug 2020 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2EE2078D
	for <linux-iio@archiver.kernel.org>; Sun, 30 Aug 2020 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598804075;
	bh=2cpBzI9+I4OZsb+HGKiW8U5e7n3qk32BLLJZXoQlVBE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gPuu/GA5w9xhFqdJEfsyUqJ0FkIE76tAtTPXu5NrvV3trB3JlSo3BE+HLTK+DAWEU
	 RQPHBZ6rX1stv1TnH08rfXv/fMQ1HEH5SCBGRK8BdMnDcdA/Z63vIxtX8AHmUkakVX
	 p1aJ485R8MTaUBGoK+Q2DazbbPmtCgYLiMdX9MFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgH3QOe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgH3QOd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 12:14:33 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C67B20707;
        Sun, 30 Aug 2020 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598804073;
        bh=2cpBzI9+I4OZsb+HGKiW8U5e7n3qk32BLLJZXoQlVBE=;
        h=From:To:Cc:Subject:Date:From;
        b=SuINqRlJJLcy/SfTsuiu8gLGpYBdZgBsm+x9gc5SEWtC/8/hY10o/5KmclgZvaz2j
         plYGWvDd6w0/lBMs/Wbgnf09npUerC+Q6Qm1KcxLaQBaw6tG/BRaVg265Kf9S95oFG
         uXjp6/Ec+CU5jrLI+VBggedMWnyqf6LbSyxpIBeQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/2] dt-bindings: yaml conversions of some simple ADC bindings.
Date:   Sun, 30 Aug 2020 17:11:52 +0100
Message-Id: <20200830161154.3201-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Remaining binding conversions for which changes were needed based on v1
reviews.

Jonathan Cameron (2):
  dt-bindings: iio: adc: ti,adc12138 yaml conversion.
  dt-bindings: iio: adc: ti,ads7950 binding conversion

 .../bindings/iio/adc/ti,adc12138.yaml         | 86 +++++++++++++++++++
 .../bindings/iio/adc/ti,ads7950.yaml          | 65 ++++++++++++++
 .../bindings/iio/adc/ti-adc12138.txt          | 37 --------
 .../bindings/iio/adc/ti-ads7950.txt           | 23 -----
 4 files changed, 151 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7950.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt

-- 
2.28.0

