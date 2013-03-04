Return-Path: <lars@metafoo.de>
Message-ID: <5134E53E.1090108@metafoo.de>
Date: Mon, 04 Mar 2013 19:17:34 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Voltage scale, milli or micro?
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

So according to our documentation the voltage channel scale is in
microvolts, but for some odd reason almost all drivers report the scale in
millivolts. In the IIO hwmon bridge we also have this comment "Assumes that
IIO and hwmon operate in the same base units. This is supposed to be true,
but needs verification for new channel types." and hwmon also uses
millivolts. So I'm wondering should we fix all our drivers to match the
specification or should we update the specification to match reality.
I would prefer the later.

- Lars
