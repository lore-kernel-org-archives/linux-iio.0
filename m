Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD7C433E0
	for <linux-iio@archiver.kernel.org>; Thu, 25 Feb 2021 20:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C82664DF3
	for <linux-iio@archiver.kernel.org>; Thu, 25 Feb 2021 20:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhBYUIc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:08:32 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:44324 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231974AbhBYUIa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Feb 2021 15:08:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id E060041389;
        Thu, 25 Feb 2021 20:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1614283666; x=
        1616098067; bh=AAbdfFn0Frq8m1wdTqlBvgbDtUPXDn7s2PZdWVrqS54=; b=V
        jD30xxfd3W7Txrud7QBg40kklXnZz8A9BXlkHkOtsSfD2xSu+3GcQVxD79zOqCwm
        lpOVBlQZ7KQCSvfiV7TIc9b5QvO17o0LL+VoCFs9gKb3QM3PtZwORkhEs8jK9SSQ
        e6S9P3DPIURctlMYwxAWSdMaJI0Npb/bAdw+IztwYA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AppmvYxE2rZ2; Thu, 25 Feb 2021 23:07:46 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 5FD0A41292;
        Thu, 25 Feb 2021 23:07:46 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.0.34) by
 T-EXCH-03.corp.yadro.com (172.17.100.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 25 Feb 2021 23:07:46 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/1] add proximity rate option for vcnl3020
Date:   Thu, 25 Feb 2021 23:14:43 +0300
Message-ID: <20210225201444.12983-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.34]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the runtime control of proximity rate for vcnl3020 proximity
sensor.

Changes from v1:
  1. add .read_avail method
  2. remove dts and parse of it

Ivan Mikhaylov (1):
  iio: proximity: vcnl3020: add proximity rate

 drivers/iio/proximity/vcnl3020.c | 97 +++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

-- 
2.26.2

