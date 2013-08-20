Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39430 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab3HTOu6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2013 10:50:58 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU0046I3WW34B0@mailout2.w1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 20 Aug 2013 15:50:56 +0100 (BST)
Message-id: <52138250.6040101@samsung.com>
Date: Tue, 20 Aug 2013 16:50:56 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>,
	linux-iio@vger.kernel.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	s.nawrocki@samsung.com
Subject: Re: [PATCH/RFC v4 2/3] iio: gp2ap020a00f: Add a driver for the device
References: <1376658739-3417-1-git-send-email-j.anaszewski@samsung.com>
 <520FD862.3070802@kernel.org>
In-reply-to: <520FD862.3070802@kernel.org>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/17/2013 10:09 PM, Jonathan Cameron wrote:
> On 08/16/13 14:12, Jacek Anaszewski wrote:
>> Add a new driver for the ambient light/proximity sensor
>> device. The driver exposes three channels: light_clear
>> light_ir and proximity. It also supports triggered buffer,
>> high and low ambient light threshold event and proximity
>> detection events.
>>
>> Signed-off-by: Jacek Anaszewski<j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Kyungmin Park<kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> Looking good but a few little bits and pieces left.
> Superfluous !! when converting to boolean.
> If the proximity detection cannot start with thresholds set to
> the current value then fail to start it, don't fudge the variables.
>
> One question that comes to mind as well.  Does the chip always return
> a value in the same units whatever scale is being applied?  If so then
> all is fine (and this is a cleverer chip than commonly seen!).

The chip can be set into two modes: manual and auto calculation.
In the manual mode it outputs the result of CLEAR photodiode
in D0 register and the result of IR photodiode in D1 register.
Illuminance value can be obtained by making some calculation
basing on these two values and some variables factors.
In the auto calculation mode it outputs the calculated result
without the influence of infrared spectrum in lux units to the
D0 register. In addition raw IR result is stored in the D1 register.

In the recent patch I switched over to using auto calculation mode
to avoid the problems with dynamically changing scale value.

> Otherwise how does userspace know what it is getting?

This was my concern when I asked in the other email how
to inform the user what scale has been applied.

Thanks,
Jacek
