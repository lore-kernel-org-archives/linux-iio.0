Return-Path: <SRS0=ao10=4G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A28C34026
	for <linux-iio@archiver.kernel.org>; Tue, 18 Feb 2020 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F1C22527
	for <linux-iio@archiver.kernel.org>; Tue, 18 Feb 2020 15:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRPpI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:45:08 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:38148 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBRPpH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 10:45:07 -0500
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 43C30102FA1;
        Tue, 18 Feb 2020 16:45:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 43C30102FA1
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH v2 0/2] iio: light: vcnl4000: update sampling periods
Date:   Tue, 18 Feb 2020 16:44:49 +0100
Message-Id: <20200218154451.13066-1-tomas@novotny.cz>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Vishay has published new information which explain drifts seen in
experiments. So update the sampling periods for affected variants.

As pointed out in another series, the variable has a misleading name
(rate instead of period). This will be fixed in the other series to make
backporting of these patches straightforward.

Tested on vcnl4200. Tests on vcnl4040 done by Guido.

Changes in v2:
- fix rate -> period in commit messages and subjects
- collect tags

Tomas Novotny (2):
  iio: light: vcnl4000: update sampling periods for vcnl4200
  iio: light: vcnl4000: update sampling periods for vcnl4040

 drivers/iio/light/vcnl4000.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.16.4

