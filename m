Return-Path: <SRS0=5Wrn=Z2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28192C43603
	for <linux-iio@archiver.kernel.org>; Wed,  4 Dec 2019 11:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E698120803
	for <linux-iio@archiver.kernel.org>; Wed,  4 Dec 2019 11:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="b8s5H7H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfLDLNI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:13:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33587 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLNI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 06:13:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id y23so4594908wma.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Dec 2019 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c4ZhnqdZwQ1jkrhazSJJXoHNQ3MHx1CRCVBv+5aSp2o=;
        b=b8s5H7H7kQi5gVJYCe9vtzXTCo2YRnCb0/I+gZYBKlUf9RXhSplL/DMdtQOf8bxTqh
         sLDPXbyAvT1x222Ywt/65zj2/xN7S9DP/H1OIfpQO0E7DjmkAwc/jrRxZib4zwjL+/wE
         Obttp9dRi5Pj71Gxv1ET2q2BbFyVaUBeHULt56Gd1+Q05Yb+mAgrerFXCkAFEh7c5200
         RopGH7zEv5RBP+73S+pFIzM78swYmdZbCkcXWMurH8cTOPmZWdJtPijoS4yWcT82N2MU
         L1BgY/kSp87VFGEAIyuoa7ATxfpWJAMQZaY/7U3QDlnIUYRkGjAQ1b6cfLNwdidMQy18
         0xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c4ZhnqdZwQ1jkrhazSJJXoHNQ3MHx1CRCVBv+5aSp2o=;
        b=o/B+m8ZnJvAERPxOXxmNexUNyog56VR9yp/w/W0tzQtxy14k+Kf/7L+kEynISXye3U
         8Sfk2T2BjieCVHr+G0kPRSwkj36ZhEiBhR3HjESU4PhwRwG/XfLHFhKQp2WIV5X+n8Wz
         EZWKBtKBCnDLj/e31AkND5cCXQx6ystQFgeghiWryFsD7JsFRcmg6JES1pmvZhM1AuZh
         eCW/KNvP5MZL4jlZw4K6OWQ7M6BSAzy/3awAOdrXbRLOLcXwd27oVuILGqF/kk6gfQiJ
         wj2Io4wY6os0hkzY3hHLgyFWV0Vt0u75g68kJxDh9yAmh7O1n6AqA83jAq8vhdMHA9oy
         G+mw==
X-Gm-Message-State: APjAAAXOlMSet25IM8YdHE5wYLltNwA+wL0GuIlYXOAAnaCuU6uQ8oeq
        nl4am6YCtJb11bG7Fd9lB613AYRC5RWCNg==
X-Google-Smtp-Source: APXvYqxzWiVpatre/vYmVyofwnezYhQKRJqbOdEUAwxVzhaaZY1Lwe1HuzrxLHOYAW1IuQKui9kBSw==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr12239951wmj.41.1575457985604;
        Wed, 04 Dec 2019 03:13:05 -0800 (PST)
Received: from [192.168.1.37] (230.120-247-81.adsl-dyn.isp.belgacom.be. [81.247.120.230])
        by smtp.gmail.com with ESMTPSA id c72sm6697535wmd.11.2019.12.04.03.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 03:13:04 -0800 (PST)
Subject: Re: [v2] iio: ad7949: fix channels mixups
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <9ea595fc-d53b-3cd4-a511-db2b09726606@essensium.com>
 <20191202141336.4507-1-andrea.merello@gmail.com>
 <c3f3367f-cc78-23f3-ec89-439b9bc8f433@essensium.com>
 <20191204110659.00004987@Huawei.com>
From:   Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <13a71c7e-678c-cffa-ae43-104918f88265@essensium.com>
Date:   Wed, 4 Dec 2019 12:13:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204110659.00004987@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Le 04/12/2019 à 12:06, Jonathan Cameron a écrit :
> On Mon, 2 Dec 2019 16:36:19 +0100
> Couret Charles-Antoine <charles-antoine.couret@essensium.com> wrote:
>
>> Le 02/12/2019 à 15:13, Andrea Merello a écrit :
>>>    drivers/iio/adc/ad7949.c | 22 +++++++++++++++++-----
>>>    1 file changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
>>> index 5c2b3446fa4a..2c6f60edb7ce 100644
>>> --- a/drivers/iio/adc/ad7949.c
>>> +++ b/drivers/iio/adc/ad7949.c
>>> @@ -89,6 +89,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>>>    				   unsigned int channel)
>>>    {
>>>    	int ret;
>>> +	int i;
>>>    	int bits_per_word = ad7949_adc->resolution;
>>>    	int mask = GENMASK(ad7949_adc->resolution, 0);
>>>    	struct spi_message msg;
>>> @@ -100,12 +101,23 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
>>>    		},
>>>    	};
>>>    
>>> -	ret = ad7949_spi_write_cfg(ad7949_adc,
>>> -				   channel << AD7949_OFFSET_CHANNEL_SEL,
>>> -				   AD7949_MASK_CHANNEL_SEL);
>>> -	if (ret)
>>> -		return ret;
>>> +	/*
>>> +	 * 1: write CFG for sample N and read old data (sample N-2)
>>> +	 * 2: if CFG was not changed since sample N-1 then we'll get good data
>>> +	 *    at the next xfer, so we bail out now, otherwise we write something
>>> +	 *    and we read garbage (sample N-1 configuration).
>>> +	 */
>>> +	for (i = 0; i < 2; i++) {
>>> +		ret = ad7949_spi_write_cfg(ad7949_adc,
>>> +					   channel << AD7949_OFFSET_CHANNEL_SEL,
>>> +					   AD7949_MASK_CHANNEL_SEL);
>>> +		if (ret)
>>> +			return ret;
>>> +		if (channel == ad7949_adc->current_channel)
>>> +			break;
>>> +	}
>>>    
>>> +	/* 3: write something and read actual data */
>>>    	ad7949_adc->buffer = 0;
>>>    	spi_message_init_with_transfers(&msg, tx, 1);
>>>    	ret = spi_sync(ad7949_adc->spi, &msg);
>> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> Hi Charles-Antoine,
>
> Why a signed-off-by as opposed to a reviewed-by or similar?
>
> signed-off-by brings some very specific legal implications around Developer
> Certificate of Origin, so is normally just the author plus people involved in
> the path to upstream (maintainers).

Ah sorry, I made the mistake, I wanted to add:

Reviewed-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>

Regards,

Charles-Antoine COuret

