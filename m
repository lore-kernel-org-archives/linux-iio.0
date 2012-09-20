Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-050.synserver.de ([212.40.185.50]:1045 "EHLO
	smtp-out-050.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab2ITNaE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Sep 2012 09:30:04 -0400
Message-ID: <505B164B.1010002@metafoo.de>
Date: Thu, 20 Sep 2012 15:12:43 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Fwd: iio_trigger doesn't work
References: <CAEE_umptNVPOYeTANC4mtAo8AxizmFkrFoa0eLGoLFtTRgWzng@mail.gmail.com> <CAEE_umoJ-QmmFMkiXE0AvC3cE4PoD2DrsivFa-49jS2L=nG0ZA@mail.gmail.com> <5059FD50.80604@metafoo.de> <CAEE_umrYWXKz6hOF958E96DhRdafGTtSE7fz0UfdX_rPZrgqTQ@mail.gmail.com> <505B0193.1040605@metafoo.de> <CAEE_umodNxVNqm0NiCvPDTaouL2GsCyd+iLqrAOGcegWE6ocbw@mail.gmail.com>
In-Reply-To: <CAEE_umodNxVNqm0NiCvPDTaouL2GsCyd+iLqrAOGcegWE6ocbw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/20/2012 02:44 PM, Denis Ciocca wrote:
>> Yes, you need a buffer. The trigger won't be activated until the buffer is
>> active. To activate the buffer you need to select at least one scan element
>> in the scan_elements subfolder of you IIO device, then set the buffer size
>> by writing to buffer/length and finally write a 1 to buffer/enable. Now you
>> should see your acc_trigger_handler being called.
> 
> I don't understand what you mean with:
> "select at least one scan element in the scan_elements subfolder"
> I have seen the adis16240 accelerometer driver for example but I don't saw
> anything about scan element. Can you be more specific?

So each channel has a scan index. And for each channel you can enable
whether the channel should be sampled in buffered mode or not. There is a
sysfs file for each channel which allows you to do this in the scan_elements
subfolder. In order to start sampling you have to enable at least one
scan_element by writing a 1 to its enable attribute.

- Lars
