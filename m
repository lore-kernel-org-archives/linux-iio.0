Return-Path: <SRS0=k/Hr=2A=gmail.com=karniksayli1995@kernel.org>
Date: Mon, 20 Feb 2017 01:27:21 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] Use BIT() and GENMASK() macros
Message-ID: <cover.1487483384.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Use BIT() and GENMASK() macros for left shifts.

sayli karnik (2):
  staging: iio: ad7152: Use BIT() macro for left shifting 1
  staging: iio: ad7152: Use GENMASK() macro for left shifts

 drivers/staging/iio/cdc/ad7152.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

-- 
2.7.4
