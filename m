Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:53046 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbbFKAta (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2015 20:49:30 -0400
Received: from localhost ([127.0.0.1] helo=mungewell.org)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1Z2qgS-0007jh-Rn
	for linux-iio@vger.kernel.org; Wed, 10 Jun 2015 20:49:28 -0400
Message-ID: <76810d0b37fef1d1bcbb120b8e5ddfc9.squirrel@mungewell.org>
Date: Wed, 10 Jun 2015 20:49:28 -0400
Subject: Newb: Can't start buffer with iio_dummy
From: simon@mungewell.org
To: linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,
Trying to get started with iio and having problems with the iio_dummy
module. I don't have real iio hardware on this machine (or any other).

I think that in order to trigger the buffer I can use the 'poke_ev0'
event, but whenever I attempt to start the buffer I get:
--
# modprobe iio_dummy
# cd /sys/bus/iio/devices/iio\:device0
# echo 'poke_ev0' > trigger/current_trigger
# echo 1 > scan_elements/in_voltage0_en
# echo 100 > buffer/length
# echo 1 > buffer/enable
bash: echo: write error: Invalid argument
--

Current trigger returns nothing....
--
# cat trigger/current_trigger
# ls /sys/bus/iio/devices/iio_evgen
poke_ev0  poke_ev2  poke_ev4  poke_ev6  poke_ev8  power      uevent
poke_ev1  poke_ev3  poke_ev5  poke_ev7  poke_ev9  subsystem
--

I Google'd around but there does not seem to be a How-to/Example on line.
I'm using 4.1.0-rc7.
Simon.


