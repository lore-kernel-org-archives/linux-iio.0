Return-Path: <SRS0=+dIK=66=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60194C433E1
	for <linux-iio@archiver.kernel.org>; Sat, 16 May 2020 06:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A90B20709
	for <linux-iio@archiver.kernel.org>; Sat, 16 May 2020 06:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="Xr0KtTrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgEPG2n (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 May 2020 02:28:43 -0400
Received: from www381.your-server.de ([78.46.137.84]:45214 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgEPG2n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 May 2020 02:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=40qmOq9WfLYWjzCfPZdBtFOjcgCKkFGhA5kfOtl5WzQ=; b=Xr0KtTrKfGhKnuItazqelolnhZ
        MFFE497pTku5X8nZ2FZldeQ+g7Ov6lDouHiktY5K+Eso8WKBhVfmyWX9MQuX36SjcmU7qZ6uV5I1p
        9cRvpGp8heoz++zED1tEZ7XPWZc6YrZY/G2KkPiCNI7VMqFWdIsg8qNYyvpLVh8nrdrLpjlT9Oo79
        dL/j6thLZI3sN03L+yPlo5VqMrjrhGnoFQR/zvLA1eB92lXyhZ3kL75mKT5qUgm+SXL2Zuu4Xnz66
        1g+CV10+VV0kJOFqdm+v9tLuys2yAYMImLlmXZ6AH8GLcPheBvnEK5OlNV7AkWcDrXX7mZkzr9kq8
        SCjzhODA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jZqJI-0000CB-Oo; Sat, 16 May 2020 08:28:36 +0200
Received: from [82.135.78.16] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jZqJI-0008w6-Ey; Sat, 16 May 2020 08:28:36 +0200
Subject: Re: [PATCH 0/2] iio: adc: Add a current from voltage driver
To:     Jonathan Bakker <xc-racer2@live.ca>, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linus.walleij@linaro.org
References: <BN6PR04MB066014AF936EF8ADCBF011A1A3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d5f785bf-15f5-9ca5-f7f8-863c74447010@metafoo.de>
Date:   Sat, 16 May 2020 08:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BN6PR04MB066014AF936EF8ADCBF011A1A3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25813/Fri May 15 14:16:29 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/16/20 4:26 AM, Jonathan Bakker wrote:
> In the discussion around adding the GP2A002 light driver, there came
> up the question of what to do when a system emulates a current ADC
> by using a voltage ADC and a resistor.  Rather than adding it on
> a per-driver basis, it was suggested(1) to add a minimal IIO driver
> to support this situation.
>
> The new driver is fairly simple - it simply takes a voltage ADC and
> a resistor value in ohms exposed as the scale and outputs a current.
>
> It has been tested on a first-gen Galaxy S device which has the above
> mentioned GP2A002 chip connected to the voltage ADC resistor complex.
>
> 1) https://lore.kernel.org/linux-iio/20200202150843.762c6897@archlinux/

Hi,

There is afe/iio-rescale.c, which I think already implements this 
functionality.

- Lars


