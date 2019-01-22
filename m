Return-Path: <SRS0=dXrR=P6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC074C37122
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B3C20870
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="ovgAK46y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfAVCGf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:06:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33605 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfAVCGe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 21:06:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so10982641pfb.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 18:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oi43RhrC5PR6Hi3TRSIeGUgHksZc+dj1RsbzBTLaZUE=;
        b=ovgAK46y7k4yWwwo5n96K+WNf8q1iZgqT/kqcpqGhvCUGW0GziFJEc+SaR0oNf58jB
         SMWGZ2Y5LPxQ2ZiEacw5Aa+JCYbIx9ss22i/9f65vvVTbgctxWPSc2RVTrXT810gIrUx
         zVHLCSrC0fsQcl/FYXlJ1z+eC31/E+oVBxeyI4+DH7W767h8f9TbnMxgvcuJICjcI0PC
         5N08QP/E+tyUL2YM25crcyxOesl4oQP56VJb2296OVI1P/qii0nfIj32ZEh/jqQ+frG2
         KUn4hjhUu2JC74TIVTpAKib1KxihbrDh6dpJD80Af7Ac0X262GttPkwWO4x/qzzaYR6U
         fhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oi43RhrC5PR6Hi3TRSIeGUgHksZc+dj1RsbzBTLaZUE=;
        b=ei4ahS9qlGgjHyAkB7lKlTqr0eTVOCzpNeptoMaWM+pCoSeWjq3cxLFu220HJrkUtu
         pEgcZ/mHSoVrDLIoBINJMg3h6mpLzminyFVt741l0/I0KwAPO/uVhKZxyxsfLcAf+6lj
         UE5e7/t6rSyG3dQwg7iHpNBhaHf63in859D+jhmEHQsIIpkbXM3CWKDtyjFqa9oxs5YM
         OHJPfvgR3OczZ4R+3fYfC0GW66zpJkYvqlTu/htCQxPZsCkoEq4qoRG1Jy5zekvqWcX7
         i9PeJWFTYaur0wZEzhFQ+zq+B5TDDD7Ep15XP5hp1eq2/TWuYJTWLU23puQQi21xwpY8
         CJ8Q==
X-Gm-Message-State: AJcUukcepsNLx9xfuTwW8/qpXpFexFbbPEaZVN2bl29dgc+umE4yJoLI
        zsKsEXvZJL8hDauZ9BoRST1qAg==
X-Google-Smtp-Source: ALg8bN4qUwrXfhWZxz/LkbKZtgqJ0JeiQ5jPj7Mlpk0IywMEYBI99MU0yMEKsTxqtF9PN4JLobhXvw==
X-Received: by 2002:a62:44d8:: with SMTP id m85mr32162724pfi.164.1548122793904;
        Mon, 21 Jan 2019 18:06:33 -0800 (PST)
Received: from [192.168.0.8] (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id r130sm20922621pfr.48.2019.01.21.18.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:06:33 -0800 (PST)
Subject: Re: [PATCH 2/5] iio:bmi160: add drdy interrupt support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
References: <20190114035621.5252-1-martin@martingkelly.com>
 <20190114035621.5252-3-martin@martingkelly.com>
 <20190119171704.4356c763@archlinux>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <a88c6993-280b-2e44-e861-6883f67ed20e@martingkelly.com>
Date:   Mon, 21 Jan 2019 18:06:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119171704.4356c763@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/19/19 9:17 AM, Jonathan Cameron wrote:
> On Sun, 13 Jan 2019 19:56:18 -0800
> Martin Kelly <martin@martingkelly.com> wrote:
> 
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> Add interrupt support for the data ready signal on the BMI160, which fires
>> an interrupt whenever new accelerometer/gyroscope data is ready to read.
> 
> Various minor comments inline.  Mostly fine, but one big 'oddity'.
> 
> I think we only ever request 1 irq, but we have support in here for
> configuring the chip to generate two at the same time.  Doesn't make
> much sense as it stands... Am I missing something?
> 
> Jonathan
> 

Yeah, I initially wrote it not allowing for a "BOTH" mapping but added 
it afterwards in order to support what the hardware allows. However, 
thinking about it more, the hardware allows this so that you can map 
different types of interrupts onto the two pins. So, I agree with you 
that with just a DRDY interrupt, there's no reason for this mapping, so 
I've dropped it.

Thanks for the other comments; I have made all the changes you suggested 
and sent a v2. I also added a cleanup patch in the v2 to change the 
other invocations of "if (ret < 0)" to "if (ret)", as there were a 
number of them in the driver prior to this change.
