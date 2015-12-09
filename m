Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24339 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbbLILlY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 Dec 2015 06:41:24 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 0/3] iio: light: us5218d: Add interrupt support and some tidying up
Date: Wed,  9 Dec 2015 13:40:41 +0200
Message-Id: <1449661244-18692-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first patch fixes an inconsistency that I've missed in the px_enable and
als enable status variables.
The second patch adds interrupt support for proximity. It's the same with what
I previously sent (https://lkml.org/lkml/2015/11/29/83), but with the suggested
changes. I chose to resend it because it needs to go together with the first one
because there is a particular workflow case involving event enabling that can be
affected by that bug.
And lastly, some refactoring to improve readability regarding the read raw function. 


Adriana Reus (3):
  iio: light: us5182d: Fix enable status inconcistency
  iio: light: us5182d: Add interrupt support and events
  iio: light: us5182d: Refactor read_raw function

 drivers/iio/light/us5182d.c | 445 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 363 insertions(+), 82 deletions(-)

-- 
1.9.1

