Return-Path: <SRS0=UNU4=QK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052CFC282D7
	for <linux-iio@archiver.kernel.org>; Sun,  3 Feb 2019 00:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC35720870
	for <linux-iio@archiver.kernel.org>; Sun,  3 Feb 2019 00:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="OdMXId4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfBCAar (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 19:30:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34401 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfBCAaq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 19:30:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so5117041plz.1
        for <linux-iio@vger.kernel.org>; Sat, 02 Feb 2019 16:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qcUn+mGlHwk43YTFNIzD6HyXrckX3EkUGidVCRh44mQ=;
        b=OdMXId4rxzTXJjd/dWpjk+i5wo9t68Jaab2euMhTyghGGFLaA2IQzdlWRC3eziE9ya
         PQ188HxPdXLuks+WBXpG58eLS9SdW1WB7e6X6GoJ/nt0wH8BFBvXemz0PFZJrOmdu6bW
         uzteKrFDOGEsKiJ0bzTxiJ5emqKw1ISdczW6FCkARkSUJ47hi+i/7TUOS8HLFft2eQ05
         JbNhyewybLa010GE/rSK4QMP3xNeRz/EsDreqyH86rew659mhFXr4I8fgC9kITfChPxS
         YwhSCIVd9HxwO/ccULK+3GZiGuB/+oPfhA4UvQ0d9vFfKZjsVnf+GRr8ADzzXFIk2tRN
         E3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qcUn+mGlHwk43YTFNIzD6HyXrckX3EkUGidVCRh44mQ=;
        b=MzEAKwMwfTUcBvQpFpKYx26tm0VjdbLh3LcCyVltmLICXL6LWpCOKHlZtika/KTx3c
         0ZlDQP8fRiC2X/vuTJVd1tk0tEuvhvsVfbNZDCe4nW3vc7UJrNmI2f6YoP9Z3yB12f46
         zIX079U3rvlsjgMVcX96/9fvkFBVS7DRQpvKscKhECK6KW11aZfX3Hhz+zObMoKKy+aE
         b8988gGzOmsOVMwOq9u0TpVYp95pg/iO176S/m0i5Jgzc6Xjxw9Fgpffj4IVEL6Jjx8d
         B/G91Fe0eeORkyL6BApGQXOQe0aZMxnaXoVJMWTpXVpRX+hNHiyPPHTI5Pdw5JZa+V3p
         nGJQ==
X-Gm-Message-State: AHQUAuZjO50OQ8m5PQUxpktxmHIyWJjE/mCk1DJW0hcfi1UWR5RZS6Zj
        AG4rcsBcpqcKPsQDEq1a5IIbjg==
X-Google-Smtp-Source: AHgI3IbAn/WJk1N9wGkKtTfmmfbAZLrbQC/TqJNISF1nUnHqAzjCha59Vzib9UJPGk17mWYB+qOktA==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr2837909plt.85.1549153845965;
        Sat, 02 Feb 2019 16:30:45 -0800 (PST)
Received: from [192.168.0.8] (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id w88sm20650737pfk.11.2019.02.02.16.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 16:30:44 -0800 (PST)
Subject: Re: [PATCH v4 6/6] iio:bmi160: use if (ret) instead of if (ret < 0)
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20190202215601.20275-1-martin@martingkelly.com>
 <20190202215601.20275-7-martin@martingkelly.com>
 <CAOMZO5DsbEhdW1dhcWxig7b5VB7qnkWtbU-SqY5cGJp2Ld0nuA@mail.gmail.com>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <aff2e86e-a6be-24da-0f4a-add25a2cbee2@martingkelly.com>
Date:   Sat, 2 Feb 2019 16:30:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DsbEhdW1dhcWxig7b5VB7qnkWtbU-SqY5cGJp2Ld0nuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/2/19 3:12 PM, Fabio Estevam wrote:
> On Sat, Feb 2, 2019 at 7:59 PM Martin Kelly <martin@martingkelly.com> wrote:
>>
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> We are using "if (ret < 0)" in many places in which the function returns 0
>> on success. Use "if (ret)" instead for better clarity and correctness.
> 
> What's wrong with "if (ret < 0)" ?
> 

Jonathan Cameron pointed out that the check is for functions that return 
0 on success. Thus, the check should be either "if (ret != 0)" or "if 
(ret)". Jonathan prefers "if (ret)", so I'm using that. By leaving it at 
"if (ret < 0)", technically a function could return positive numbers and 
not count as an error, which is a bug.
