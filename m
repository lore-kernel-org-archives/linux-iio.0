Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FDDC433DB
	for <linux-iio@archiver.kernel.org>; Mon,  8 Feb 2021 08:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D77564E7A
	for <linux-iio@archiver.kernel.org>; Mon,  8 Feb 2021 08:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBHICI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 8 Feb 2021 03:02:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2517 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBHIBz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 03:01:55 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DYywj0CQCz67ly9;
        Mon,  8 Feb 2021 15:54:45 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 8 Feb 2021 09:01:13 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:01:11 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 16:01:10 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 05/24] staging:iio:cdc:ad7150: Drop platform data support
Thread-Topic: [PATCH 05/24] staging:iio:cdc:ad7150: Drop platform data support
Thread-Index: AQHW/WjHVQYCYyHtHUelBGcs7eZ3RapN5C8g
Date:   Mon, 8 Feb 2021 08:01:10 +0000
Message-ID: <aa4c713cb40448109f858b301e7a0f04@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
 <20210207154623.433442-6-jic23@kernel.org>
In-Reply-To: <20210207154623.433442-6-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Monday, February 8, 2021 4:46 AM
> To: linux-iio@vger.kernel.org
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> <Michael.Hennerich@analog.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; robh+dt@kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Subject: [PATCH 05/24] staging:iio:cdc:ad7150: Drop platform data support
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There are no mainline board files using this driver so lets drop
> the platform_data support in favour of devicetree and similar.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/staging/iio/cdc/ad7150.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c
> b/drivers/staging/iio/cdc/ad7150.c
> index 0dce1b8ce76d..7ad9105e6b46 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -570,20 +570,6 @@ static int ad7150_probe(struct i2c_client *client,
>  			return ret;
>  	}
> 
> -	if (client->dev.platform_data) {
> -		ret = devm_request_threaded_irq(&client->dev, *(unsigned int *)
> -						client->dev.platform_data,
> -						NULL,
> -						&ad7150_event_handler,
> -						IRQF_TRIGGER_RISING |
> -						IRQF_TRIGGER_FALLING |
> -						IRQF_ONESHOT,
> -						"ad7150_irq2",
> -						indio_dev);
> -		if (ret)
> -			return ret;
> -	}
> -

The original code looks ugly, I forget when ad7150 needs
the second interrupt.

>  	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  	if (ret)
>  		return ret;
> --
> 2.30.0

Thanks
Barry

