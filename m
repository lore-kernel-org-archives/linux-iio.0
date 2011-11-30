Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:38819 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab1K3NaK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2011 08:30:10 -0500
Received: from [192.168.0.41] (col31-4-88-188-83-94.fbx.proxad.net [88.188.83.94])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 577B113C
	for <linux-iio@vger.kernel.org>; Wed, 30 Nov 2011 14:30:00 +0100 (CET)
Message-ID: <4ED62FD2.4040500@free-electrons.com>
Date: Wed, 30 Nov 2011 14:29:54 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: Buffer chrdev API and test
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi list,

I'm currently trying to test the buffer output, using the chrdev present
at /dev/iio:deviceN.

So I looked into the generic_buffer.c file which seems to do exactly that.

By looking into the source code, my understanding is that samples are
stored with this frame format :

+--bpe--+--...--+--bpe--+--64 bits--+
| Ch 0  | ..... | Ch N  | timestamp |
+-------+-------+-------+-----------+

the overall "frame" size being stored in /sys/..../buffer/bytes_per_datum.

Now, when I execute generic-buffer, it sets up correctly the driver by
enabling the channels, the buffer, setting the trigger, etc, but outputs
nothing at all. After some number of trigger firing, it finally exits,
having displayed nothing but

# /root/generic-buffer -n at91_adc -t at91_adc-dev0-external
iio device number being used is 0
iio trigger number being used is 3
/sys/bus/iio/devices/iio:device0 at91_adc-dev0-external
#

which seems pretty odd to me.

But when I do a cat directly on /dev/iio:device0, I get some binary
data, which indicates that the buffer is filled anyway.

So, is generic_buffer supposed to print something ? If so, what kind of
output should I expect ?
Or is it just a poor driver configuration/data storing from me ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
