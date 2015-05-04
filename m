Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13017 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969AbbEDBLN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 3 May 2015 21:11:13 -0400
Message-ID: <5546C72E.2040101@linux.intel.com>
Date: Sun, 03 May 2015 18:11:10 -0700
From: Sathyanarayanan Kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Robert Moore <robert.moore@intel.com>,
	Rafael J Wysocki <rafael.j.wysocki@intel.com>,
	lenb@kernel.org, linux-api@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC PATCH 3/3] iio: derive the mounting matrix from ACPI _PLD
 objects
References: <1430146908-27919-1-git-send-email-octavian.purdila@intel.com>	<1430146908-27919-4-git-send-email-octavian.purdila@intel.com>	<64714.10.254.87.235.1430149342.squirrel@linux.intel.com>	<CAE1zot+YKTPmVbG-_fNRy-E_VCcqq1VE78H3PMSMb5HvsBheQw@mail.gmail.com>	<553EB0B3.5000707@linux.intel.com> <CAE1zot+fusrvow+s2+CmoctcSD=c2BxoSyd2b=7MBv-pg68A+Q@mail.gmail.com>
In-Reply-To: <CAE1zot+fusrvow+s2+CmoctcSD=c2BxoSyd2b=7MBv-pg68A+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Octavian,

On 04/27/2015 07:23 PM, Octavian Purdila wrote:
> On Tue, Apr 28, 2015 at 12:57 AM, sathyanarayanan kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Hi
>>
>> On 04/27/2015 08:54 AM, Octavian Purdila wrote:
>>> On Mon, Apr 27, 2015 at 6:42 PM, Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>>> Since Acpi framework already exports this info to user space, Why not do
>>>> this derivation in user space code ? Why do we need new ABI, if the same
>>>> can be derived from existing one.
>>>>
>>> The ABI was added in the previous patch so that we can present the
>>> sensor orientation information to userspace even in the case of device
>>> tree.
>> If the main reason for implementing a new ABI is to support DT platforms,
>> Why not implement a version of _PLD for device tree ? Don't you think it
>> would be much better than adding a new ABI to export redundant information ?
>>
> IMO the mounting matrix is more consistent with the IIO ABIs. Although
> I have no issue with repicating _PLD for device tree if people agree
> that it is better.
Since your main issue is, device tree lacking ABI to specify location
information, you should consider fixing it there. Let's wait for others
comment on this.

If you think mounting matrix provides more information than what is 
supported
by _PLD,  then we should consider implementing another ABI. AFAIK, that 
is not
the case here.

Adding adding a new ABI to represent the information that can be derived
from existing ABI does not seem to be useful.
>
>> Also the location information of the device is not just specific to iio
>> drivers. You should consider that we would have similar requirements for
>> devices implemented as input or platform drivers.
> The upstream standard for those sensors where the orientation matters
> (accelerometer, gyro, compass) is IIO.
>
> Granted, there are other device types for which the orientation
> information may be useful (e.g. camera). However the actual
> interpretation and action to be taken is different for each subsystem
> (e.g. in the camera case do the correction via V4L2_CID_HFLIP /
> V4L2_CID_VFLIP) so I think it is better to expose it at the subsystem
> level in a way consistent with the subsystem's ABIs.
I agree that location information is used differently at different
sub systems. But my question is why we need  a new ABI ?

Why not handle it in user space ?

-- 
--
Sathyanarayanan KN
Android Kernel Developer

