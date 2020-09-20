Return-Path: <SRS0=gotz=C5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EAAC43465
	for <linux-iio@archiver.kernel.org>; Sun, 20 Sep 2020 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C49221789
	for <linux-iio@archiver.kernel.org>; Sun, 20 Sep 2020 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600610089;
	bh=T86JAw3R4aZZNRay0kr5XtMniE6KnC2qkg2s36rFsZE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Xi2rVbUDtfkOyA7zomA9omAx17UiOFDzZHWmzUQgMkwjqQwQHOHtg01YFLVtkwbGb
	 5xam84SmSu+mOWdaBLq1s5i/hZdNaogZQ+Fzj+jPRsXn1Q0MNwoJIhHhxAmfTEdbGl
	 +yG7ZGyBZIsdUuKCvnyaWzulDhE08GUEldDkxic0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgITNys (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 20 Sep 2020 09:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgITNys (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 09:54:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A8821531;
        Sun, 20 Sep 2020 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600610088;
        bh=T86JAw3R4aZZNRay0kr5XtMniE6KnC2qkg2s36rFsZE=;
        h=From:To:Cc:Subject:Date:From;
        b=OKbOOIIpVmmU0uf35MHaw3Vh4GiXU+HZ2YKgT0wnBtZsdbT/WeuPvn3y3aSz7DNi4
         okOw5fkcjj39mSsiVdIQw6FCTowJkeg7dOi+uBty/J2diw+L57eU7FS7CT5Szpbb3b
         lJf73dgimDtoEYo74TGnRq+Uqnt4rk2y8nbD65GA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 0/1] dt-bindings:iio:adc: Another set of yaml conversions.
Date:   Sun, 20 Sep 2020 14:54:35 +0100
Message-Id: <20200920135436.199003-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The only has a cover letter to match up with the earlier sets.
I wouldn't normally put one on a single patch!

Changes since v2:
* Apply all but one patch.
* amlogic,meson-saradc:
  - consistent capitalization
  - clock names etc all shared, only the number of them changed dependent
    on type.

Jonathan Cameron (1):
  dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion

 .../bindings/iio/adc/amlogic,meson-saradc.txt |  48 ------
 .../iio/adc/amlogic,meson-saradc.yaml         | 149 ++++++++++++++++++
 2 files changed, 149 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml

-- 
2.28.0

