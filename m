Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36739 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbaBRIjc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 03:39:32 -0500
Message-ID: <53031C67.8060202@kernel.org>
Date: Tue, 18 Feb 2014 08:40:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC]coding style for NULL pointer checks
References: <5300ACC6.90509@gmx.de> <530109DE.3010607@metafoo.de>
In-Reply-To: <530109DE.3010607@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/02/14 18:56, Lars-Peter Clausen wrote:
> On 02/16/2014 01:19 PM, Hartmut Knaack wrote:
>> Hi together,
>> I noticed, that many pointers in the IIO subsystem are checked for successful allocation in the way of "if (pointer == NULL)" or "if (pointer != NULL)", while in a few cases the form of simply "if (!pointer)" or "if (pointer)" is used. So, is there any interest in having a more consistent style, and if so, for which one?
>> My personal preference is for the latter one.
>
> I think enforcing this is a bit to much nitpicking. So if you clean this up the other pattern will probably appear again in new drivers at some point.
>
> Otherwise, if you feel strongly about this, go ahead and send a patch.
My inclination on this is that there are better things to spend time on
but as they say scratch the itch if you really want to!

I'd rather have the nice error patch cleanups you've been doing or
if you are really bored, there are lots of staging drivers in need of
tendour loving care!

J


