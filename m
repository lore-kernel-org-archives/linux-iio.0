Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:46966 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812Ab2HTTXP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Aug 2012 15:23:15 -0400
Received: by ghrr11 with SMTP id r11so5342552ghr.19
        for <linux-iio@vger.kernel.org>; Mon, 20 Aug 2012 12:23:15 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Dagenais?= <jeff.dagenais@gmail.com>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, device-drivers-devel@blackfin.uclinux.org
Subject: 
Date: Mon, 20 Aug 2012 15:23:00 -0400
Message-Id: <1345490581-30375-1-git-send-email-jeff.dagenais@gmail.com>
In-Reply-To: <502E10A4.1080800@metafoo.de>
References: <502E10A4.1080800@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a follow-up to a preliminary patch from Lars-Peter Clausen to add
support for I2C based DACs on ad5446.c.

Turns out this patch was 1 line away from a hole-in-one, a simple compile
error and voilà! Drove my ad5622's perfectly.

Great job Lars-Peter!

 drivers/iio/dac/Kconfig  |   9 +++--
 drivers/iio/dac/ad5446.c | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
 drivers/iio/dac/ad5446.h |   5 ++-
 3 files changed, 256 insertions(+), 120 deletions(-)
