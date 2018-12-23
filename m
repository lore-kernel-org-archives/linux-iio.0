Return-Path: <SRS0=i5w7=PA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E692C43387
	for <linux-iio@archiver.kernel.org>; Sun, 23 Dec 2018 11:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB9121903
	for <linux-iio@archiver.kernel.org>; Sun, 23 Dec 2018 11:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="AIj7bMgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeLWLtC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:49:02 -0500
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:57688 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbeLWLtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Dec 2018 06:49:02 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Dec 2018 06:49:02 EST
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id b26IgQWxwjyENb27pgQ9Uw; Sun, 23 Dec 2018 11:40:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1545565253;
        bh=fawX1Td788cQoCbFJwT0YQ/JHtab9lpKJDDjjEufgic=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=AIj7bMgCnsuw4c5CzRfHOozaZjHidtdoKf6RElasalfWCRUNBhx9mRFYV2JzV3iXW
         bKmwyypRXOy9UNONoR0uBK+peU79bdmmVkTORvFQ2YlPi6NavRumig/WJea64mnrtw
         6lr9DiKPkSA9vB2j1eixNTg5IHG0ZaR9KBvfMKPQMwzDZt+Oh1Izf0zmgaJ5ZzRJPt
         FXs6VscdztFOz1v3/YW11V4DJC3jDqccOHd/U7hz67ZXvfNEdDlx6fLuqkzdk3ybU2
         pZeVfsuNkJm0cHAk+hT41QD+bf5oJ7WijI+QU6wGqroDZ4bYEXijCZCOqQ0eHrbjDA
         meTfya9wQ1GLw==
Received: from HAM.N0WIQ.org ([IPv6:2601:283:8102:e200:1e1b:dff:fea9:78c5])
        by resomta-po-16v.sys.comcast.net with ESMTPSA
        id b27mgpWI76Mzgb27ogJEqv; Sun, 23 Dec 2018 11:40:53 +0000
X-Xfinity-VMeta: sc=??;st=legit
To:     linux-iio@vger.kernel.org
From:   Kerry Miller <n0wiq@comcast.net>
Subject: Loging int PlutoSDR
Message-ID: <2569cb00-2759-f4c0-28e7-062a3e4a2f19@comcast.net>
Date:   Sun, 23 Dec 2018 04:40:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear People,

I find myself between a Network engineer, An RF engineer, and I can do 
some computer programming.  I am retired from earning a paycheck and I 
wanted to learn more about SDR.  I do use a native Fedora Linux 
operating system on my PC desktop.  My gole is to put PlutoSDR on a 
raspberry Pi (Exactly a Raspberry Pi B3+ I have forgotten the PlutoSDR 
ssh login and I don't remember where on the web I found that information 
a year ago.  I relate the PlutoSDR to a Raspberry Pi 2 or a raspberry Pi 
2B, How wrong am I?

-- 
Kerry N0WIQ

