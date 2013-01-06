Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3] staging:iio:tsl2583 update interfaces
Date: Sun,  6 Jan 2013 16:23:00 +0000
Message-Id: <1357489383-30811-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This driver is now fairly old and has lagged a bit as we have brought
in newer cleaner ways of doing things.  Anyhow, I was looking at
it with a view to moving it out of staging and thought I would clean
up a few bits whilst doing so.  Note I don't have one of these.

There are some 'unusual' interfaces in here still such as integrationtime.
We need to have a think about whether we want to add these to the info
mask and handle them through read/write_raw or not.

I'm also decidely unkeen on the manual power enable / disable that is
still in this driver.  That should ideally be done on demand.

Hence i am not proposing moving this out of staging just yet!

Jonathan

Jonathan Cameron (3):
  staging:iio:light:tsl2583 use read_raw, write_raw hooks.
  staging:iio:light:tsl2583 apply in_ prefix to attributes.
  staging:iio:light:tsl2583 switch to kstrto and strtobool

 drivers/staging/iio/light/tsl2583.c | 247 +++++++++++++++++-------------------
 1 file changed, 119 insertions(+), 128 deletions(-)

-- 
1.8.1
