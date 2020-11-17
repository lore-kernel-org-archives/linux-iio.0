Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4B6C5519F
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 10:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0AC7238E6
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 10:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="YFyZ8184"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgKQKib (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Nov 2020 05:38:31 -0500
Received: from www381.your-server.de ([78.46.137.84]:50864 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKQKia (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 05:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=IzuSViUEPJ5VqCkOoHggN05h1dEcyBfD+1drIfyESPI=; b=YFyZ8184ZXaQi+H/8bZ78Pf6ER
        4O3fdhXVVNJQSHVXncVJgp3OkhPyvcqfBRnxP0tmhkn4EQhe6VXZf0f0nvyr6rAOF9KX8VklOoETu
        MgOriKRfZe2tKOx8JPBHl6RSVNDDaiSXSAo3Cof1otiMXor2I49SeT3kPPhe0gJaBUxoAl0Ssl0/j
        2MNbRWgWpy2s5iXMrIIYh8EnDA2aVhS13FfTUHQao10X2RLaBh7R0UoqsLRWDRMer1qslOJ4GL9HE
        M1LX0b1vlcktTgC8ncQJlY+T6ZUBO46XH3f5gPgrKQ+X2MyQMPLe7bFpQi4gATMHN4+burXCUgyjt
        /MjSNzgQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1keyNY-00050c-UC; Tue, 17 Nov 2020 11:38:29 +0100
Received: from [62.216.202.98] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1keyNY-0008jM-Pa; Tue, 17 Nov 2020 11:38:28 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard interrupt context
Date:   Tue, 17 Nov 2020 11:37:50 +0100
Message-Id: <20201117103751.16131-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25990/Mon Nov 16 14:19:13 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On PREEMPT_RT enabled kernels unmarked hrtimers are moved into soft
interrupt expiry mode by default.

The IIO hrtimer-trigger needs to run in hard interrupt context since it
will end up calling generic_handle_irq() which has the requirement to run
in hard interrupt context.

Explicitly specify that the timer needs to run in hard interrupt context by
using the HRTIMER_MODE_REL_HARD flag.

Fixes: f5c2f0215e36 ("hrtimer: Move unmarked hrtimers to soft interrupt expiry on RT")
Reported-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Also pass HRTIMER_MODE_REL_HARD to hrtimer_start().
---
 drivers/iio/trigger/iio-trig-hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index f59bf8d58586..410de837d041 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -102,7 +102,7 @@ static int iio_trig_hrtimer_set_state(struct iio_trigger *trig, bool state)
 
 	if (state)
 		hrtimer_start(&trig_info->timer, trig_info->period,
-			      HRTIMER_MODE_REL);
+			      HRTIMER_MODE_REL_HARD);
 	else
 		hrtimer_cancel(&trig_info->timer);
 
@@ -132,7 +132,7 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
 	trig_info->swt.trigger->ops = &iio_hrtimer_trigger_ops;
 	trig_info->swt.trigger->dev.groups = iio_hrtimer_attr_groups;
 
-	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	trig_info->timer.function = iio_hrtimer_trig_handler;
 
 	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
-- 
2.20.1

