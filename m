Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44075 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbcJ3U3R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 16:29:17 -0400
In-Reply-To: <20161030200409.GA14808@basecamp.onstation.org>
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org> <1477648821-3786-8-git-send-email-masneyb@onstation.org> <a0fc532f-f034-d817-00f6-a28ec60daf6a@kernel.org> <20161030200409.GA14808@basecamp.onstation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 07/10] staging: iio: tsl2583: convert illuminance0_calibscale sysfs attr to use iio_chan_spec
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sun, 30 Oct 2016 20:29:07 +0000
To: Brian Masney <masneyb@onstation.org>,
        Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, lars@metafoo.de, pmeerw@pmeerw.net,
        knaack.h@gmx.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Mark.Rutland@arm.com
Message-ID: <AB13BE14-F431-4E0B-8C4C-8EF59CB13720@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 30 October 2016 20:04:09 GMT+00:00, Brian Masney <masneyb@onstation.org> wrote:
>On Sun, Oct 30, 2016 at 06:37:40PM +0000, Jonathan Cameron wrote:
>> On 28/10/16 11:00, Brian Masney wrote:
>> > The illuminance0_calibscale sysfs attribute is not currently
>created by
>> > the IIO core. This patch adds the appropriate mask to
>iio_chan_spec,
>> > along with the appropriate data handling in the read_raw() and
>> > write_raw() functions, so that the sysfs attribute is created by
>the IIO
>> > core. With this change, this sysfs entry will have its prefix
>changed
>> > from illuminance0_ to in_illuminance_.
>> > 
>> > Signed-off-by: Brian Masney <masneyb@onstation.org>
>> Hmm. Could probably have computed the mean on the fly but fine as is.
>
>Hi Jonathan,
>   Thanks for your feedback. I'll have another patch set ready for you
>by next weekend with my next round of cleanups to that driver. I'll
>change this so that it calculates the mean on the fly unless I hear
>otherwise from you.

I don't worry about the mean change. Not worth changing to my mind.

J
>
>Brian
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
