Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35941 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbbKKMJ6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Nov 2015 07:09:58 -0500
MIME-Version: 1.0
In-Reply-To: <1447171653-12756-2-git-send-email-mtitinger@baylibre.com>
References: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
	<1447171653-12756-2-git-send-email-mtitinger@baylibre.com>
Date: Wed, 11 Nov 2015 14:09:57 +0200
Message-ID: <CAEnQRZBeZpBxSCf85MRmByguHA8kXTNp9+NPD2d3cdsMRb+74w@mail.gmail.com>
Subject: Re: [RFC 1/4] iio: ina2xx: add direct IO support for TI INA2xx Power Monitors
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Marc Titinger <mtitinger@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	mturquette@baylibre.com, bcousson@baylibre.com,
	ptitiano@baylibre.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

<snip>

> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> ---
>  drivers/iio/adc/Kconfig      |   9 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ina2xx-iio.c | 404 +++++++++++++++++++++++++++++++++++++++++++

One more thing. In IIO we do not prefer generic names for files.
Lets name this after the first device in the family.

Here I would say we should call it drivers/iio/adc/ina219.c. Skip the
-iio suffix
from file name, because it is already under the iio/ directory.

If there is a module name conflict with hwmon module we can name the
.ko resulted
from this file ina219-iio.ko.
