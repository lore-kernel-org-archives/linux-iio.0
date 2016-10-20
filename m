Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 2/2] staging: iio: ad7606: rework regulator handling
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
References: <1476968903-15771-1-git-send-email-eraretuya@gmail.com>
 <1476968903-15771-3-git-send-email-eraretuya@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e610e89b-0fd9-37db-7b38-ccccc912101b@metafoo.de>
Date: Thu, 20 Oct 2016 15:20:06 +0200
MIME-Version: 1.0
In-Reply-To: <1476968903-15771-3-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/20/2016 03:08 PM, Eva Rachel Retuya wrote:
> Currently, this driver ignores all errors from regulator_get(). The way
> it is now, it also breaks probe deferral (EPROBE_DEFER). The correct
> behavior is to propagate the error to the upper layers so they can
> handle it accordingly.
> 
> Rework the regulator handling so that it matches the standard behavior.
> If the specific design uses a static always-on regulator and does not
> explicitly specify it, regulator_get() will return the dummy regulator.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
