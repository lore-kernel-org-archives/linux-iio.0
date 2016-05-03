Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57233 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbcECKnO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2016 06:43:14 -0400
In-Reply-To: <CAEnQRZA05=_fShP9W6QXu7cYGwn_ApPr1V7JGHwbB33jKzyMMw@mail.gmail.com>
References: <1461932343-14967-1-git-send-email-constantin.musca@intel.com> <21eeb9cd-5d48-043f-716a-7b7b4f5305b9@kernel.org> <CAEnQRZA05=_fShP9W6QXu7cYGwn_ApPr1V7JGHwbB33jKzyMMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v3] iio: accel: Add support for Freescale MMA7660FC
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 03 May 2016 12:43:00 +0200
To: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: Constantin Musca <constantin.musca@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <56562B39-B495-48AE-9B2E-8903C9760BE4@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 3 May 2016 09:29:26 CEST, Daniel Baluta <daniel.baluta@intel.com> wrote:
>On Sun, May 1, 2016 at 9:56 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> On 29/04/16 13:19, Constantin Musca wrote:
>>> Minimal implementation of an IIO driver for the Freescale
>>> MMA7660FC 3-axis accelerometer. Datasheet:
>>>
>http://www.freescale.com.cn/files/sensors/doc/data_sheet/MMA7660FC.pdf
>>>
>>> Includes:
>>> - ACPI support;
>>> - read_raw for x,y,z axes;
>>> - reading and setting the scale (range) parameter.
>>> - power management
>>>
>>> Signed-off-by: Constantin Musca <constantin.musca@intel.com>
>> Couple of trivial bits inline as well as that request to update the
>link above
>> if possible...
>>
>> Why the retries? (I'm on a train without internet access for quite a
>few
>> hours yet hence I can't dig into the datasheet!)
>
>I suggested the retries because it's quite unsafe to infinitely loop
>in the kernel
>on a hardware condition. We can lockup the kernel if there is some sort
>of
>hardware problem.
Agreed but why try more than once? Needs a comment...
>
>
>>
>> Anyhow, even if it's obvious from the datasheet, that sort of 'magic'
>needs
>> an explanation comment...

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
