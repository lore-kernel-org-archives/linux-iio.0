Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54309 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbbCNOAs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 10:00:48 -0400
Message-ID: <55016AC3.2060704@kernel.org>
Date: Thu, 12 Mar 2015 10:30:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
CC: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>, devicetree@vger.kernel.org,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 6/7] iio: mlx90614: Add power management
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com> <1424879712-28304-7-git-send-email-vianney.leclement@essensium.com> <54FDBEB7.8030403@kernel.org> <20150309164308.GA2320@katana>
In-Reply-To: <20150309164308.GA2320@katana>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/15 16:43, Wolfram Sang wrote:
> On Mon, Mar 09, 2015 at 03:39:35PM +0000, Jonathan Cameron wrote:
>> On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
>>> Add support for system sleep and runtime power management.
>>>
>>> To wake up the device, the SDA line should be held low for at least 33ms
>>> while SCL is high.  As this is not possible using the i2c API (and not
>>> supported by all i2c adapters), a GPIO connected to the SDA line is
>>> needed.  The GPIO is named "wakeup" and can be specified in a device
>>> tree with the "wakeup-gpios" binding.
>> Needs some i2c specialist input on this!  As you mentioned it is liable
>> to be controversial.  Wolfram, is this a one off special or do
>> any other devices do this sort of magic?
> 
> s/magic/insanity/ :)
> 
> I have never heard of something like this. Unsuprisingly, I can
> not recommend doing it this way. But we all know hardware...
> 
> And while we could think about reusing the bus_recovery_infrastructure,
> I don't think it is worth the hazzle. So, doing this GPIO fallback may
> well be the best we can do now.
> 
Fair enough.  Lets go with this approach then and hope this is the only bit
of hardware ever to do this (yeah right ;)

