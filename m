Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdHRHUG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Aug 2017 03:20:06 -0400
Date: Fri, 18 Aug 2017 08:19:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, hdegoede@redhat.com,
        wsa@the-dreams.de, chris.packham@alliedtelesis.co.nz,
        jelle@vdwaa.nl, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/5]  iio: srf08: add support for similar devices and
 triggered buffers
Message-ID: <20170818081949.419da8a5@archlinux>
In-Reply-To: <20170817220829.GA4687@arbeit>
References: <20170817220829.GA4687@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 Aug 2017 00:08:29 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

For some reason my laptop hadn't picked up this posting until just now.
Too many random wifi hotspots I guess.

Anyhow given the rebase was trivial I'll stick with V3 for everything.
Wolfram can pickup patch 1 whenever he likes.

Jonathan

> This patch series adds support for:
> - triggered buffer
> - ultrasonic devices srf02 and srf10
> 
> Changes in v4:
> - rebase to recent git repository with trivial-devices.txt now under
>   devicetree/bindings
> 
> Changes in v3:
> - introduce struct chip_info for device specific features
> - remove locking error in srf08_trigger_handler()
> 
> Changes in v2:
> - removed unnecessary patch "[PATCH 6/7] iio: srf08: add buffered to device mode"
> - incorporated patch "[PATCH 7/7] iio: srf08: change text in Kconfig" where suitable
> - changed order of patches to improve logical flow of changes
> - improved distinction of sensor types
> 
> Andreas Klinger (5):
>   iio: srf08: add device tree binding for srf02 and srf10
>   iio: srf08: add device tree table
>   iio: srf08: add triggered buffer support
>   iio: srf08: add sensor type srf10
>   iio: srf08: add support for srf02 in i2c mode
> 
>  .../devicetree/bindings/trivial-devices.txt        |   2 +
>  drivers/iio/proximity/Kconfig                      |   8 +-
>  drivers/iio/proximity/srf08.c                      | 227 ++++++++++++++++++---
>  3 files changed, 203 insertions(+), 34 deletions(-)
> 

