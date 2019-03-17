Return-Path: <SRS0=squ6=RU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38EC43381
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 20:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC6C20857
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 20:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcAsnqgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfCQUxU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:53:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32838 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUxU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2019 16:53:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id z7so12232227lji.0
        for <linux-iio@vger.kernel.org>; Sun, 17 Mar 2019 13:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PctDhGTTLR51kSJgr1rpsEFGwcMNgxZDiIyPFpij1eI=;
        b=DcAsnqgV6cqa2p6WLOC0NkJmIWGEEBc9rKKkFs5FxwPInPFIMg09Aut+6wFRY4TR6N
         0pK38QuJVe/Be6Iepu6YrZHoDtG4gk5Wpq0hJiMcsN3gJHSEyUyDrWro/EF90lZ135As
         shMtvko3NND9FySdExx8X7dVF/bi1cLFySSJOZcTJAtk3RvHZmg/F5t8cTZeWipuvH9K
         r4c1Jgp7Hg4b8OgbF9yERHrPmaTH3VYxdv+5bYMAU1rB7GCcDmgvMUZIL5CuQ6wd1vKQ
         9rvtsiwqrmRuAPxC7doh337VCKfG/CaUjCqFx6j3Qa6+72bEK4W0Nv0884LkBdqPUIQW
         6/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PctDhGTTLR51kSJgr1rpsEFGwcMNgxZDiIyPFpij1eI=;
        b=Tad3EEf1P5PZgmhsDP2+3Vro7wttwFD/dkGnoTKyJQ3pxgfulTtZXOCQdD0lw/95hq
         LKqAo1YyWiqajGSz4MFt9x2uzN8jIFOKUAQgWCXZTXW526AqhZeAZrz0mnUC1ZJfKnQq
         iMKy5JxGIXOCQq1eRY94g32FkRxglVlPfZVZQXLuyOC4z4APK2zir7sE5Szz9JU3sCO6
         6Psfqkpa8YFa7z56whzdhk//lJBhic1hu7LNNbxuAlN29ds2vRFMpRX8JvYOX2ddB83O
         NZw2nfoCrXXu9XL8ASWZs2NulRK3b8HmxVFuSa5PKhNh2JaUkLsCdKdxUICfhZKCAKII
         RuTQ==
X-Gm-Message-State: APjAAAV/aiNlP9x2V3GZ8bggl4Vh1YyvktU+7DWUxNdJBQm+vHFq3GSZ
        pBeElUqJqo4z5CkGLtqQg8rmD+q3ZI8=
X-Google-Smtp-Source: APXvYqxyhi5kvU1qroBktvn+b9l998/lIovbFV4ltRQvHlEgqjqHnwXl8/9kAj6mtBCNDVIZXvFS1w==
X-Received: by 2002:a2e:8192:: with SMTP id e18mr963727ljg.6.1552855998517;
        Sun, 17 Mar 2019 13:53:18 -0700 (PDT)
Received: from ubuntu.localdomain ([95.161.223.243])
        by smtp.googlemail.com with ESMTPSA id v4sm1725578ljj.80.2019.03.17.13.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 13:53:17 -0700 (PDT)
From:   Vladimir Petrigo <vladimir.petrigo@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        devel@driverdev.osuosl.org,
        Vladimir Petrigo <vladimir.petrigo@gmail.com>
Subject: [PATCH 0/3] Code formatting clean up
Date:   Sun, 17 Mar 2019 23:53:09 +0300
Message-Id: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce small code formatting cleaning up in the staging AD drivers

Vladimir Petrigo (3):
  staging: iio: ad7192: Fix style issue
  staging: iio: ad7280a: Add parentheses to macros
  staging: iio: ad7780: Add parentheses to macros

 drivers/staging/iio/adc/ad7192.c  | 2 +-
 drivers/staging/iio/adc/ad7280a.c | 6 +++---
 drivers/staging/iio/adc/ad7780.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4

