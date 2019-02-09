Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE84C282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE252218D2
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549741179;
	bh=D38Fa0XXohE7DPQ+PVv40mosY7LccJe2Pu53DH2mGoY=;
	h=Date:From:To:Subject:List-ID:From;
	b=MwhlD8hUmbDO+vDiy7wEEZ2lePsGNaQYg3dfDDevLUumyglI81am9AtiD7vIPU0g2
	 kt1GC1+zXCSIsGxea/5svO1l6yIrMCUZdsUTtzuFGCxB+x/uSMqyIm+CyDFUzcNzZC
	 xd6udaZWdaMYjqV+VpJO+eE3qj61fmteCSlE8mfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfBITjj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:39:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbfBITjj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 14:39:39 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D500121919;
        Sat,  9 Feb 2019 19:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549741178;
        bh=D38Fa0XXohE7DPQ+PVv40mosY7LccJe2Pu53DH2mGoY=;
        h=Date:From:To:Subject:From;
        b=FbLQuuJmsHe7gIOqpAOB256KOidwZTVRd5MagcUUhSPGZU9WBdFZ1Yap6aT2yrueo
         bLKVKmN7DQPZdqYsRMm+QSTHllsmGbSAiIRUvsQ+igdSy/OCaXQCP/TNFf7i+X3gdS
         hu8NHqLi8M+hNCzt6zrLZj8pGyQa6XH/kzXToQMQ=
Date:   Sat, 9 Feb 2019 19:39:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andreas Brauchli <a.brauchli@elementarea.net>
Subject: [PATCH] iio:chemical:sps30 Suppress some switch fallthrough
 warnings.
Message-ID: <20190209193934.64038cf4@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes warnings reported on linux-next but marking one path
and adding an explicit return in the other.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Brauchli <a.brauchli@elementarea.net>
---
I'd like to get this one into linux-next fairly quick so it anyone
has time to do a quick sanity check it would be much appreciated!

 drivers/iio/chemical/sps30.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 375df5060ed5..edbb956e81e8 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -118,6 +118,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
 	case SPS30_READ_AUTO_CLEANING_PERIOD:
 		buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
 		buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
+		/* fall through */
 	case SPS30_READ_DATA_READY_FLAG:
 	case SPS30_READ_DATA:
 	case SPS30_READ_SERIAL:
@@ -295,6 +296,8 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 				*val2 = 10000;
 
 				return IIO_VAL_INT_PLUS_MICRO;
+			default:
+				return -EINVAL;
 			}
 		default:
 			return -EINVAL;
-- 
2.20.1

