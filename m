Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC024C282CA
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F56D20C01
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="0BASRRNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfA0Un3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:43:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35543 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfA0Un2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jan 2019 15:43:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so6341444pgs.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=04Hwve9x7N8Ww3tEwi/ygQUVtPCcvw9qv0TFIUlZ2Kk=;
        b=0BASRRNwpJNy9PxpJLKptw0RH2pWIoVsbxh7hQ2GLY0blgDitAciHu4SQBQL4i5OIW
         VT6P7jXBSGZqDY8B0q2hJKORONmoivjuaILT21loKDryhOqsHsWSjkwdg8Khk09DjQZS
         ij/mupI2BSS2WUEQUGhu1p1RC2CNfAG/yL64gPy6z9T0DVpP/GXwEhCm21z3NXAGFjnX
         1Lor6MC8WWa2L+GoXAmnLTV+kdTJO6CYj18H5RF+o0PnXo+6qPCCu8BoZkYtB/0V06w3
         BSHCk+5nVgXA0Kr7tV7WkQvXjEvY+unmURXAWkBd9v2BEb1ztu+gMkQkdrB69PH7m/v+
         TU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04Hwve9x7N8Ww3tEwi/ygQUVtPCcvw9qv0TFIUlZ2Kk=;
        b=P3fweBH3fIef1edZGoW8Nt7DUB1h6WMM5svRTWlAQW4f/minD59fD93hU6ndX2U0kg
         +m11YlQ6ldDgzZoSORMWzL3uNs0OjQ0aOEeVl/VBUMQCV7XsxIC4KKxMJ8T7u40qCI5C
         I+BXpjzW+2CVYiKsUcHYs2maJ7v43stadapyQJ/JsvfkRYgPto87hPYDxv/7qCoYe7Mh
         Ra53ERTkGyVfeEIeqPubUQaWbobNphFf2RNuyxq9e/e2wXz8EyivoDa+C2Cj9K3INy7h
         tQJMIyY+R3tKL1niKY5GYBUljHG8YDTam9t5+OTSc+L/GsgmBZPV1t1T2CxtpGJK/1i/
         RKDQ==
X-Gm-Message-State: AJcUuke+Vi6e1vCmQNar1YXW4ZzLmtPYsG+e6bahpqVT4XFpkMUDjOmw
        D4ZEPzE8fydC1qJwjKbx08PSng==
X-Google-Smtp-Source: ALg8bN65l0kc18BAHESNI9M4uhGi0EPy8iyBGxOJbXUAINvN5SPPx7eVfjllx3wXM5Ir4w0AKmCPfA==
X-Received: by 2002:a63:2784:: with SMTP id n126mr17732496pgn.48.1548621807959;
        Sun, 27 Jan 2019 12:43:27 -0800 (PST)
Received: from [192.168.0.8] (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id e86sm44282632pfb.6.2019.01.27.12.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:43:26 -0800 (PST)
Subject: Re: [PATCH v2 2/6] iio:bmi160: add drdy interrupt support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
References: <20190122020431.5338-1-martin@martingkelly.com>
 <20190122020431.5338-2-martin@martingkelly.com>
 <20190126201756.12faa7bb@archlinux>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <e2ede2cc-527e-24e1-81de-0fe7b6b2cc4c@martingkelly.com>
Date:   Sun, 27 Jan 2019 12:43:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126201756.12faa7bb@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/26/19 12:17 PM, Jonathan Cameron wrote:
> On Mon, 21 Jan 2019 18:04:27 -0800
> Martin Kelly <martin@martingkelly.com> wrote:
> 
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> Add interrupt support for the data ready signal on the BMI160, which fires
>> an interrupt whenever new accelerometer/gyroscope data is ready to read.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
[snip]

> 
> That seems unlikely.  Why on a rising trigger are we setting a flag
> that is named to imply it sets level triggering?
> 

Looking again, I see that the code is right but the names/comment were 
wrong. In v3, I renamed BMI160_LEVEL_TRIGGERED to BMI160_EDGE_TRIGGERED, 
as the default is actually level-triggered active-low. The datasheet (p 
63) has a sentence:

‘1’ (‘0’) is edge (level) triggered for INT1 pin

which I read backwards.
