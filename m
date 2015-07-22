Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46557 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964874AbbGVQ3C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2015 12:29:02 -0400
In-Reply-To: <CA+0Dg4qeAvTJ1EJFqN4=eJ3X9qecP8yPhvBBvUs-pYqP08i3jA@mail.gmail.com>
References: <CA+0Dg4qeAvTJ1EJFqN4=eJ3X9qecP8yPhvBBvUs-pYqP08i3jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: iio_utils tool incorrectly assumes "offset" file to be present
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 22 Jul 2015 17:28:36 +0100
To: Joo Aun Saw <jasaw@dius.com.au>, linux-iio@vger.kernel.org,
	knaack.h@gmx.de
Message-ID: <E85353EF-6909-4FB1-A9D4-3A974F69CD97@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 22 July 2015 15:55:53 BST, Joo Aun Saw <jasaw@dius.com.au> wrote:
>Hi,
>
>I'm new to this mailing list and I'm new to IIO, so please forgive me
>if I ask silly questions. I haven't got time follow the latest
>development in IIO.
>
>I'm using iio_utils tool in my program and noticed build_channel_array
>function assumes "offset" file to be present under the IIO device. The
>issue is, not all IIO devices provide an "offset" file. I'm using ST
>accel, magn, and gyro drivers, and there's no "offset" file. Is offset
>supposed to be optional?
Yes.  That function should probably be checking for the -ENOENT return value
and setting the offset to 0 rather than faulting out.

Scale isn't required either and for some devices such a proximity sensors is not
 well defined (depends on the reflectance of the target)

Hatmut, I missed this when reviewing your patch adding error handling back in May (I think...)

53118557b6a9c263e4a80825da367b2116529541

>
>
>Joo.
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
