Return-Path: <SRS0=C9z+=7X=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Tue, 22 Aug 2017 00:05:46 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/7] iio: accel: kxcjk1003: support Kionix KXTF9
Message-ID: <20170821220546.nesuah4lhsaoiruk@qmqm.qmqm.pl>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 22, 2017 at 12:03:29AM +0200, Micha³ Miros³aw wrote:
> This series adds support for KXTF9 accelerometer. It is mostly compatible
> to KXCJK, but replaces motion direction interrupt with tap detection
> (not supported in this implementation, yet).
> 
> First 5 patches are refactorings with no outside-visible effects.
> Patch 6 fixes sysfs attribute name of sampling_frequency_avail
> to match sampling_frequency attribute it describes.
> Patch 7 finally adds support for KXTF9 accelerometers.

I forgot to add changelog. Here it is:

v2:
	- removed register renaming
	- split report_motion_event() patch
