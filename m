Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54447 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbCNOZf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 10:25:35 -0400
Message-ID: <550444DE.9040201@kernel.org>
Date: Sat, 14 Mar 2015 14:25:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>
CC: outreachy-kernel@googlegroups.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Outreachy kernel] [PATCH v2] iio: Add ABI documentation for
 proximity scan_elements
References: <20150312155250.GA20385@haneen-vb> <CAEnQRZAEg0QNRAonD6ODvfYymWT3nMNLoqz8XGqx4uN+GZFDQw@mail.gmail.com>
In-Reply-To: <CAEnQRZAEg0QNRAonD6ODvfYymWT3nMNLoqz8XGqx4uN+GZFDQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/03/15 16:06, Daniel Baluta wrote:
> On Thu, Mar 12, 2015 at 5:52 PM, Haneen Mohammed
> <hamohammed.sa@gmail.com> wrote:
>> This patch adds ABI documentation entries for in_proximity_en,
>> in_proximity_type, and in_proximity_index in the scan_elements directory.
>> At least one user for these is present, the AS3935 Franklin lightning sensor.
>>
>> Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
>> ---
>> v2: Fix typos in commit subject/body.
>>
>>  Documentation/ABI/testing/sysfs-bus-iio | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 9a1a5fc..fd026d9 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -999,6 +999,7 @@ What:               /sys/.../iio:deviceX/scan_elements/in_incli_y_en
>>  What:          /sys/.../iio:deviceX/scan_elements/in_pressureY_en
>>  What:          /sys/.../iio:deviceX/scan_elements/in_pressure_en
>>  What:          /sys/.../iio:deviceX/scan_elements/in_rot_quaternion_en
>> +What:          /sys/.../iio:deviceX/scan_elements/in_proximity_en
>>  KernelVersion: 2.6.37
>>  Contact:       linux-iio@vger.kernel.org
>>  Description:
>> @@ -1015,6 +1016,7 @@ What:             /sys/.../iio:deviceX/scan_elements/in_timestamp_type
>>  What:          /sys/.../iio:deviceX/scan_elements/in_pressureY_type
>>  What:          /sys/.../iio:deviceX/scan_elements/in_pressure_type
>>  What:          /sys/.../iio:deviceX/scan_elements/in_rot_quaternion_type
>> +What:          /sys/.../iio:deviceX/scan_elements/in_proximity_type
>>  KernelVersion: 2.6.37
>>  Contact:       linux-iio@vger.kernel.org
>>  Description:
>> @@ -1066,6 +1068,7 @@ What:             /sys/.../iio:deviceX/scan_elements/in_timestamp_index
>>  What:          /sys/.../iio:deviceX/scan_elements/in_pressureY_index
>>  What:          /sys/.../iio:deviceX/scan_elements/in_pressure_index
>>  What:          /sys/.../iio:deviceX/scan_elements/in_rot_quaternion_index
>> +What:          /sys/.../iio:deviceX/scan_elements/in_proximity_index
>>  KernelVersion: 2.6.37
>>  Contact:       linux-iio@vger.kernel.org
>>  Description:
>> --
>> 1.9.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20150312155250.GA20385%40haneen-vb.
>> For more options, visit https://groups.google.com/d/optout.

