Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37296 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbGMNOm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 09:14:42 -0400
Date: Mon, 13 Jul 2015 16:13:58 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com
Subject: [PATCH 0/3] tools: iio: Fix style issues
Message-ID: <cover.1436789446.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset fixes some style issues in userspace iio tools
as indicated by checkpatch.pl.

Cristina Opriceana (3):
  tools: iio: Remove explicit NULL comparison
  tools: iio: Remove unnecessary braces
  tools: iio: Add ARRAY_SIZE macro

 tools/iio/generic_buffer.c    |  4 +--
 tools/iio/iio_event_monitor.c |  3 +--
 tools/iio/iio_utils.c         | 58 +++++++++++++++++++++----------------------
 tools/iio/iio_utils.h         |  2 ++
 tools/iio/lsiio.c             | 10 ++++----
 5 files changed, 39 insertions(+), 38 deletions(-)

-- 
1.9.1

