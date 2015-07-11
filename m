Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49024 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbbGKR6l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jul 2015 13:58:41 -0400
Message-ID: <55A1594F.1060204@kernel.org>
Date: Sat, 11 Jul 2015 18:58:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>
CC: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Multiple IIO_THRESHOLD events
References: <CAKzfze8sGEyU9DgDR4y2p3=5d+9024WgqgVw5fsv4b2XY1HH1g@mail.gmail.com>
In-Reply-To: <CAKzfze8sGEyU9DgDR4y2p3=5d+9024WgqgVw5fsv4b2XY1HH1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/15 18:23, Matt Ranostay wrote:
> Hello Jonathan,
> 
> I am currently working on temperature sensor that has multiple trip
> points, and was wondering what would be the correct way to tie this to
> one channel if several events may have the same IIO_EV_DIR_*
> direction.
> 
> low temp trippoint - > IIO_EV_DIR_FALLING
> high temp trippoint -> IIO_EV_DIR_RISING
> critical temp trippoint ->  ?
> 
> Would it make sensor to add functionality to allow iio_event_spec to
> have an .index field so multiple IIO_EV_DIR_RISING could be parsed
> into sysfs entries?
> 
> 
> Thanks,
> 
> Matt
> 
Hi Matt,

The few times this has come up before, the conclusion has been that
the device was actually more suited to have a hwmon driver than an IIO one.
We have had event units capable of being configured for this sort of operation
but have never actually implemented it.

You are quite correct in that we don't have a current way to support
it.  An index field and appropriate extension of the abi is fine.  However
you've also got to find somewhere in the event code to place it.
That's nastier from an ABI change point of view.

