Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35774 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbcEDOhY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:37:24 -0400
Subject: Re: [PATCH v3] iio: accel: Add support for Freescale MMA7660FC
To: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
References: <1461932343-14967-1-git-send-email-constantin.musca@intel.com>
 <21eeb9cd-5d48-043f-716a-7b7b4f5305b9@kernel.org>
 <CAEnQRZA05=_fShP9W6QXu7cYGwn_ApPr1V7JGHwbB33jKzyMMw@mail.gmail.com>
 <56562B39-B495-48AE-9B2E-8903C9760BE4@jic23.retrosnub.co.uk>
 <CAEnQRZAvp4qb1asPKwGDV-HAkDjU+ca-4kQR-QSFp=83SbO7gw@mail.gmail.com>
Cc: Constantin Musca <constantin.musca@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <98934844-092f-a0de-de29-f15510b86a0a@kernel.org>
Date: Wed, 4 May 2016 10:28:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAvp4qb1asPKwGDV-HAkDjU+ca-4kQR-QSFp=83SbO7gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/16 11:55, Daniel Baluta wrote:
> On Tue, May 3, 2016 at 1:43 PM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
>>
>>
>> On 3 May 2016 09:29:26 CEST, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>> On Sun, May 1, 2016 at 9:56 PM, Jonathan Cameron <jic23@kernel.org>
>>> wrote:
>>>> On 29/04/16 13:19, Constantin Musca wrote:
>>>>> Minimal implementation of an IIO driver for the Freescale
>>>>> MMA7660FC 3-axis accelerometer. Datasheet:
>>>>>
>>> http://www.freescale.com.cn/files/sensors/doc/data_sheet/MMA7660FC.pdf
>>>>>
>>>>> Includes:
>>>>> - ACPI support;
>>>>> - read_raw for x,y,z axes;
>>>>> - reading and setting the scale (range) parameter.
>>>>> - power management
>>>>>
>>>>> Signed-off-by: Constantin Musca <constantin.musca@intel.com>
>>>> Couple of trivial bits inline as well as that request to update the
>>> link above
>>>> if possible...
>>>>
>>>> Why the retries? (I'm on a train without internet access for quite a
>>> few
>>>> hours yet hence I can't dig into the datasheet!)
>>>
>>> I suggested the retries because it's quite unsafe to infinitely loop
>>> in the kernel
>>> on a hardware condition. We can lockup the kernel if there is some sort
>>> of
>>> hardware problem.
>> Agreed but why try more than once? Needs a comment...
>>>
>>>
>>>>
>>>> Anyhow, even if it's obvious from the datasheet, that sort of 'magic'
>>> needs
>>>> an explanation comment...
> 
> Agree we need a comment on that. As for the number of retries I can see
> drivers doing from 5 to 100 (re)tries:
Interacts with the delays in the relevant loops.
> 
> 
> humidity/si7005.c
> 44:     int tries = 50;
> 55:     while (tries-- > 0) {
This one has a 20msec delay so total time is 1 second.
It is polling for a status change as the reading completes (faking an 
interrupt).
> 
> temperature/tmp006.c
> 55:     int tries = 50;
> 57:     while (tries-- > 0) {
100msec sleep so 5 seconds (feels a bit long now you mention it.)

> 
> dac/mcp4725.c
> 76:     int tries = 20;
> 99:     while (tries--) {
> 111:    if (tries < 0) {
Curious overkill - comment says up to 50msecs then allows 20 x 20
 = 400 msecs.
> 
> pressure/mpl3115.c
> 49:     int ret, tries = 15;
> 57:     while (tries-- > 0) {
15x20msecs no comment on how long it might take but 300msecs seems fine.
> 
> light/ltr501.c
> 329:    int tries = 100;
> 332:    while (tries--) {
100x25mescs = 2.5secs (rather long) - no comment on what is reasonable...
> 
> proximity/pulsedlight-lidar-lite-v2.c
> 160:    int tries = 10;
polls rather quick 1-2msecs so max 10msecs.
> 
> accel/mma9551_core.c
> 75:#define MMA9551_I2C_READ_RETRIES     5
No real description at all for this one... I don't have the datasheet to hand
an no internet right now.

Definitely room for some improved commenting in some of these drivers
(I clearly wasn't as fussy in the past!)  If anyone wants to datasheet dive
and add missing justifications that would be great.

Jonathan
> 
> Daniel.
> 

