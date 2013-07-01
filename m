Return-Path: <akpm@linux-foundation.org>
Date: Mon, 1 Jul 2013 15:20:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Maxime Ripard
 <maxime.ripard@free-electrons.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: inkern: fix iio_convert_raw_to_processed_unlocked
Message-Id: <20130701152004.cfddc36e7b3d9d63e1960514@linux-foundation.org>
In-Reply-To: <1372696809-14661-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372696809-14661-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Mon,  1 Jul 2013 18:40:09 +0200 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> When reading IIO_CHAN_INFO_OFFSET, the return value of iio_channel_read() for
> success will be IIO_VAL*, checking for 0 is not correct.

I have a canned response:

When writing a changelog, please describe the end-user-visible effects
of the bug, so that others can more easily decide which kernel
version(s) should be fixed, and so that downstream kernel maintainers
can more easily work out whether this patch will fix a problem which
they or their customers are observing.

> Cc: <stable@vger.kernel.org> # 3.10.x

Especially when cc'ing -stable.
