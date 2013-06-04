Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:60024 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752064Ab3FDLKY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Jun 2013 07:10:24 -0400
Subject: Re: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub devices to regmap interface
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Pantelis Antoniou <panto@antoniou-consulting.com>
In-Reply-To: <20130604110532.GJ1151@linutronix.de>
Date: Tue, 4 Jun 2013 14:10:20 +0300
Cc: Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Message-Id: <FBB90884-C774-4981-A5BA-26B498B19D76@antoniou-consulting.com>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-13-git-send-email-bigeasy@linutronix.de> <51AB84F5.2030405@kernel.org> <20130604102318.GC1151@linutronix.de> <F58DCC19-20B7-4385-B323-C1A2E5F22641@antoniou-consulting.com> <20130604105210.GI1151@linutronix.de> <4AA621AD-5273-444C-875C-05486CC810A8@antoniou-consulting.com> <20130604110532.GJ1151@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Jun 4, 2013, at 2:05 PM, Sebastian Andrzej Siewior wrote:

> * Pantelis Antoniou | 2013-06-04 13:54:48 [+0300]:
> 
>> What make you think I am the original author?
> Nothing, you just made _this_ patch.
> 

I'm the author of that patch that fixes it, I'm not the author of the original driver.

>> I just fixed whatever I had to fix to get it working.
> Fair enough.
> 
>> Namely that the multi function device was using regmap in one place and
>> not in another, which had the nice effect of the regmap cache getting out of sync.
> 
> Yeah, that is a pain. Currently I think why we do need regmap at all
> here and I think about getting rid of it. Most of the values read here
> need no caching at all.
> 

You need to talk to the original driver author then.

>> Regards
>> 
>> -- Pantelis
> 
> Sebastian

Regards

-- Pantelis

