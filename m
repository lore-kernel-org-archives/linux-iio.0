Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49619 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752244AbaHCJ41 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Aug 2014 05:56:27 -0400
Date: Sun, 3 Aug 2014 11:56:10 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: gmane@reliableembeddedsystems.com
Cc: linux-iio@vger.kernel.org
Subject: Re: iio A/D converter input to input event subsystem
Message-ID: <20140803095610.GQ3214@piout.net>
References: <b12ce7f23b622a613c07e9de19ece607@reliableembeddedsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b12ce7f23b622a613c07e9de19ece607@reliableembeddedsystems.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Robert,

On 02/08/2014 at 13:14:30 -0500, gmane@reliableembeddedsystems.com wrote :
> Hi,
> 
> I would like to use a couple of resistors and keys and one Analog
> input[1], read the analogue voltage from a kernel driver, figure out
> which key is pressed and pass this on to the Linux input subsystem.
> (Am I really the only one with this use case?)
> 
> In my specific case it's about a beagle bone black, which means that
> the A/D driver is an iio adc driver[2].
> 
> How would it be possible to reuse the iio A/D converter driver code
> for my driver? Maybe it would even be possible to create something
> more generic so iio A/D converter channels could be used as input
> keys. Some sample code which would enable me to choose an analog
> input and read from it from kernel space would help me to write some
> basic sample driver, I guess.
> 
> The reason I would like to write a device driver instead of a user
> space application is mainly the input subsystem. From the user space
> application's point of view utilizing a device driver which feeds
> the input subsystem would make it easy to exchange what's underneath
> without user space even noticing. (keys to Input pins, a key matrix
> to I/O pins, i2c input, A/D converter,...).
> 

Did you have a look at uinput? This would allow you to inject input
events after processing the ADC values in userspace.

Simple example: http://thiemonge.org/getting-started-with-uinput

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
