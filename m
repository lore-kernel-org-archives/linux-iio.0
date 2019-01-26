Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF0C282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1426F218CD
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 23:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="Y+miU2tP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAZXby (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 18:31:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34809 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfAZXby (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Jan 2019 18:31:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so5661915pga.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Jan 2019 15:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2LCOYruZ6pFgZ/bC7J2Fr9Cnl/WoPFifRL2Ys9dRy+s=;
        b=Y+miU2tPn+PkIf+skYQxnmHQUAbedYvxmHszUQp9p2dlUKU5qusEBNxRIfzhjcn11u
         RCjRVvXBICJDxCesEuXxbXAZhmjLkGHfafz2SpAvySOA/MXj5Q8Wyz8MOQ+F2u5LSw98
         zTyKfzv9ZkLjEMAbTCE9TswtZTKkSUnw5KOyziMLHfsNsZWBzKQGWbPAX4XA5hU0Pl5x
         9s+UMzyk2XJRBRSHLx9JYkIpmLVI6y6qADeJ3QRUrRGiRQXdh45EtR76/AXMw+obbRxw
         slxcMIeP0ntS7OWXf0Spq0UBctSTPg292jHdofEHspCcGN4Bv2E67VtgrTKOeD5jTuly
         KAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LCOYruZ6pFgZ/bC7J2Fr9Cnl/WoPFifRL2Ys9dRy+s=;
        b=C0+0wHaqptbivjPNa+En8fNCAVzqRoTLuSIWueSr+kPxsNlsTJW0lsgd4O2Z4Pubhj
         9BJ4vYrbWn5NObXdZ08J+M64qYXtYCz8SqRJWupKxajDjoCH1gIwyVVuAFGfpIqTqFWa
         UhxDGlCF+egNmSWSJttFCLvEvy59Fh4gjGl7He+J/2QLQqLKTmctxzIUkej/sYtmQpfh
         81FvgaiTSAUw9RPLXI4+dGkQK+UJlryeS6EK7S8S4Yk9McPWHo6RKtboO3zdelI43my1
         sj2Aj+mEZMTZ49yL4AKJJxI1ct2Y/6t7maruUu7lhlsr9ofz1wS7ZDKR9aJuDs9GOQg2
         IuAA==
X-Gm-Message-State: AJcUukfME+cUPWPs+5FFyH39g/YK6qFiQcfQWb+OHWM9NihVSNSibl3G
        QtYyp61k7phNXuxEiWh93tUEXA==
X-Google-Smtp-Source: ALg8bN4teHOJCN3yLus0AVvNDHaMRAGFQCbCsDA6wjM/p45od01Newf+kcU5OqLeUF9qMtnPtAFpdQ==
X-Received: by 2002:a63:235f:: with SMTP id u31mr14777713pgm.122.1548545513077;
        Sat, 26 Jan 2019 15:31:53 -0800 (PST)
Received: from [192.168.0.8] (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id x19sm43719182pfk.14.2019.01.26.15.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 15:31:52 -0800 (PST)
Subject: Re: [PATCH v2 4/6] dt-bindings: document open-drain property
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
References: <20190122020431.5338-1-martin@martingkelly.com>
 <20190122020431.5338-4-martin@martingkelly.com>
 <20190126201958.0448e660@archlinux>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <ef9a2b58-372f-c3e8-8ae8-86b5045e7b0c@martingkelly.com>
Date:   Sat, 26 Jan 2019 15:31:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126201958.0448e660@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/26/19 12:19 PM, Jonathan Cameron wrote:
> On Mon, 21 Jan 2019 18:04:29 -0800
> Martin Kelly <martin@martingkelly.com> wrote:
> 
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> We have added an optional boolean property for configuring a BMI160
>> interrupt pin as open-drain, as opposed to the default push-pull, so
>> document this.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
>> ---
>>   Documentation/devicetree/bindings/iio/imu/bmi160.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
>> index 1aec19997fb5..7eb4b6016404 100644
>> --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
>> +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
>> @@ -12,6 +12,8 @@ Optional properties:
>>    - interrupts : interrupt mapping for IRQ
>>    - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
>>      input, set to "INT2" if INT2 pin should be used instead
>> +- bmi160,open-drain : set if the specified interrupt pin should be configured as
>> +  open drain. If not set, defaults to push-pull.
> I missed this before, but normally we prefix with a manufacturer rather than
> a particular part number.  Maybe that changed when I wasn't looking though!
> 
> Anyhow, these DT binding changes all need devicetree maintainer reviews as they
> aren't totally trivial.
> 

Yep, devicetree is on this thread. Rob, should I prefix with device name 
("bmi160") or manufacturer ("bosch")?

> Thanks,
> 
> Jonathan
> 
>>   
>>   Examples:
>>   
> 

