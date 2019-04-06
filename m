Return-Path: <SRS0=ooLe=SI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94316C10F06
	for <linux-iio@archiver.kernel.org>; Sat,  6 Apr 2019 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E1213A2
	for <linux-iio@archiver.kernel.org>; Sat,  6 Apr 2019 19:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNG1zjeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDFTpd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:45:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39961 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfDFTpd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Apr 2019 15:45:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so11196472qts.7
        for <linux-iio@vger.kernel.org>; Sat, 06 Apr 2019 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O46R9SJOkUqQKhtw7gkNkoaWcrIpkyhIJC1buLGXKgs=;
        b=fNG1zjeX7c1Okd8b0xNqwX+uhEn3D0316Z175svcNjC2c2yThbH8fhZQqUOCXORnJv
         E4wCaVhMIfBQ8O7o65B8/pMZ+At/5eQiLeQEu5e2vZVOIXTi6I/3KiwoAb62l7Eiz0zt
         ORwdXTgD2zrcGlvogT17Y5pQTvbImE0DPPLO4/wdGkd9iL0ZHjo+CyYHan22djO3FiqO
         JqFH/3gec5KKn51RNkASGqA2hY6requ6Gr7crD5v935/RF/gEwjSz5EKgKsdBIKLxwhC
         h73desnb0G6NdPFb4JRHTeBkgoIM3+geVRFJRDeHRHF7wWFie1rLeDIhyZ7Bs7bLVcO8
         HCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O46R9SJOkUqQKhtw7gkNkoaWcrIpkyhIJC1buLGXKgs=;
        b=f4z86JPkGbR6zkQWp7dBKowtD0VgamGLu+4LleHNYSjVRkCabGFWdn7gLi2VxW8SnT
         Z8hMccOkLpW1fxGNObmKCNEFvtsVHjquVHSs1x0INtUriK1amv9iXp9r/gufuq5Cg0wh
         lLclk8wwrRDw93jdFAK7vnuQlizvFmdGK0cBQraBreGuGA555UP8qWInL5thb6p/von0
         kXHFAJy9eLWvlr+Hi/5YYJf9D7au56kGOXlfi/7H88UKJ8/fxHTbY9mrrct/5seWeOiv
         Br+aj2RMjotgafTCdm4SZ0IGPeOKKtqsA3hAcDmdiztslBS7yKPFJD0z1C3IjUC8ACyg
         p1/A==
X-Gm-Message-State: APjAAAXnXUrECL26NV52Fqu+zjhOE0qJC74FIted42EQfyF/sInLueaG
        OHjtrMQ08HnUuaueUxvcdnU=
X-Google-Smtp-Source: APXvYqypUH2kbue7AtWwbeCs0mB0s52qyys4gYz+iJdlPxWy01EqxlrutuAoa6+LNNY2nqRsmYb32w==
X-Received: by 2002:a0c:81fa:: with SMTP id 55mr16675039qve.91.1554579932365;
        Sat, 06 Apr 2019 12:45:32 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id k4sm8926510qki.15.2019.04.06.12.45.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Apr 2019 12:45:31 -0700 (PDT)
Date:   Sat, 6 Apr 2019 16:45:28 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     dragos.bogdan@analog.com, michael.hennerich@analog.com,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Subject: RFC on IIO AD7292 driver GSoC proposal
Message-ID: <20190406194528.qx2tvrriuymb6xnq@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello.

My name is Marcelo Schmitt, I'm a computer science student learning
how to contribute to the Linux Kernel in the IIO subsystem. I was told
by a friend that Google was encouraging people who contribute to open
source projects through the GSoC program and that there was a project
for developing a new IIO driver. I intend to continue contributing to
IIO and, if possible, engage in this GSoC project. As suggested by
GSoC organization, I shared a draft proposal for the project here
https://docs.google.com/document/d/1vOegyoC5b90jwLe1PBz4IbKGXaXMozi-RldS5OAZz4Y.
It would be really great if anyone could comment on it.
Sorry for sending it so close to dead line date.

Thanks in advance,

Marcelo
