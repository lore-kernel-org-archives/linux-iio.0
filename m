Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: one more fix
Date: Mon, 24 Oct 2011 10:49:17 +0100
Message-Id: <1319449758-26883-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Drat, missed this one in the last set.

Anyhow, relatively trivial.

Jonathan Cameron (1):
  staging:iio:core shared attrs do not work with modifier.

 drivers/staging/iio/industrialio-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.7
