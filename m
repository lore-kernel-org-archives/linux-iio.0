Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 21 Sep 2015 17:06:49 -0500
From: Michael Welling <mwelling@ieee.org>
To: lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: ADS1018 ADC driver
Message-ID: <20150921220648.GA12569@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

I am in the process of starting a new device driver for the ADS1018 ADC.
Before starting I did some research as whether similar drivers exist in the kernel.

It appears that ADC drivers are in both hwmon and iio/adc. The closest drivers to
the device mentioned are in hwmon.

Where is the best place for this new ADC driver?
Shouldn't ADCs all be in the same subsystem?
Has there been any effort to unify or distiguish where drivers should go?
