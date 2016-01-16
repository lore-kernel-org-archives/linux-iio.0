Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:33124 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbcAPOgk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 16 Jan 2016 09:36:40 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 0C45E2095A
	for <linux-iio@vger.kernel.org>; Sat, 16 Jan 2016 15:36:37 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: iio: mma8452: driver improvements for v4.6
Date: Sat, 16 Jan 2016 15:35:19 +0100
Message-Id: <1452954922-2266-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This includes my pending changes for the mma8452 driver for v4.6.
It hopefully makes the auto builder happy and simplifies the thing
on the mailing lists.

[PATCH v6 1/3] iio: mma8452: add freefall detection for Freescale's

[PATCH 2/3] iio: mma8452: whitespace cleanup

[PATCH 3/3] iio: mma8452: add support for MMA8451Q
Strictly this is v2, after Peter's and Jonathan's review.
