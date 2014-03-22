Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns1.siteground282.com ([184.154.233.8]:52699 "EHLO
	serv01.siteground282.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbaCVScL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Mar 2014 14:32:11 -0400
Received: from [127.0.0.1] (port=39571 helo=secure282.sgcpanel.com)
	by serv01.siteground282.com with esmtpa (Exim 4.80.1)
	(envelope-from <gmane@reliableembeddedsystems.com>)
	id 1WRPaC-0006aH-CY
	for linux-iio@vger.kernel.org; Sat, 22 Mar 2014 12:19:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sat, 22 Mar 2014 12:19:44 -0500
From: gmane@reliableembeddedsystems.com
To: <linux-iio@vger.kernel.org>
Subject: iio on beagle bone black 3.13.6 kernel
Message-ID: <be30164b26d247c2576ba7369032bc23@reliableembeddedsystems.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I use a beagle bone black with a 3.13.6 kernel and would like to get 
the
./generic_buffer test which comes with the kernel to work.

This is what I do:

echo 1 > /sys/bus/iio/devices/iio_sysfs_trigger/add_trigger

ls /sys/bus/iio/devices/
iio:device0  iio_sysfs_trigger  trigger0

cat /sys/bus/iio/devices/trigger0/name
sysfstrig1

echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage5_en


./generic_buffer.out -n TI-am335x-adc -t sysfstrig1 -l 128
iio device number being used is 0
iio trigger number being used is 0
  sysfstrig1
---> Could not open /trigger/current_trigger
Failed to write current_trigger file

How can I get rid of this?

Is this a problem with my driver, or should I just create this magic
file somewhere?

Regards,

Robert

