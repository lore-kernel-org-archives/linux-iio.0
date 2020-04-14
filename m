Return-Path: <SRS0=scjX=56=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCBFC352BE
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 23:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B2A2076C
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 23:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634468AbgDNX43 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:56:29 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:51054 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgDNX43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 19:56:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 7413E200E7EC;
        Wed, 15 Apr 2020 07:56:23 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Az9jWYfI5Vw3; Wed, 15 Apr 2020 07:56:23 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 530CB200E7CA;
        Wed, 15 Apr 2020 07:56:23 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 4245BC019EC;
        Wed, 15 Apr 2020 07:56:23 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 1DD37201602; Wed, 15 Apr 2020 07:56:23 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     chris.ruehl@gtsys.com.hk
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: patch set ltc2632
Date:   Wed, 15 Apr 2020 07:56:01 +0800
Message-Id: <20200414235609.20125-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Patchset to extend ltc2632 spi driver to support the similar chip set
ltc2634.
* Patch v3 1/3 update documentation struct ltc2632_chip_info
* Patch v3 2/3 patch ltc2632.c,Kconfig,ltc2632.txt(devtree)
* Patch v3 3/3 convert ltc2632.txt to yaml format named lltc,ltc2632.yaml

* Patch v3 2/3 : correct help text

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---

