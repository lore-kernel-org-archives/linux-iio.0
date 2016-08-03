Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34068 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758123AbcHCUDH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2016 16:03:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so37952086wma.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Aug 2016 13:02:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e983e54-9de4-8fe8-477f-9dd0263b0f32@metafoo.de>
References: <1470111916-9104-1-git-send-email-mranostay@gmail.com> <9e983e54-9de4-8fe8-477f-9dd0263b0f32@metafoo.de>
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 3 Aug 2016 13:02:12 -0700
Message-ID: <CAKzfze8vkmGwEX5Us4+K83pJp8vocgZfGVXDmivn+HYfe6hcrg@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: ams-iaq-core: update driver name and DT
 match table
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 3, 2016 at 5:13 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/02/2016 06:25 AM, Matt Ranostay wrote:
>> DT match name should be similar to the i2c device table entry.
>
> Why?

To be consistent mostly.   But I have noticed  compatible =
"ams,iaq-core" doesn't actually match...
Does anyone here know if i2c-core just checks the id_table, and not
of_match_table as well?

Anyone have thoughts on this but I dig into this too deep?

>
