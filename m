Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:53182 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab1HRQGY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2011 12:06:24 -0400
Message-ID: <4E4D3A67.2010407@cam.ac.uk>
Date: Thu, 18 Aug 2011 17:14:31 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: capfun: fix inverted logic of ThrFixed
References: <1313679621-5347-1-git-send-email-michael.hennerich@analog.com> <4E4D2F7E.8090605@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143006BAB50@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177143006BAB50@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/18/11 16:36, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-08-18:
>> On 08/18/11 16:00, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> Bit 7 of the AD7150 configuration register needs to be set for fixed
>>> threshold modes.
>> Oops.  Will merge with the relevant patch.
> 
> By the way - without you having hardware to test -
> pretty impressive this major respin worked out of the box!
> 
> Congratulations!
Thanks.  Interestingly none of the ones where I actually have
hardware have done so :)
