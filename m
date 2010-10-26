Return-Path: <groeck@ericsson.com>
Date: Mon, 25 Oct 2010 20:52:06 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Mike Frysinger <vapier@gentoo.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <20101026035206.GA20995@ericsson.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk>
 <DB904C5425BA6F4E8424B3B51A1414D16578B22370@NWD2CMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16578B22370@NWD2CMBX1.ad.analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 25, 2010 at 11:27:42PM -0400, Zhang, Sonic wrote:
> 
> 
> >-----Original Message-----
> >From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> >Sent: Monday, October 25, 2010 6:54 AM
> >To: Mike Frysinger
> >Cc: linux-iio@vger.kernel.org;
> >device-drivers-devel@blackfin.uclinux.org; Zhang, Sonic; Guenter Roeck
> >Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for
> >ADT7408 temperature sensors
> >
> >On 10/23/10 21:29, Mike Frysinger wrote:
> >> From: Sonic Zhang <sonic.zhang@analog.com>
> >Here we enter new territory. This device is already supported
> >in hwmon.  Do we have a usecase that is not covered by that driver?
> >
> 
> I don't find a way to get event notification other than poll in hwmon framework. So, I move all temperature devic with interrupt available to IIO framework.
> 
A much better approach, if such notifications are required and make sense,
would be to add it to the hwmon framework. Rewriting drivers just to get 
notifications is not a solution.

Besides, did you consider using kobject_uevent() ? The generic gpio driver
uses that mechanism to create udev notifications on alarms.

Guenter
