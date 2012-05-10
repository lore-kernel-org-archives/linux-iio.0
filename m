Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58398 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716Ab2EJN2q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 May 2012 09:28:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
Date: Thu, 10 May 2012 13:28:36 +0000
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	thomas@free-electrons.com, plagnioj@jcrosoft.com,
	patrice.vilchez@atmel.com
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com> <4FAB7D29.9000107@free-electrons.com> <4FAB815A.8040109@atmel.com>
In-Reply-To: <4FAB815A.8040109@atmel.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201205101328.36524.arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thursday 10 May 2012, Nicolas Ferre wrote:
> So I would really like to keep the non-DT probing. This will give the
> ability for users to experiment IIO/ADC with whichever kernel revision,
> whichever AT91 SoC they like.
> 
> Arnd, we will have to agree on a way to push this work into mainline,
> but please consider keeping the non-DT part for this driver.

Ok. If the non-DT part is important to you, I suggest you merge it
all through the IIO tree, to avoid dependency problems with the
platform data header file.

Please add my Acked-by for the arch/arm patches.

	Arnd
