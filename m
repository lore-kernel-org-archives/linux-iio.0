Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60376 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab2LKKaL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Dec 2012 05:30:11 -0500
Date: Tue, 11 Dec 2012 10:35:15 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Holler <holler@ahsoftware.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 3/3 v2] iio: add rtc-driver for HID sensors of type time
Message-ID: <20121211103515.5ecfa0ae@pyramind.ukuu.org.uk>
In-Reply-To: <50C677D9.5070109@ahsoftware.de>
References: <50C5DFCC.60203@ahsoftware.de>
	<1355151119-2489-1-git-send-email-holler@ahsoftware.de>
	<50C61675.2000407@metafoo.de>
	<50C6603E.5070909@ahsoftware.de>
	<50C66406.9090606@metafoo.de>
	<50C677D9.5070109@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 11 Dec 2012 01:01:29 +0100
Alexander Holler <holler@ahsoftware.de> wrote:

> Am 10.12.2012 23:36, schrieb Lars-Peter Clausen:
> > Well, I've been exaggerating a bit, you can call it multiple times, but you
> 
> Thanks a lot for the explanation(s).
> 
> >>>> +error_free_drvdata:
> >>>> +    platform_set_drvdata(pdev, NULL);
> >>>
> >>> Setting the platform data to NULL should not be necessary. Some
> >>> drivers do
> >>> this but it's kind of the result of cargo-cult-coding.
> >>>
> >>>> +    kfree(time_state);
> 
> Btw. I wouldn't call that cargo-cult-coding. It's more defensive 
> programming as people might not be sure, if there is something around 
> which still might access the platform data at that point. Ok, there 
> would be a need for a mutex or similiar if that really could happen, but 
> I wouldn't call such practices cargo-cult. ;)

Agreed - pointer NULLing catches a lot of mistakes during teardown where
timers or interrupts running in parallel get missed.

Alan
