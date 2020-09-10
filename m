Return-Path: <SRS0=b3IJ=CT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C648DC433E2
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A68C20BED
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgIJRsn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:48:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727807AbgIJRsH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:48:07 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6A65C7EC37958B00689B;
        Thu, 10 Sep 2020 18:47:55 +0100 (IST)
Received: from localhost (10.52.121.43) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 10 Sep
 2020 18:47:55 +0100
Date:   Thu, 10 Sep 2020 18:46:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nishant Malpani <nish.malpani25@gmail.com>
CC:     <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 0/3] iio: gyro: adxrs290: Add triggered buffer &
 debugfs support
Message-ID: <20200910184618.00001b86@Huawei.com>
In-Reply-To: <20200910123000.16860-1-nish.malpani25@gmail.com>
References: <20200910123000.16860-1-nish.malpani25@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.43]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 17:59:57 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Introduce DATA_RDY trigger for triggered buffer setup; this enables continuous
> data capture. Additionally, add support for direct register access using the debugfs 
> iio interface. 
> 
> The device-tree bindings documentation illustrates an example of using a GPIO irq
> line to trigger a data capture.
> 
> Nishant Malpani (3):
>   iio: gyro: adxrs290: Add triggered buffer support
>   dt-bindings: iio: gyro: adxrs290: Add interrupts support
>   iio: gyro: adxrs290: Add debugfs register access support
> 
>  .../bindings/iio/gyroscope/adi,adxrs290.yaml  |   6 +
>  drivers/iio/gyro/Kconfig                      |   2 +
>  drivers/iio/gyro/adxrs290.c                   | 237 ++++++++++++++++--
>  3 files changed, 231 insertions(+), 14 deletions(-)
> 

Hi Nishant,

Something odd went on with this version.  It's not come across threaded
and patch 1 is missing.  Please resend.

Thanks,

Jonathan

