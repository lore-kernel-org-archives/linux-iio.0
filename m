Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF310C6FD1C
	for <linux-iio@archiver.kernel.org>; Wed, 22 Mar 2023 09:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCVJJp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCVJJk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2023 05:09:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310DD5DCAE
        for <linux-iio@vger.kernel.org>; Wed, 22 Mar 2023 02:09:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n19so768239wms.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Mar 2023 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679476153;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIo8FbyobGdeQjgMiSgscC07gnUNe4wDdBq9sEfgL3Y=;
        b=IChelLMXRukvs9WOpZNMbJr/z8qLXldPHwd6gwf3UGMDe4/HQfQS3iK4SdveWmwKFS
         /5PhqdfubZ1kppRWKsGrFCXD1Ly26Nwcn6T9nvQyUbeEayuETnEiqUpDThw2BcOJlzGD
         vYMPv14fIXAbRa50hz9cxcrRX5km8c5Lyv62nJQB2sgwN0FHyy+mUS+9pRUGZ9Lbhvbz
         iv2Rce3/s+MssFY0hqwKWLxBT3BT2l4dGWyEFrkfYZXJaTroYhUBmrHhW05x2KRuwnP2
         +YSmEhFpEvM0RlRsaGAMiVdfovbGI+KhiWAVjzRO11IFaHQ496SPkwkt3ZDOUz3m2rCG
         z2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476153;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIo8FbyobGdeQjgMiSgscC07gnUNe4wDdBq9sEfgL3Y=;
        b=R26yqGVY2xJZ/YGeAi2i9c/XL3BEk6ZPAtQAW2AmRLKtYC3CGuj+KT5m3r1ySycMLB
         iRpgv6L5UZjWycaskMFXUichtZUWni3nSl6ltQkYzWyGcoyfQrbWUxxA7+OHgyoVpEN9
         E1gRGC+KRmizdnrAXN4CLaCgLpx30aHwj/NcVJnmZuliM4I7+wRrbypdJpTziXGhnRzi
         /OJN8Y0Mpqqbbt07LVZrmEqccfo0TV6BIz4UuLNRgQQzzR+qkb8g+ycMOC0DgNGSf1wY
         flBJkI9GIYoMy+GsJN0RZWdCyBX3QW9fQBzoPDMdftAwd7HZywF7lT0VSluLiMH+K9FL
         +34w==
X-Gm-Message-State: AO0yUKX5d0VNtrAvJvZVrdASwgMj766BYwWCjUhd4QCrPVclZto7G0yK
        BTTjMEd4EhGV4EbL2zQO0P8=
X-Google-Smtp-Source: AK7set/7KBK6RzSBPHAV0hi3ti2lczAaduMHlJIynOzG0aT4H2ux2QPRgqtC8xwj7xY+KtkJx7FjhQ==
X-Received: by 2002:a05:600c:295:b0:3ed:492f:7f37 with SMTP id 21-20020a05600c029500b003ed492f7f37mr4579386wmk.10.1679476153158;
        Wed, 22 Mar 2023 02:09:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm13379671wrs.44.2023.03.22.02.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:09:12 -0700 (PDT)
Date:   Wed, 22 Mar 2023 12:09:09 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
Message-ID: <02034937-12e2-44f5-8311-10d960dc7dc4@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[ No idea why this warning is showing up after 6 years. -dan ]

Hello Linus Walleij,

This is a semi-automatic email about new static checker warnings.

The patch 63c3ecd946d4: "iio: adc: add a driver for Qualcomm PM8xxx
HK/XOADC" from Apr 4, 2017, leads to the following Smatch complaint:

    drivers/iio/adc/qcom-pm8xxx-xoadc.c:769 pm8xxx_xoadc_parse_channel()
    error: we previously assumed 'hwchan' could be null (see line 761)

drivers/iio/adc/qcom-pm8xxx-xoadc.c
   760		hwchan = &hw_channels[0];

Here the hw_channels is variant->channels so it potentially is NULL
(maybe?  I don't know the context very well).

   761		while (hwchan && hwchan->datasheet_name) {
                       ^^^^^^
Check for NULL.

   762			if (hwchan->pre_scale_mux == pre_scale_mux &&
   763			    hwchan->amux_channel == amux_channel)
   764				break;
   765			hwchan++;
   766			chid++;
   767		}
   768		/* The sentinel does not have a name assigned */
   769		if (!hwchan->datasheet_name) {
                     ^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

   770			dev_err(dev, "could not locate channel %02x/%02x\n",
   771				pre_scale_mux, amux_channel);

regards,
dan carpenter
