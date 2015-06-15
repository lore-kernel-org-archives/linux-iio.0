Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41361 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbbFOPE7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jun 2015 11:04:59 -0400
Received: from localhost ([127.0.0.1] helo=mungewell.org)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1Z4VwY-00088m-AG
	for linux-iio@vger.kernel.org; Mon, 15 Jun 2015 11:04:58 -0400
Message-ID: <2d05200efc42012bd16be4dde0fad85d.squirrel@mungewell.org>
Date: Mon, 15 Jun 2015 11:04:58 -0400
Subject: ST driver - ad-hoc allocation of trigger interrupt
From: simon@mungewell.org
To: linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,
A friend and I were attempting to get a LSM303DLHC breakout board hooked
up to the expansion header on the RaspPi yesterday - it was him doing the
work and me offering suggestions from afar (unfortunately the blind
leading the blind)...

Anyhow 'we' got reasonably far and could read raw value and trigger the
buffer via the 'iio-sysfs-trig'. The problem came when we wanted the
device to trigger itself at the set sample frequency.

We infer that we need to connect the DRDY signal to a CPU interrupt line,
but can't see how we tell the ST iio driver which one.

I did find this is the source:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/common/st_sensors/st_sensors_trigger.c?id=refs/tags/v4.1-rc8#n21

Which shows that the 'sdata->get_irq_data_ready()' can be pre-defined in
the data structure passed on driver init. But how can we do that from the
command line, or even a little script/app once the kernel is up and
running?


The story of our attempt is documented here:
https://groups.google.com/forum/?hl=en#!topic/richards-tech-user-forum/BjQpWjTmims

Any suggestions on how we can succeed?

Many thanks,
Simon.

