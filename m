Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:37559 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdJDT7M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Oct 2017 15:59:12 -0400
Date: Wed, 4 Oct 2017 21:50:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: adc: mcp320x: Add support for mcp3550/1/3
Message-ID: <20171004195037.GB9195@wunner.de>
References: <cover.1504807204.git.lukas@wunner.de>
 <77df087e5d4a8954b3a7e019372884b877583558.1504807204.git.lukas@wunner.de>
 <20170910171514.714abfdd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170910171514.714abfdd@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 10, 2017 at 05:15:14PM +0100, Jonathan Cameron wrote:
> On Sat, 9 Sep 2017 20:32:41 +0200 Lukas Wunner <lukas@wunner.de> wrote:
> > These ADCs are marketed as single-channel 22 bit delta-sigma ADCs, but
> > in reality their resolution is 21 bit with an overrange or underrange
> > of 12% beyond Vref.  In other words, "full scale" means +/- 2^20.
[snip]
> 
> Excellent.  Applied to the togreg branch of iio.git and pushed out as
> testing.

Just a gentle reminder, this patch isn't on your kernel.org branches yet.
I assumed the reason was a dependency / merge conflict with my two patches
on the fixes-togreg branch and you were waiting for them to be in upstream.
They have landed in Linus' tree yesterday, I'm not sure if anything else is
necessary (backmerge or some such).

Thanks,

Lukas
