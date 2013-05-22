Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:37009 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752232Ab3EVIFD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 04:05:03 -0400
Message-ID: <519C7C29.9040707@jic23.retrosnub.co.uk>
Date: Wed, 22 May 2013 09:04:57 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Guillaume Ballet <gballetwork@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Why is only one int returned in iio_read_channel_processed?
References: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com>
In-Reply-To: <CAGi_vrjcy=pB93FT8XrNHNZZb82RT=0YEbjds3PU4L4OstFgGQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/13 08:49, Guillaume Ballet wrote:
> Hello,
>
> The read_raw operation in iio_info has a signature that takes two
> integer as in/out parameters. This lets the driver return values with
> micro- or nano-unit precision.
>
> However, the high-level iio_read_channel_raw and
> iio_read_channel_processed
Do we even have an iio_read_channel_processed? I think you are referring
to the in kernel consumer interface.  In iio/consumer.h we have an 
iio_read_channel_raw but unless I am going mad no 
iio_read_channel_processed (as of yet).

https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/include/linux/iio/consumer.h?h=togreg
(is the latest development tree).

Which tree are you looking at?

> functions' signature only has one integer
> in/out parameter. That makes sense in the context of _raw because the
> value isn't yet processed.
>
> However, as the scale is a number encoded over two ints, the
> _processed value should also span two ints. Is there a reason why it's
> still only one int?
No it certainly should not be one int for exactly the reasons you have 
stated.
>
> Thanks,
> Guillaume
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

