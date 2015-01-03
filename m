Return-Path: <alexandre.belloni@free-electrons.com>
Date: Sat, 3 Jan 2015 22:08:19 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	marex@denx.de, fabio.estevam@freescale.com, robert.hodaszi@digi.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH V2] iio: mxs-lradc: fix iio channel map regression
Message-ID: <20150103210819.GL4194@piout.net>
References: <1420317252-19761-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420317252-19761-1-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 03/01/2015 at 20:34:12 +0000, Stefan Wahren wrote :
> Since commit c8231a9af8147f8a ("iio: mxs-lradc: compute temperature
> from channel 8 and 9") with the removal of adc channel 9 there is
> no 1-1 mapping in the channel spec.
> 
> All hwmon channel values above 9 are accessible via there index minus
> one. So add a hidden iio channel 9 to fix this issue.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
