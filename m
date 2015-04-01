Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35466 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbbDALBJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2015 07:01:09 -0400
Received: by widdi4 with SMTP id di4so40401280wid.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2015 04:01:08 -0700 (PDT)
Date: Wed, 1 Apr 2015 14:00:07 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
	daniel.baluta@gmail.com
Subject: [PATCH 0/2] iio: Place drivers on standby on error
Message-ID: <cover.1427797741.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset places drivers on standby when an error occurs
to avoid wasting power.

Cristina Opriceana (2):
  iio: magnetometer: mag3110: Place driver on standby on error
  iio: light: ltr501: Powerdown device on error

 drivers/iio/light/ltr501.c         | 18 ++++++++++--------
 drivers/iio/magnetometer/mag3110.c | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
1.9.1

