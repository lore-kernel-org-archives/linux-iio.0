Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:51759 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753463Ab1K2NAv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Nov 2011 08:00:51 -0500
Message-ID: <4ED4D611.7030701@analog.com>
Date: Tue, 29 Nov 2011 13:54:41 +0100
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Alessandro Rubini <rubini@gnudd.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"federico.vaga@gmail.com" <federico.vaga@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"greg@kroah.com" <greg@kroah.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: ZIO wiki analysis of IIO and why it doesn't meet there requirements
 [was Re: Industrial Input Output analysis]
References: <4ED36B93.5020703@metafoo.de>  <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com> <4ED21960.1000002@kernel.org> <20111129110013.GA27762@mail.gnudd.com>
In-Reply-To: <20111129110013.GA27762@mail.gnudd.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/29/2011 12:00 PM, Alessandro Rubini wrote:
>
> Hello Lars-Peter, sorry for the delay.
>> We do use IIO for high speed data conversion.
> May I know how high?
>

Hi Alessandro,

Right now we use IIO to capture single work loads at 250MSPS.
User space requests - let's say 1M samples, the IIO driver captures and 
returns data to user space.
(sounds a bit similar to your use case)

Hardware is a Virtex6 FPGA, microblaze softcore running Linux and the 
converter is a AD9467
on an FMC-LPC card.

The per-sample buffer implementations in IIO are purely optional!
You can build your own buffer implementation by using the 
INDIO_BUFFER_HARDWARE flag.

For now the full rate capture is only used for hardware validation 
purposes.
Later it is assumed that there will be data decimation inside the FPGA 
fabric,
so that only a few MSPS sustained data is DMAed into the processor core 
system.
Right now it's not decided whether double buffering or a larger chain is 
required in order
to solve the producer-consumer and latency problems.

But I'm pretty optimistic that there is nothing in IIO which prevents me 
from getting the
right solution in place.

Ideally there is only one subsytem, and not one targeting low-speed and 
another for high speed.


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


