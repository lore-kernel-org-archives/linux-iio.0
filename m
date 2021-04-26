Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093AEC433ED
	for <linux-iio@archiver.kernel.org>; Mon, 26 Apr 2021 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF575613AA
	for <linux-iio@archiver.kernel.org>; Mon, 26 Apr 2021 17:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhDZREw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZREv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:04:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D411A61006;
        Mon, 26 Apr 2021 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456650;
        bh=KVqCV45lfa8idoThO7GqWA+x3XioyQKlnBmOCGjc6uk=;
        h=From:To:Cc:Subject:Date:From;
        b=kdZCW8kBdDzSInzGx1ltorfkRhTGVu3HGK+Q+BNWY8WAjaj8DSDw+fg21Fzn7zXR8
         lWCAOjmhXKr33Ry3fUhdCJ8PeXRvS8B+t7YkJ57sVz8x6Z3I9iFBjnUJSO/SJImHgl
         EqBO2dXcgTybAu3iwGeAQaPBg+rYL/hPFAG6u9N6dody6CdSq0rSyAxeotZO7XqeHx
         s+r1H3lLb6enO7tCZGUXj4j3xFFUWv23egsikIKT8qF8RUbbIgDhqyknBOXjM2tKIQ
         isDxk9EBRHzeEhLO7abL3plWGjxLUEPp3z4xs2DdJQvUrrD8ZgEvZh4+7vY6xPqMeg
         pcrvEPszXQkXw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] iio: cleanup some new instances of manual parent setting.
Date:   Mon, 26 Apr 2021 18:02:43 +0100
Message-Id: <20210426170251.351957-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

It seems I still haven't trained my eyes to spot these.

I think they have all been introduced since
iio_device_alloc() and friends started setting this
8525df47b3d1e ("iio: core: fix/re-introduce back parent assignment")
78289b4a58b58 ("iio: core: pass parent device as parameter during allocation")

Anyhow, all seem fairly obvious to me, but maybe I missed something so please
take a look.

Jonathan Cameron (8):
  iio: accel: bmi088: Drop manual assignment of iio_dev.dev.parent
  iio: dac: ad5766: Drop duplicate setting of iio_dev.dev.parent
  iio: adc: mp2629: Drop duplicate setting iio_dev.dev.parent
  iio: adc: mt6360: Drop duplicate setting of iio_dev.dev.parent
  iio: adc: ti-ads131e08: Drop duplicate setting of iio_dev.dev.parent
  iio: humidity: hdc2010: Drop duplicate setting of iio_dev.dev.parent
  iio: position: hid-sensor-custom-intel-hinge: Drop duplicate parent
    setting.
  iio: common: scmi_sensors: Drop duplicate setting of
    iio_dev.dev.parent

 drivers/iio/accel/bmi088-accel-core.c                | 1 -
 drivers/iio/adc/mp2629_adc.c                         | 1 -
 drivers/iio/adc/mt6360-adc.c                         | 1 -
 drivers/iio/adc/ti-ads131e08.c                       | 1 -
 drivers/iio/common/scmi_sensors/scmi_iio.c           | 1 -
 drivers/iio/dac/ad5766.c                             | 1 -
 drivers/iio/humidity/hdc2010.c                       | 1 -
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 1 -
 8 files changed, 8 deletions(-)

-- 
2.31.1

