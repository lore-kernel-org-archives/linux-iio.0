Return-Path: <Sonic.Zhang@analog.com>
From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Mike Frysinger <vapier@gentoo.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 26 Oct 2010 01:38:06 -0400
Subject: RE: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16578B223AD@NWD2CMBX1.ad.analog.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk> <20101024234735.GB15616@ericsson.com>
 <DB904C5425BA6F4E8424B3B51A1414D16578B2238F@NWD2CMBX1.ad.analog.com>
 <20101026050851.GA21264@ericsson.com>
In-Reply-To: <20101026050851.GA21264@ericsson.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



>-----Original Message-----
>From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
>Sent: Tuesday, October 26, 2010 1:09 PM
>To: Zhang, Sonic
>Cc: Jonathan Cameron; Mike Frysinger;
>linux-iio@vger.kernel.org; device-drivers-devel@blackfin.uclinux.org
>Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for
>ADT7408 temperature sensors
>
>On Tue, Oct 26, 2010 at 12:20:59AM -0400, Zhang, Sonic wrote:
>[ ... ]
>
>>
>> With the raw register value, the driver gives application
>develop full flexibility to control the device. Is it possible
>to define a unifiied ABI for all different ADCs in IIO
>framework? May IIO should document a policy on ABI difinition.
>>
>The whole point of an ABI (or API) is that it is well defined
>and unified, and can be used across multiple devices.
>Otherwise it is not an ABI.
>
>Guenter
>
Yes, I don't think the attribute values exported by the IIO ADC drivers are=
 ABI. Difference ADCs may differ.

Sonic
