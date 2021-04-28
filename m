Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FF2C433B4
	for <linux-iio@archiver.kernel.org>; Wed, 28 Apr 2021 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B886F613C8
	for <linux-iio@archiver.kernel.org>; Wed, 28 Apr 2021 13:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhD1Nz7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:55:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2939 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhD1Nz7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 09:55:59 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVg3f2C0zz72f7l;
        Wed, 28 Apr 2021 21:49:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 15:55:12 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 14:55:11 +0100
Date:   Wed, 28 Apr 2021 14:53:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean Nyekjaer <sean@geanix.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <Nuno.Sa@analog.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] iio: accel: fxls8962af: add hw buffered
 sampling
Message-ID: <20210428145337.00002166@Huawei.com>
In-Reply-To: <d536b4ab-eaa5-5411-9b68-266b7a8a56b6@geanix.com>
References: <20210428082203.3587022-1-sean@geanix.com>
        <20210428082203.3587022-3-sean@geanix.com>
        <d536b4ab-eaa5-5411-9b68-266b7a8a56b6@geanix.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.69]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 13:05:38 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 28/04/2021 10.22, Sean Nyekjaer wrote:
> > |@@ -433,7 +450,10 @@ static int fxls8962af_read_raw(struct iio_dev 
> > *indio_dev, ret = fxls8962af_get_temp(data, val); break; case 
> > IIO_ACCEL: - ret = fxls8962af_get_axis(data, chan, val); + if 
> > (iio_buffer_enabled(indio_dev))|  
> |Seeing the iio_device_claim_direct_mode() is doing exactly the same 
> check :)|

And in a race free fashion ;)

> > |+ ret = -EBUSY; + else + ret = fxls8962af_get_axis(data, chan, val); 
> > break; default: ret = -EINVAL;|  
> 

