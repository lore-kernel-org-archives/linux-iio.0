Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/2] staging:iio: add name_extend to allow for named channels
Date: Thu, 28 Apr 2011 15:24:21 +0100
Message-Id: <1304000663-5176-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is needed for the light sensors where we indicate what a given sensor
is measuring. It also came up in Michael's questions in the the thread
Oddities and how to handle them.  Also for that matter allows us to put
back the in0_supply_raw convention that got squashed in moving to
iio_chan_spec registration.

What do people think?

(this is rather rough and ready, but then it is an RFC ;)

Jonathan Cameron (2):
  RFC add naming to channels
  Example of naming usage

 drivers/staging/iio/iio.h               |   26 +++-
 drivers/staging/iio/industrialio-core.c |   34 +++-
 drivers/staging/iio/light/tsl2563.c     |  323 +++++++++++--------------------
 3 files changed, 165 insertions(+), 218 deletions(-)

-- 
1.7.3.4
