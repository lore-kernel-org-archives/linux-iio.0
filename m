Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37718 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbcDAI2y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2016 04:28:54 -0400
MIME-Version: 1.0
In-Reply-To: <9dc210ed21cc467699ec0a33a62507f9@EMAIL.axentia.se>
References: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
	<9dc210ed21cc467699ec0a33a62507f9@EMAIL.axentia.se>
Date: Fri, 1 Apr 2016 11:28:52 +0300
Message-ID: <CAEnQRZBBVuYSBNPXTTSR0UeiQa8UH8TVndzn5AhrWWYp-iSQKA@mail.gmail.com>
Subject: Re: [PATCH] iio: max5487: Add support for Maxim digital potentiometers
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Rosin <peda@axentia.se>
Cc: Cristina Moraru <cristina.moraru09@gmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"daniel.baluta@intel.com" <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> .wipers and .max_pos need not be in max5487_cfg, they are common.
> .wipers isn't even used. Which means that if you like, you can
> use the ohms reading as the driver_data directly instead of going
> via the MAX548x enumeration, see below. Or is there some reason
> not doing so?

You make a good point. Anyhow we thought of a generic approach. In the future
this chip family could support more wipers with different positions.
