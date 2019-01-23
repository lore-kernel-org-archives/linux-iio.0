Return-Path: <SRS0=F8OE=P7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEDAC282C0
	for <linux-iio@archiver.kernel.org>; Wed, 23 Jan 2019 19:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7505F21855
	for <linux-iio@archiver.kernel.org>; Wed, 23 Jan 2019 19:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYFjh/1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfAWTgY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:36:24 -0500
Received: from mail-yw1-f41.google.com ([209.85.161.41]:36641 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfAWTgY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jan 2019 14:36:24 -0500
Received: by mail-yw1-f41.google.com with SMTP id i73so1398072ywg.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Jan 2019 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=S2czTqVO7MrOb0aEEIoh9i20Mc05XGmWbIIElK/bR88=;
        b=TYFjh/1xMhMHTYUCFy44uBK+eEZDr6Cuap236K09eWeZVc42JGus2zKoBIo3PcA27W
         rrwLZt6FH/Fr9Mv8cHhZwy+giXaAR0vsR/8Ldqtc7hnNGvSA3If89g/HYXwc+HVOXoMe
         1eZnARQaSMLJSjOckILb5cVpgfKF7TI03v51NgHYtprv0IjX63vmj9fuUlfedRiTXRfb
         CdCY7J4jJYGkblEe5Js/f+QHmJS7mR7tq/PbAttMVGxFO2yzWIEvny2IYqMhYW47TCt/
         eONLs+54WMGnIAVSJHyyk5CWy18v7vWaTvON9D2p96KcBaeM4WjwSFKxIThJG6rmL5je
         1JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=S2czTqVO7MrOb0aEEIoh9i20Mc05XGmWbIIElK/bR88=;
        b=SBA+1O40nNHXa+uZL4vl82WVUW3yolSoo9vjz/xJplibC6gFzXGsxsVqwe1mYCavXC
         uCG/kNOf100QeUfmubN5JsUqsfIWmmEL9AUFKdlSoD2hHlrHON/Aog++ZTn69ivJNyfM
         AzmqI7TwiYe91/82U2vJqkKZkj7NlgAI7ZU2DJjTmNFg+giTFDGU1cbFeXgQUQxrGSXw
         pv15P6xe8yx0VV9XXUbu/Js7ZP5JGWQ2lbTXrfL2u0JvBRGcOnAeZwpFu791FdfRr42y
         P8qseTLZ5eE2P166hMtuCUMUx1oo7Y1sHrilJWFAD689w/Lrf8u5AxBED65A/9ttd/ww
         xM2A==
X-Gm-Message-State: AJcUukcjDgnF4TOxY7rZjl71LzHypwbvpbnY2dAW+Kmq6dUsne2U2ZkS
        G6htu9+dCeeIXncdC9euWzHw6yiIevdQzBrClCPccw==
X-Google-Smtp-Source: ALg8bN4oOTJquiXjs+7Y1f2IhJSJp02BX4yG6CX0+h6EN9PANrIWSdm4ywmfjmHhMoKh4+9R8fooIC4TOR/da+czbvc=
X-Received: by 2002:a81:2916:: with SMTP id p22mr3459582ywp.176.1548272183493;
 Wed, 23 Jan 2019 11:36:23 -0800 (PST)
MIME-Version: 1.0
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Wed, 23 Jan 2019 11:36:12 -0800
Message-ID: <CAJx26kVrDbxrp+rKQOhao_k5O8LThLcDRs8HibcohVEvhAF3Tg@mail.gmail.com>
Subject: ti-ads7950.c GPIO Pins
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        david@lechnology.com, Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I have an use case where I need to configure the 4 GPIO pins on a
ADS7953. The current driver does not support this. What would be the
proper way to implement this?

I created an IIO_VOLTAGE channel for each GPIO to enable or disable
them, but this doesn't seem right to me.

Any suggestions?

Thanks,
Justin
