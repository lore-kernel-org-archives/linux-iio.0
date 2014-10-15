Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47785 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaJOOhF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 15 Oct 2014 10:37:05 -0400
Message-ID: <543E868C.4000204@ti.com>
Date: Wed, 15 Oct 2014 09:37:00 -0500
From: Dan Murphy <dmurphy@ti.com>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	<linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <laurentiu.palcu@intel.com>
Subject: Re: RFC Introducing Heart Monitors for IIO
References: <1413314032-923-1-git-send-email-dmurphy@ti.com> <543E2435.8090704@intel.com>
In-Reply-To: <543E2435.8090704@intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel

On 10/15/2014 02:37 AM, Daniel Baluta wrote:
>
>
> On 10/14/2014 10:13 PM, Dan Murphy wrote:
>> All
>>
>> I am introducing a new sensor category for IIO.  This is for
>> heart rate monitors.
>>
>> Putting this out as a RFC to see if anyone else is developing the
>> same and we can build upon each others patches.
>>
>> I have another sensor to follow up on this series but don't want
>> to start that driver until I understand if there is anyone else
>> doing the same.
>>
>> The first patch introduces the heart rate monitoring into the IIO
>> sub-systems
>>
>> The second patch introduces the DT documentation heart_monitors directory
>> along with the documentation for the TI AFE4403 part.
>>
>> The final patch introduces the heart_monitors directory along with the source
>> for the TI AFE4403 device
>
> We are happy to see this! What is your second sensor?
>

Well right now I cannot give the details as it has not been released but it part of this family
with an I2C interface.

Dan

> Daniel.
>
>


-- 
------------------
Dan Murphy

