Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35807 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbcA0JNS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jan 2016 04:13:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAKzfze-usm3BM0wu3vVy5zoX0Zq2=5EgNfEwYwqnL2H8_tRbEQ@mail.gmail.com>
References: <1453839667-3626-1-git-send-email-cristina.moraru09@gmail.com>
	<CAKzfze-usm3BM0wu3vVy5zoX0Zq2=5EgNfEwYwqnL2H8_tRbEQ@mail.gmail.com>
Date: Wed, 27 Jan 2016 11:13:17 +0200
Message-ID: <CAEnQRZDACDTnmMdnefaWEK_Mt-5CSP1bndXERVseuJ3KLWbCHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: si7005: add support for Hoperf th02
From: Daniel Baluta <daniel.baluta@intel.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: Cristina Moraru <cristina.moraru09@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
	geert@linux-m68k.org,
	=?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 27, 2016 at 12:56 AM, Matt Ranostay <mranostay@gmail.com> wrote:
> On Tue, Jan 26, 2016 at 12:21 PM, Cristina Moraru
> <cristina.moraru09@gmail.com> wrote:
>> This patch adds support for Hoperf th02 humidity and
>> temperature sensor as it uses same register definitions
>> as si7005
>>
>> th02 Datasheet: http://www.anglia-live.com/netalogue/pdfs/hrf/datasheets/TH02_V1.1.pdf
>>
>> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
>> ---
>>  drivers/iio/humidity/Kconfig  | 3 ++-
>>  drivers/iio/humidity/si7005.c | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
>> index c1f3a21..866dda1 100644
>> --- a/drivers/iio/humidity/Kconfig
>> +++ b/drivers/iio/humidity/Kconfig
>> @@ -43,7 +43,8 @@ config SI7005
>>           humidity and temperature sensor.
>>
>>           To compile this driver as a module, choose M here: the module
>> -         will be called si7005.
>> +         will be called si7005. This driver also
>> +         supports Hoperf TH02 Humidity and Temperature Sensor.
>
> This probably shouldn't be changing the Kconfig description. Since if
> every driver added a line for each device/variant it supported
> everything would get quite wordy.

Wordy is good :). We usually add all the supported chips in the Kconfig.
See for example entries for BMC150_ACCEL or IIO_ST_ACCEL_3AXIS.

thanks,
Daniel.
