Return-Path: <SRS0=AGAg=QZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F7EC43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 07:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E21F217F5
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 07:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfBRHye (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:54:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:52657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbfBRHye (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Feb 2019 02:54:34 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LdKs1-1hMPul0Uk5-00iWRz; Mon, 18 Feb 2019 08:54:11 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] iio: remove redundant unlikely annotation
Date:   Mon, 18 Feb 2019 15:53:26 +0800
Message-Id: <20190218075326.24672-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:827lQk+zNT9LRn4NSrietVouqyIWKGrmfs/qJEvFEdWilt9HefE
 E3mLR2Mmilda3YmyS4erocoMIZEsPl9hRvz1u2FL4kGdN+i2uzFyisJNaET5iCTu8YeclLI
 QqovBbFSW6rPJFw0RJN01PEx1YJvmsXUNRCSnx9jwqn8+seMicBpfKjgAtkkWmtdY9YMH32
 8YVfwPE3NU2lAbFQX0nKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:26lZBUUhyF8=:ULZxvzstX3eN2kkkfDxtoe
 qNnO0ayBUwQvmCwxjQoWfvWykvdLHmRmo/ZEH3QS14O+BaEX/XIh5BP5DXI+Vga+1xPwjuRa1
 RrLmKex8GmGaStImH6c9KnU4UsnBbGu8t03U1W254rnvKRF+XkPa8sPGamHSDe14iIJFeSl5H
 bmZ+9/rmxUuQ42g0oxOU3FRZ7X8wfi36Rx+xGipv6eMuDs6jeAgkwUUElL2pPwgqg6JcboFsa
 /p2NT+6E3/fXctWx+N3WbAXZlLj7FkPfBXIhNU1SQ4IE2Cb8GinHUil4JROAeqytWPxRvEavA
 Bcpdi7KoQJQMVc636JWq/8jVfWwytfMtD0i5/Ds7TQDVlOPO9+yRx4CxW3Bd9AmomcRvOGf1e
 q0NWuZ2XPiV+MRNCwXj3/2YnBsZY0IhBbS+/shJinmJHU7yLgJ0TCy0VOJku0BM6xQTq71Ia7
 j9KmBmfhTNlcJ8phDr6SaS2iuzCBC629L5vDfTrZZg/ECONo7LSrz6uDT1eFZ28CJIc5zorZ6
 Eo70/welR5Bg0wo7kz6c1G1yXqCfS5woHr1tS077F2YyD3axmyZ5uJHI/GfhGUHzel9DUyFnD
 l6khfsLdD9ahj0jb7s2BTEBEq/wjc8GdcUknAXFltsrsnCRpXMfvnBeHfU3gyoLY+YJbb9p0+
 9WlTxqkAVSHwC63WIq5sIZy8QhDj95uYPuaMUp8lhDoHhN3SAoD97tIEdvXTAXOwaw7gFcbEB
 +4hwBdM9kds5ivlqUlH4eCjxs06DLrZtA2ahsFfVVk5mgI4I2KdE8DxvMqZbujoDdLNxXWyX4
 21xn5EE2XNB2hrWisBWPxY+MXm/1S/MnNUS3GoF0xBsYh4RDZq0sBP3J81dS1diTmBoakjPED
 GcRgvWAWIFGrJwodsV3+AOOAbn3WKGndrQwwmlhpCOAO2sDU3WW8fS3jlBu1JD
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

unlikely has already included in IS_ERR(),
so just remove redundant unlikely annotation.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/iio/trigger/iio-trig-loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
index 94a90e0a3fdb..9258d3cf149b 100644
--- a/drivers/iio/trigger/iio-trig-loop.c
+++ b/drivers/iio/trigger/iio-trig-loop.c
@@ -60,7 +60,7 @@ static int iio_loop_trigger_set_state(struct iio_trigger *trig, bool state)
 	if (state) {
 		loop_trig->task = kthread_run(iio_loop_thread,
 					      trig, trig->name);
-		if (unlikely(IS_ERR(loop_trig->task))) {
+		if (IS_ERR(loop_trig->task)) {
 			dev_err(&trig->dev,
 				"failed to create trigger loop thread\n");
 			return PTR_ERR(loop_trig->task);
-- 
2.20.1

