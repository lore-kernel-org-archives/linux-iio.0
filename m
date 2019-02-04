Return-Path: <SRS0=dQzZ=QL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A005C282C4
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B312087C
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="BoYr/kBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfBDRHx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:07:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40097 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfBDRHx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2019 12:07:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so201837plq.7
        for <linux-iio@vger.kernel.org>; Mon, 04 Feb 2019 09:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/+W/4N9wmNOAQkB8U5MTTAJPkQPiF5Zm/JYyQxhSzQE=;
        b=BoYr/kBoGRR0WmXVGv5CyHiEDSMMEtWe59OdB4l7D8NnH42NyN0bBmeFIKPpMcnjeF
         soAoApB6VJKTB7zzTIqic5D2ReK3JKCxfZKk9wxS2S/PRueQawKGDjLWySg5FXpqM01n
         TdUoRxCRrf+DlFsYOX22jDADtZqDv81outK52dhN0CfSQzlW7jyjsyjDohJ2ZANdlnPE
         RH9KmUjCLiOPyb2eZST0RuGfLp3FqWUsN0AVGfhWLWNiiHMCxoSu2Vgf9FI5js0UO/SG
         zjJJvzV/DvyjFFa+ZsDFjnVtoBkqS9HNNQPJvAYuPalw42NsiOxy9mB6xbbAnoFSLnBa
         0b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+W/4N9wmNOAQkB8U5MTTAJPkQPiF5Zm/JYyQxhSzQE=;
        b=JMaSUkvy+PCcB0zfhot1XPaeYRpqJNRYOVgY13AtUATZ6qQJV0AkSP1BcGWfJe59l7
         ZJ3e2QAKXRG8wsdFwn/D5Nswf6sYTX+oKgZ0XNngnLanArScyn42VQod5hKG6LWnn9HQ
         Ii2HhUKb+XU7yRtB71ZIadJXrnW8brbC2vZbklULqzr4PYX/QPIDDlXHp4yj5DHxL9Yx
         C5ii42wCzfIJx27BHg15ouHRPkOKmsTGi2leB1TzyOjCN+/xmcmVy5K0XaZ9K5jNUF/v
         GliFv65APdlEKcPaOm3nXou3g+qWYTh/6UmV/gBYuNhfxEVVsQO33N246E29mxk6dZsr
         CLOQ==
X-Gm-Message-State: AHQUAuYeoWs5HdalMDG54P1CjkvayravTPSNigdvFqOGMHkYZ9ZGMs0Y
        fY7qId8TWwjWVnXVZtKlbZ7Ab/m98hQ=
X-Google-Smtp-Source: AHgI3IbnK4B+GDQg0kUHLrDu4u1/3ERRd+G0H4ATuo9sqmJ3l8hviCm2Tj13puZbTyMTDuloCASmGg==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr373976plu.127.1549300072405;
        Mon, 04 Feb 2019 09:07:52 -0800 (PST)
Received: from [192.168.0.8] (71-212-3-95.tukw.qwest.net. [71.212.3.95])
        by smtp.gmail.com with ESMTPSA id f64sm1787834pfh.0.2019.02.04.09.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:07:51 -0800 (PST)
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
 <aff2e86e-a6be-24da-0f4a-add25a2cbee2@martingkelly.com>
 <CAOMZO5BNK+v6t3qFYs5b+NpPHkrR4jiuy13DsM=AOQxAR3kY4g@mail.gmail.com>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <1197951a-61c3-65a7-b7c7-2396116ea13e@martingkelly.com>
Date:   Mon, 4 Feb 2019 09:07:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BNK+v6t3qFYs5b+NpPHkrR4jiuy13DsM=AOQxAR3kY4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/4/19 7:15 AM, Fabio Estevam wrote:
> On Sat, Feb 2, 2019 at 10:30 PM Martin Kelly <martin@martingkelly.com> wrote:
> 
>> Jonathan Cameron pointed out that the check is for functions that return
>> 0 on success. Thus, the check should be either "if (ret != 0)" or "if
>> (ret)". Jonathan prefers "if (ret)", so I'm using that. By leaving it at
>> "if (ret < 0)", technically a function could return positive numbers and
>> not count as an error, which is a bug.
> 
> I fail to see how regmap_read()/regmap_write() functions could return
> positive numbers on error.
> 

It's not that the functions actually do return positive numbers (they 
don't). It's just that the success criteria is documented as "returns 0 
on success". Thus logically the correct check for error is "if (ret != 
0)" or just "if (ret)". This also is a bit self-documenting. That's why 
this patch is a cleanup instead of a bugfix.
