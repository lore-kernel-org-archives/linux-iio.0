Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58692 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742Ab3GLUAS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2013 16:00:18 -0400
Message-ID: <51E06050.4040901@kernel.org>
Date: Fri, 12 Jul 2013 21:00:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: harald@ccbib.org
CC: linux-iio@vger.kernel.org
Subject: Re: humidity sensors
References: <E1UwWkL-0000pI-8V@stardust.g4.wien.funkfeuer.at> <51DC4FE0.1080402@kernel.org> <E1Uwfov-0000cI-Mb@stardust.g4.wien.funkfeuer.at> <500695c3-bb30-46e7-8fab-3ba32a01a246@email.android.com> <5bb3a4a786b9e02708d0b5dfeb7f570c@imap.cosmopool.net>
In-Reply-To: <5bb3a4a786b9e02708d0b5dfeb7f570c@imap.cosmopool.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/11/2013 08:43 PM, harald@ccbib.org wrote:
> On Wed, 10 Jul 2013 10:46:50 +0100, Jonathan Cameron <jic23@kernel.org>
> wrote:
>> Harald Geyer <harald@ccbib.org> wrote:
>>> I didn't look into this in detail yet, but porting the driver to
>>> hwmon probably isn't much more work than adding humidity
>>> support to IIO. Which way do you prefer?
>>
>> I don't really mind but as they have been controversial in hwmon perhaps
>> iio is a better bet.
> 
> Ok, so I'll prepare a patch to add humidity support and update the
> dht11-gpio driver accordingly.
> 
> One (hopefully) last question: Into which subdirectory should the
> dht11-gpio driver (temperature and humidity) go?
drivers/iio/humidity

(even if we get devices that measure it in the other ways, they can
share a directory!)
> 
> Harald
> 
