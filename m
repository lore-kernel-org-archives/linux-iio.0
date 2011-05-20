Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/2] IIO more resolver cleanups.
Date: Fri, 20 May 2011 11:58:30 +0100
Message-Id: <1305889112-28814-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305884517-11168-1-git-send-email-jic23@cam.ac.uk>
References: <1305884517-11168-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

What can I say, this morning has turned out to be rather dull as well
and these other two drivers are small so here is a cleanup series for them.

Note in the ad2s1210 driver I forgot to clear the IN / OUT of resolution bit
out of the Kconfig file. I'm also not entirely sure I understand how that
is supposed to work, so may well have it wrong.

Thanks,


Jonathan Cameron (2):
  staging:iio:resolver:ad2s120x cleanup.
  staging:iio:resolver:ad2s90 general cleanup

 drivers/staging/iio/resolver/ad2s120x.c |  196 +++++--------------------------
 drivers/staging/iio/resolver/ad2s90.c   |   50 ++------
 2 files changed, 44 insertions(+), 202 deletions(-)

-- 
1.7.3.4
