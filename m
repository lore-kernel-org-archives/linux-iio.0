Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-221.synserver.de ([212.40.185.221]:1079 "EHLO
	smtp-out-221.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab3GPK1Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 06:27:25 -0400
Message-ID: <51E52036.7040400@metafoo.de>
Date: Tue, 16 Jul 2013 12:28:06 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	jonathan cameron <jic23@kernel.org>
Subject: Re: iio_trigger_poll_chained stop and trig->use_count always equals
 to 1
References: <5206767.5F4z6p4ukz@ctocwl0124>
In-Reply-To: <5206767.5F4z6p4ukz@ctocwl0124>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/16/2013 11:26 AM, Denis CIOCCA wrote:
> Hi all,
> 
> I need your help to understanding my strange issue...
> The scenario is that:
> 
> - I have one I2C device (microcontroller) that expose some sensors.
> - I wrote one driver that create one IIO device for each sensor.
> - There is only one trigger associated to all IIO devices, and one buffer for 
> each device.
> 
> When interrupt appear (DRDY of one or more sensors), the driver reads a mask 
> from micro to understand how many sensors have new data. After that, the 
> driver reads all new data from micro and save all data to one buffer. This is 
> done in a threaded irq function.
> 
> When iio_trigger_poll_chained is called, all data are saved to one common 
> buffer, each iio_triggered_buffer_setup functions is called and can split and 
> push their data to iio_buffer.
> 
> The issue is that: after some samples (about 50:100) the 
> iio_trigger_poll_chained doesn't call the iio_triggered_buffer_setup functions 
> and trig->use_count is always equals to 1.
> 

Yea, there is a race condition. Try this patch:
http://www.spinics.net/lists/linux-iio/msg08710.html

- Lars
