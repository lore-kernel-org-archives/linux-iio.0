Return-Path: <SRS0=BP1q=XJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60923C4CEC9
	for <linux-iio@archiver.kernel.org>; Sat, 14 Sep 2019 15:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36222206A4
	for <linux-iio@archiver.kernel.org>; Sat, 14 Sep 2019 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C2MzGcdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfINPXI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 14 Sep 2019 11:23:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfINPXI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2019 11:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QeS3aSLBDbtOqUsJfdzyrqBh1JWu32OM9gL7ixNGo6s=; b=C2MzGcdwlrUizS+r2nwmeKMlb
        Wc0C59b4VGQaslqc1Ad7h+6B9GanGZHUsmqcH0/f4ZkNCTaHYVXPkosCYbIzVRBuA/F/hvHs6IVzb
        8g8nSvvUnU2CYBX/OqG1e360Q3aNeAfR620irmIFguRs2UjOzq2mPPXcX1Fb8h7oBdCaPcW0AAMBk
        GbOQlkdxFMxsnrjuGUHz47mHvEaMloMbIQeYxMCn53mGXI6EONTQ070GnkVHjCAYhjHi/6owdjJ4c
        bbWx1Jpku+ZJEbfLiuGW+HqLo462J/otqT+zEbC5h7b+Omg6Mh06D6LCdiirztWYcgRDGOd9sxdhY
        ei1tq0uPw==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i99tD-0001Hp-Uf; Sat, 14 Sep 2019 15:23:07 +0000
Subject: Re: Problems during compiling in kernel modules
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-newbie@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20190913173821.GA5986@SARKAR> <20190913180103.GB5986@SARKAR>
 <ff4b5c99-086b-4456-fb2b-643a6caefcee@infradead.org>
 <20190914063136.GA23166@SARKAR>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cffb789d-1464-c194-bfc4-bc05a5ac9db7@infradead.org>
Date:   Sat, 14 Sep 2019 08:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190914063136.GA23166@SARKAR>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/13/19 11:31 PM, Rohit Sarkar wrote:
> On Fri, Sep 13, 2019 at 03:36:03PM -0700, Randy Dunlap wrote:
>> Hi,
>> It works for me.  Do you have a kernel .config file?
>> Does it set/enable CONFIG_IIO and some/any/all drivers in drivers/iio/accel/ ?
>>
>> If you don't have a kernel .config file, I don't expect it to work.
>> -- 
>> ~Randy
> 
> Hey Randy,
> I do have a .config file but no it does not set "CONFIG_IIO".
> The weird thing is when I built the kernel initially the object files
> for drivers/iio/accel/ were generated. 
> That's strange right?

Sounds like you now have a different .config file and that the earlier
.config file did enable CONFIG_IIO.

-- 
~Randy
