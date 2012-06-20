Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49643 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab2FTVYB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jun 2012 17:24:01 -0400
Received: by gglu4 with SMTP id u4so6102131ggl.19
        for <linux-iio@vger.kernel.org>; Wed, 20 Jun 2012 14:24:00 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 20 Jun 2012 22:23:59 +0100
Message-ID: <CAAfyv36oD+mNrXhx1yDqnUpPT=Caecoc=oBhUTGjPNF9Rwdc3w@mail.gmail.com>
Subject: reading data from hmc5883
From: Belisko Marek <marek.belisko@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm runnig 3.5-rc2 kernel on my board with hmc5883 magnetometer.
I've check iio documentation but cannot figure out how to read data from
device. Node /dev/iio:device0 is properly created.
I try both test programs: generic_buffer and iio_event_monitor but
both gives me an error:
iio_event_monitor:
./iio_monitor hmc5883
Found IIO device with name hmc5883 with device number 0
Failed to read event from device: Bad file descriptor

IMO this is because hmc5883 don't have event_attrs set and then this fail.

generic_buffer:
./generic -n hmc5883
iio device number being used is 0
Failed to find the trigger hmc5883-dev0

Not sure about that one but seems trigger is missing (hmc5883 use
INDIO_DIRECT_MODE)

Is there other way how to read data from device or only possibility is
by reading sysfs (no polling ?) ?
Or it is just simple open device -> sleep on poll and when wake -> read data?

Thanks in advance,

Marek
-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
