Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.114]:41979 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751122AbaBSKMc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2014 05:12:32 -0500
Date: Wed, 19 Feb 2014 11:12:27 +0100
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/3] iio: adc: Add MEN 16z188 ADC driver
Message-ID: <20140219101227.GD16649@jtlinux>
References: <1392737654-22682-1-git-send-email-johannes.thumshirn@men.de>
 <1392737654-22682-4-git-send-email-johannes.thumshirn@men.de>
 <15736e39-f1b0-45b3-a70c-c81370cf49f1@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <15736e39-f1b0-45b3-a70c-c81370cf49f1@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 18, 2014 at 07:17:04PM +0000, Jonathan Cameron wrote:
>
>
> On February 18, 2014 3:34:14 PM GMT+00:00, Johannes Thumshirn <johannes.thumshirn@men.de> wrote:
> >Add support for MEN 16z188 ADC IP Core on MCB FPGAs.
> >
> >Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
> Looks pretty good apart from the nitpicks. One more little thing...

Thanks, I'll rework this and the comments from Peter Meerwald and Lars-Peter
Clausen in v2 of the patch series as well.

I think it'll be done by monday.

Thanks,
Johannes
