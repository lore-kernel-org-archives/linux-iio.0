Return-Path: <groeck@ericsson.com>
Date: Mon, 25 Oct 2010 22:08:51 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Mike Frysinger <vapier@gentoo.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <20101026050851.GA21264@ericsson.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk>
 <20101024234735.GB15616@ericsson.com>
 <DB904C5425BA6F4E8424B3B51A1414D16578B2238F@NWD2CMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16578B2238F@NWD2CMBX1.ad.analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 26, 2010 at 12:20:59AM -0400, Zhang, Sonic wrote:
[ ... ]

> 
> With the raw register value, the driver gives application develop full flexibility to control the device. Is it possible to define a unifiied ABI for all different ADCs in IIO framework? May IIO should document a policy on ABI difinition.
> 
The whole point of an ABI (or API) is that it is well defined and unified,
and can be used across multiple devices. Otherwise it is not an ABI.

Guenter
