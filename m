Return-Path: <linux@roeck-us.net>
Date: Wed, 28 Oct 2015 05:15:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
Cc: Michal Marek <mmarek@suse.cz>,
	William Markezana <william.markezana@meas-spec.com>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Cameron <jic23@kernel.org>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: Duplicate htu21 drivers
Message-ID: <20151028121558.GB10739@roeck-us.net>
References: <56309D5C.30008@suse.cz>
 <20151028105128.770BF1E93@relay1.suse.de>
 <5630AE44.3040803@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 28, 2015 at 12:53:12PM +0100, ludovic.tancerel@maplehightech.com wrote:
> I was not sure about the timing for the plan … :)
> Now that the patch has been approved for IIO, then indeed I can remove the patch for htu21 in hwmon.

Yes, the driver in hwmon needs to be removed. Patch welcome.

Guenter

> Thanks,
> Ludovic
> 
> 
> 
> > Le 28 oct. 2015 à 12:15, Michal Marek <mmarek@suse.cz> a écrit :
> > 
> > Dne 28.10.2015 v 11:52 ludovic.tancerel@maplehightech.com napsal(a):
> >> Hello Michal,
> >> 
> >> the plan discussed with Jonathan and Guenter was to remove the driver
> >> in hwmon once the iio one was introduced.
> >> 
> >> Should I  provide a patch in Kconfig to make them conflict as of now
> >> ?
> > 
> > Then you can either execute your plan :), or make the hwmon driver
> > depend on HTU21=n.
> > 
> > Michal
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
