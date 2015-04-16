Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:50476 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbbDPH4w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 16 Apr 2015 03:56:52 -0400
Date: Thu, 16 Apr 2015 09:56:49 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: "utkarsh.gupta@freescale.com" <utkarsh.gupta@freescale.com>
cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Advice needed on combination sensor driver implementation
In-Reply-To: <BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40@BN1PR0301MB0612.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.02.1504160952410.18538@pmeerw.net>
References: <BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40@BN1PR0301MB0612.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> Please advice on whether this driver could be implemented as 
> accel_magnetometer combined driver in a separate folder in iio? Or should 
> this be implemented as separate accel and magnetometer modules in their 
> corresponding existing folders in iio?

we already have many combined sensors, e.g. temperature and pressure 
sensors; actually many sensors offer a temperature channel for calibration

I'd just stick the driver under accel/ (because accel/ is shorter than 
magnetometer/ :) and have it implement accelerometer and magnetometer 
channels

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
