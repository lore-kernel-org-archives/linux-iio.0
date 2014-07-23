Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH  0/8] iio: mma8452 enhancements
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Wed, 23 Jul 2014 19:17:19 +0200
Message-ID: <20140723171719.22067.79447.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

This series adds some additional features to the mma8452 accelerometer driver
	* debugfs register access
	* transient threshold events
	* highpass filter

The highpass filter attributes are added to the core.

In addition a latent bug in the device initialisation is fixed.
