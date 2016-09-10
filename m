Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:33230 "EHLO fe2.pruts.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754945AbcIJSQ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Sep 2016 14:16:26 -0400
Content-Type: text/plain; charset=UTF-8
From: Ico Doornekamp <ico@pruts.nl>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: sca3000_core: Fix superfluous indent white space
In-reply-to: <50ce9913-92cc-8e1b-f8eb-2faec769622a@kernel.org>
References: <20160909174414.31002-1-ico@pruts.nl> <95f27ba9-d54c-3dad-6b33-217010ce55bd@kernel.org> <1473522932-sup-4169@pruts.nl> <50ce9913-92cc-8e1b-f8eb-2faec769622a@kernel.org>
Date: Sat, 10 Sep 2016 20:16:20 +0200
Message-Id: <1473530764-sup-9251@pruts.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* On 2016-09-10 18:26:45 +0200, Jonathan Cameron wrote:
 
> Another good one is to find things in staging drivers that we now
> have IIO_INFO_* elements for.
> 
> For example in sca3000 I see there is an explicit attribute defined that
> could be replaced by IIO_INFO_SAMPLING_FREQUENCY being added in the
> relevant masks and appropriate sections added to the read_raw
> and write_raw callbacks.
>
> Not a trivial job, but not too hard to figure out perhaps?

Not too hard, although I'm not able to actually run and test due to lack
of hardware.

> + a good step up from white space patches.

I do hope the Little Penguin agrees on this :)

> Guess maybe that needs to be a bit later if you are ploughing through
> the eudyptula-challenge (though that didn't exist when I got started
> so I don't know what order they do stuff in!)

I have no clue: I'm trying to stick to the steps and not peek ahead.

-- 
:wq
^X^Cy^K^X^C^C^C^C
