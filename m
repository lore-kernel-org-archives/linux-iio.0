Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88814C43461
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 04:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDA5611F0
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 04:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhEPEoq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 May 2021 00:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEPEoq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 00:44:46 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42530C061573;
        Sat, 15 May 2021 21:43:32 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i67so2843360qkc.4;
        Sat, 15 May 2021 21:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbjgNUVe8Zu5bIwH6pqs1iD0nbz2OTZgRS9bz6+pBoU=;
        b=QOwS14iHpV4ItuYZ4ul5r5ddPSeFJJNh+9KIlMJKofQmMBujv/EchplQKAkZ6LUGyT
         U647SuNDcSlPuMFXpT7zD7OBDa6TXJyUmhhpjv94As/VsId1eUqU5uN+iWp+9l7a1MJM
         0bmtT4i6vXdYaHHAS2cFGTjcU2H/5LA50FnDM052YTRxyg1/l4rWww5uQDXZiJWwG2vq
         motZxVHFZcdkuCUZFSuq3zhAedSdgmrPe3N/KWSvhpSmn1/f4Tx8WaRe/5ih9o6Vl7KX
         dVtrbnpfOuk+4SStHWGrfu6+nvmxRCyvqV8fnjLjvbvcv3lnWvf+hRxDk1aq2G/c/MLp
         zuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbjgNUVe8Zu5bIwH6pqs1iD0nbz2OTZgRS9bz6+pBoU=;
        b=N7egciiapmiyrGLnmNaga6Oh1cQz2wdkJY3Oyc0fuFJK/uNDFXyVTrEt012u8hurl+
         QVqb7d4l56PLLhpchQsPgpo6PiCLVNY1OC4b21SBB5BVeemqrPoTGUdpz3s5LsL2Mq9S
         er7Tk24njIY1K/6CaWewoUMM44CVPTuHlAzArhO6LsuG+b76sXnTcsuJi7ljtndWbCAe
         HgFlUZwJt+ldxvn91KTizN7t67p89Y2VYRNCyWAI8K7IQSqo4219UbGtsyDDvqwqnulI
         xzGtEfvHha5Cm3yITXTenlKBIn2+xOHj4Ebih1RMfATdHLCFP1b/8jL2b9rYdgO0eYWW
         McWw==
X-Gm-Message-State: AOAM5337yPV/sB3a926Qp1qkV0GMGYNjsjTdDV2mBSdiXprp1FfpC6Ct
        pxRIlxQcvOojDal7VlurBO59T4xwYxil4g==
X-Google-Smtp-Source: ABdhPJzyJJVyXvG37KENRcXJhI/FsZIpfphYnKmkv72HRkI5oL5crmcP5NTFZJLDPUS+m1CdamozHQ==
X-Received: by 2002:a37:a0c9:: with SMTP id j192mr38139415qke.19.1621140211357;
        Sat, 15 May 2021 21:43:31 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j28sm7750980qkl.35.2021.05.15.21.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 21:43:30 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: [RFC PATCH v1 0/2] hwmon: (iio_hwmon) optionally force iio channel type
Date:   Sun, 16 May 2021 00:43:13 -0400
Message-Id: <20210516044315.116290-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a devicetree binding to optionally force a different IIO channel
type.

This is useful in cases where ADC channels are connected to a circuit
that represent another unit such as a temperature or a current.

`channel-types` was chosen instead of `io-channel-types` as this is not
part of the iio consumer bindings.

In the current form, this patch does what it's intended to do:
change the unit displayed by `sensors`, but feels like the wrong way to
address the problem.

Would it be possible to force the type of different IIO channels for
this kind of use case with a devicetree binding from the IIO subsystem?

It would be convenient to do it within the IIO subsystem to have the
right unit there too.

Thanks for your time,
Liam

Liam Beguin (2):
  hwmon: (iio_hwmon) optionally force iio channel type
  dt-bindings: hwmon: add iio-hwmon bindings

 .../devicetree/bindings/hwmon/iio-hwmon.yaml  | 41 +++++++++++++++++++
 drivers/hwmon/iio_hwmon.c                     |  2 +
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml


base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
2.30.1.489.g328c10930387

