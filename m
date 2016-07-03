Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:35955 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbcGCQuz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 12:50:55 -0400
Subject: Re: [PATCH 1/3] mfd: add support for Allwinner SoCs ADC
To: Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
 <87ab8638-926b-89ce-26a5-705a321d3066@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5779422D.9060207@metafoo.de>
Date: Sun, 3 Jul 2016 18:49:49 +0200
MIME-Version: 1.0
In-Reply-To: <87ab8638-926b-89ce-26a5-705a321d3066@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2016 01:17 PM, Jonathan Cameron wrote:
> On 28/06/16 09:18, Quentin Schulz wrote:
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. For now, only the ADC and the thermal
>> sensor drivers are probed by the MFD, the touchscreen controller support
>> will be added later.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> The code looks fine to me. The 'controversial' bit of this is listing
> iio-hwmon as an mfd child to get it to probe as a result of this being
> present.  My immediately thought is that it should be separately
> described in the devicetree and hence instantiated outside of this driver.

The devicetree is a generic description of the hardware. The iio-hwmon
bridge is a software component that translates between two Linux specific
ABIs. In my opinion putting the later in the former is makes no sense, it is
simply not part of the hardware description.

Its quite terrible that we have the bindings in the first place, but I guess
we have to keep them considering they are ABI and there are existing users.
But we should definitely strongly discourage the introduction of new users.

It is policy whether an application wants to access a device using the IIO
or hwmon API. As such it must be managed by userspace, this is not something
that can be done using devicetree nor should it be something that is done on
a driver by driver basis.

- Lars

