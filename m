Return-Path: <rdunlap@infradead.org>
Message-ID: <55A01972.9070405@infradead.org>
Date: Fri, 10 Jul 2015 12:13:54 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org
CC: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] DocBook documentation for IIO
References: <1436357088-30743-1-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1436357088-30743-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 07/08/15 05:04, Daniel Baluta wrote:
> In our effort to support vendors writing drivers for their own
> sensors we introduce IIO documentation in DocBook format.
> 
> It documents Industrial I/O core including IIO devices, buffers, triggers and
> triggered buffers. It also offers a short list of online resources
> for the IIO subsystem.
> 
> This is far from being complete any suggestions are welcomed. At a first
> glance we also need to add documentation for events. We are also working
> on auto-generating template drivers based on the type of the IIO sensors.

Hi Daniel,

This is a good start.  Might as well get it merged and keep improving it.

Here are a few nits:

Warning(..//drivers/iio/industrialio-buffer.c:1145): cannot understand function prototype: 'struct iio_demux_table '

>> drop the "()" in the first line:
 * struct iio_demux_table() - table describing demux memcpy ops


In iio_buffer_get() and iio_buffer_put(), change "may be NULL"
to "may be %NULL".

In linux/iio/iio.h, struct iio_chan_spec, the sub-fields of @scan_type confuse
scripts/kernel-doc.  There isn't really a good way to do what you are trying
to do (AFAIK).  The problem is that things like "realbits:" (ending with a colon)
cause kernel-doc to think that that is some special comment and it generates
a separate paragraph for it at the end of the struct.  I changed all of those
colons to hyphens, but then kernel-doc just runs all of those sub-field
comment descriptions together... so I added a ';' at the end of each one, but
it doesn't look nice.


> Generated html files should be available online here http://dbaluta.github.io/
> or you could run make htmldocs in the root of your kernel repo to get them.
> 
> Daniel Baluta (1):
>   DocBook: Add initial documentation for IIO
> 
>  Documentation/DocBook/Makefile |   2 +-
>  Documentation/DocBook/iio.tmpl | 588 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 589 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/DocBook/iio.tmpl
> 


-- 
~Randy
