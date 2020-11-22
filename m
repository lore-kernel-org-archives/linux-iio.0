Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB8CC5519F
	for <linux-iio@archiver.kernel.org>; Sun, 22 Nov 2020 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7474208D5
	for <linux-iio@archiver.kernel.org>; Sun, 22 Nov 2020 11:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEqEU/LY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgKVL5A (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 22 Nov 2020 06:57:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgKVL5A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 06:57:00 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38CF20674;
        Sun, 22 Nov 2020 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606046219;
        bh=laSh1fTlBi6w6vs9KICAer2Rzn8e/Dithlb79XwAXRA=;
        h=From:To:Cc:Subject:Date:From;
        b=UEqEU/LY4nI7go8hTXUHj/YzRWn/MdaU6oz6zn2dUunJT4/knEH1HfCoTxkBS0q1N
         j7Pxvy7mgpg47f1le9XW4CyDH8yDbiUQgf3UkoBigyiJ7eUHQAo5T4LEwaDHXD4Cmx
         nYojlGIyy0mixiphLsUo1UCoMcdo+5kxDIT7Uoi8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] hts221: add vdd power regulator
Date:   Sun, 22 Nov 2020 12:56:47 +0100
Message-Id: <cover.1606045688.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce support to control VDD power line available on hts221 devices

Changes since v1:
- update vdd-supply binding
- rely on dev_err_probe() in hts221_init_regulators() to avoid
  printing error message is the deferred case

Lorenzo Bianconi (2):
  iio: humidity: hts221: add vdd voltage regulator
  dt-bindings: iio: humidity: hts221: introduce vdd regulator bindings

 .../bindings/iio/humidity/st,hts221.yaml      |  2 +
 drivers/iio/humidity/hts221.h                 |  2 +
 drivers/iio/humidity/hts221_core.c            | 37 +++++++++++++++++++
 3 files changed, 41 insertions(+)

-- 
2.28.0

