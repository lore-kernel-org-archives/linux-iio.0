Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44065 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759193Ab3EGJUF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 7 May 2013 05:20:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1UZe43-0005Cb-4e
	for linux-iio@vger.kernel.org; Tue, 07 May 2013 11:20:03 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2013 11:20:03 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2013 11:20:03 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 2/2] iio: ak8975: Implement data ready interrupt handling
Date: Tue, 07 May 2013 11:17:11 +0200
Message-ID: <kmagqi$guj$2@ger.gmane.org>
References: <1366123040-17917-1-git-send-email-j.anaszewski@samsung.com> <1366123040-17917-3-git-send-email-j.anaszewski@samsung.com> <5187DF32.7060107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <5187DF32.7060107@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/2013 06:49 PM, Jonathan Cameron wrote:
> On 04/16/2013 03:37 PM, Jacek Anaszewski wrote:
>> Implement "data ready" interrupt handling in addition to the
>> two existing read modes - DRDY GPIO polling and ST1 register
>> DRDY bit polling.
>>
>> Signed-off-by: Jacek Anaszewski<j.anaszewski@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>> Cc: Andrew Chew<achew@nvidia.com>
>
> Allowing either the gpio or the interrupt is a little ususual, but
> I suppose does avoid having to change existing users to gain interrupt
> support (if their gpio subsystem happens to support interrupts).

Thanks for the review. I am going to send new series promptly.

Regarding the gpio issue - I can imagine the situation when there is no 
available interrupt pin at the CPU, as they were all connected to the 
other devices, there are some free general purpose pins though. It is 
always better to have a possibility to periodically read the state of
such a pin, instead of performing cycling I2C transmission to check the 
status of DRDY bit in the ST1 register, which is a fallback in the driver.

Thanks,
Jacek Anaszewski

