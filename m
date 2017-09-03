Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45150 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbdICLhm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2017 07:37:42 -0400
Date: Sun, 3 Sep 2017 12:37:34 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        lars@metafoo.de, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging: iio: tsl2x7x: constify i2c_device_id
Message-ID: <20170903123734.232932e7@archlinux>
In-Reply-To: <b84769c2-5fce-46ec-f272-408bd6bfe394@gmail.com>
References: <1503333831-26300-1-git-send-email-arvind.yadav.cs@gmail.com>
        <20170821193109.kf45g2ndv3nngewp@mwanda>
        <b84769c2-5fce-46ec-f272-408bd6bfe394@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Aug 2017 10:51:37 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> Hi
> 
> 
> On Tuesday 22 August 2017 01:50 AM, Dan Carpenter wrote:
> > Don't say "[PATCH 4/4]".  It's not a patchset or a part of an email
> > thread.  
> Yes, It's part of these patchset.
>    [PATCH 1/4] misc: apds9802als: constify i2c_device_id
>    [PATCH 2/4] misc: hmc6352: constify i2c_device_id
>    [PATCH 3/4] misc: isl29020: constify i2c_device_id
>    [PATCH 4/4] staging: iio: tsl2x7x: constify i2c_device_id
For a series like this that is jumping around the kernel
it would have been better to have broken it up on a subsystem
basis.  It is always confusing when people only see a small
part of a bigger series and need to go looking to find out
if they have missed something in the other patches.

Anyhow, applied to the togreg branch of iio.git which will
be pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> >
> > regards,
> > dan carpenter
> >  
> ~arvind
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

