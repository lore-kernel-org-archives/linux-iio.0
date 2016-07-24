Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34012 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbcGXXvU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 19:51:20 -0400
MIME-Version: 1.0
In-Reply-To: <20160721081046.0f658c18@endymion>
References: <1467945971-23798-1-git-send-email-mranostay@gmail.com>
 <1467964564.3225.12.camel@chaos.suse> <CAKzfze82xFRU6A09rXS3OhtLU99cZt_2waRcFGvTgWbx9huZLA@mail.gmail.com>
 <20160721081046.0f658c18@endymion>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sun, 24 Jul 2016 16:50:39 -0700
Message-ID: <CAKzfze8Uc3FGG2+d-H3-=md_J2nwDdG6Tp=5KSTad6Pv+0iXeg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: sht3x: set initial jiffies to last_update
To: Jean Delvare <jdelvare@suse.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	David Frey <david.frey@sensirion.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 20, 2016 at 11:10 PM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Matt,
>
> On Fri, 8 Jul 2016 17:22:10 -0700, Matt Ranostay wrote:
>> On Fri, Jul 8, 2016 at 12:56 AM, Jean Delvare <jdelvare@suse.de> wrote:
>> > On jeu., 2016-07-07 at 19:46 -0700, Matt Ranostay wrote:
>> >> Handling the wraparound requires the data->last_update to be set to an
>> >> initial jiffies value. Otherwise you can start in a state where the
>> >> sensor will never request a reading.
>> >
>> > I can't see how. As I read the code, in the worst case, readings can be
>> > blocked for interval_ms (2 seconds maximum.)
>>
>> On 64-bit systems this is never an issue because the jiffies counter
>> will never wrap around.
>>
>> But my system is a 32-bit ARM core, so the the kernel sets the initial
>> value to 0xfffb6c20 so it will wrap around in 5 minutes to find buggy
>> code.
>>
>> So looking at time_after(0xfffb6c20, 0) will return false always till
>> it finally rolls over.
>
> I've always been confused by how jiffies wrapping is handled. So I
> tested it, and you are correct.
>

Yeah but of course on 64-bit systems most just use the lower 32-bits
of the jiffies counter.

But since that could rollover, and the unlikely event no sensor data
was read for ~57 days you could be in the same state that couldn't get
a data sample ....

Not sure if we want to check this edge case.. and also this effects a
few iio drivers (mostly mine :)) if we really care about this.


>> >> Cc: Guenter Roeck <linux@roeck-us.net>
>> >> Cc: David Frey <david.frey@sensirion.com>
>> >> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> >> ---
>> >>  drivers/hwmon/sht3x.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
>> >> index 450645b6053d..05a925257938 100644
>> >> --- a/drivers/hwmon/sht3x.c
>> >> +++ b/drivers/hwmon/sht3x.c
>> >> @@ -722,7 +722,7 @@ static int sht3x_probe(struct i2c_client *client,
>> >>       data->setup.blocking_io = false;
>> >>       data->setup.high_precision = true;
>> >>       data->mode = 0;
>> >> -     data->last_update = 0;
>> >> +     data->last_update = jiffies;
>> >>       data->client = client;
>> >>       crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
>> >>
>> >
>> > Both look equally wrong to me. With your proposal, accessing the sysfs
>> > attributes right after loading the driver will not trigger a reading.
>> >
>> > In order to guarantee that the first access will trigger a reading,
>> > data->last_update should be initialized to jiffies -
>> > msecs_to_jiffies(2000) (the maximum interval value.)
>>
>> Ok that is fine.  Rather do  jiffies + (2 * HZ)
>
> 2 * HZ is fine. But it's minus, not plus. You want to initialize the
> last update time to 2 seconds BEFORE the driver is being loaded, so
> that the current time is at least 2 seconds AFTER the (fake) last
> update at first access. And you should subtract another jiffy to be on
> the safe side.
>
> Can you please send an updated patch?

Sure will do.

>
> --
> Jean Delvare
> SUSE L3 Support
