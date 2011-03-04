Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:47837 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab1CDJTU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2011 04:19:20 -0500
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Marten Svanfeldt <marten.svanfeldt@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 4 Mar 2011 09:19:16 +0000
Subject: RE: High frequency software trigger
Message-ID: <544AC56F16B56944AEC3BD4E3D59177133FA70B26C@LIMKCMBX1.ad.analog.com>
References: <4D709432.90003@gmail.com>
In-Reply-To: <4D709432.90003@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Marten Svanfeldt wrote on 2011-03-04:
> Hi,
>
> I have recently begun looking at utilizing iio for the input part of a
> robotics system but have some doubts about its usability for which I
> would like your comments.
>
> Today we have (in our embedded system) a number of custom written
> drivers interfacing SPI attached accelerometers and AD converters,
> utilizing hrtimers for software triggering of sampling at 50 to 250 Hz.
> Herein lays my current question, has anyone used the IIO system with
> these type of sampling rates? The RTC based trigger seems to only give
> second or higher intervals.
>
> I will be looking at converting our special drivers to be acceptable
> for upstream submission, same for a hrtimers based trigger, should
> that be a good idea.
>
> Best regards
> Marten Svanfeldt

I recently submitted a trigger source driver that utilizes Blackfin hardware timer.

http://wiki.analog.com/software/linux/docs/iio/iio-trig-bfin-timer

Not sure what your platform is, but there might be similar peripherals,
that can generate sub second cyclic interrupts.

I successfully used it on a fast Blackfin processor at frequencies of 10kHz and above,
with this simple demo application.

http://wiki.analog.com/software/linux/docs/iio/iio_netscope

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif

