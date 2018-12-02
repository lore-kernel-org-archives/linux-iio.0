Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D217C04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32AF20834
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="IXD/qwR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32AF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbeLBL6A (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:58:00 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:41739 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLBL6A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 06:58:00 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <localhost>
Received: from localhost (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sun,  2 Dec 2018 12:57:55 +0100 (CET)
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 0/3] staging: iio: adc: ad7280a: channel and attr init refactor
Date:   Sun,  2 Dec 2018 12:58:27 +0100
Message-Id: <20181202115830.20363-1-sst@poczta.fm>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1543751877;
        bh=ghuhQxJFahQXbF0jcz8xqDI30I12hcnekshKjZM/AxI=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Cc:Subject:
         Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
         X-Interia-Antivirus;
        b=IXD/qwR5lZLGGY4W9+ZMvru3+/pWIp8YZprxyEq73I2CP16kUDx93+dmIJh8fJGOD
         G1OfXCz7nIS2oD0qoYDeub+aEEIajTCrnrdYa0xDvh1SAL45oEbxyahPnQ2nMpN+b7
         5MWK6klnVzlz0gnoZQjH5zVLZr1jDMBupMY9/Dz0=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This small series enhances the readability of the code by refactoring the
ad7280_channel_init and ad7280_attr_init functions.

The readability is enhanced by splitting the functions into more functions that
do more specific operations. The last patch adds braces to two complex for
loops.

Slawomir Stepien (3):
  staging: iio: adc: ad7280a: split ad7280_channel_init() to more
    functions
  staging: iio: adc: ad7280a: split ad7280_attr_init() to more functions
  staging: iio: adc: ad7280a: add braces to complex for loops

 drivers/staging/iio/adc/ad7280a.c | 204 +++++++++++++++++++-----------
 1 file changed, 129 insertions(+), 75 deletions(-)

-- 
2.19.2

