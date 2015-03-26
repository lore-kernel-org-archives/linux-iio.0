Return-Path: <daniel.baluta@intel.com>
Message-ID: <5513DBB8.5010900@intel.com>
Date: Thu, 26 Mar 2015 12:13:12 +0200
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: jic23@kernel.org, jlbec@evilplan.org, lars@metafoo.de,
 knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, octavian.purdila@intel.com
Subject: Re: [PATCH 1/3] iio: configfs: Add configfs support to IIO
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com>	 <1427302832-9336-2-git-send-email-daniel.baluta@intel.com> <1427314499.10958.36.camel@x220>
In-Reply-To: <1427314499.10958.36.camel@x220>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 03/25/2015 10:14 PM, Paul Bolle wrote:
> A license nit.
>
> On Wed, 2015-03-25 at 19:00 +0200, Daniel Baluta wrote:
>> --- /dev/null
>> +++ b/drivers/iio/industrialio-configfs.c
>
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>
>> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
>> +MODULE_DESCRIPTION("Industrial I/O configfs support");
>
> You probably want
>      MODULE_LICENSE("GPL v2");
>
> here too. Because now, at module load time, the license will default to
> "unspecified" which will taint the kernel.

:), correct! I forgot about it.

Daniel.
