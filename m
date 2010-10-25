Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57042 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab0JYNyl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2010 09:54:41 -0400
Message-ID: <4CC58D85.3000503@cam.ac.uk>
Date: Mon, 25 Oct 2010 15:00:37 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Mike Frysinger <vapier@gentoo.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	"Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: Re: BUILD ISSUE: Re: [PATCH 07/36] staging: iio: adc: new driver
 for AD7291 devices
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org> <1287955358-3153-8-git-send-email-vapier@gentoo.org> <4CC58904.9010401@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177130945B1C0A@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177130945B1C0A@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/10 14:40, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2010-10-25:
>> On 10/24/10 22:22, Mike Frysinger wrote:
>>> From: Sonic Zhang <sonic.zhang@analog.com>
>> Build test results (cross compiled for arm) on top of staging-next
>>
>> drivers/staging/iio/adc/ad7291.c: In function 'ad7291_probe':
>> drivers/staging/iio/adc/ad7291.c:951: error: 'struct i2c_client' has
>> no member named 'irq_flags'
>> drivers/staging/iio/adc/ad7291.c:966: error: 'struct i2c_client' has
>> no member named 'irq_flags'
>>
>> Google tells me you guys have posted a patch adding this a couple of
>> weeks back.  Doesn't
>> look like Jean liked it...   If it is merging you need to tell Greg
>> that there is a dependency
>> on it when you send him the merge request. Otherwise just remove the
>> usage and rely on it happening in board setup code. Personally I agree
>> with what the patch was trying to do, but if it isn't merging we don't
>> want to hold this driver up waiting for it.
> 
> Ok - I remove it for now.
> 
> Actually we've added irq_flags to both i2c and spi board info.
> There were a few people who commented positively on both patches.
> Feel free to send your cents as well.
Grep the whole set. There are quite a few users.

Jonathan
> 
> -Michael
> 
