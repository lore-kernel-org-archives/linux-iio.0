Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <F244A294-8B78-4A9C-BB0B-268AFCC3EC5C@kernel.org>
References: <1416230316-14511-1-git-send-email-daniel.baluta@intel.com>
	<F244A294-8B78-4A9C-BB0B-268AFCC3EC5C@kernel.org>
Date: Mon, 17 Nov 2014 17:09:16 +0200
Message-ID: <CAEnQRZCa07iOt5baDHaH4-wNNYsP7rOf5Sixs+yndNo5-OP4kQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] kmx61: Small cleanups
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 17, 2014 at 4:59 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> On November 17, 2014 1:18:34 PM GMT+00:00, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>This is a small cleanup patchset, that:
>>       * makes it clear that kmx61 uses only the micro part of scale
>>       * use macro instead of hardcoded value for driver name
>>
>>Jonathan, if you think it's worth it, these could be squased together
>>with
>>the initial patch submitted in testing:
>>       61ef04a496 (iio: imu: Add support for Kionix KMX61 sensor)
>>
>
> Given the additional bits from Peter, I don't mind pulling the original and applying an updated patch.

I prefer this :). I will send an updated patch with fixes reported by Peter.

>
> Additional changes like this are fine as well if you prefer.

I am almost done with adding support for runtime PM. Let me know
if you want this as a separate patch or just one big updated patch.

Daniel.
