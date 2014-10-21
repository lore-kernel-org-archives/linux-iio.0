Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34349 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbaJUCtT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Oct 2014 22:49:19 -0400
From: Brian Vandre <bvandre@gmail.com>
To: gregkh@linuxfoundation.org, jic23@kernel.org,
	alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org
Cc: Brian Vandre <bvandre@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Staging: iio: adc: Checkpatch.pl warning cleanups
Date: Mon, 20 Oct 2014 21:48:47 -0500
Message-Id: <cover.1413858979.git.bvandre@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch-set fixes 2 checkpatch.pl warnings
dealing with lines over 80 characters.

Brian Vandre (2):
  Staging: iio: adc: fix line over 80 characters
  Staging: iio: adc: fix line over 80 characters

 drivers/staging/iio/adc/mxs-lradc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.1

