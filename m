Return-Path: <SRS0=gBti=AP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E2FC433E1
	for <linux-iio@archiver.kernel.org>; Sat,  4 Jul 2020 03:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC1B212CC
	for <linux-iio@archiver.kernel.org>; Sat,  4 Jul 2020 03:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2zYcSx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGDDqW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 3 Jul 2020 23:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgGDDqU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jul 2020 23:46:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E0C061794;
        Fri,  3 Jul 2020 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=l2dNp9CDCJWinvc4lxu8WrMSWxEENUQ4lh7tctfmeCY=; b=o2zYcSx9s6tpm7oS6TkJxGFzET
        04GnFb6LY6i2JGbzGnYpv5GmmiWMlIAYslf9NEz4RLDjcxPhTmfE9OMuRd5/2OC/GPr2rAqYPo8W8
        qSGhJPbgp5fTLRoz+sn/a8VJGfB0SNZipL70akZNifLrdIdBeWnN8rdpm8pNQ3HA+vpMB2GOyVUxI
        Y4szHID82GDhxLVjUJZ9uaHzSr4XoD6clWAtjhxb2IyAyDhQ6aHKdCeIIqauIKdvu1+/yKzcQc+Wl
        O7iD2RUa+l28E2AyoxXLI/7M22gBBZDsAJ4ASC/BjtzT15nB/F4BrOpdVTZE3ln5bkfGwS9uMGKOE
        y4jxsvkg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ85-0001Xb-S7; Sat, 04 Jul 2020 03:46:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH 13/17] Documentation/driver-api: nvdimm: drop doubled word
Date:   Fri,  3 Jul 2020 20:44:58 -0700
Message-Id: <20200704034502.17199-14-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drop the doubled word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-nvdimm@lists.01.org
---
 Documentation/driver-api/nvdimm/nvdimm.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/nvdimm/nvdimm.rst
+++ linux-next-20200701/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -73,7 +73,7 @@ DAX:
   process address space.
 
 DSM:
-  Device Specific Method: ACPI method to to control specific
+  Device Specific Method: ACPI method to control specific
   device - in this case the firmware.
 
 DCR:
