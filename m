Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40363 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab2HUO33 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Aug 2012 10:29:29 -0400
Received: by yenl14 with SMTP id l14so5855305yen.19
        for <linux-iio@vger.kernel.org>; Tue, 21 Aug 2012 07:29:29 -0700 (PDT)
From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, device-drivers-devel@blackfin.uclinux.org
Subject: [PATCH  v3.6-rc2 V2 0/2] iio:ad5446: add I2C DACs and header cleanup
Date: Tue, 21 Aug 2012 10:28:56 -0400
Message-Id: <1345559338-19509-1-git-send-email-jeff.dagenais@gmail.com>
In-Reply-To: <502E10A4.1080800@metafoo.de>
References: <502E10A4.1080800@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Here's a V2 of Lars' "Add support for I2C based DACs" and a commit that
removes the seamingly useless private header file.

 drivers/iio/dac/Kconfig  |   9 ++--
 drivers/iio/dac/ad5446.c | 429 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------
 drivers/iio/dac/ad5446.h |  91 --------------------------------------
 3 files changed, 322 insertions(+), 207 deletions(-)
