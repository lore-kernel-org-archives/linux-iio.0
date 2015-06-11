Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:34556 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbbFKCPX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2015 22:15:23 -0400
Message-ID: <0892d019fa0f8ce4d040c106333aef83.squirrel@mungewell.org>
In-Reply-To: <76810d0b37fef1d1bcbb120b8e5ddfc9.squirrel@mungewell.org>
References: <76810d0b37fef1d1bcbb120b8e5ddfc9.squirrel@mungewell.org>
Date: Wed, 10 Jun 2015 22:15:21 -0400
Subject: Re: Newb: Can't start buffer with iio_dummy
From: simon@mungewell.org
To: simon@mungewell.org
Cc: linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Hi,
> Trying to get started with iio and having problems with the iio_dummy
> module. I don't have real iio hardware on this machine (or any other).

Ah, figured it out. Confusion between events and triggers.

You can make fake triggers with
--
# modprobe iio_dummy
# modprobe iio-trig-sysfs
# cd /sys/bus/iio/devices
# echo 1 > iio_sysfs_trigger/add_trigger
# cat trigger0/name > iio\:device0/trigger/current_trigger
# echo 100 > iio\:device0/buffer/length
# echo 1 > iio\:device0/scan_elements/in_voltage0_en
# echo 1 > iio\:device0/buffer/enable
# echo 1 > trigger0/trigger_now
--

Now I can see a line for each trigger occurrence.
--
# hexdump -v -e '16/1 "%02x " "\n"' < /dev/iio\:device0
07 00 ea d9 00 88 ff ff 9a 81 97 31 6e 8c e6 13
07 00 ea d9 00 88 ff ff 03 28 10 99 6e 8c e6 13
07 00 ea d9 00 88 ff ff b1 84 0d cd 6e 8c e6 13
07 00 ea d9 00 88 ff ff 79 84 6d f9 6e 8c e6 13
07 00 ea d9 00 88 ff ff f5 04 df 23 6f 8c e6 13
07 00 ea d9 00 88 ff ff ea fd e1 4c 6f 8c e6 13
--

Data is buffered while there is no consumer, and outputs any 'stored'
samples once the consumer (hexdump) is started.

Looking good,
Simon.

