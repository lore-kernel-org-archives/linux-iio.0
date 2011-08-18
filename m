Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:21771 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab1HRPin convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2011 11:38:43 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Date: Thu, 18 Aug 2011 16:36:56 +0100
Subject: RE: [PATCH] iio: capfun: fix inverted logic of ThrFixed
Message-ID: <544AC56F16B56944AEC3BD4E3D59177143006BAB50@LIMKCMBX1.ad.analog.com>
References: <1313679621-5347-1-git-send-email-michael.hennerich@analog.com>
 <4E4D2F7E.8090605@cam.ac.uk>
In-Reply-To: <4E4D2F7E.8090605@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-08-18:
> On 08/18/11 16:00, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> Bit 7 of the AD7150 configuration register needs to be set for fixed
>> threshold modes.
> Oops.  Will merge with the relevant patch.

By the way - without you having hardware to test -
pretty impressive this major respin worked out of the box!

Congratulations!

-Michael



>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/adc/ad7150.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> diff --git a/drivers/staging/iio/adc/ad7150.c
>> b/drivers/staging/iio/adc/ad7150.c
>> index 9e01614..fdf4da8 100644
>> --- a/drivers/staging/iio/adc/ad7150.c
>> +++ b/drivers/staging/iio/adc/ad7150.c
>> @@ -349,7 +349,7 @@ static int ad7150_write_event_config(struct
> iio_dev *indio_dev,
>>              goto error_ret;
>>      };
>> -    cfg |= (adaptive << 7) | (thresh_type << 5);
>> +    cfg |= (!adaptive << 7) | (thresh_type << 5);
>>
>>      ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
>>      if (ret < 0)
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



