Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031466AbdEXUB3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 16:01:29 -0400
Date: Wed, 24 May 2017 21:01:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux-iio@vger.kernel.org, thomas.petazzoni@free-electrons.com,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: sun4i-gpadc-iio: fix parent device being
 used in devm function
Message-ID: <20170524210124.058072b6@kernel.org>
In-Reply-To: <20170521190632.GB13344@Red>
References: <20170518063607.11069-1-quentin.schulz@free-electrons.com>
        <20170521190632.GB13344@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 21 May 2017 21:06:32 +0200
Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> On Thu, May 18, 2017 at 08:36:07AM +0200, Quentin Schulz wrote:
> > For the sake of DT binding stability, this IIO driver is a child of an
> > MFD driver for Allwinner A10, A13 and A31 because there already exists a
> > DT binding for this IP. The MFD driver has a DT node but the IIO driver
> > does not.
> > 
> > The IIO device registers the temperature sensor in the thermal framework
> > using the DT node of the parent, the MFD device, so the thermal
> > framework could match the phandle to the MFD device in the DT and the
> > struct device used to register in the thermal framework.
> > 
> > devm_thermal_zone_of_sensor_register was previously used to register the
> > thermal sensor with the parent struct device of the IIO device,
> > representing the MFD device. By doing so, we registered actually the
> > parent in the devm routine and not the actual IIO device.
> > 
> > This lead to the devm unregister function not being called when the IIO
> > module driver is removed. It resulted in the thermal framework still
> > polling the get_temp function of the IIO module while the device doesn't
> > exist anymore, thus generated a kernel panic.
> > 
> > Use the non-devm function instead and do the unregister manually in the
> > remove function.
> > 
> > Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---  
> 
> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Thanks.  I'm afraid this has gone into a non rebasing tree
(and upstream for that matter) so I can't now apply this.
We will have to fall back on the email record.

Thanks

Jonathan
> 
> Thanks

