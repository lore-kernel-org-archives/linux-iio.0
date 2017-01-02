Return-Path: <SRS0=aWTH=YQ=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v3 2/2] staging: iio: ad7606: move out of staging
To: Jonathan Cameron <jic23@kernel.org>,
 Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <cover.1481424136.git.eraretuya@gmail.com>
 <406fd6f60db88f051b36bf6f28cfe8fc8b1acb32.1481424136.git.eraretuya@gmail.com>
 <9b5ec6ff-ed6b-f8a5-ea7f-967c00571268@kernel.org>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, daniel.baluta@gmail.com, amsfield22@gmail.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7fa7d6b2-541a-ccf8-83e4-10f1fb381fee@metafoo.de>
Date: Mon, 2 Jan 2017 19:33:07 +0100
MIME-Version: 1.0
In-Reply-To: <9b5ec6ff-ed6b-f8a5-ea7f-967c00571268@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 12/30/2016 09:16 PM, Jonathan Cameron wrote:
> On 11/12/16 02:47, Eva Rachel Retuya wrote:
>> Move the ad7606 driver from staging/iio/adc to iio/adc. Also, update the
>> corresponding Makefile and Kconfig associated with the change.
>>
>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Personally (and this is much debated ;) I prefer for the odd case
> of staging graduations, that git isn't run with the -M parameter so we
> have the whole driver to comment on.
> 
> Anyhow, just casting my eyes over the code so here are some notes:
> 1. The whole computing scale available values on the fly seems rather over the
> top as they can be easily precomputed and stored in a static const array.
> There are only 2 of them!
> 
> 2. There are some single line comments still using multiline syntax (now
> I'm really nitpicking ;)
> 
> 3. A slight oddity has crept in with the cleanup of attributes.  We now
> prevent the appearance of the _scale_available / oversampling_ratio_available
> attributes if the gpios are attached, but not _scale or _oversampling.
> (oops).  If we are going to do this dance, then we should also have an
> alternative set of iio_chan_spec array to reflect this.
> 
> 4. I'd drop the 'More devices added in future' comment. It's now the future
> and they haven't been yet ;)
> 

I actually have a patch adding more devices, that just waits for the driver
to be moved out of staging. But still the comment can be removed it is not
really meaningful.

> 5. We can write oversampling ratio, but queries to the write_get_fmt will
> return an error for that. Probably want to fix that unless I'm missing something.
> 
> 6. There are some ancient references to 'ring' buffers in the comments and
> function naming.  We switched over from my hand rolled ring buffer to the
> kfifo buffer we now use ages ago.  Would be nice to clear those out.
> 
> None of these are really blockers to it moving out of staging
> (except the bugs we introduced in the cleanup), but might be nice
> to do one last series pinning those down then get a final review done to
> see if we missed anything else.
> 
> Been a long time since I looked at this one in any depth and it's certainly
> heading in the right direction!
