Return-Path: <SRS0=Gvxw=OV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E4C67839
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CC92080F
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 17:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="R3vDK1XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CC92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeLLRBt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:01:49 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:58934 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeLLRBt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Dec 2018 12:01:49 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <localhost>
Received: from localhost (unknown [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Wed, 12 Dec 2018 18:01:42 +0100 (CET)
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 0/2] staging: iio: adc: ad7280a: channel and attr init refactor
Date:   Wed, 12 Dec 2018 18:02:26 +0100
Message-Id: <20181212170228.28498-1-sst@poczta.fm>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1544634104;
        bh=zU9L/syhsmocuSGWkrDkrIhDpFyMiQck4HIXDvx3TII=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Cc:Subject:
         Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
         X-Interia-Antivirus;
        b=R3vDK1XW6kb52ocSu4SUTc/C3CB6tbrQ6HVtlEDboORjUV0YIsqqONH52dTj0NqwP
         UxTwOLlq/xhUdIEW3tpn/a4obOOaCebIBCf79wllzRcWQ13MgBMgBPYPJ/PytppWXq
         n/j66PmWSP4M+2gHRustvdeJM6y8xDqOkM2Wlao8=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This small series enhances the readability of the code by refactoring the
ad7280_channel_init and ad7280_attr_init functions.

The readability is enhanced by splitting the functions into more functions that
do more specific operations.

Since v1:
* The patch "staging: iio: adc: ad7280a: add braces to complex for loops" has
   been removed. It's not needed anymore.

Slawomir Stepien (2):
  staging: iio: adc: ad7280a: split ad7280_channel_init() to more
    functions
  staging: iio: adc: ad7280a: split ad7280_attr_init() to more functions

 drivers/staging/iio/adc/ad7280a.c | 243 +++++++++++++++++++-----------
 1 file changed, 158 insertions(+), 85 deletions(-)

-- 
2.19.2

