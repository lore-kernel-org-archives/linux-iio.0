Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36412 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966029AbbLRCdE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Dec 2015 21:33:04 -0500
MIME-Version: 1.0
In-Reply-To: <1450400953.5427.18.camel@intel.com>
References: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
	<1450399868.5427.11.camel@linux.intel.com>
	<1450400312.5427.15.camel@intel.com>
	<CAOhV88OinTE31-qp1vh-4XHT-TqMTTOYwHiLk0yptg0prwetjw@mail.gmail.com>
	<1450400953.5427.18.camel@intel.com>
Date: Thu, 17 Dec 2015 18:33:02 -0800
Message-ID: <CAOhV88Oqj+JrPsHqZmtmydUftSA9sUuCDErUOaAG_Erk+uDr1g@mail.gmail.com>
Subject: Re: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"cmo@melexis.com" <cmo@melexis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"jikos@kernel.org" <jikos@kernel.org>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Dec 17, 2015 at 5:11 PM, Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> On Thu, 2015-12-17 at 17:08 -0800, Nish Aravamudan wrote:
>> On Thu, Dec 17, 2015 at 5:00 PM, Pandruvada, Srinivas
>> <srinivas.pandruvada@intel.com> wrote:
>> > Hi Andy,
>> >
>> > As per Nish these patches are impacting sensors on Yoga.
>> > https://lkml.org/lkml/2015/11/30/441
>>
>> To be clear, without that series, the touchpad and touchscreen on the
>> Yoga 900 don't work at all. So they are necessary for functioning. I
>> don't know (I will test it now), if removing the series makes the IIO
>> sensors work properly in /dev/.
> This is important to know before we take Andy's time.

It seems like Andy's patches are not the problem. That is, with stock
4.4-rc5, the accelerommeter /dev files still do not update.

-Nish
