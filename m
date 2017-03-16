Return-Path: <SRS0=K8Jb=2Z=hadess.net=hadess@kernel.org>
Message-ID: <1489665702.18490.12.camel@hadess.net>
Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor
 support
From: Bastien Nocera <hadess@hadess.net>
To: Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com
Date: Thu, 16 Mar 2017 13:01:42 +0100
In-Reply-To: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2017-03-16 at 18:20 +0800, Song Hongyan wrote:
> As accelerometer sensor becomes more and more popular, there are more
> user scenarios have been developed, "Hinge" is a very important
> usecase
> which needs two accelerometer sensors to calculate the included angle
> of keyboard and screen.
> In this case, two accelerometer sensors will be exposed. Currently,
> IIO interface hasn't other way to distinguish two sensors with same
> sensor type, except sensor name. So a new sensor name "accel_2nd_3d"
> is added for secondary accelerometer sensor.
> 
> In HID level, connection type is a good common property to
> differentiate two sensors with same sensor type.

I've been told in the past not to rely on device names in iio-sensor-
proxy, and this would go against this advice.

As you have a "type" to export, why not export that instead?
