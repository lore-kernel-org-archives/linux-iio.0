Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:45828 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab1GYPvt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 11:51:49 -0400
Date: Mon, 25 Jul 2011 11:51:25 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: (iio) restore macro IIO_ATTR_2
Message-ID: <20110725115125.199f8f11@v0nbox>
In-Reply-To: <4E2D53E1.90305@cam.ac.uk>
References: <1311373619-19188-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<4E2D53E1.90305@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Jul 2011 12:30:41 +0100,
Jonathan Cameron <jic23@cam.ac.uk> wrote:

> On 07/22/11 23:26, Vivien Didelot wrote:
> > For some reason, IIO_ATTR_2 has been deleted by commit
> > 99e5dc45b854b4b661044e807905152911ed3fdb but it is still used by
> > the macro IIO_DEVICE_ATTR_2. This patch restores it.
> > Please ignore it if it shouldn't exist anymore. If so, this would
> > need to remove IIO_DEVICE_ATTR_2 as well. Obviously it seems to be
> > useful as the struct iio_dev_attr has a val2 member.
> Good spot.  Do you have a user for the two parameter version?  If not
> I'd prefer to just scrap the IIO_DEVICE_ATTR_2 until we actually need
> it. That also means we can scrap val2 from struct iio_dev_attr which
> is a nice little clean up.  How about the following?

I'm actually using the second member, as I'm trying to move the TS-5500
ADC driver from HWMON to IIO (you can see the HWMON patch here:
https://lkml.org/lkml/diff/2011/7/19/223/1). It is used in the
ts5500_adc_show_range() function (nr is the equivalent of val2).

But I've found the ad7291.c driver which is 8 channels as well. 
It might offer a solution that avoids using this second parameter. Is
it a good driver to refer to in this case?

Regards,
Vivien.
