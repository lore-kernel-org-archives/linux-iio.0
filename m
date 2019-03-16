Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0950BC43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 10:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB2A218D0
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 10:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0niLQa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfCPKju (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 06:39:50 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:55853 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfCPKjt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Mar 2019 06:39:49 -0400
Received: by mail-it1-f170.google.com with SMTP id z126so11219491itd.5
        for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2019 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7RbHIKSvkSu5MTQqeMl90TxuVj+HzjusbaId14VN4Mo=;
        b=e0niLQa3QzADahxjKH1zGyoQkuovBSwcKu8/rYsenMVJHSpGvLAWs718Pe8feBVfbL
         NEBlEvayzWHVgcjb5JMO8uS3lh8GLdh/04bwSQ6LyH8NMilel7eBHRiLBi0z7CfpUHFN
         WLGtrveTGvBjaoFNuhq9plnsNfGqVQnUXI87muc+5IbgblLmcAtzASmJE5/CHOlQJsny
         Gj0eEXWA0Ud8bLAUs4jvBa0HFlC60baRVcUEG5d7lhvmUiXTJHnbWXTn51vkXRGy/pPT
         b3oxb/XdnYQZSSXjuVjL6Iy1k46qchXjW7g4kuZRoF8gDloU8BVRdhoaeLQkNZQGqond
         yqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7RbHIKSvkSu5MTQqeMl90TxuVj+HzjusbaId14VN4Mo=;
        b=LG8dmxMXGefqwOn/3kOymr+LjL1WeGs5vk22XOBsx/SzV9bWIydWFqHxCr/rZ6cfJM
         pDiiqkb5cGN7C9CZz9MBRf/3EinaiKsCV3zC6zjIUzr6PySmA7Q6YuJRa36g5MCg3RJG
         0kpo63wpf2HmNSfpNNw0f99ljbKbiJ5ENjSnNvYelkIkGKOAkzlc7h8wLIyM8B4Av5cO
         CYXAKVXuVGzuDXNn5H+n0Ux6eL4XHzlIFSipvwSaIuwi8DvSbra8JmG7U2l77563soBY
         jfTJEfJ9YgtFL7sT0pa3VvRYrXLl46Wp7M9Oe2pEd0ngHrelceUobBO21mNahgo4nBdf
         8pUQ==
X-Gm-Message-State: APjAAAV3Hmo/CYRx32+XScGlYXA0KllYzDgLAgiQE3Gg9YlmSqEKwsII
        7JY3VKWocmHu9vaB92SVfRpM7aUNdMIY4lq/BX5xzDZl
X-Google-Smtp-Source: APXvYqz1SnJUdqvSPfw3dN7DVnK++1ZPujMQf4ACquT/rKrRMH8sklpdTyOpbg1vR1oeHL+MK9iTqgQgrKA9tn+OXKg=
X-Received: by 2002:a05:660c:743:: with SMTP id a3mr4726828itl.7.1552732788916;
 Sat, 16 Mar 2019 03:39:48 -0700 (PDT)
MIME-Version: 1.0
From:   Karuna Grewal <karunagrewal98@gmail.com>
Date:   Sat, 16 Mar 2019 16:09:36 +0530
Message-ID: <CAHRz_ybdmvgntoVjvSizUKLKETJasHyucoPM56v2Xrf=3K30Hw@mail.gmail.com>
Subject: [GSoC] AD7292 driver project
To:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I'm interested in working on the AD7292 driver for Linux kernel as a
part of the GSoC project. I've previous experience working with device
drivers and am also familiar with couple of Linux kernel's subsystems.
For a starting point I wonder if someone can point out some tasks
which I could work upon as the project page doesn't elaborate much
about it.
In case the idea is to start working on the driver itself I'd like to
discuss about the same.

Best Regards,
Karuna Grewal
