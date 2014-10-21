Return-Path: <bvandre@gmail.com>
From: Brian Vandre <bvandre@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	alexandre.belloni@free-electrons.com,
	linux-iio@vger.kernel.org,
	marex@denx.de
Cc: Brian Vandre <bvandre@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: iio: adc: Checkpatch.pl warning cleanups
Date: Tue, 21 Oct 2014 17:56:46 -0500
Message-Id: <cover.1413931615.git.bvandre@gmail.com>
In-Reply-To: <cover.1413858979.git.bvandre@gmail.com>
References: <cover.1413858979.git.bvandre@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch-set fixes 2 checkpatch.pl warnings
dealing with lines over 80 characters.

Changes from v1:
-squashed 2 patches into 1 as suggested by Alexandre Belloni


Brian Vandre (1):
  Staging: iio: adc: fix line over 80 characters

 drivers/staging/iio/adc/mxs-lradc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.1
