Return-Path: <SRS0=/qDq=C4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F131C43463
	for <linux-iio@archiver.kernel.org>; Sat, 19 Sep 2020 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBD921707
	for <linux-iio@archiver.kernel.org>; Sat, 19 Sep 2020 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600517589;
	bh=FdjoHzBqdxfA3CxLo3N6Wg3cZlWs5fLQmVZq3zJiU80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jUkYGRGdIaAA6Qr0qZkrD+xJPqc1HJl9F71gi0lgxqJdZtopnknQH2mQYTK7Rk6dp
	 09QtWQ1U8tRYfElLFfpyYZyGFG3LoR9HQjb4XFOoQqIqW2j6yy+qAS7iK9hxBNKRtl
	 AQWoF1uvCwegiU8cQFY+NUH0PxzXM1gDbqf1oSRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISMNI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Sep 2020 08:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgISMNI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 08:13:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E994B2100A;
        Sat, 19 Sep 2020 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600517588;
        bh=FdjoHzBqdxfA3CxLo3N6Wg3cZlWs5fLQmVZq3zJiU80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EWh1ldn+WsoBN+8yRMJN0egouYZ6EISrWnuLpQLBglW77GaoNRgHa/KBpJJBw3m0W
         0WIbG9CXuILWYyzPXyTDap+Rdw1muUXquPWLxhIHcSedbc7yja6Ej1PQM2HAHiPUfo
         Ps/9BzLGWQg9rDp1pM4r/LdTcUaStBQpc/wuNw9o=
Date:   Sat, 19 Sep 2020 13:13:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH] iio:accel:bma180: Fix use of true when should be
 iio_shared_by enum
Message-ID: <20200919131303.3475c7db@archlinux>
In-Reply-To: <9a5b9bf3-28e9-9643-0924-a7b33e339032@metafoo.de>
References: <20200913121227.764626-1-jic23@kernel.org>
        <9a5b9bf3-28e9-9643-0924-a7b33e339032@metafoo.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 15:36:58 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 9/13/20 2:12 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Given a value of 1 corresponds to IIO_SHARE_BY_TYPE I have replaced
> > it with that.  Should cause no functional change.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: Jonathan Bakker <xc-racer2@live.ca>  
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks. Applied to the togreg branch of iio.git.
I haven't marked it for stable because it has not material affect.
Not a problem if it gets picked up anyway of course!

Thanks,

Jonathan

> 
> 
> > ---
> >   drivers/iio/accel/bma180.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index 448faed001fd..6b74c2b04c15 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -673,7 +673,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
> >   };
> >   
> >   static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
> > -	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
> > +	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
> >   	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
> >   	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
> >   	{ }  
> 
> 

