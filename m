Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30864 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932568AbcBWIgi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 23 Feb 2016 03:36:38 -0500
Message-ID: <56CC1A15.6020704@parrot.com>
Date: Tue, 23 Feb 2016 09:36:37 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Crt Mori <cmo@melexis.com>,
	Masanari Iida <standby24x7@gmail.com>
Subject: Re: [PATCH v3 1/1] iio:core: timestamping clock selection support
References: <cover.1456153753.git.gregor.boirie@parrot.com> <be5ff3a84a721d539414f81520bbce9c7c561fe1.1456153753.git.gregor.boirie@parrot.com> <E1aXvw9-0000bL-Gj@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1aXvw9-0000bL-Gj@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 02/22/2016 08:14 PM, Harald Geyer wrote:
> Hi Gregor!
Hi Harald,

[snip]

>   drivers/iio/humidity/dht11.c                      |  16 +-
> The dht11 driver only uses timestamps internally. AFAICT they are not
> exported to user space, so there is little point in making the clock
> selectable.
Ok. It seems no timestamping channel / events is exposed anyway: I 
suppose it
makes no sense to use the timestamping clock API in this case.
>
> What's more important: The timestamps are used to decide the validity
> of cached values. I think your change introduces a bug where the driver
> could report outdated (or even uninitialized) values to user space.
>
> (Actually we switched the driver to monotonic time just recently to fix
> this.)
I guess I should leave the dht11 driver completly untouched in my patch 
then.
Thanks for the quick feedback :)

[snip]

Regards,
Grégor.
