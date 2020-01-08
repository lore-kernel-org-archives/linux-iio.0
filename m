Return-Path: <SRS0=vtwJ=25=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826FBC282DD
	for <linux-iio@archiver.kernel.org>; Wed,  8 Jan 2020 16:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4672070E
	for <linux-iio@archiver.kernel.org>; Wed,  8 Jan 2020 16:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAHQA0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:00:26 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:46210 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHQAZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 11:00:25 -0500
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id F06C1104487;
        Wed,  8 Jan 2020 17:00:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net F06C1104487
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomas Novotny <tomas@novotny.cz>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH 0/2] iio: light: vcnl4000: update sampling rates
Date:   Wed,  8 Jan 2020 16:58:50 +0100
Message-Id: <20200108155852.32702-1-tomas@novotny.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Vishay has published new information which explain drifts seen in
experiments. So update the sampling rates for affected variants.

Patches are based on iio/fixes-togreg to avoid conflict.

Tested on vcnl4200.

Tomas Novotny (2):
  iio: light: vcnl4000: update sampling rates for vcnl4200
  iio: light: vcnl4000: update sampling rates for vcnl4040

 drivers/iio/light/vcnl4000.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.16.4

