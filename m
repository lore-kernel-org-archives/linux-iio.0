Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:43769 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376Ab1K3QKZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2011 11:10:25 -0500
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "rubini@gnudd.com" <rubini@gnudd.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"federico.vaga@gmail.com" <federico.vaga@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"greg@kroah.com" <greg@kroah.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Wed, 30 Nov 2011 16:08:44 +0000
Subject: RE: ZIO wiki analysis of IIO and why it doesn't meet there
 requirements [was Re: Industrial Input Output analysis]
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714873344064@LIMKCMBX1.ad.analog.com>
References: <4ED4D611.7030701@analog.com>  <4ED36B93.5020703@metafoo.de>
  <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com>
 <4ED21960.1000002@kernel.org> <20111129110013.GA27762@mail.gnudd.com>
 <20111129144449.GA14261@mail.gnudd.com>
In-Reply-To: <20111129144449.GA14261@mail.gnudd.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Alessandro Rubini wrote on 2011-11-29:
> Hello.
>
>> Right now we use IIO to capture single work loads at 250MSPS. User
>> space requests - let's say 1M samples, the IIO driver captures and
>> returns data to user space. (sounds a bit similar to your use case)
>
> Yes, it's similar.
>
>> Hardware is a Virtex6 FPGA, microblaze softcore running Linux and the
>> converter is a AD9467
>> on an FMC-LPC card.
>
> That's similar too. Is the code available somewhere?

No - it's not yet available. We're currently validating HW, HDL and software.
It will be available in a few days/weeks.

Check out wiki.analog.com

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



