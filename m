Return-Path: <SRS0=q/Pt=RY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BC3C10F00
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6158A218D4
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAirxhjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCUVPe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:15:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40577 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCUVPe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Mar 2019 17:15:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id u68so5630206lff.7
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2019 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yt2mMFnV7foERwQnPo0/W93SgTmFFm3FZqzCnwLlrE0=;
        b=IAirxhjvduGy8y6LoOTnaG6BKBmR9fTFUPclUUW0GfLSllt3vjY0GWVsXWLBAe0N1R
         qwulYMhLMVQYi1GR5U9WxQ/m4fMOBdujoqmPlvyi/2ahur0a8UP9G5bnbjl9rnjyY7JB
         8pfczEVn0cObJjD0J26tlvfYoMKf0Y+RExfjLeFp/XvPV6k4Gs7MYYITtIgqmWwbKcVR
         6DU7CT8uIh4myX/987A3pT7qNDBb4P4r+haNfFVwK8V9a6WBEhYAwQk7+vu7RnEOaqwj
         2uqOIkjRB7aV2WcbcPZ9QrYyBGzakSC9+k2EN+5sLnpiJiVPPg8su7ZVtphmwZtBeD2/
         tBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yt2mMFnV7foERwQnPo0/W93SgTmFFm3FZqzCnwLlrE0=;
        b=guh8mUA1O55xUktrVNkYHBBx9JtlwNKTL/362ZO4W1DSA3FpWvMDDviryIvmbCJZsv
         aU736d9TdthdqBW9S0B9hYJ9ZYxmDJXj60H28RLdDUnFbnA/5NRYHEVuonOl89Vz0jTR
         qgWXWHQWE/T9RiB8nvpItsXhQwuUEPcF1fRlzbZRA8NP36mB5+sJZKIZRRR1Ui0H5SD5
         ZPpLxf6Vm1D6FDAA3+Siu/QBR1dZspL/suTZhxY+dxF+cyfq1prrGWInL5Ze8JYekE42
         7/hBMeVBADHorJJp3ag8MOBKSzQnJN9/103x5r2y2R7I8Fd/jgwMW7tk6KdlALW69uld
         B7Ww==
X-Gm-Message-State: APjAAAVYO4n6NI8+yhGCt91o6vCcrcKfKuelVemTNm0QyH9As8SrCtz0
        n2ouzpk9V8WT6Vv4nXYmrCDA4D/tjK0=
X-Google-Smtp-Source: APXvYqyQrltcpZlY9Czp6BlxAsVD34v43hXyV+CmEls+SByQvBTcG2JerWuVwDj+1AF0XBk1zCAtTA==
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr3101151lfi.1.1553202932457;
        Thu, 21 Mar 2019 14:15:32 -0700 (PDT)
Received: from ubuntu.localdomain ([95.161.223.243])
        by smtp.googlemail.com with ESMTPSA id f18sm1051355lja.91.2019.03.21.14.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 14:15:31 -0700 (PDT)
From:   Vladimir Petrigo <vladimir.petrigo@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Vladimir Petrigo <vladimir.petrigo@gmail.com>
Subject: [PATCH v2 0/2] staging: iio: adc: Fix code formatting issues
Date:   Fri, 22 Mar 2019 00:15:26 +0300
Message-Id: <1553202928-34824-1-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v1 -> v2
 - remove redundant patch for the ad7192.c
 - fix the issue with diff for the ad7280a.c
 - fix the redundant parentheses in the patch for ad7780.c

Vladimir Petrigo (2):
  staging: iio: ad7280a: Add parentheses to macros
  staging: iio: ad7780: Add parentheses to macros

 drivers/staging/iio/adc/ad7280a.c | 6 +++---
 drivers/staging/iio/adc/ad7780.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

