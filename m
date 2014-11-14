Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:58724 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbaKNJBc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Nov 2014 04:01:32 -0500
Received: by mail-vc0-f173.google.com with SMTP id id10so4239885vcb.18
        for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2014 01:01:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <545E0980.2080201@kernel.org>
References: <CAMHSBOWmmCdd=5HXJN-vz9saaPrq3n0p-LjCNvnX3Q3ZieZdRQ@mail.gmail.com>
 <1415225452-21957-1-git-send-email-gwendal@chromium.org> <1415225452-21957-4-git-send-email-gwendal@chromium.org>
 <1415286329.7340.16.camel@spandruv-hsb-test> <545E0980.2080201@kernel.org>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Fri, 14 Nov 2014 01:01:10 -0800
Message-ID: <CAMHSBOX6FeYQANYcmoSWqrX6KGTy6muGdY8+UY4_7acDe3ENHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: ak8975: add ak09911 and ak09912 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Gwendal Grignou <gwendal@chromium.org>, knaack.h@gmx.de,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 8, 2014 at 4:16 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On 06/11/14 15:05, Srinivas Pandruvada wrote:
> > On Wed, 2014-11-05 at 14:10 -0800, Gwendal Grignou wrote:
> >> Add 2 new definition entries to support ak0991x compass.
> >> Add a more advanced function to check we are dealy with the
> >> expected device.
> > This commit message doesn't state that you are removing ak09911 driver.
> > Although you added in cover letter, but that will not be present in the
> > history.
> >
> >>
> >> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >> ---
> >>  drivers/iio/magnetometer/Kconfig   |  17 +-
> >>  drivers/iio/magnetometer/Makefile  |   1 -
> >>  drivers/iio/magnetometer/ak09911.c | 326 -------------------------------------
> >>  drivers/iio/magnetometer/ak8975.c  | 197 ++++++++++++++++++++--
> >>  4 files changed, 184 insertions(+), 357 deletions(-)
> >>  delete mode 100644 drivers/iio/magnetometer/ak09911.c
> >>
> >> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> >> index b2dba9e..cd8750b 100644
> >> --- a/drivers/iio/magnetometer/Kconfig
> >> +++ b/drivers/iio/magnetometer/Kconfig
> >> @@ -6,27 +6,16 @@
> >>  menu "Magnetometer sensors"
> >>
> >>  config AK8975
> >> -    tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
> >> +    tristate "Asahi Kasei AK 3-Axis Magnetometer"
> >>      depends on I2C
> >>      depends on GPIOLIB
> >>      help
> >> -      Say yes here to build support for Asahi Kasei AK8975 3-Axis
> >> -      Magnetometer. This driver can also support AK8963, if i2c
> >> -      device name is identified as ak8963.
> >> +      Say yes here to build support for Asahi Kasei AK8975, AK8963,
> >> +      AK09911 or AK09912 3-Axis Magnetometer.
> >>
> >>        To compile this driver as a module, choose M here: the module
> >>        will be called ak8975.
> >>
> >> -config AK09911
> > Instead
> > config AK09911
> >       select AK8975
> >
> > I stated my reason below.
> Agreed.  This will reduce breakage and is common when merging drivers.
>
> >> -    tristate "Asahi Kasei AK09911 3-axis Compass"
> >> -    depends on I2C
> >> -    help
> >> -      Say yes here to build support for Asahi Kasei AK09911 3-Axis
> >> -      Magnetometer.
> >> -
> >> -      To compile this driver as a module, choose M here: the module
> >> -      will be called ak09911.
> >> -
>
> >
> > I need to test this driver.
> > Jonathan,
> > If possible, wait for Tested by tag from me or someone else.
> Will do.
Srinivas,

Did you have a chance to test these CLs? Let me know if you find any problem.
On my side, the changes work fine with an ak09912.
Thanks,

Gwendal.
> >
> > Thanks,
> > Srinivas
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
