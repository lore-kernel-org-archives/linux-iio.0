Return-Path: <SRS0=ZZPN=QB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C033C282C0
	for <linux-iio@archiver.kernel.org>; Fri, 25 Jan 2019 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E16218A2
	for <linux-iio@archiver.kernel.org>; Fri, 25 Jan 2019 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfAYKDB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:03:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfAYKDB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Jan 2019 05:03:01 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 761B857D5D5F977E172B;
        Fri, 25 Jan 2019 18:02:59 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 18:02:57 +0800
Date:   Fri, 25 Jan 2019 10:02:47 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Phil Reid <preid@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        <alexandru.ardelean@analog.com>
Subject: Re: iio scale precision
Message-ID: <20190125100247.000070ca@huawei.com>
In-Reply-To: <CA+U=DsqtHkZYMVuWKJGYMOsQ3m4N5Cf2B9pj18JZPSvW_aNbzg@mail.gmail.com>
References: <ec351562-c263-6550-4c6e-7ba2c605e5c0@electromag.com.au>
        <CA+U=DsqtHkZYMVuWKJGYMOsQ3m4N5Cf2B9pj18JZPSvW_aNbzg@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Jan 2019 10:36:19 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Wed, Jan 23, 2019 at 11:17 AM Phil Reid <preid@electromag.com.au> wrote:
> >
> > What's the best way to handle scale values for very high precision ADC's.
> >
> > eg a 24 or even a 32 bit dac with a 2.5v full scale range.
> >
> > Even using the nV conversion param it looses a fair bit of precision.
> >
> > Would a option to return a rational number would be better?  
> 
> Are you saying something like float/double C types ?
> Typically those are not allowed in kernel.
> 
> Scale values are typically/mostly for informational purposes.
> i.e. the driver computes the scales [and the current selected scales]
> for the measured values, so that the userspace parts [usually libiio]
> can compute actual values
> 
> So, you could compute & display scales almost any way you want it,
> even just displaying a string representation of the scale value.
> It is good to follow some conventions though.
> 
> You could take a look at various formats for the scales.
> Something like IIO_VAL_INT_PLUS_NANO or IIO_VAL_FRACTIONAL or
> IIO_VAL_FRACTIONAL_LOG2 [see __iio_format_value  in
> drivers/iio/industrialio-core.c to get some idea ] .
> Depends what you really need.

If we are dealing with a 32bit device we may just need to add a pico version
which will generate a pile of leading zeros.  Even smaller types are fine
as well if needed.

As Alex says, it's just formatted to a string (mostly). The exception is
if we have in kernel users in which case it'll be up to the consumer
to figure out how to apply the scale.  We provide some utility functions
but I doubt these high precision ADCs are going to get used by another driver
in kernel.

J
> 
> I guess to give a better answer here [I deferred giving one hoping
> someone more informed would jump-in], we would also need a more
> concrete example.
> 
> Thanks
> Alex
> 
> >
> > Or am I doing something wrong.
> >
> > --
> > Regards
> > Phil  


