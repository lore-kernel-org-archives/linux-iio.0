Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A0AC433B4
	for <linux-iio@archiver.kernel.org>; Wed, 12 May 2021 08:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BD4613C8
	for <linux-iio@archiver.kernel.org>; Wed, 12 May 2021 08:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhELIlO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 May 2021 04:41:14 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:6882 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELIlN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 04:41:13 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2609b9458745-1a17c; Wed, 12 May 2021 16:39:52 +0800 (CST)
X-RM-TRANSID: 2ee2609b9458745-1a17c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6609b9442e6c-2c712;
        Wed, 12 May 2021 16:39:44 +0800 (CST)
X-RM-TRANSID: 2ee6609b9442e6c-2c712
Subject: Re: [PATCH] iio: adc: ad7768-1: Fix the right interrupt
 interfacecalls
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511153108.14816-1-tangbin@cmss.chinamobile.com>
 <e923eaea-bd62-2395-5c71-92eb9d849fd5@metafoo.de>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <5dd97e8f-8a52-c79c-2b00-7e6b807990ed@cmss.chinamobile.com>
Date:   Wed, 12 May 2021 16:39:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e923eaea-bd62-2395-5c71-92eb9d849fd5@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lars-Peter:

         Thanks for you reply!

> Hi,
>
> Thanks for the patch. Aren't those two expressions equivalent? Are you 
> seeing an issue with the current code? If so can you include that in 
> the commit message?
>
> - Lars
>
>
        When submitting this patch, I actually thought about it for a 
while, but finally decided to submit it, my reason is as follows:

         In numerical data of address, &ad7768_interrupt is equal to 
ad7768_interrupt, and the compilation can pass. But I think they are not 
the same, ad7768_interrupt is the first

address of the function, and its type is irqreturn_t, &ad7768_interrupt 
represents the address of an object that points to the function 
ad7768_interrupt().

         So I think they are not the same, For previous experience with 
devm_request_irq(), I send this patch. If I'm wrong, I'm sorry to bother 
you.

Thanks

Tang Bin



