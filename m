Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53553 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912AbcA3QMh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 11:12:37 -0500
Subject: Re: [PATCH 2/2] iio: si7005: add support for Hoperf th02
To: Daniel Baluta <daniel.baluta@intel.com>,
	Matt Ranostay <mranostay@gmail.com>
References: <1453839667-3626-1-git-send-email-cristina.moraru09@gmail.com>
 <CAKzfze-usm3BM0wu3vVy5zoX0Zq2=5EgNfEwYwqnL2H8_tRbEQ@mail.gmail.com>
 <CAEnQRZDACDTnmMdnefaWEK_Mt-5CSP1bndXERVseuJ3KLWbCHQ@mail.gmail.com>
Cc: Cristina Moraru <cristina.moraru09@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
	geert@linux-m68k.org,
	=?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACE0F3.30708@kernel.org>
Date: Sat, 30 Jan 2016 16:12:35 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDACDTnmMdnefaWEK_Mt-5CSP1bndXERVseuJ3KLWbCHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/16 09:13, Daniel Baluta wrote:
> On Wed, Jan 27, 2016 at 12:56 AM, Matt Ranostay <mranostay@gmail.com> wrote:
>> On Tue, Jan 26, 2016 at 12:21 PM, Cristina Moraru
>> <cristina.moraru09@gmail.com> wrote:
>>> This patch adds support for Hoperf th02 humidity and
>>> temperature sensor as it uses same register definitions
>>> as si7005
>>>
>>> th02 Datasheet: http://www.anglia-live.com/netalogue/pdfs/hrf/datasheets/TH02_V1.1.pdf
>>>
>>> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
>>> ---
>>>  drivers/iio/humidity/Kconfig  | 3 ++-
>>>  drivers/iio/humidity/si7005.c | 1 +
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
>>> index c1f3a21..866dda1 100644
>>> --- a/drivers/iio/humidity/Kconfig
>>> +++ b/drivers/iio/humidity/Kconfig
>>> @@ -43,7 +43,8 @@ config SI7005
>>>           humidity and temperature sensor.
>>>
>>>           To compile this driver as a module, choose M here: the module
>>> -         will be called si7005.
>>> +         will be called si7005. This driver also
>>> +         supports Hoperf TH02 Humidity and Temperature Sensor.
>>
>> This probably shouldn't be changing the Kconfig description. Since if
>> every driver added a line for each device/variant it supported
>> everything would get quite wordy.
> 
> Wordy is good :). We usually add all the supported chips in the Kconfig.
> See for example entries for BMC150_ACCEL or IIO_ST_ACCEL_3AXIS.
Absolutely - never mind burning words that are hidden under help ;)

Jonathan
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

