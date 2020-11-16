Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2,WEIRD_QUOTING autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DF1C4742C
	for <linux-iio@archiver.kernel.org>; Mon, 16 Nov 2020 10:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16B820B80
	for <linux-iio@archiver.kernel.org>; Mon, 16 Nov 2020 10:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKPJpA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Nov 2020 04:45:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2106 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgKPJpA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Nov 2020 04:45:00 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CZPJv2jftz67Drl;
        Mon, 16 Nov 2020 17:43:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 10:44:58 +0100
Received: from localhost (10.52.125.36) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 16 Nov
 2020 09:44:55 +0000
Date:   Mon, 16 Nov 2020 09:44:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 3/9] ARM: dts: Cygnus: Drop incorrect io-channel-ranges
 property.
Message-ID: <20201116094448.00004116@Huawei.com>
In-Reply-To: <dc1680ac-28b9-872b-6ded-7c1a9bd88fdc@gmail.com>
References: <20201115192951.1073632-1-jic23@kernel.org>
        <20201115192951.1073632-4-jic23@kernel.org>
        <dc1680ac-28b9-872b-6ded-7c1a9bd88fdc@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.36]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Nov 2020 19:23:21 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 11/15/2020 11:29 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This property applies to consumers of io-channels.  In this case we
> > have a provider so the property is not used.
> > 
> > Not dt_schema will now detect this as an error due to a dependency
> > between this property and the io-channels property.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>  
> 
> Applied to devicetree/next, with the second paragraph fixed to:
> 
> """
> Recent changes to dt-schema result int his being reported as an error
> as a dependency is enforced between this property and io-channels.
> """"
> 
> since it did not look like a correct sentence making sense otherwise.
Oops. I shouldn't write patch descriptions on a Sunday evening.  Indeed
it was garbage.

> 
> PS: please make sure you run get_maintainer.pl, this patch did not land
> in our patchwork instance since bcm-kernel-feedback-list@broadcom.com
> was not copied.

Sorry, these cross tree patch series are a bit of a pain to deal with
but I should have picked up on that one.

Jonathan

> 
> Thanks you

