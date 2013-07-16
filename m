Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog125.obsmtp.com ([207.126.144.159]:42550 "EHLO
	eu1sys200aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932438Ab3GPN0z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 16 Jul 2013 09:26:55 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	jonathan cameron <jic23@kernel.org>
Date: Tue, 16 Jul 2013 15:26:16 +0200
Subject: Re: iio_trigger_poll_chained stop and trig->use_count always equals
 to 1
Message-ID: <1405801.Tk0FNxtVJJ@ctocwl0124>
References: <5206767.5F4z6p4ukz@ctocwl0124> <51E52036.7040400@metafoo.de>
In-Reply-To: <51E52036.7040400@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

thank you very much, now it works fine!

Only one thing:
- In your patch I think there is a mistake on iio_trigger_poll_chained 
function: generic_handle_irq should be replaced by handle_nested_irq.

Thanks,
Denis


On Tuesday, July 16, 2013 12:28:06 PM Lars-Peter Clausen wrote:
> On 07/16/2013 11:26 AM, Denis CIOCCA wrote:
> > Hi all,
> > 
> > I need your help to understanding my strange issue...
> > The scenario is that:
> > 
> > - I have one I2C device (microcontroller) that expose some sensors.
> > - I wrote one driver that create one IIO device for each sensor.
> > - There is only one trigger associated to all IIO devices, and one buffer
> > for each device.
> > 
> > When interrupt appear (DRDY of one or more sensors), the driver reads a
> > mask from micro to understand how many sensors have new data. After that,
> > the driver reads all new data from micro and save all data to one buffer.
> > This is done in a threaded irq function.
> > 
> > When iio_trigger_poll_chained is called, all data are saved to one common
> > buffer, each iio_triggered_buffer_setup functions is called and can split
> > and push their data to iio_buffer.
> > 
> > The issue is that: after some samples (about 50:100) the
> > iio_trigger_poll_chained doesn't call the iio_triggered_buffer_setup
> > functions and trig->use_count is always equals to 1.
> 
> Yea, there is a race condition. Try this patch:
> http://www.spinics.net/lists/linux-iio/msg08710.html
> 
> - Lars