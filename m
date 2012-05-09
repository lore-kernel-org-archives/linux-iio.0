Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54195 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224Ab2EIOkR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 10:40:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
Date: Wed, 9 May 2012 14:40:14 +0000
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org, thomas@free-electrons.com,
	nicolas.ferre@atmel.com, plagnioj@jcrosoft.com,
	patrice.vilchez@atmel.com
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201205091440.14587.arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday 09 May 2012, Maxime Ripard wrote:
> Here is another version of the patches to bring ADC driver to Atmel boards.
> Since last version, here is what changed:
>   * Rebased on top of staging-next to move out of staging. Had to change to IIO
>     kfifo buffer along the way.
>   * Reworked the DT bindings according to Jean-Christophe reviews
>   * Made various fixes according to reviews
>   * Support for X5 boards

What's the reason for providing both DT and non-DT probing in that driver?
Doesn't it make more sense to just require that everyone who uses this
device boots using the device tree?

	Arnd
