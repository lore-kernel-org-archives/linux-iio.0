Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V5 0/7] iio: mma8452 enhancements
To: Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-iio@vger.kernel.org
Date: Mon, 01 Jun 2015 15:39:43 +0200
Message-ID: <20150601133943.24925.83080.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

This series adds some additional features to the mma8452 accelerometer driver
	* debugfs register access
	* transient threshold events
	* highpass filter
	* interrupt driven sampling (trigger)

Attributes are added to the core for:
* highpass filter for readings
* both high and lowpass filters for events

In addition a latent bug in the device initialisation is fixed.

V5 changes:
	* Moved event highpass filter event attribute declaration
	 from patch 4 to 6 (to be with the implementation code)
	* Added a validate_device function to prevent use of trigger
	with other devices

The first three patches have already been applied to -next but have
been resent, unchanged, in this series to keep it all together.
