Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:42159 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab2FNHTK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jun 2012 03:19:10 -0400
Message-ID: <4FD9906C.7090400@cam.ac.uk>
Date: Thu, 14 Jun 2012 08:19:08 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jon Brenner <jbrenner@taosinc.com>,
	linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2] IIO channel type and modifiers for CCT and RGBC data
References: <1337183202.6344.1.camel@jonz-ub2> <alpine.DEB.2.01.1206140006370.29697@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1206140006370.29697@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/13/2012 11:09 PM, Peter Meerwald wrote:
>
>> Add iio channel type and modifiers for Correlated Color Temperature (CCT)
>> and RGBC (red/green/blue/clear) data.
>
>> +What:		/sys/bus/iio/devices/device[n]/in_intensity_clear[_input|_raw]
>> +What:		/sys/bus/iio/devices/device[n]/in_intensity_red[_input|_raw]
>> +What:		/sys/bus/iio/devices/device[n]/in_intensity_green[_input|_raw]
>> +What:		/sys/bus/iio/devices/device[n]/in_intensity_blue[_input|_raw]
>> +KernelVersion:	3.4.0
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		This property is supported by sensors that have a RGBC
>> +		sensing mode. This value should be the output from a reading
>> +		and if expressed in SI units, should include _input. If this
>> +		value is not in SI units (irradiance, uW/mm), then it should
>> +		include _raw.
>
> should the irradiance unit be uW/mm^2 ??
or just W/m^2? Whichever people prefer! Good spot Peter.

