Return-Path: <SRS0=THUK=QG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A06C282D4
	for <linux-iio@archiver.kernel.org>; Wed, 30 Jan 2019 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F3421473
	for <linux-iio@archiver.kernel.org>; Wed, 30 Jan 2019 08:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfA3IEo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:04:44 -0500
Received: from mailgw04.loh-group.com ([195.226.74.53]:58190 "EHLO
        mailgw04.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfA3IEo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jan 2019 03:04:44 -0500
Received: from mailgw04.loh-group.com (mailgw04.loh-group.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C0F5DFA3A;
        Wed, 30 Jan 2019 09:04:41 +0100 (CET)
Received: from mailgw04.loh-group.com (mailgw04.loh-group.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00A51DFA37;
        Wed, 30 Jan 2019 09:04:41 +0100 (CET)
Received: from notesroot2.de.flg.int (rootserver2.de.flg.int [10.201.6.141])
        by mailgw04.loh-group.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 09:04:40 +0100 (CET)
MIME-Version: 1.0
X-Disclaimed: 1
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <20190126175810.2b6f8058@archlinux>
References: <20190126175810.2b6f8058@archlinux>,
        <OF76C145E1.65F3BD5B-ONC125838C.00390E6F-C125838C.003B6395@rittal.de>
Subject: Re: Re: imx25 ADC values wrong after sporadic time
From:   Benjamin Beckmeyer <beckmeyer.b@rittal.de>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-iio@vger.kernel.org
Message-ID: <OF3C596761.167B90FC-ONC1258392.002AA183-C1258392.002C5F53@rittal.de>
X-Mailer: Lotus Domino Web Server Release 9.0.1FP6 April  20, 2016
X-MIMETrack: Serialize by http on herborn07/DE/FLG(Release 9.0.1FP6|April  20, 2016) at
 30.01.2019 09:04:39,
        Serialize complete at 30.01.2019 09:04:39,
        Itemize by http on herborn07/DE/FLG(Release 9.0.1FP6|April  20, 2016) at
 30.01.2019 09:04:39,
        Serialize by Router on rootserver2/FLG(Release 9.0.1FP6|April  20, 2016) at
 30.01.2019 09:04:40,
        Serialize complete at 30.01.2019 09:04:40
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
        charset=ISO-8859-1
Date:   Wed, 30 Jan 2019 09:04:41 +0100 (CET)
X-TM-AS-GCONF: 00
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Obviously I'm guessing just as much as you are.

> I would first check to see if the interrupt fired at all in the case
> where the timeout occurred.  The completion only fires if we have
> a flag set in the status register.  Add an else to that block see
> if we get interrupts where it isn't set.  For example if we are
> getting spurious interrupts from somewhere occasionally we might
> get a race in there as it clears all the irq sources, not just the
> ones we have actually handled (which is dubious as there is defintely
> a race in there if any of the others are firing).
> You could cynically add a spinning loop of some type to waste time
> in that race period and see if you can open the window up to replicate
> on your system.

> I don't have one of these, but perhaps try on your 'good' system
> with just clearing the SR_E0Q interrupt and it may give us some insight
> into why the others are being cleared.

> Note that if we don't find an expected interrupt (and there isn't
> a weird hardware bug that needs working around) then we should
> return IRQ_NONE to let the kernel spurious interrupt handling kick
> in correctly.

> Otherwise, I would indeed look at the interrupt controller driver.
> Might be something dubious in there.  Of course the RTC error
> could be something entirely different.

> Of course the usual issues of power brownout and similar might
> also be going on.  The delights of systems at customers working
> differently than the ones you have!

> Jonathan

Hey Jonathan,

thanks for your reply and your guesses, too.
I will try some changes and maybe come back again. Like it wrote before
it could take 2 months.
I thought maybe somebody else could have the same problem or better I 
hoped somebody had the same problem and a solution for me. But I know 
that this hardware is really rare. 

Benjamin
