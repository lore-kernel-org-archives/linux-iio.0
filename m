Return-Path: <SRS0=gBti=AP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB9FC433EA
	for <linux-iio@archiver.kernel.org>; Sat,  4 Jul 2020 03:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91D62100A
	for <linux-iio@archiver.kernel.org>; Sat,  4 Jul 2020 03:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWNe5fwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgGDDpN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 3 Jul 2020 23:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgGDDpM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jul 2020 23:45:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6CC061794;
        Fri,  3 Jul 2020 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RjgXbItONDI8qoKZoagX/7fm2XOCDVB41PDHOzajmYk=; b=RWNe5fwbC3uETb+vlA25w47G3W
        81y378w8gWI/l1I3BPLGTGJicfvdaYVSHZlWHL4Hr274m/Gu+9IT0kTIyL9CibvdIjGBGjA0sEIg2
        zPhQ7y4YxWIMVJNCAjAtZPQxKkCok68tVHKhYM/AWFDo8STqJT6VWg8wFXfdJOdojDYsKxqN2zWGO
        ILNhDg2rOINWSh94+fSvNzVs0SACUZiQvqnxJgiCJ2jzDTuI9P5RBHjoZOnCRuAiVODwJ3OIB3HUC
        x4PHuDEI9filMB0QaqnSXiLe2h3crPRb65DfVRIkCXMmbrrFyBqlIQC0wi3nSpCE1f7DqmZJiG6je
        HtGhnLOw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrZ6y-0001Xb-Bk; Sat, 04 Jul 2020 03:45:09 +0000
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
Subject: [PATCH 00/17] Documentation/driver-api: eliminate duplicated words
Date:   Fri,  3 Jul 2020 20:44:45 -0700
Message-Id: <20200704034502.17199-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove occurrences of duplicated words in Documentation/driver-api/.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-usb@vger.kernel.org
Cc: Eli Billauer <eli.billauer@gmail.com>


 Documentation/driver-api/dmaengine/provider.rst        |    2 +-
 Documentation/driver-api/driver-model/platform.rst     |    2 +-
 Documentation/driver-api/firmware/built-in-fw.rst      |    2 +-
 Documentation/driver-api/firmware/direct-fs-lookup.rst |    2 +-
 Documentation/driver-api/firmware/firmware_cache.rst   |    2 +-
 Documentation/driver-api/firmware/request_firmware.rst |    2 +-
 Documentation/driver-api/generic-counter.rst           |    2 +-
 Documentation/driver-api/iio/buffers.rst               |    2 +-
 Documentation/driver-api/media/cec-core.rst            |    2 +-
 Documentation/driver-api/media/dtv-frontend.rst        |    6 +++---
 Documentation/driver-api/media/v4l2-controls.rst       |    4 ++--
 Documentation/driver-api/media/v4l2-dev.rst            |    2 +-
 Documentation/driver-api/ntb.rst                       |    2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst             |    2 +-
 Documentation/driver-api/uio-howto.rst                 |    2 +-
 Documentation/driver-api/usb/URB.rst                   |    2 +-
 Documentation/driver-api/xillybus.rst                  |    2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)
