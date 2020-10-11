Return-Path: <SRS0=8e7N=DS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B9C433E7
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 16:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF94221FF
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602433990;
	bh=lC44VfHT0jF+22KHV0RLsWcrH040kuaNxL+oYa/q+l0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BQbIDkfsjEtdBnYdmXmEcuyVJtsjmSyrgUMrkBAULX1A1fGnuCuBLkl0ZhAwy/UAv
	 1M7tQvpcZ/8FVlPtDAfiN5f2jQAPNNIuhdyePHG24OXAkCQbyIL3TWkfjy9pY1J+HA
	 KHOShmSJlQvtLuebfKfPqdIaJmY6E4sQNcmUzGIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgJKQdJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Oct 2020 12:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388091AbgJKQdJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 12:33:09 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC7E21655;
        Sun, 11 Oct 2020 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602433988;
        bh=lC44VfHT0jF+22KHV0RLsWcrH040kuaNxL+oYa/q+l0=;
        h=From:To:Cc:Subject:Date:From;
        b=iC6jNjNBPtSfAHsEtGtRBrkPBLJ3pRtdl4YlZi7WIp4teeVoEEAvVjQ0kpJgfL7lA
         g5FoCDY64637KMV/tKoKW6C4qsFkBK+QahD3+PFM29WcC9qkSeTpCbwmAqMb5ugHnE
         eSY6G5phqkVJQlMsidUmBl5TkNlPqRzL05/MV87w=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] dt-bindings:iio:consumer yaml bindings
Date:   Sun, 11 Oct 2020 17:30:29 +0100
Message-Id: <20201011163031.240708-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi Rob / All,

I've done this as a small independent series as it's something new
to me and I'm far from sure I did it correctly.

This includes both pulling out the iio consumer binding to a separate
yaml file and an example of using it.

Thanks,

Jonathan

Jonathan Cameron (2):
  dt-bindings:iio:iio-consumer add yaml binding for IIO consumers
  dt-bindings:iio:dac:dpot-dac: yaml conversion.

 .../devicetree/bindings/iio/dac/dpot-dac.txt  | 41 ------------
 .../devicetree/bindings/iio/dac/dpot-dac.yaml | 67 +++++++++++++++++++
 .../devicetree/bindings/iio/iio-bindings.txt  | 53 ---------------
 .../devicetree/bindings/iio/iio-consumer.yaml | 59 ++++++++++++++++
 4 files changed, 126 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/iio-consumer.yaml

-- 
2.28.0

