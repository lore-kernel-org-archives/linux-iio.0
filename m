Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41084 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbbKWIUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2015 03:20:17 -0500
From: Juergen Borleis <jbe@pengutronix.de>
To: kernel@pengutronix.de
Subject: Re: [PATCH v8 6/8] input: touchscreen: imx25 tcq driver
Date: Mon, 23 Nov 2015 09:21:02 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
	Markus Pargmann <mpa@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
	Eric Bc3a9nard <eric@eukrea.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>, linux-input@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de> <1447675269-8831-7-git-send-email-mpa@pengutronix.de> <5650AE5A.5010506@kernel.org>
In-Reply-To: <5650AE5A.5010506@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Message-Id: <201511230921.02588.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Saturday 21 November 2015 18:48:10 Jonathan Cameron wrote:
> [...]
> Another personal preference. I'd not bother wrapping these single line
> calls up but rather just make them inline.  They don't in of
> themselves add much to my mind.  Still this one is very much up to you
> as far as I'm concerned.

A matter of taste. Programming bits is more or less hard to understand even if 
we use macros with useful names. So it is me to prefer self explaining 
functions by no cost of code because the compiler will optimise it away.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Borleis             |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
