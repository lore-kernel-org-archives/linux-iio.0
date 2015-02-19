Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V3 0/9] iio: mma8452 enhancements
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Thu, 19 Feb 2015 15:15:54 +0100
Message-ID: <20150219141553.27001.18825.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

This series adds some additional features to the mma8452 accelerometer driver
	* debugfs register access
	* transient threshold events
	* highpass filter
	* interrupt driven sampling (trigger)
	* self test mode

Attributes are added to the core for:
* highpass filter for readings
* both high and lowpass filters for events

In addition a latent bug in the device initialisation is fixed.

V3 changes:
	Use 3db frequency for filter enable / disable (0=disable)
	Support enabling filter for readings in addition to events
	Use IIO_EV_INFO_PERIOD rather than custom attribute
	Use devm_iio_trigger_alloc()
	Add comment to explain irq activation during probe()
	iio_device_register() only after all setup
	Drop iio_push_event() wrapper
	Correct parameters to iio_push_event()
	Document missing attributes
	Add self test mode
