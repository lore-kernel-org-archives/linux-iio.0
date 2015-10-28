Return-Path: <mmarek@suse.cz>
Subject: Re: Duplicate htu21 drivers
To: "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com>
References: <56309D5C.30008@suse.cz> <20151028105128.770BF1E93@relay1.suse.de>
Cc: William Markezana <william.markezana@meas-spec.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>, lm-sensors@lm-sensors.org,
 linux-iio@vger.kernel.org
From: Michal Marek <mmarek@suse.cz>
Message-ID: <5630AE44.3040803@suse.cz>
Date: Wed, 28 Oct 2015 12:15:16 +0100
MIME-Version: 1.0
In-Reply-To: <20151028105128.770BF1E93@relay1.suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Dne 28.10.2015 v 11:52 ludovic.tancerel@maplehightech.com napsal(a):
> Hello Michal,
> 
> the plan discussed with Jonathan and Guenter was to remove the driver
> in hwmon once the iio one was introduced.
> 
> Should I  provide a patch in Kconfig to make them conflict as of now
> ?

Then you can either execute your plan :), or make the hwmon driver
depend on HTU21=n.

Michal
