Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:32855 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754057Ab3ENRy2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 May 2013 13:54:28 -0400
Message-ID: <51927AEF.6080107@metafoo.de>
Date: Tue, 14 May 2013 19:57:03 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: Use buffer without trigger
References: <CAEE_umrLpNJo1kMbLtktK0RH6WCKCEYR+yiTiyPJu_8G3coE7A@mail.gmail.com> <CAEE_umq7aC5=HWAW_2N=XsLJ0y6YqBojjN0Awm3BuGmqHSzrsw@mail.gmail.com>
In-Reply-To: <CAEE_umq7aC5=HWAW_2N=XsLJ0y6YqBojjN0Awm3BuGmqHSzrsw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/14/2013 06:18 PM, Denis Ciocca wrote:
> Hi all,
> 
> I have one question about iio device. I want create with only one physical
> device a lot of iio devices because I want to activate each 'sensor'
> without stop the buffer and reactivate with more channels.
> But, I want to use only one trigger, for example of the major iio device.
> It is possible to register only a buffer of one device and use the trigger
> of another one?

Simple answer: yes.

- Lars
