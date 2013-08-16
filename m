Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19780 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab3HPNLg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2013 09:11:36 -0400
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH/RFC v4 0/3] gp2ap020a00f ambient light/proximity sensor
Date: Fri, 16 Aug 2013 15:11:24 +0200
Message-id: <1376658684-3267-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver supports:
 - reading channels in 'one shot' mode through read_raw callback,
 - four events - rising and falling ambient light events and
   rising and falling proximity roc events.
 - triggers for all the three channels (triggers can't be enabled
   simultaneosly with proximity detection event)

This is a follow-up of the previous patch and it includes
following improvements (Jonathan - thanks for the review)
  - switched over to using devm_iio_device_alloc
  - switched over to using devm_request_threaded_irq
  - switched over to using newly implemented managed allocator
    for iio_trigger
  - simplified error handling path in the probe function
  - switched over to using standard endian conversion
    functions
  - removed redundant debugfs interface
  - removed local reg_mask variables from gp2ap020a00f_set_operation_mode

Jonathan, I'd like to also make sure that you've seen my emails
in the threads related to the first and the second version of this RFC.
I asked there some vital questions related to this driver but they are
left unanswered. I will repeat them here:

  - I am getting warning while calling iio_trigger_poll, and I am not
    sure if it is acceptable:

    WARNING: at kernel/irq/handle.c:146handle_irq_event_percpu+0x2a4/0x2b4()
    irq 8 handler iio_pollfunc_store_time+0x0/0x38 enabled interrupts

  - I am still encountering "module in use" message when I am trying
    to execute rmmod on a driver module after generic_buffer application
    has been launched at least once. This is not specific only to my
    implementation but also for lps331ap driver (the only one of the 
    remaining IIO drivers supporting triggers I am able to test
    currently).
  - The scale value for the illuminance_clear channel changes dynamically,
    depending on the lux mode set. I think that currently IIO isn't
    prepared for such a situation?

Besides the above I've detected that write_event_config callback
is called even if the state to be set is already set. This poses
an issue for me, as if it is done by design then I have to handle
it in my driver.

Thanks,
Jacek Anaszewski

Jacek Anaszewski (1):
  iio: gp2ap020a00f: Add a driver for the device

 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   20 +
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/gp2ap020a00f.c                   | 1473 ++++++++++++++++++++
 4 files changed, 1506 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
 create mode 100644 drivers/iio/light/gp2ap020a00f.c

-- 
1.7.5.4

