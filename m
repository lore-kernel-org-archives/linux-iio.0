Return-Path: <lars@metafoo.de>
Message-ID: <54271FA1.7050902@metafoo.de>
Date: Sat, 27 Sep 2014 22:35:45 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging:iio:ad5933: Fix NULL pointer deref when
 enabling buffer
References: <1411655235-7635-1-git-send-email-lars@metafoo.de> <542684D9.3010703@kernel.org>
In-Reply-To: <542684D9.3010703@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/27/2014 11:35 AM, Jonathan Cameron wrote:
>> Fixes: 959d2952d124 ("staging:iio: make iio_sw_buffer_preenable much more general.")
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Yikes, that was some time ago.  Anyhow, applied to the fixes-togreg branch of
> iio.git
> though given timing it won't go in until after the merge window.
> Also marked for stable.

Thanks.

>
> I'm not 100% sure how one marks a patch as for only onwards from a particular tree.
> There is syntax for saying cherry pick.  Hopefully the fixes tag will do the job.

Yes, the fixes tag usually does the right thing.
