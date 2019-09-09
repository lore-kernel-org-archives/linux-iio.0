Return-Path: <SRS0=8cOJ=XE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF100C433EF
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 12:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFB321920
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 12:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404805AbfIIMQK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:16:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:22495 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404804AbfIIMQK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 08:16:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 05:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="268056052"
Received: from pipin.fi.intel.com ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 09 Sep 2019 05:16:07 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [RFC/PATCH 0/1] Quadrature Encoder Support
Date:   Mon,  9 Sep 2019 15:16:04 +0300
Message-Id: <20190909121605.92008-1-felipe.balbi@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Here's a simple RFC for Intel's Quadrature Encoder. Let me make it clear
that I don't mean we should the following patch as is, rather I'd like
to open the discussion to, perhaps, extending Industrial Automation
Framework with support for Quadrature Encoders.

Let me know if you think IIO would be correct place for such devices,
then I can start reworking the driver to provide an IIO-compliant
interface.

I'm thinking we would need standard sysfs files for configuring the QEP
into single-shot QEP mode or buffered Capture mode, configure thresholds
and other details.

Cheers

Felipe Balbi (1):
  misc: introduce intel QEP

 drivers/misc/Kconfig     |   7 +
 drivers/misc/Makefile    |   1 +
 drivers/misc/intel-qep.c | 813 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 821 insertions(+)
 create mode 100644 drivers/misc/intel-qep.c

-- 
2.23.0

