Return-Path: <SRS0=1Shn=BL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1479C433DF
	for <linux-iio@archiver.kernel.org>; Sat,  1 Aug 2020 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD67207FB
	for <linux-iio@archiver.kernel.org>; Sat,  1 Aug 2020 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596296817;
	bh=A5VWbbmysSHlK5gjb2gpMbSoQBobsj/TeC5mu5V2CV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CsTkyHRywET7rXOItO3S5XjqHMBI7N6euxdDQknn//289eWOwJfIpyusZgV8leWss
	 hUAifTYsjiCOxhXPxWQEO1hEy1hbJV93oqNculKLwK7towNAL4/y4i68mHHSWgCaIk
	 9yUe835HYTRiRpKWAXPtIBPgijnZOo/cv3xw7jJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgHAPq5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 Aug 2020 11:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgHAPq5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 11:46:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED8E2071E;
        Sat,  1 Aug 2020 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596296816;
        bh=A5VWbbmysSHlK5gjb2gpMbSoQBobsj/TeC5mu5V2CV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vhubruG0dBh7EUpNwSsUPWjrOyWrU8X0vEJu8C19qumDIY2rLzYEu5KozimZpnImJ
         m+tJ/83RNYDG9U5PQDn5B+Mcqwc4f1z6xf0c1FQCv8cM4jkOsvVWEShEfOodSUr/QD
         Hh26l8LcvoSjq8HJa4cEfRjNsFfUo16zWZN9gdls=
Date:   Sat, 1 Aug 2020 16:46:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: cros_ec: Set Gyroscope default frequency to
 25Hz
Message-ID: <20200801164651.6858015b@archlinux>
In-Reply-To: <e98794b4-3f70-ce27-dd64-6bfaff433b8d@collabora.com>
References: <20200728204825.3312921-1-gwendal@chromium.org>
        <e98794b4-3f70-ce27-dd64-6bfaff433b8d@collabora.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 13:17:53 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Gwendal,
> 
> Thank you for your patch.
> 
> On 28/7/20 22:48, Gwendal Grignou wrote:
> > BMI160 Minimium gyroscope frequency in normal mode is 25Hz.
> > When older EC firmware do not report their sensors frequencies,
> > use 25Hz as the minimum for gyroscope to be sure it works on BMI160.
> > 
> > Fixes: ae7b02ad2f32d ("iio: common: cros_ec_sensors: Expose cros_ec_sensors
> > frequency range via iio sysfs")
> >   
> 
> I think your email broke this line, it should be a single line. Other than that ...
> 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> 
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> > ---
> > Change since v1: Fix spelling.
> > 
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 156848d27c473..213837c2ecee2 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -85,10 +85,13 @@ static void get_default_min_max_freq(enum motionsensor_type type,
> >  
> >  	switch (type) {
> >  	case MOTIONSENSE_TYPE_ACCEL:
> > -	case MOTIONSENSE_TYPE_GYRO:
> >  		*min_freq = 12500;
> >  		*max_freq = 100000;
> >  		break;
> > +	case MOTIONSENSE_TYPE_GYRO:
> > +		*min_freq = 25000;
> > +		*max_freq = 100000;
> > +		break;
> >  	case MOTIONSENSE_TYPE_MAG:
> >  		*min_freq = 5000;
> >  		*max_freq = 25000;
> >   

