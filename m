Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB5C2BBCA
	for <linux-iio@archiver.kernel.org>; Wed, 16 Dec 2020 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542942389F
	for <linux-iio@archiver.kernel.org>; Wed, 16 Dec 2020 08:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgLPIXP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:23:15 -0500
Received: from www381.your-server.de ([78.46.137.84]:44998 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgLPIXP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 03:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=icK32a3qnSPQjO/4JYLfi0Vv/PxB4NJrdnrp7/a86go=; b=Wy/fUlkT5uzAK6KhNzHil4vei/
        V2m2GIzvXh6Go2ZQfyXO/+eeRXR5opU+6OsXs/GotUaSpEYfZh6nLfuFfNUqpwB/swqB1mO5+qRL8
        GiHEt2wzjADScyqMtVaBeN1c5iGStLYcUePsd2w3YKV3YPgHZ3vA6B/4V1LTGHjmk6v27fJIhgL8w
        s5EUshGpjNhJ2YSyGBmErzcFlWjsTiBxSVBZgN6BjxTCfvjjO/6gEIJKXkG555winODT5XNoK4Sz7
        fpMpw+G0AlwT+XlffdUDkFfTu4zQ0Tt7eonmvWfrHuqhliA31Y/jMxskI33Lgm3MS21Pp3HkT/+CZ
        wuq71ekQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kpS4r-0002DI-0H; Wed, 16 Dec 2020 09:22:29 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kpS4q-000ME0-RD; Wed, 16 Dec 2020 09:22:28 +0100
Subject: Re: [PATCH V2] iio: adc: ad7476: Add LTC2314-14 support
To:     Mircea Caprioru <mircea.caprioru@analog.com>, jic23@kernel.org
Cc:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>
References: <20201216082304.89187-1-mircea.caprioru@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <40b2ec69-c376-c0a2-5940-585c742822e3@metafoo.de>
Date:   Wed, 16 Dec 2020 09:22:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201216082304.89187-1-mircea.caprioru@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26018/Tue Dec 15 15:37:09 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/16/20 9:23 AM, Mircea Caprioru wrote:
> [...]
> Changelog v2
> - fix conflict with ADS7868 device in chip_info_tbl
> [...]
>   	[ID_ADS7868] = {
>   		.channel[0] = ADS786X_CHAN(8),
>   		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),

Hi Mircea,

I think this is still missing a } here


> +	[ID_LTC2314_14] = {
> +		.channel[0] = AD7940_CHAN(14),
> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>   	},
>   };

