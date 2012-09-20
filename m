Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60539 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab2ITMoT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Sep 2012 08:44:19 -0400
Received: by oago6 with SMTP id o6so2088892oag.19
        for <linux-iio@vger.kernel.org>; Thu, 20 Sep 2012 05:44:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <505B0193.1040605@metafoo.de>
References: <CAEE_umptNVPOYeTANC4mtAo8AxizmFkrFoa0eLGoLFtTRgWzng@mail.gmail.com>
	<CAEE_umoJ-QmmFMkiXE0AvC3cE4PoD2DrsivFa-49jS2L=nG0ZA@mail.gmail.com>
	<5059FD50.80604@metafoo.de>
	<CAEE_umrYWXKz6hOF958E96DhRdafGTtSE7fz0UfdX_rPZrgqTQ@mail.gmail.com>
	<505B0193.1040605@metafoo.de>
Date: Thu, 20 Sep 2012 14:44:18 +0200
Message-ID: <CAEE_umodNxVNqm0NiCvPDTaouL2GsCyd+iLqrAOGcegWE6ocbw@mail.gmail.com>
Subject: Re: Fwd: iio_trigger doesn't work
From: Denis Ciocca <denis.ciocca@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Yes, you need a buffer. The trigger won't be activated until the buffer is
> active. To activate the buffer you need to select at least one scan element
> in the scan_elements subfolder of you IIO device, then set the buffer size
> by writing to buffer/length and finally write a 1 to buffer/enable. Now you
> should see your acc_trigger_handler being called.

I don't understand what you mean with:
"select at least one scan element in the scan_elements subfolder"
I have seen the adis16240 accelerometer driver for example but I don't saw
anything about scan element. Can you be more specific?

> Btw. Marten Svanfeldt wrote a generic higres timer trigger for IIO.
> Unfortunately this driver is not ready for mainline yet, but I've pushed it
> to https://github.com/lclausen-adi/linux-2.6/commit/6f34757 in case you want
> to take a look at it or use it.

Now I look!

Thanks
