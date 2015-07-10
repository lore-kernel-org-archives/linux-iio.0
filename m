Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:34224 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555AbbGJUBc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jul 2015 16:01:32 -0400
MIME-Version: 1.0
In-Reply-To: <55A01972.9070405@infradead.org>
References: <1436357088-30743-1-git-send-email-daniel.baluta@intel.com>
	<55A01972.9070405@infradead.org>
Date: Fri, 10 Jul 2015 23:01:31 +0300
Message-ID: <CAEnQRZBKOG0_RGi38oXNZoFF=T37P6a9++NB9m2v01i_nvYMUg@mail.gmail.com>
Subject: Re: [PATCH] DocBook documentation for IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Randy,

On Fri, Jul 10, 2015 at 10:13 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 07/08/15 05:04, Daniel Baluta wrote:
>> In our effort to support vendors writing drivers for their own
>> sensors we introduce IIO documentation in DocBook format.
>>
>> It documents Industrial I/O core including IIO devices, buffers, triggers and
>> triggered buffers. It also offers a short list of online resources
>> for the IIO subsystem.
>>
>> This is far from being complete any suggestions are welcomed. At a first
>> glance we also need to add documentation for events. We are also working
>> on auto-generating template drivers based on the type of the IIO sensors.
>
> Hi Daniel,
>
> This is a good start.  Might as well get it merged and keep improving it.

This sounds like a good plan.

>
> Here are a few nits:
>
> Warning(..//drivers/iio/industrialio-buffer.c:1145): cannot understand function prototype: 'struct iio_demux_table '
>
>>> drop the "()" in the first line:
>  * struct iio_demux_table() - table describing demux memcpy ops
>
>
> In iio_buffer_get() and iio_buffer_put(), change "may be NULL"
> to "may be %NULL".
>
> In linux/iio/iio.h, struct iio_chan_spec, the sub-fields of @scan_type confuse
> scripts/kernel-doc.  There isn't really a good way to do what you are trying
> to do (AFAIK).  The problem is that things like "realbits:" (ending with a colon)
> cause kernel-doc to think that that is some special comment and it generates
> a separate paragraph for it at the end of the struct.  I changed all of those
> colons to hyphens, but then kernel-doc just runs all of those sub-field
> comment descriptions together... so I added a ';' at the end of each one, but
> it doesn't look nice.

We now about the warnings. Cristina is already working on a patch series to fix
them.

thanks,
Daniel.
