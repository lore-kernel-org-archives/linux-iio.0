Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:36827 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbbJSLMH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 Oct 2015 07:12:07 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 779E120841
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2015 13:12:04 +0200 (CEST)
Message-ID: <5624CFA7.1030603@posteo.de>
Date: Mon, 19 Oct 2015 13:10:31 +0200
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: Joachim Eastwood <manabian@gmail.com>, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: add Freescale MMA7455L 3-axis accelerometer
 driver
References: <1445120719-29685-1-git-send-email-manabian@gmail.com>
In-Reply-To: <1445120719-29685-1-git-send-email-manabian@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2015-10-18 um 00:25 schrieb Joachim Eastwood:
> Add support for Freescale MMA7455L 3-axis in 10-bit mode with both
> I2C and SPI bus support. This is a rather simple driver that
> currently doesn't support all the hardware features of MMA7455L.
> 
> Tested on Embedded Artists' LPC4357 Dev Kit using I2C bus.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---

Think about adding support for MMA7456L as well. What's the difference
between the two, except for the ID?

thanks
                             martin

