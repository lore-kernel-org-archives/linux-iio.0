Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C996AC282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 18:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB5221916
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 18:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="B57FL9od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBIShO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:37:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35647 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBIShO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2019 13:37:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so3217313pfi.2
        for <linux-iio@vger.kernel.org>; Sat, 09 Feb 2019 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HC4UMgRo9taydEULszTY+A/+5tC9LQ94RoUGAAv3sP0=;
        b=B57FL9odZ/cNeH5Muri3I0/NJnsePO1pMMVr+AfyNFtnHo4/dAKXqHUVOxxuQOve+B
         yRQl61DUwAaqaMWuhB+PZI/cJHtyCrVZolEl1scz9KPzojPgVtwa8Kvh8RlCemQM64+3
         BC2xbgwrne+1t7iYxS/d4uS16mDAKTSf9ySUT/P0mL4zVzAAz5tUqRiCPjeNrXF3tCv8
         kE4lWccPHk547LnRyAQifQFmM/YgIcVnKJxzDHzaf9OP8B/jSEdtlLB13UmsIgr7O6yk
         BO5noUZ+/0HYytLv0tOGP4l2Ht7BGLYnTa+9iSAm7+hTnj4XYINKQ1cC7LbXDUV7eECY
         539A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HC4UMgRo9taydEULszTY+A/+5tC9LQ94RoUGAAv3sP0=;
        b=VeB2Exh+b+Y1KF15G/p44J0B1fjKF9dhUK2eRjJHvzPn8OB9agBwIMHTFVe6BEJPzv
         dQGEOcWi0W7yk4JNToWO+2IQjetmpiRI2YZjdAfQZB8TuxNq0HX802yP7khl92MzymK3
         6US2x01Ppx9GxvlvGcN0s3aJar7sXszHfVAMODh53RRBKtx9qb1y5womMNVV0pUNp/L+
         UgEDKZsWHDm0Ks5OiW6zwuhme1GEjVZjzby2zQ7nEkeqPot65cbL9+xYeXeEyUul0YR7
         3RSC5loSpXFWK0Shpzp8P9wmqjJJfVrDCCR5yvyk/qhLu82MSUe4o9k6Gs4Acx+a9LU/
         suDg==
X-Gm-Message-State: AHQUAubsi58eCRJvuf14+I40z4n1IiS4Ftri9NTmAgtIthYZlWq79dpy
        noLyn5iyNqvE5C45YdBsYO8mHg==
X-Google-Smtp-Source: AHgI3IZk/2oPNlLyMBwl/F1NWsaiS0oL4TWbD9XmqRGb26CjV9A0h5g7KTQXj5naX8XouxQgThv0ug==
X-Received: by 2002:a63:2054:: with SMTP id r20mr26098965pgm.328.1549737432933;
        Sat, 09 Feb 2019 10:37:12 -0800 (PST)
Received: from [192.168.0.8] (71-212-3-95.tukw.qwest.net. [71.212.3.95])
        by smtp.gmail.com with ESMTPSA id 125sm8815438pfx.159.2019.02.09.10.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 10:37:12 -0800 (PST)
Subject: Re: [PATCH v4 3/6] dt-bindings: fix incorrect bmi160 IRQ note
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
References: <20190202215601.20275-1-martin@martingkelly.com>
 <20190202215601.20275-4-martin@martingkelly.com>
 <20190209151715.676fc7df@archlinux>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <588057dd-a406-3d0a-fd6a-b25a5bf9e804@martingkelly.com>
Date:   Sat, 9 Feb 2019 10:37:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209151715.676fc7df@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/9/19 7:17 AM, Jonathan Cameron wrote:
> On Sat,  2 Feb 2019 13:55:58 -0800
> Martin Kelly <martin@martingkelly.com> wrote:
> 
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> The bmi160 bindings say that the BMI160 requires level-triggered,
>> active-low interrupts, but it actually supports all interrupt types, so fix
>> the note to reflect that.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> I'm not sure why you changed the example, but it does no hard.
> 

I guess I just wanted to make it even clearer that level-low is not the 
only IRQ type available, but you're right that it's not strictly necessary.
