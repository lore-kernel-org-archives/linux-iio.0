Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D07C48BE8
	for <linux-iio@archiver.kernel.org>; Wed, 16 Jun 2021 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CF0611BE
	for <linux-iio@archiver.kernel.org>; Wed, 16 Jun 2021 14:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhFPOKm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:10:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3251 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhFPOKm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jun 2021 10:10:42 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G4msp663Fz6JBQF;
        Wed, 16 Jun 2021 21:55:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 16:08:34 +0200
Received: from localhost (10.52.123.249) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 15:08:33 +0100
Date:   Wed, 16 Jun 2021 15:08:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK\" <linux-kselftest@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org"@domain.invalid
Subject: Re: [PATCH v2 05/10] iio: Remove a cast in iio-test-format which is
 no longer required
Message-ID: <20210616150826.00001cd7@Huawei.com>
In-Reply-To: <CAFd5g44Eboz-=6LFQJ93sPVt53GQ60MGBUPyacKUj=0cFTJr0A@mail.gmail.com>
References: <20210513193204.816681-1-davidgow@google.com>
        <20210513193204.816681-5-davidgow@google.com>
        <CAFd5g44Eboz-=6LFQJ93sPVt53GQ60MGBUPyacKUj=0cFTJr0A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.249]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Jun 2021 13:14:44 -0700
Brendan Higgins <brendanhiggins@google.com> wrote:

> On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
> >
> > KUnit's EXPECT macros no longer typecheck as stringently, so casting the
> > result of strcmp() is now unnecessary.
> >
> > Signed-off-by: David Gow <davidgow@google.com>  
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Seems sensible

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
