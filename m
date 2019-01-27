Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC49C282CA
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 23:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4990C2147A
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 23:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfA0Xjj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 18:39:39 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39990 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbfA0Xjj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jan 2019 18:39:39 -0500
X-Greylist: delayed 1882 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jan 2019 18:39:38 EST
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0RN8Gui027696
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 18:08:16 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0RN8Bfd005441
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 18:08:16 -0500
Received: by mail-qt1-f197.google.com with SMTP id w15so18746029qtk.19
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 15:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=QQQI1VeREQLrhDI8VVdoD+egvcJS/4EzoFBcR02kzdA=;
        b=HwRJDkxn2UWTS7GXMKynilF5bQqkLfyqbDIceL7JXSLBrTliuTXmftB+MyJ4THu2EJ
         8eET+Tp3clik4cGoQjOSTLl7pxkIbJHMYEnIEF7kAhLCXYBvRJpFStah0V+LjNbTwbR8
         GWTMrovw/bZLCTpAa1ySJA89mPa6ry34kaHW7fZM3y3EeXp6A4QiD680bR0k+zS+nj+3
         EBgTnTImlAJawWbkwwo+5ktlh9617Rz1KzPbVOioPdLaUeGWn+swxzFQOm/fftODRQdR
         dryiop4YVb4R8UQdIL5U1B8AQZ/QAxhaN/SBdSeilKZXA0tNBAn4ehs4nMesAwvE4grk
         AcCg==
X-Gm-Message-State: AJcUukeoqxlJnsZoVPWGhKuvoPDFmVTxmalhMCY/o4wQ/299DZoq/DJs
        ZErO0m/yQXQmUgrs9ld07P3DHufl4Tsb954g4ywc5lzk/N1sR/aQNMLOHBnGnsMLd5hXNYD1G4f
        y1P8dMTctYma6ooIe1HBnTvQZjkvBveI=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr17796077qkb.25.1548630490998;
        Sun, 27 Jan 2019 15:08:10 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6YKNOekIeWq2fp5ZJWmzwVkrTCS4z7c8HwfcFREpt0CaQunJIEglpMk5hX4Ez5BUMeqNrmGQ==
X-Received: by 2002:a37:61cd:: with SMTP id v196mr17796068qkb.25.1548630490866;
        Sun, 27 Jan 2019 15:08:10 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id w184sm97215556qkw.90.2019.01.27.15.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 15:08:09 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Bharath Vedartham <linux.bhar@gmail.com>
cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: industrialio-core: add check when kzalloc fails
In-reply-to: <20190124142755.GA31059@bhar.linux>
References: <20190124142755.GA31059@bhar.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 27 Jan 2019 18:08:36 -0500
Message-ID: <17314.1548630516@turing-police.cc.vt.edu>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Jan 2019 19:58:00 +0530, Bharath Vedartham said:
> add code to handle the case when kzalloc fails to allocate memory to dev
>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

>  		dev_set_name(&dev->dev, "iio:device%d", dev->id);
>  		INIT_LIST_HEAD(&dev->buffer_list);
> +	} else {
> +		return NULL;
>  	}
>  
>  	return dev;

Not needed, as the 'if (dev)' statement fails, dev is already null.
