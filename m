Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B18DC433DB
	for <linux-iio@archiver.kernel.org>; Sun, 24 Jan 2021 07:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3514222B48
	for <linux-iio@archiver.kernel.org>; Sun, 24 Jan 2021 07:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAXHnS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Jan 2021 02:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhAXHnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2021 02:43:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B63BC061573;
        Sat, 23 Jan 2021 23:42:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kx7so6431509pjb.2;
        Sat, 23 Jan 2021 23:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnQ1t1HIXvpFZ4+CSt2hUE9Q8ybzJKBcDIeS7w8dyP0=;
        b=Qk79N4yICeLlLFyGIkwZwtfFfCNd9R65zQmsW1A9ewdpV2XIlh5lbEDuie5cX87QMD
         DuPYE8LSJUFt5BzlTas0NiiewgRaJywa/rGqtWAS4Q3bosWnXDBvbfJbHled7cBrBmC9
         /l/HbMkYawe51dbSehH74wVZRiiA1bMYIREZpd9ymzl24aKBPqtZN/moyqT7G2+QqU6Q
         ZnlnOa/+T30doyhdRKb1UoOAEOfchVlOXUfY8pYc5nAU/CWRbM1N9rI4uo/Z5TbOFS0r
         Mh+nOd4w9ppctYl+1pzU488p3euZYo50hf49VqVoFd2iYvXlQSNxBVjDSb39DCSTDR2N
         FRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JnQ1t1HIXvpFZ4+CSt2hUE9Q8ybzJKBcDIeS7w8dyP0=;
        b=W63TN//RLOfXdbo9sdCFICfLE4ZRLLTZdHhOR4UbCQyXDW/46m6XbfRXNGJg8RB2GU
         D7PqEfjQJV6kd8xWJiSkWUVd2PNe7edQlXSQ2ZsgHuQxhjHu00DhHqUTLUalTPNzRjqT
         on5KS7tzujQ1Fos7X4mTGV54Uyo5ugVwnzviopejsRznoZPYss/CtNzRV/5+urJqSF5s
         C7VQRmIuItannLiFv0xkiprifP9cUow/qhG1wZQhieKrNdlSiPA5G9BTc5RU3ig1acU6
         UkSxGs3NgO+hZc/pa3S2J4U0J2c9dbnYD9XapuIOHIRyUKpTru/LCAW3oIGEVf+r6xit
         R5YA==
X-Gm-Message-State: AOAM531lKyk+IIn+asF3Myn2p0Mr+vSQrU+tRV9SfOv8hbkX1XzZVbsn
        Dqhn5XIaBmdqPrG8GVbhjkU=
X-Google-Smtp-Source: ABdhPJzse6JCTU8QUfQ2CmyWhbecICQ0PY8QVckXAv6w5er/77dlI9IxBXKbJczbRNc0bb3Rw7UP1w==
X-Received: by 2002:a17:90a:c82:: with SMTP id v2mr15212121pja.171.1611474155751;
        Sat, 23 Jan 2021 23:42:35 -0800 (PST)
Received: from localhost.localdomain (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id k3sm12642449pgm.94.2021.01.23.23.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 23:42:35 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org, fabrice.gasnier@foss.st.com
Cc:     fabrice.gasnier@st.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, benjamin.gaignard@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/2] Remove the IIO counter ABI
Date:   Sun, 24 Jan 2021 16:42:22 +0900
Message-Id: <cover.1611473891.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO counter driver has been superseded by the Counter subsystem as
discussed in [1]. This patchset removes the IIO counter ABI code and
documentation.

[1] https://lore.kernel.org/lkml/20210119104105.000010df@Huawei.com/

William Breathitt Gray (2):
  counter: 104-quad-8: Remove IIO counter ABI
  iio: Remove the IIO counter ABI documentation

 Documentation/ABI/testing/sysfs-bus-iio       |  40 --
 .../testing/sysfs-bus-iio-counter-104-quad-8  | 133 ----
 MAINTAINERS                                   |   1 -
 drivers/counter/104-quad-8.c                  | 652 ++----------------
 drivers/counter/Kconfig                       |   2 +-
 5 files changed, 65 insertions(+), 763 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8

-- 
2.30.0

