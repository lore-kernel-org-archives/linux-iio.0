Return-Path: <jbe@pengutronix.de>
From: Juergen Borleis <jbe@pengutronix.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFT 3/5] iio: mxs-lradc: move STMP reset out of ADC init
Date: Fri, 15 Apr 2016 08:48:44 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
 Marek Vasut <marex@denx.de>,
 Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com> <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201604150848.44242.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Stefan,

On Thursday 14 April 2016 17:48:27 Stefan Wahren wrote:
> This patch moves the STMP reset out of ADC init function
> in order to make it never fail. This is also necessary
> for PM ops.

What do you mean with "make it never fail"?

> [...]

jb
