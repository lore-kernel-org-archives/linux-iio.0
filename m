Return-Path: <SRS0=9Nc3=NE=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 0/2] iio: potentiometer: tpl0102: improve driver to report steps/range
Date: Wed, 24 Oct 2018 11:38:56 +0100
Message-Id: <20181024103858.28201-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset enables userspace to know how many steps a respective
potentiometer can support.

Matt Ranostay (2):
  iio: potentiometer: tpl0102: switch to using pointer to chip config
  iio: potentiometer: tpl0102: add IIO_AVAIL_RANGE support

 drivers/iio/potentiometer/tpl0102.c | 41 +++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 11 deletions(-)

-- 
2.17.1
