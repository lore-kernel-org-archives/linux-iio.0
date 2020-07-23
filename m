Return-Path: <SRS0=lxFI=BC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A005BC433E0
	for <linux-iio@archiver.kernel.org>; Thu, 23 Jul 2020 12:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FA820792
	for <linux-iio@archiver.kernel.org>; Thu, 23 Jul 2020 12:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGWM3v (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:29:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2517 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbgGWM3v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Jul 2020 08:29:51 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 76F0A2E340AB2B69148A;
        Thu, 23 Jul 2020 13:29:49 +0100 (IST)
Received: from localhost (10.52.125.229) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Jul
 2020 13:29:49 +0100
Date:   Thu, 23 Jul 2020 13:28:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH v3 18/27] iio:imu:inv_mpu6050: Use regmap_noinc_read for
 fifo reads.
Message-ID: <20200723132828.00000a68@Huawei.com>
In-Reply-To: <CAHp75Vchi4mfAmZB1yeu-ftwvXP71LTAs_aEDEpE1AYWuY5phA@mail.gmail.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-19-jic23@kernel.org>
        <CAHp75Vchi4mfAmZB1yeu-ftwvXP71LTAs_aEDEpE1AYWuY5phA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.229]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 15:15:46 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > We should not be assuming that we are reading a sequence of
> > registers as here we are doing a read of a lot of data from
> > a single register address.  
> 
> > -               result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
> > -                                         st->data, bytes_per_datum);
> > +               result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
> > +                                          st->data, bytes_per_datum);  
> 
> I don't know the difference between these APIs, but AFAIU in this case
> we always ask for a minimum data (like one item of 2 bytes or so) per
> access. Because registers are defined like 16-bit wide we are fine. Is
> that correct?
Yes.   There is only really a different in these two APIs if caching
is enabled in regmap.  Conceptually noinc is repeated reading of the same
register, whilst build_read reads a bunch of registers starting at this
location.   If any of them happen to be cacheable, regmap_bulk_read will
update the cached value for any registers it happens to read.  In this
particular case that would be incorrect because the hardware is not
doing any auto increment of the address during repeated reads, it's just
reading the same register lots of times.

Jonathan




