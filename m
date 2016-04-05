Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35107 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbcDEIRR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Apr 2016 04:17:17 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1604011613450.15685@pmeerw.net>
References: <1459513870-3852-1-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1604011613450.15685@pmeerw.net>
Date: Tue, 5 Apr 2016 11:17:15 +0300
Message-ID: <CAEnQRZApmNrG5-6TR=L+rz1M-Rrs_hKc+xAOC_X5R3B24_Jeog@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: Add initial support for Bosch BMI160
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Apr 1, 2016 at 5:28 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
>> BMI160 is an Inertial Measurement Unit (IMU) which provides acceleration
>> and angular rate measurement. It also offers a secondary I2C interface
>> for connecting a magnetometer sensor (usually BMM160).
>>
>> Current driver offers support for accelerometer and gyroscope readings
>> via sysfs or via buffer interface using an external trigger (e.g.
>> hrtimer). Data is retrieved from IMU via I2C or SPI interface.
>
> comments below

Hi Peter,

Agree with all your comments. Will fix in v2.

thanks!
