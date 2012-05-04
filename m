Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:44590
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751585Ab2EDOAn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 4 May 2012 10:00:43 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 4 May 2012 15:00:48 +0100
Subject: RE: [PATCH 3/3] iio: frequency: New driver for AD9523 SPI Low
 Jitter Clock Generator
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714E797B4F51@LIMKCMBX1.ad.analog.com>
References: <1336138266-25480-1-git-send-email-michael.hennerich@analog.com>
 <1336138266-25480-3-git-send-email-michael.hennerich@analog.com>
 <4FA3DE8E.6050802@cam.ac.uk>
In-Reply-To: <4FA3DE8E.6050802@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2012-05-04:
> On 5/4/2012 2:31 PM, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
> Before I dive in here too far, let me ask the stupid question.
>
> Whilst I know nothing much about it, why is the kernel's clock framework
> unsuitable for this device?

Hi Jonathan,

I think we had a similar discussion before.

The in-kernel clock infrastructure HAVE_CLK <linux/clk.h> is not suitable
since it is designed for SoC like systems.

1) The API is exported by arch and platform code.
2) Data structures differ between the different implementations.
3) Coexistence with other clock providers is by design impossible.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



