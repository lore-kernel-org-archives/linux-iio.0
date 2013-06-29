Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41858 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab3F2JqC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 05:46:02 -0400
Message-ID: <51CEACD8.7070804@kernel.org>
Date: Sat, 29 Jun 2013 10:46:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add ds1077 programmable oscillator driver
References: <1371938043-3865-1-git-send-email-pmeerw@pmeerw.net> <51C87806.5000700@metafoo.de> <alpine.DEB.2.01.1306241932420.13960@pmeerw.net> <51C8887D.4080406@metafoo.de>
In-Reply-To: <51C8887D.4080406@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/24/2013 06:57 PM, Lars-Peter Clausen wrote:
> On 06/24/2013 07:47 PM, Peter Meerwald wrote:
>> Hello,
>>
>>> Hm, I wonder where we should draw the line between what should be
>>> implemented as a IIO driver and what should be implemented as a clk API
>>> driver. This one looks like it actually belongs into the clk framework.
>>
>> several IIO drivers have overlap with other kernel subsystems
> 
> Which is not a necessarily good.
> 
>>
>> I think the 'line' depends on the intended use/application of the driver, 
>> not so much on characteristics of the hardware; why do you think it 
>> belongs to clk?
> 
> But the usecase might differ from board to board and that's when you get a
> problem. One user wants a clk driver another a IIO driver.
> 
>>
>> the ds1077 is a small, separate chip which can generate a frequency; using 
>> IIO I can easily control that frequency from userspace
>>
>> clk seems to be targetted more at integrated clocksources that get 
>> activated automatically when needed by other components (maybe I am wrong)
> 
> 
> I think there is a userspace consumer for the clk API in the making.

Just to jump on the end of this conversation, sorry Peter but this one definitely
looks to me like it belongs clk rather than IIO. If there wasn't a userspace
API in the making, I'd suggest now was the time to propose one as you
clearly have an application for one.

Jonathan
