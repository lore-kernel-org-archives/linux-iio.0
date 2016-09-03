Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45114 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754115AbcICQK4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 12:10:56 -0400
Subject: Re: [PATCH] iio: fix pressure data output unit in
 hid-sensor-attributes
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
References: <1472467856-14526-1-git-send-email-hock.leong.kweh@intel.com>
 <1472586592.5025.3.camel@intel.com>
Cc: "Lay, Kuan Loon" <kuan.loon.lay@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Ooi, Joyce" <joyce.ooi@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "Lim, Lee Booi" <lee.booi.lim@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <768770a0-978a-cef3-23a8-929e63a5c414@kernel.org>
Date: Sat, 3 Sep 2016 17:10:38 +0100
MIME-Version: 1.0
In-Reply-To: <1472586592.5025.3.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/08/16 20:49, Pandruvada, Srinivas wrote:
> On Mon, 2016-08-29 at 18:50 +0800, Kweh, Hock Leong wrote:
>> From: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
>>
>> According to IIO ABI definition, IIO_PRESSURE data output unit is
>> kilopascal:
>> http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-
>> bus-iio
>>
>> This patch fix output unit of HID pressure sensor IIO driver from
>> pascal to
>> kilopascal to follow IIO ABI definition.
>>
>> Signed-off-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Thanks,

Applied to the fixes-togreg branch of iio.git and marked for stable.

Jonathan
> 
>> ---
>>  .../iio/common/hid-sensors/hid-sensor-attributes.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> index e81f434..dc33c1d 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> @@ -56,8 +56,8 @@ static struct {
>>  	{HID_USAGE_SENSOR_ALS, 0, 1, 0},
>>  	{HID_USAGE_SENSOR_ALS, HID_USAGE_SENSOR_UNITS_LUX, 1, 0},
>>  
>> -	{HID_USAGE_SENSOR_PRESSURE, 0, 100000, 0},
>> -	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL,
>> 1, 0},
>> +	{HID_USAGE_SENSOR_PRESSURE, 0, 100, 0},
>> +	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL,
>> 0, 1000},
>>  };
>>  
>>  static int pow_10(unsigned power)

