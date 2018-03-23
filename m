Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:36918 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeCWMmK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Mar 2018 08:42:10 -0400
Date: Fri, 23 Mar 2018 13:42:08 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] iio: dac: add TI DAC5755 family support
In-Reply-To: <9027eb14-2332-c925-2e0e-30ef45e11b57@prevas.dk>
Message-ID: <alpine.DEB.2.21.1803231341420.14661@vps.pmeerw.net>
References: <20180322102336.32268-1-sean.nyekjaer@prevas.dk> <alpine.DEB.2.21.1803221200240.9561@vps.pmeerw.net> <20180323132753.00000c4e@huawei.com> <9027eb14-2332-c925-2e0e-30ef45e11b57@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> But the reason for the RFC tag is that I don't have the hardware to test this
> on yet...
> It will arrive sometime next month

this explains the broken handling of the i2c_master_send() retval :)

p.

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
