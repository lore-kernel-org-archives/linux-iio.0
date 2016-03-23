Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33204 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbcCWMc3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2016 08:32:29 -0400
MIME-Version: 1.0
In-Reply-To: <56EE7FD3.7050803@kernel.org>
References: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
	<1458232366-12773-4-git-send-email-daniel.baluta@intel.com>
	<56EE7FD3.7050803@kernel.org>
Date: Wed, 23 Mar 2016 14:32:27 +0200
Message-ID: <CAEnQRZDxc2ju1mamgmSm8soFjv2L7WVER8oA-77hFJd7BcfP1g@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: imu: mpu6050: Add support for auxiliary I2C master
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Crt Mori <cmo@melexis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Ge Gao <ggao@invensense.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Adriana Reus <adi.reus@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 20, 2016 at 12:47 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 17/03/16 16:32, Daniel Baluta wrote:
>> The MPU-60X0 [1] has an auxiliary I2C bus for connecting external
>> sensors. This bus has two operating modes:
>>       * pass-through, which connects the primary and auxiliary busses
>>       together [already implemented]
>>       * I2C master mode, where MPU60X0 acts as a master to any
>>       external connected sensors [implemented in this patch]
>>
>> I2C master supports up to 5 slaves. Slaves 0-3 have a common operating
>> mode while slave 4 is different.
>>
>> This patch only adds support for slave 4 because it has a cleaner
>> interface and it has an interrupt that signals when data from slave
>> to master arrived.
>>
>> Registers are described here [2].
>>
>> We use threaded handler for reading slave4 done interrupt bit.
>>
>> [1]
>> https://www.cdiweb.com/datasheets/invensense/MPU-6050_DataSheet_V3%204.pdf
>> [2]
>> http://www6.in.tum.de/pub/Main/TeachingWs2015SeminarAuonomousFahren/RM-MPU-6000A.pdf
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> hmm. Daniel - this is an i2c driver (be it within an IIO driver) so you need
> to cc Wolfram and the i2c list.
>
> I'll be needing an Ack from Wolfram if I am to take this,

Will do with v2.

Daniel.
