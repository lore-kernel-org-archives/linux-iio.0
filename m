Return-Path: <SRS0=Oeur=RQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B32C43381
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C240E20657
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 19:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSVa/5bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCMTfr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:35:47 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46046 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCMTfr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2019 15:35:47 -0400
Received: by mail-qk1-f176.google.com with SMTP id z76so1851446qkb.12;
        Wed, 13 Mar 2019 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BJ2p3Jy84UTBSluqlnLMaXAMIYi6tpopx84A7m0yWUY=;
        b=sSVa/5bgzNZbLQdK1pMGzJHFJQ4FoWlkLoFpPThi8aGWB0gCH8Up62SW6P/Mg3V64/
         A9JGTyQVDh+NAHCJCgMJzno2n1Qbn2AIFaVGnqwzzR/qVVBKZ3Mkdj8545iYPxqHrq12
         apjTLaKRSDpSjHaNPR/RnQClns3q6EyUsALrn234VpQtueulQG6E/c1Mq9iUfyySZKKx
         nr0PkT29em5s3l9doZIwdCfaYXpLKNOrZz7vDFqllIkAoQfVrqhuDEBpvc3Ts0lsoeh8
         x9YI9qOR2Vq1d1IHe7zOjb0EFAGzd++sDXLxeijw+ZUOV/f0ars/k8z2A6JeMz1kHRk4
         CzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BJ2p3Jy84UTBSluqlnLMaXAMIYi6tpopx84A7m0yWUY=;
        b=KZTJJvvNjVixkPI+la/Xqu6uqTSjxgJYzRyORqWQUZTNT1XNFKQo3VaL05npIh4sik
         M0ge241cQC27SVR4DwVPZ9+qVRml9l4El6KveFkmMuVy/hyYPcx+kmiylnXFaSez0oQJ
         sy0WQQwkoaAJxNMrdWyxFDcUkV+gOIKUHCV0UwkaOzaCtr2F60YYfIQZfaUZLLLqzB7m
         1b8zui1Txy8oa0JW/1t35/c1t2OyWX6UsO/DbIVZ9QU6k7li4tmu/Y01kAGjX+N25P42
         xZ0URw74lgLpp0ew/UUdNcNi7oP2E0uLXThE6AsFg//fAPnkrJgGWh1EtihRCemUSHmY
         2MzA==
X-Gm-Message-State: APjAAAWHuoI+L0O5izz10fy7J2DqTkJwRKzLffrDi4QS3eSmO1rWCscK
        sRDbs8lQEpFECDKW9ddmB08Wiy6O
X-Google-Smtp-Source: APXvYqxFNxuUDflIxqm+cRwqKajiLqbm9IUFUwD4A9/lOGaYOY6WAzhx/S3f8GTdUeNQFTF+rU2w6A==
X-Received: by 2002:a37:7407:: with SMTP id p7mr33658178qkc.13.1552505745475;
        Wed, 13 Mar 2019 12:35:45 -0700 (PDT)
Received: from localhost.localdomain ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id e85sm1495607qkj.58.2019.03.13.12.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 12:35:44 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:35:23 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     gascoar@gmail.com, linux-spi@vger.kernel.org
Subject: Testing ad9833 with Diolan DLN2 adapter
Message-ID: <20190313193523.k6vipjv33uoiqx25@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I am trying to test an ad9833 module like the one in [1] using Diolan DLN2
adapter and the driver ad9834.c

So far I get the DLN2 adapter correctly registered as master device
(below the spi debug output) but the ad9833 driver doesn't even probe.

Below the spi log output and pin connections. I'm using the testing
branch of the iio repo. The ad9834 and dln2 drivers were compiled as
modules.

The question is: should this setup probe or extra steps are needed?

Any help appreciated.

Thanks,

Gaston

Hardware device
---------------

[1] https://www.amazon.com/Alloet-AD9833-Generator-Programmable-Triangle/dp/B07GS1CDXZ/ref=sr_1_1?keywords=ad9833&qid=1550752799&s=gateway&sr=8-1

Kernel tree: IIO, testing branch.

DLN2 - AD983 connections
------------------------

 - SS -> FSY
 - SCK -> CLK
 - MOSI -> DAT
 - GND -> GND
 - VCC_OUT -> VCC

SPI debug output
----------------

[65465.572149] usb 1-1.2: New USB device found, idVendor=a257, idProduct=2013, bcdDevice= 1.00
[65465.572155] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[65465.572158] usb 1-1.2: Product: Diolan DLN2
[65465.572160] usb 1-1.2: Manufacturer: Diolan
[65466.553970] dln2 1-1.2:1.0: Diolan DLN2 serial 33629166
[65466.554925] usbcore: registered new interface driver dln2
[65466.733716] dln2-spi dln2-spi.3.auto: cs_num = 5
[65466.734198] dln2-spi dln2-spi.3.auto: freq_min = 2000, freq_max = 18000000
[65466.734453] dln2-spi dln2-spi.3.auto: bpw_mask = 0xFF80
[65466.735044] dln2-spi dln2-spi.3.auto: registered master spi0
