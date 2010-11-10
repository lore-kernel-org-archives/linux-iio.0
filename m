Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:35564 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322Ab0KJXtP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Nov 2010 18:49:15 -0500
Date: 10 Nov 2010 23:20:56 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	mensch0815@gmail.com
Subject: Re: [PATCH] iio - add support for bmp085 barometer
Message-ID: <Prayer.1.3.3.1011102320560.4446@hermes-2.csi.cam.ac.uk>
In-Reply-To: <20101109234953.GA9001@kroah.com>
References: <4CCADE59.9070702@gmail.com>
 <20101109234953.GA9001@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Nov 9 2010, Greg KH wrote:

>On Fri, Oct 29, 2010 at 04:46:49PM +0200, Matthias Brugger wrote:
>> This patch adds support for the Bosch Sensortec bmp085 digital
>> barometer to the iio subsystem.
>> 
>> Signed-off-by: Matthias Brugger <m_brugger@web.de>
>> ---
>>  drivers/staging/iio/Kconfig            |    1 +
>>  drivers/staging/iio/Makefile           |    1 +
>>  drivers/staging/iio/barometer/Kconfig  |   12 +
>>  drivers/staging/iio/barometer/Makefile |    5 +
>>  drivers/staging/iio/barometer/baro.h   |    8 +
>>  drivers/staging/iio/barometer/bmp085.c |  398
>> ++++++++++++++++++++++++++++++++
>
>The patch is line-wrapped and can't be applied :(
>
>Care to get Jonathan's ack and resend it in a format I can apply it in?
>
>thanks,
>
Sorry, I'm out and about until end of next week (conference in Queenstown
New Zealand, it's a hard life)

So may be a little while before I get to this.

Jonathan
