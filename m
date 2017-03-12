Return-Path: <SRS0=OzGk=2V=gmail.com=karniksayli1995@kernel.org>
Date: Mon, 13 Mar 2017 03:45:43 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] Replace mlock with private lock and improve code flow
Message-ID: <cover.1489356140.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The patch series replaces mlock with a private lock for driver ad9834 and
improves code flow by eliminating excessive goto.

sayli karnik (2):
  staging: iio: ad9834: Use private driver lock instead of mlock
  staging: iio: ad9834: Remove unnecessary goto label and compress
    return logic

 drivers/staging/iio/frequency/ad9834.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4
