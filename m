Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47856 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab1CXPQ3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2011 11:16:29 -0400
Message-ID: <4D8B609A.5070603@cam.ac.uk>
Date: Thu, 24 Mar 2011 15:17:46 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: ADC: New driver for the AD7880 / AD7781 24-bit Sigma-Delta
 ADC
References: <1300975814-14423-1-git-send-email-michael.hennerich@analog.com> <4D8B5D86.8010503@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177137545394A3@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177137545394A3@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/24/11 15:12, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-03-24:
>> On 03/24/11 14:10, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> Hi Michael,
>>
>> Some slightly inconsistent handling of the absence of pdata.
>> Is it possible to use this device without pdrst being connected?
> 
> Yes and no.
> You could but then the AD7780 asserts SDO/RDY whenever a new sample is available.
> No way to stop it, without utilizing PDRST.
> I therefore use spi bus locking and keep the part in reset/power down whenever is should be quiet.
> The part also lacks a dedicated spi chip select. So we definitely want to use PDRST.
Fair enough. That's an 'interesting' bit of hardware!
> 
>> If not, then check for pdata early in probe and fail if not present.
> 
> Yes - I typically do this, however it slipped this time.
> 
>> The datardy on the data out line is a delightful big of hardware
>> design and I guess what you have here is the only way to handle it.
> 
> Unfortunately that's the case.
> 
>> Having said that, perhaps some explanatory comments, maybe in the
>> header, would be useful.  Do you have that irq pin dual wired to the
>> spi data out?
> 
> Yes
> 
> Thanks for the review.
> 
You are most welcome.
