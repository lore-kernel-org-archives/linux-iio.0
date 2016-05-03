Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <56562B39-B495-48AE-9B2E-8903C9760BE4@jic23.retrosnub.co.uk>
References: <1461932343-14967-1-git-send-email-constantin.musca@intel.com>
	<21eeb9cd-5d48-043f-716a-7b7b4f5305b9@kernel.org>
	<CAEnQRZA05=_fShP9W6QXu7cYGwn_ApPr1V7JGHwbB33jKzyMMw@mail.gmail.com>
	<56562B39-B495-48AE-9B2E-8903C9760BE4@jic23.retrosnub.co.uk>
Date: Tue, 3 May 2016 13:55:40 +0300
Message-ID: <CAEnQRZAvp4qb1asPKwGDV-HAkDjU+ca-4kQR-QSFp=83SbO7gw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: Add support for Freescale MMA7660FC
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Constantin Musca <constantin.musca@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 3, 2016 at 1:43 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 3 May 2016 09:29:26 CEST, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>On Sun, May 1, 2016 at 9:56 PM, Jonathan Cameron <jic23@kernel.org>
>>wrote:
>>> On 29/04/16 13:19, Constantin Musca wrote:
>>>> Minimal implementation of an IIO driver for the Freescale
>>>> MMA7660FC 3-axis accelerometer. Datasheet:
>>>>
>>http://www.freescale.com.cn/files/sensors/doc/data_sheet/MMA7660FC.pdf
>>>>
>>>> Includes:
>>>> - ACPI support;
>>>> - read_raw for x,y,z axes;
>>>> - reading and setting the scale (range) parameter.
>>>> - power management
>>>>
>>>> Signed-off-by: Constantin Musca <constantin.musca@intel.com>
>>> Couple of trivial bits inline as well as that request to update the
>>link above
>>> if possible...
>>>
>>> Why the retries? (I'm on a train without internet access for quite a
>>few
>>> hours yet hence I can't dig into the datasheet!)
>>
>>I suggested the retries because it's quite unsafe to infinitely loop
>>in the kernel
>>on a hardware condition. We can lockup the kernel if there is some sort
>>of
>>hardware problem.
> Agreed but why try more than once? Needs a comment...
>>
>>
>>>
>>> Anyhow, even if it's obvious from the datasheet, that sort of 'magic'
>>needs
>>> an explanation comment...

Agree we need a comment on that. As for the number of retries I can see
drivers doing from 5 to 100 (re)tries:


humidity/si7005.c
44:     int tries = 50;
55:     while (tries-- > 0) {

temperature/tmp006.c
55:     int tries = 50;
57:     while (tries-- > 0) {

dac/mcp4725.c
76:     int tries = 20;
99:     while (tries--) {
111:    if (tries < 0) {

pressure/mpl3115.c
49:     int ret, tries = 15;
57:     while (tries-- > 0) {

ight/ltr501.c
329:    int tries = 100;
332:    while (tries--) {

proximity/pulsedlight-lidar-lite-v2.c
160:    int tries = 10;

accel/mma9551_core.c
75:#define MMA9551_I2C_READ_RETRIES     5

Daniel.
