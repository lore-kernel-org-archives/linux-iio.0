Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36517 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab3HRKTg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 18 Aug 2013 06:19:36 -0400
Message-ID: <5210ADC3.6090704@kernel.org>
Date: Sun, 18 Aug 2013 12:19:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com
Subject: Re: [PATCH/RFC v4 0/3] gp2ap020a00f ambient light/proximity sensor
References: <1376658684-3267-1-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1376658684-3267-1-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/16/13 14:11, Jacek Anaszewski wrote:
> This driver supports:
>  - reading channels in 'one shot' mode through read_raw callback,
>  - four events - rising and falling ambient light events and
>    rising and falling proximity roc events.
>  - triggers for all the three channels (triggers can't be enabled
>    simultaneosly with proximity detection event)
> 
> This is a follow-up of the previous patch and it includes
> following improvements (Jonathan - thanks for the review)
>   - switched over to using devm_iio_device_alloc
>   - switched over to using devm_request_threaded_irq
>   - switched over to using newly implemented managed allocator
>     for iio_trigger
>   - simplified error handling path in the probe function
>   - switched over to using standard endian conversion
>     functions
>   - removed redundant debugfs interface
>   - removed local reg_mask variables from gp2ap020a00f_set_operation_mode
> 
> Jonathan, I'd like to also make sure that you've seen my emails
> in the threads related to the first and the second version of this RFC.
> I asked there some vital questions related to this driver but they are
> left unanswered. I will repeat them here:
oops. I'm awful at responding to tricky questions / or reading cover
letters.  Sorry about that.
> 
>   - I am getting warning while calling iio_trigger_poll, and I am not
>     sure if it is acceptable:
> 
>     WARNING: at kernel/irq/handle.c:146handle_irq_event_percpu+0x2a4/0x2b4()
>     irq 8 handler iio_pollfunc_store_time+0x0/0x38 enabled interrupts
Drat, I'd missed this entirely. The issue here is that your trigger has
to sleep (and hence occurs in a bottom half) in order to work out what it is
receiving (event or dataready).  Triggers are actually interrupt chips thus
the top half is expected to be called in interrupt context but you've already
left it in this case.  Hence there are two options... Either don't allow for a
top half and call iio_trigger_poll_chained instead (which will only call the
bottom halfs) or do it in a similar fashion to that done in the sysfs trigger.
(drivers/iio/triggers/iio-trig-sysfs) This uses an irq_work structure
to jump back into interrupt context and call the iio_trigger_poll successfully.

We probably need to check for other drivers suffering this issue.  Mostly
hardware uses separate physical pins for events vs data ready so this isn't
that common. I know some ST devices do this.  This always made the lis3l02dq
driver a pain to deal with (though now the that the irq_work stuff exists
that should be easy to tidy up).

> 
>   - I am still encountering "module in use" message when I am trying
>     to execute rmmod on a driver module after generic_buffer application
>     has been launched at least once. This is not specific only to my
>     implementation but also for lps331ap driver (the only one of the 
>     remaining IIO drivers supporting triggers I am able to test
>     currently).
Umm.. I'm unsure, but it 'might' be something to do with the interrupt issues
that are firing the above warning (though I doubt it as the lps331ap isn't
suffering from that bug - as it currently stands in tree).
Check that all the sysfs entries are as one would expect (no trigger attached
or buffered enabled etc).  Might be a bug in generic_buffer but I haven't
personally seen it do this.

>   - The scale value for the illuminance_clear channel changes dynamically,
>     depending on the lux mode set. I think that currently IIO isn't
>     prepared for such a situation?

Indeed not.  The overhead to indicate this in buffered mode will completely
defeat the object of having that so lightweight.  My suggestion would be
to apply the scale to the data before pushing it to the driver.  Clearly
this may result in needing more space in the buffer storage, but thats
still cleaner than having an explicit way to detecting that the scale
of the device has automatically changed.  We have only so far seen this
auto scaling done in light sensors and right now I think yours may be
the only one that does buffered output rather than just being polling on
sysfs (in which the conversions to lux are typically done including
any such scaling).
> 
> Besides the above I've detected that write_event_config callback
> is called even if the state to be set is already set. This poses
> an issue for me, as if it is done by design then I have to handle
> it in my driver.

The core 'could' call read_event_config to get whether the state is
already set, but there is no advantage in doing that over simply
doing the check in the driver itself that I can see.  Hence I'd
expect that logic to be in the driver. Feel free to propose otherwise
and we can see if there is a strong feeling out there about one way
or the other.

> 
> Thanks,
> Jacek Anaszewski
> 
> Jacek Anaszewski (1):
>   iio: gp2ap020a00f: Add a driver for the device
> 
>  .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   20 +
>  drivers/iio/light/Kconfig                          |   12 +
>  drivers/iio/light/Makefile                         |    1 +
>  drivers/iio/light/gp2ap020a00f.c                   | 1473 ++++++++++++++++++++
>  4 files changed, 1506 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
>  create mode 100644 drivers/iio/light/gp2ap020a00f.c
> 
