Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734FC6FD18
	for <linux-iio@archiver.kernel.org>; Tue, 18 Apr 2023 12:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjDRMlV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 18 Apr 2023 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjDRMlU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Apr 2023 08:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1013F8C;
        Tue, 18 Apr 2023 05:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87E03632EE;
        Tue, 18 Apr 2023 12:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE97C433EF;
        Tue, 18 Apr 2023 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681821672;
        bh=Tjcn1bBBGUm5nKUGLkls5OpQmOhSCTAFSd0dYAHhLTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kU+GxWPjd9tE9UNqxaxwJSpX/lJniODy5awEtgu9twvN/+HTnyef+44w5p4x5lZ45
         bdoEvqPk3TIJ2Nj9qNB4+uFcsNzu07cvZVr6iHmpdkUi8MPeUNAm395vQd+CAtdTuJ
         zefAnMaNEaKmkj1w/gJrrY5WCxv0+/vZx3R1wSAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 5.15 89/91] counter: fix docum. build problems after filename change
Date:   Tue, 18 Apr 2023 14:22:33 +0200
Message-Id: <20230418120308.650334974@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418120305.520719816@linuxfoundation.org>
References: <20230418120305.520719816@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

commit 7110acbdab462b8f2bc30e216c331cbd68c00af9 upstream.

Fix documentation build warnings due to a source file being
renamed.

WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -sphinx-version 1.8.5 -export ../drivers/counter/counter.c' failed with return code 2

Error: Cannot open file ../drivers/counter/counter.c

Fixes: aaec1a0f76ec ("counter: Internalize sysfs interface code")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Link: https://lore.kernel.org/r/20211005055157.22937-1-rdunlap@infradead.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/generic-counter.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -247,7 +247,7 @@ for defining a counter device.
 .. kernel-doc:: include/linux/counter.h
    :internal:
 
-.. kernel-doc:: drivers/counter/counter.c
+.. kernel-doc:: drivers/counter/counter-core.c
    :export:
 
 Implementation


