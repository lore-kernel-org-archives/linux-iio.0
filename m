Return-Path: <lars@metafoo.de>
Message-ID: <5493016D.7000602@metafoo.de>
Date: Thu, 18 Dec 2014 17:31:41 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH v2] iio: ensure scan index is unique at buffer register
References: <1418394390-19690-1-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1418394390-19690-1-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/12/2014 03:26 PM, Vlad Dogaru wrote:
> Having two or more channels with the same positive scan_index field
> makes no sense.  Prevent this situation by failing to register a buffer
> if two scan indexes are identical.
>
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>

Looks ok, although I'm not convinced that we really need it.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

[...]
