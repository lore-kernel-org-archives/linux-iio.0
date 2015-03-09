Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36105 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbbCIUir (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 16:38:47 -0400
MIME-Version: 1.0
In-Reply-To: <54FDC005.2000905@kernel.org>
References: <1421921412-7710-1-git-send-email-daniel.baluta@intel.com>
	<54C4C510.5090306@kernel.org>
	<CAEnQRZAhTQEGiSeAOahG4A_iZhPgMYnoHwLjDeEWKarwVJO3qg@mail.gmail.com>
	<CAEnQRZDtkQiqxLQZ6f4SJW29sDtMvgFe55ecTFMKfi6O7rcNdg@mail.gmail.com>
	<000d01d0551b$9d424bb0$d7c6e310$@capellamicro.com>
	<54FDC005.2000905@kernel.org>
Date: Mon, 9 Mar 2015 22:38:45 +0200
Message-ID: <CAEnQRZCAAmcs3M+2NkNknDV_2kqHEgKbsECkLpspCYJu1vQ-7Q@mail.gmail.com>
Subject: Re: [PATCH] iio: light: Add support for Capella CM3323 color/light sensor
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 9, 2015 at 5:45 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 02/03/15 19:03, Kevin Tsai wrote:
>> Hi Daniel,
>>
>> Ambient light sensor is trying to match the brightness sensitivity of human visual system.  Please see the following links:
>> http://en.wikipedia.org/wiki/Color_vision#mediaviewer/File:Eyesensitivity.svg
>> http://en.wikipedia.org/wiki/Color_vision
>>
>> You can compare the spectrum with the datasheet.  The green channel is matched with ALS spectrum.
> It's close (ish) to the right measurement, but it isn't the right measurement.  As such
> I'd argue we leave it up to userspace to make the jump and use Green if a true estimate
> if illuminance isn't available, but don't suggest it is available from the kernel.


Ok, I will respin the patch with this in mind.

thanks,
Daniel.
