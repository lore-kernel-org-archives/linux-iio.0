Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns1.siteground282.com ([184.154.233.8]:52274 "EHLO
	serv01.siteground282.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbaHBScM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Aug 2014 14:32:12 -0400
Received: from [127.0.0.1] (port=54547 helo=secure282.sgcpanel.com)
	by serv01.siteground282.com with esmtpa (Exim 4.80.1)
	(envelope-from <gmane@reliableembeddedsystems.com>)
	id 1XDdp8-0002BI-Q1
	for linux-iio@vger.kernel.org; Sat, 02 Aug 2014 13:14:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sat, 02 Aug 2014 13:14:30 -0500
From: gmane@reliableembeddedsystems.com
To: linux-iio@vger.kernel.org
Subject: iio A/D converter input to input event subsystem
Message-ID: <b12ce7f23b622a613c07e9de19ece607@reliableembeddedsystems.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I would like to use a couple of resistors and keys and one Analog 
input[1], read the analogue voltage from a kernel driver, figure out 
which key is pressed and pass this on to the Linux input subsystem. (Am 
I really the only one with this use case?)

In my specific case it's about a beagle bone black, which means that the 
A/D driver is an iio adc driver[2].

How would it be possible to reuse the iio A/D converter driver code for 
my driver? Maybe it would even be possible to create something more 
generic so iio A/D converter channels could be used as input keys. Some 
sample code which would enable me to choose an analog input and read 
from it from kernel space would help me to write some basic sample 
driver, I guess.

The reason I would like to write a device driver instead of a user space 
application is mainly the input subsystem. From the user space 
application's point of view utilizing a device driver which feeds the 
input subsystem would make it easy to exchange what's underneath without 
user space even noticing. (keys to Input pins, a key matrix to I/O pins, 
i2c input, A/D converter,...).

Regards,

Robert

[1] 
http://21stdigitalhome.blogspot.gr/2013/11/sensing-switches-on-analog-input.html
[2] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/ti_am335x_adc.c?id=refs/tags/v3.16-rc7
