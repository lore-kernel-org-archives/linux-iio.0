Return-Path: <SRS0=mPBy=TH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF2BC04AAB
	for <linux-iio@archiver.kernel.org>; Tue,  7 May 2019 05:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666C320578
	for <linux-iio@archiver.kernel.org>; Tue,  7 May 2019 05:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207908;
	bh=0esvBg3sZPHXqyPWKf8K32UkMNDTLhp2VPF6mDiGBRk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=juik6ggk7cyNu7sEJyBSMtMVn1bPvkUzzOyLqkuUVAvkN/IIG4tGsPtJ4ibqENP+J
	 XKVOjtVCz5R/szlzqhzy/HaYRQTp73x39wpyF/WVv8H44Y2xDlpSgBUtlBv/UdMybT
	 tvNuuDOSubfl8vE0+zI6yueajv3SDdRM+B5cm4Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfEGFmV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 7 May 2019 01:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbfEGFmU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 May 2019 01:42:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59EF520578;
        Tue,  7 May 2019 05:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207740;
        bh=0esvBg3sZPHXqyPWKf8K32UkMNDTLhp2VPF6mDiGBRk=;
        h=From:To:Cc:Subject:Date:From;
        b=do8xcuLo5ZtPfCPsVQHmLx8l9xcFYqbrMpZLQiUzO9E1naRmhqjmHwSAYZiGG/aap
         KXOtl5Hxj6y1VHidonrmYcN6xm/L1Z+JyM4BzK6dwUNfyj+nq80Iq0yJP2ePp/N5Ux
         /ea3x4by0Q5pLOqNawEPFjJNbf1vPTMtJeaaFKlA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 01/14] iio: adc: xilinx: fix potential use-after-free on remove
Date:   Tue,  7 May 2019 01:42:03 -0400
Message-Id: <20190507054218.340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sven Van Asbroeck <thesven73@gmail.com>

[ Upstream commit 62039b6aef63380ba7a37c113bbaeee8a55c5342 ]

When cancel_delayed_work() returns, the delayed work may still
be running. This means that the core could potentially free
the private structure (struct xadc) while the delayed work
is still using it. This is a potential use-after-free.

Fix by calling cancel_delayed_work_sync(), which waits for
any residual work to finish before returning.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 475c5a74f2d1..6398e86a272b 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1299,7 +1299,7 @@ static int xadc_remove(struct platform_device *pdev)
 	}
 	free_irq(irq, indio_dev);
 	clk_disable_unprepare(xadc->clk);
-	cancel_delayed_work(&xadc->zynq_unmask_work);
+	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	kfree(xadc->data);
 	kfree(indio_dev->channels);
 
-- 
2.20.1

