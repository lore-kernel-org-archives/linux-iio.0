Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:48178 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab3GENKl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 09:10:41 -0400
Received: by mail-bk0-f44.google.com with SMTP id 6so1051187bkj.17
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2013 06:10:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51D6981B.8090001@metafoo.de>
References: <CAPgLHd-v0MJWgtjY66Ky87ieQYxXg_9bFQxB0N5zoibshCV7Jg@mail.gmail.com>
	<20130704160110.GC13897@kroah.com>
	<51D6981B.8090001@metafoo.de>
Date: Fri, 5 Jul 2013 21:10:39 +0800
Message-ID: <CAPgLHd-Wrx7AK7Z2kgJ4nmKmL5Nafc458NH3_UeXUiLSbVxoSQ@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:ad7291: add missing .driver_module to struct iio_info
From: Wei Yongjun <weiyj.lk@gmail.com>
To: lars@metafoo.de
Cc: gregkh@linuxfoundation.org, jic23@cam.ac.uk, wfp5p@virginia.edu,
	yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/2013 05:55 PM, Lars-Peter Clausen wrote:
> On 07/04/2013 06:01 PM, Greg KH wrote:
>> On Thu, Jul 04, 2013 at 09:46:34PM +0800, Wei Yongjun wrote:
>> That's a hint that the register function should be changed so that no module ever has to set this value. Look at how PCI and USB do their driver registration function for how to do this properly. 
> I don't think that the same approach as used for PCI, USB and others works
> as nicely here. For one we do not have a registration function for the info
> struct, it would probably be possible to rework things a bit, but not
> without some code churn. And secondly we'd also have to make all the
> iio_info structs non-const, which is something I don't like. And thirdly we
> do have the proper tools to auto-detect such missing initializations (e.g.
> using coccinelle), so we can catch these errors early on and they won't show
> up in new drivers.

Agree, with the follow coccinelle script, we can found this easily.

@r__iio_info@
identifier nm;
position p;
@@
struct iio_info nm@p = {
...,
  .driver_module = THIS_MODULE,
...
};

@@
identifier nm;
position p != {r__iio_info.p};
@@
struct iio_info nm@p = {
...,
+ .driver_module = THIS_MODULE,
};





