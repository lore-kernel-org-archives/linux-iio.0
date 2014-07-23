Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47209 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbaGWQvH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jul 2014 12:51:07 -0400
Message-ID: <1406134260.28464.2.camel@hadess.net>
Subject: Re: User-space API for accelerometer(s)?
From: Bastien Nocera <hadess@hadess.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Reyad Attiyat <reyad.attiyat@gmail.com>,
	linux-iio@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 23 Jul 2014 18:51:00 +0200
In-Reply-To: <53CFB269.3040302@linux.intel.com>
References: <1403100542.30918.29.camel@nuvo>
			    <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
			    <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>
			   <53A57414.8000104@kernel.org> <1404216616.7785.1.camel@nuvo>
			  <53B59837.8080907@jic23.retrosnub.co.uk> <1404916405.10032.3.camel@nuvo>
			 <alpine.DEB.2.01.1407091644570.15209@pmeerw.net>
		 <1404944174.3519.1.camel@nuvo> <53BDEE91.80200@gmail.com>
		 <53BEAB81.8080108@linux.intel.com> <1406117990.28464.0.camel@hadess.net>
	 <53CFB269.3040302@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2014-07-23 at 06:02 -0700, Srinivas Pandruvada wrote:
> On 07/23/2014 05:19 AM, Bastien Nocera wrote:
> > On Thu, 2014-07-10 at 08:04 -0700, Srinivas Pandruvada wrote:
> >> I suggest to look at https://01.org/android-ia/downloads. Under
> >> device/intel, you can see user space HAL for sensor hubs.
> > I can't find it anywhere on those pages. There only seems to be
> > installable images, with no source code.
> >
> 
> You can see instruction here to get source code. You can see source in 
> device/intel folder.
> 
> https://01.org/android-ia/downloads/android-4.4.2r1-ia1

Right, I found this:
https://github.com/android-ia/device_intel/blob/release/android-4.1.1_r1-ia0/pc_std/libsensors/SensorConfig.h

Which seems to have a number of bugs (defines "GRAVITY" but actually
uses "GRAVITY_EARTH" in some of the formulas), and doesn't make it clear
which one of the sensors each of the sections are for.

In any case, my problem was simply one of threshold. For reference, I've
also downloaded Microsoft's documentation for hardware manufacturers:
http://msdn.microsoft.com/en-us/library/windows/hardware/dn613934(v=vs.85).aspx

Cheers

