Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37306 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbbBYUnv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 15:43:51 -0500
Message-ID: <54EDBA29.5040901@kernel.org>
Date: Wed, 25 Feb 2015 12:03:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: wsa@the-dreams.de, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: client enumeration
References: <1422656745-13576-1-git-send-email-srinivas.pandruvada@linux.intel.com> <54D11E9C.5030701@kernel.org> <54E8C925.6080805@kernel.org>
In-Reply-To: <54E8C925.6080805@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/02/15 18:06, Jonathan Cameron wrote:
> On 03/02/15 19:16, Jonathan Cameron wrote:
>> On 30/01/15 22:25, Srinivas Pandruvada wrote:
>>> Last comment from Jonathan was
>>> "
>>> This all looks fine to me, though ideally I'd like some input from
>>> others, more familiar with the dmi stuff etc and from Wolfram / others
>>> wrt to the approach.
>>> "
>> Given timing, (just missed likely merge this cycle) we now have a reasonable
>> amount of time.  So lets leave this a little while yet...
> I no one else has any comments on this than I'm going to take it pretty soon
> as is.
> 
> Jonathan
Applied to the togreg branch of iio.git.  Will be pushed out as testing
for the autobuilders to play sometime soonish.
(travelling until Friday)

Jonathan
>>>
>>> So anybody have a better suggestion, I am still open to take them.
>>> Otherwise please consider as a merge candidate.
>>>
>>> v3
>>> Add CONFIG_ACPI protection to avoid compiler warning.
>>>
>>> v2
>>> Add CONFIG_ACPI to call creation of mux clients, instead of relying
>>> on ACPI_HANDLE not present for non ACPI platforms
>>> It is possible that there is no secondary address, this is not an error.
>>>
>>> v1
>>> This is an option if auto detect is not desired. 
>>> Here using ACPI magic, by parsing both standard and vendor ACPI
>>> data.
>>>
>>> v0
>>> Using autodetect feature.
>>> Using HWMON class as other places in the system for mux and
>>> client sensor drivers.
>>>
>>> Srinivas Pandruvada (1):
>>>   iio: imu: inv_mpu6050: Create mux clients for ACPI
>>>
>>>  drivers/iio/imu/inv_mpu6050/Makefile       |   2 +-
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 211 +++++++++++++++++++++++++++++
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |   7 +
>>>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   3 +
>>>  4 files changed, 222 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

