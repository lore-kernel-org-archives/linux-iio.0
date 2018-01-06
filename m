Return-Path: <SRS0=fQ2w=EB=tobin.cc=me@kernel.org>
From: "Tobin C. Harding" <me@tobin.cc>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 RESEND] fix kernel-docs for struct iio_trigger
Date: Sat,  6 Jan 2018 12:31:56 +1100
Message-Id: <1515202318-17401-1-git-send-email-me@tobin.cc>
List-ID: <linux-iio@vger.kernel.org>

This set is a re-spin of

	[PATCH] iio: add kernel-doc '@owner'

Patch 1 is the original patch. Adds a kernel-doc description for field
@owner clearing a sphinx build warning when building kernel documentation.

Patch 2 adds field identifier for @use_count. Currently this field has a
description but lacks a field identifier.

Tobin C. Harding (2):
  iio: add kernel-doc for field @owner
  iio: add field identifier for @use_count kernel-doc

 include/linux/iio/trigger.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
