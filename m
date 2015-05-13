Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V4 0/7] iio: mma8452 enhancements
To: Peter Meerwald <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
Date: Wed, 13 May 2015 12:26:35 +0200
Message-ID: <20150513102635.27803.99054.stgit@localhost>
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

V4 changes:
	* rebased to 4.1
	* dropped already applied doc patch
	* dropped self test patch (for now)
	* Use usleep_range()
	* remove unused defines
	* add threshold mask define instead of hardcoded 0x7f
	* use direct return in mma8452_reg_access_dbg
	* update kernel version in ABI doc for high pass filter
	* fixed incorrect /** comments
	* added some newlines
	* checkpatch --strict code alignment
