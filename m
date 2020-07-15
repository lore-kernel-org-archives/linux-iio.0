Return-Path: <SRS0=5TKQ=A2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28B9C433E7
	for <linux-iio@archiver.kernel.org>; Wed, 15 Jul 2020 19:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34882078C
	for <linux-iio@archiver.kernel.org>; Wed, 15 Jul 2020 19:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="gSjbT5o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGOTRT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:17:19 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:21685 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGOTRS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 15:17:18 -0400
Date:   Wed, 15 Jul 2020 19:17:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1594840636;
        bh=QhkUqE57JqFDC+H1LrZlpubSLL3MhRo3rrBT3FK8MQI=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=gSjbT5o8TgI1hWPElAl4stLc1cTFrlFDQ4ts4L0c1cRnMgv0uswkjE8ADdDgTlvzB
         70mK5ZSj3tMX9OKWCs8w9p0MiIQmA2zlV4HRLZYwosHv1w+39GAweCcGsmKCzAJRQI
         k1wZ39QXfszPYRhsTwKp3jrokPuxDOxOor1a9VjA=
To:     jic23@kernel.org
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-iio@vger.kernel.org,
        Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH] iio: Correct kernel-doc inconsistency
Message-ID: <20200715191656.29437-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Silence documentation build warning by correcting kernel-doc comment
for iio_dev struct.

./include/linux/iio/iio.h:574: warning: Function parameter or member 'read_=
buf' not described in 'iio_dev'
./include/linux/iio/iio.h:574: warning: Function parameter or member 'read_=
buf_len' not described in 'iio_dev'

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 include/linux/iio/iio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a1be82e74c93..48049b344e6c 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -522,6 +522,8 @@ struct iio_buffer_setup_ops {
  * @flags:=09=09[INTERN] file ops related flags including busy flag.
  * @debugfs_dentry:=09[INTERN] device specific debugfs dentry.
  * @cached_reg_addr:=09[INTERN] cached register address for debugfs reads.
+ * @read_buf:=09=09[INTERN] cached register contents for debugfs reads
+ * @read_buf_len:=09[INTERN] length of @read_buf
  */
 struct iio_dev {
 =09int=09=09=09=09id;
--=20
2.26.2


