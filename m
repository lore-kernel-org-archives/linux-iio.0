Return-Path: <SRS0=n4Xm=XI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B99DC49ED7
	for <linux-iio@archiver.kernel.org>; Fri, 13 Sep 2019 22:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261DD20644
	for <linux-iio@archiver.kernel.org>; Fri, 13 Sep 2019 22:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uFNniSfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404082AbfIMWgE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:36:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404031AbfIMWgE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 18:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
        Subject:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hk/QMrwcjpBQJO1pNNtD8W+v7/fWfC/tiM3cHQ48+oI=; b=uFNniSfXPIr+x5Se8arJWe1Up
        MBxT5UlrLuAQ/C88vype8vLFgHhfe8fIDUYhWJgxQaUkKwm9YVzQNJEVoECdwFbQE4gniqRw3eI9p
        V7vnKGT+WXpJQGYFdIVqExnkUJ07owcTZUyOUbduxMYwwEQ8Q83Dw7Gx+wQhNojijY8q8aqxsZuwl
        7sTKHETumWaBNzY2vThup7Ra35XjWvyN0F0vRphfKLvtN/dYVfGVnQm8gAGXqBSkCAorJTylsdD4R
        ksLFCVDwTRNnpcDba9lWPcXRyNPYQ/QOznhW4OToelDVuDIQMAMWG7pS05a5AK4AlBHJsg1dXXN33
        3kw+WavgQ==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8uAe-00048f-4Q; Fri, 13 Sep 2019 22:36:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: Problems during compiling in kernel modules
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        linux-newbie@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
References: <20190913173821.GA5986@SARKAR> <20190913180103.GB5986@SARKAR>
Message-ID: <ff4b5c99-086b-4456-fb2b-643a6caefcee@infradead.org>
Date:   Fri, 13 Sep 2019 15:36:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913180103.GB5986@SARKAR>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/13/19 11:01 AM, Rohit Sarkar wrote:
> On Fri, Sep 13, 2019 at 11:08:21PM +0530, Rohit Sarkar wrote:
>> Hi,
>> I was trying to compile a particular folder in my kernel tree.
>>
>> AFAIK the way to do this is:
>> `make drivers/staging/iio/` from the kernel base directory.
>>
>> This gives me the following output:
>> `
>>   CALL    scripts/checksyscalls.sh
>>   CALL    scripts/atomic/check-atomics.sh
>>   DESCEND  objtool
>> `
>>
>> No object files are generated.
>> I feel like I am missing something.
>>
>> Thanks,
>> Rohit
> 
> I ran `make clean` in the `drivers/iio/accel` directory which removed
> all object files in the first place. However running make after that
> doesnt seem to compile the modules.

Hi,
It works for me.  Do you have a kernel .config file?
Does it set/enable CONFIG_IIO and some/any/all drivers in drivers/iio/accel/ ?

If you don't have a kernel .config file, I don't expect it to work.
-- 
~Randy
