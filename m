Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCEAC7EE29
	for <linux-iio@archiver.kernel.org>; Sun, 28 May 2023 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjE1VWh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 28 May 2023 17:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE1VWh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 May 2023 17:22:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BFFB8;
        Sun, 28 May 2023 14:22:36 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:e49:10dd:40c0:e842] (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B151E66028F5;
        Sun, 28 May 2023 22:22:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685308953;
        bh=1lLaRddepgjlJW8m/FCwzogjASyCbCW3Pl3FgHcbwsk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kWKimZgJE/wgD8bXw+oYGRrist/CQD8pLhPTL34wR5pIowb42+UgENaXifYNLnz5x
         XNOO/B/8TsxzEgVK9pKN4WawB0HKt+P+bGhGJzWCEj+if6nFTzf1YnQJ0dzrY5n7Ak
         JbOVvy+MZFQZii4dKeorqq26GKww80mQijQAlVqsXwsRQHgqVsHP3CbQ13FE1oedH9
         o817Lpoaes2eO+AZNYP3zIbQ4Hpbzjg6uIiD8brnzxOm8wL3EqReBkuPIjlYy+rcGn
         +djyMiHUswW8nN2fxIj5P7zy1xy7xC5FPJdI2gp9dw/frgPDn9bpl9t5Ev1qwvc0uA
         BdPzrn7uoPPig==
Message-ID: <196486e3-a6e4-d330-6193-6eff248bdefb@collabora.com>
Date:   Mon, 29 May 2023 02:52:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/8] iio: adc: rockchip_saradc: Make use of
 devm_clk_get_enabled
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>, jic23@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
 <20230525212712.255406-4-shreeya.patel@collabora.com>
 <a7e0d4f0-a497-8697-e108-5247e11abc41@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <a7e0d4f0-a497-8697-e108-5247e11abc41@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,


On 26/05/23 06:12, Dmitry Osipenko wrote:
> On 5/26/23 00:27, Shreeya Patel wrote:
>> @@ -600,8 +560,6 @@ static int rockchip_saradc_suspend(struct device *dev)
>>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>   	struct rockchip_saradc *info = iio_priv(indio_dev);
>>   
>> -	clk_disable_unprepare(info->clk);
>> -	clk_disable_unprepare(info->pclk);
>>   	regulator_disable(info->vref);
> Why clocks need to be enabled during suspend?

They don't need to be enabled during suspend. Thanks for pointing it 
out, I'll add them again in v3.


Thanks,
Shreeya Patel

