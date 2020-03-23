Return-Path: <SRS0=Yeyp=5I=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B54DC4332B
	for <linux-iio@archiver.kernel.org>; Mon, 23 Mar 2020 09:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182332074D
	for <linux-iio@archiver.kernel.org>; Mon, 23 Mar 2020 09:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCWJih (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:38:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727695AbgCWJih (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 05:38:37 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F38485246AC68F9E5766;
        Mon, 23 Mar 2020 09:38:35 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Mar 2020 09:38:35 +0000
Received: from localhost (10.47.90.106) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 09:38:35 +0000
Date:   Mon, 23 Mar 2020 09:38:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/5] iio: pressure: bmp280: Use IIO_DEVICE_ATTR_RO
 macro
Message-ID: <20200323093830.00000bdc@Huawei.com>
In-Reply-To: <CAHp75VdzZeSDtw7ZZ_XwqEEcmYH7t1ifvOAwGNr0T5=BQsud7g@mail.gmail.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
        <20200317101813.30829-2-andriy.shevchenko@linux.intel.com>
        <20200322171617.5b176335@archlinux>
        <CAHp75VdzZeSDtw7ZZ_XwqEEcmYH7t1ifvOAwGNr0T5=BQsud7g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.106]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 23:17:07 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Mar 22, 2020 at 7:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 17 Mar 2020 12:18:10 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >  
> > > Use the IIO_DEVICE_ATTR_RO macro to create the device attributes.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> >
> > Hmm. Minor gain but fair enough I guess.
> >
> > Could consider using the core support _available attributes instead.
> >
> > I'm not usually fussy about moving drivers over to that unless we have
> > an in kernel consumer, but if you are going to touch the code it
> > might be nice to move to them :)  
> 
> Any good driver as an example? Or even conversion change done for one?
> 


Grep read_avail and you will find a few.  drivers/iio/light/tsl2772.c looks
superficially similar to what would be needed here.

Jonathan

