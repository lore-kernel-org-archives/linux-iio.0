Return-Path: <SRS0=eBr9=QH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B06C282D7
	for <linux-iio@archiver.kernel.org>; Thu, 31 Jan 2019 03:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3902184D
	for <linux-iio@archiver.kernel.org>; Thu, 31 Jan 2019 03:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="OXTtkyfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfAaDC5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:02:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44129 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDC5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jan 2019 22:02:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so717428pgr.11
        for <linux-iio@vger.kernel.org>; Wed, 30 Jan 2019 19:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mj5mOLY9bCrOBp8ERb8JtB9PpUxLCpRUSjJlMW9siE8=;
        b=OXTtkyfWraQg6ZAVv1wWG1KwFbQidOC5+En1MjdV79gR1TUcU8offJcieHOQLBaWn5
         uWUHn22Ojd2Y5J9K2QnrSEApZtIjqgTtVytG6QuRxFwNwNB0npOvtNPeW60t+e50mMop
         S2EoOmvcLHPeGKw2WLQxnsmEEODxKATlPyhENQVJ89XlsFRp+pVVvEDRHfbdEgg6UD6U
         7SBBc5KJGlx1V96eI3rhIOy23hP/V4PyQH7k1Lz+fJlDWy/Uo6roZ3wCJx8zrjMjXOmR
         HNejeXsvsdWKHms+2S09tod3MB0O014AsAe5T8+hetxg2bfEUbPtMb6mrm1YuxldsNcj
         wjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mj5mOLY9bCrOBp8ERb8JtB9PpUxLCpRUSjJlMW9siE8=;
        b=XydOpGapYrdMZJTQXDHEBIr2wTwtZWqpzX3+c2+yDXR5aqEZ/2iPz/BCF6yHoP4r+n
         7I5rhLQMQnISbrwPuI8FYTjpjWrkbmUmTDCqGxkKsWNQrBfWbiED/Uy9vpUKSYxB5i0h
         FtlKTErdGP6D0YMvB2v/QnZlFXs+vUcDcx+/btkqZDtM/VMN8i8OdgPgXSAnmiiTZbSp
         kXwQbyVRzwrvArphJOnL9Uf7W+HJ4JoYPj3b3IUyUwi5KqBwTG7FeYitm2qICxEkzE/h
         ssPAILf3jrUvPevr0lb5PliQzY9mOoMG2Y0HQrEKAIjCttoNSntQSlouSOrt2z8wN3tH
         eJrQ==
X-Gm-Message-State: AJcUukfskR6Z2G6uQi0HhhEelFPnnKPFhsVOSj9Qd2mS8Fy3j7haMTZB
        UNwktI4304K0NUIG94cKUHH0UQ==
X-Google-Smtp-Source: ALg8bN7o9XG6U2G5gVCdton3pX3wvYXbE0bXDjikq7dC/bolFaP9BNtaqVkRjfuVWa+K1/tFBwo8Zw==
X-Received: by 2002:a62:c42:: with SMTP id u63mr32565795pfi.73.1548903776568;
        Wed, 30 Jan 2019 19:02:56 -0800 (PST)
Received: from [192.168.0.8] (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id h129sm11670144pfb.110.2019.01.30.19.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 19:02:55 -0800 (PST)
Subject: Re: [PATCH v3 4/6] dt-bindings: document open-drain property
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
References: <20190127203911.8696-1-martin@martingkelly.com>
 <20190127203911.8696-5-martin@martingkelly.com>
 <20190130165723.GA22934@bogus>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <a58bfea9-9570-53ab-2811-05c1519952fb@martingkelly.com>
Date:   Wed, 30 Jan 2019 19:02:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130165723.GA22934@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/30/19 8:57 AM, Rob Herring wrote:
> On Sun, Jan 27, 2019 at 12:39:09PM -0800, Martin Kelly wrote:
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
> 
> Use 'drive-open-drain' like others.
> 

OK, I'll do this in the next revision.

>>   
>>   Examples:
>>   
>> -- 
>> 2.11.0
>>

