Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35025 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbcCABJb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Feb 2016 20:09:31 -0500
MIME-Version: 1.0
In-Reply-To: <20160301005032.GA15476@deathstar>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com> <20160301005032.GA15476@deathstar>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Mon, 29 Feb 2016 22:09:10 -0300
Message-ID: <CAKi4VAKBOge=-DcT9S7+uZWUte3EFNQ95u-fHCudRXZHqYuE1w@mail.gmail.com>
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
To: Michael Welling <mwelling@ieee.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	lkml <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 29, 2016 at 9:50 PM, Michael Welling <mwelling@ieee.org> wrote:
> On Fri, Feb 05, 2016 at 03:17:18PM +0200, Daniel Baluta wrote:
>> The driver has sysfs readings with runtime PM support for power saving.
>> It also offers buffer support that can be used together with IIO software
>> triggers.
>>
>
> Daniel,
>
> So I noticed something yesterday while testing new boards.
> The channels are occassionally swapping when accessing data from multiple channels.
>
> I wrote a simple bash script to demonstrate.

This happened to me in a previous version of the patch. I remember it
being fixed in the last version (or at least I could not reproduce).
I'll test again tomorrow with your script.

Lucas De Marchi
