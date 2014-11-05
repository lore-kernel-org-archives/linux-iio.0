Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1415201330.7630.12.camel@hadess.net>
References: <1415056822.4506.24.camel@hadess.net>
	<545A3671.2010102@kernel.org>
	<CAEnQRZDD40S7ScRsKmAHR_XsA-moAzyvYUqEyiT9ME6dDM9zfA@mail.gmail.com>
	<1415201330.7630.12.camel@hadess.net>
Date: Wed, 5 Nov 2014 17:46:45 +0200
Message-ID: <CAEnQRZAZ8OtR+GrzJQ8Mg_xS681zEBNAZcxCFFRKR32yH-EuzA@mail.gmail.com>
Subject: Re: [PATCH v3] iio:kxcjk-1013: Add support for SMO8500 device
From: Daniel Baluta <daniel.baluta@intel.com>
To: Bastien Nocera <hadess@hadess.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 5, 2014 at 5:28 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Wed, 2014-11-05 at 17:22 +0200, Daniel Baluta wrote:
>> On Wed, Nov 5, 2014 at 4:38 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> > On 03/11/14 23:20, Bastien Nocera wrote:
>> >> The Onda v975w tablet contains an accelerometer that's advertised over
>> >> ACPI as SMO8500. This device is however a KXCJ9 accelerometer as
>> >> can be seen in the Windows driver's INF file, and from the etching on
>> >> the chipset ("KXCJ9 41566 0414").
>> >>
>> >> This patch also removes the attempt to get the IRQ for the "data ready"
>> >> signal, as it does not seem to be supported by this device on this
>> >> platform.
>>
>> I don't understand exactly why you remove the attempt to get IRQ? If this is
>> not supported on your device than kxcjk1013_gpio_probe should return
>> a negative value.
>
> Yep, and I see a warning in dmesg when the device is actually working
> correctly:
>                 dev_err(dev, "acpi gpio get index failed\n");

You just add is_smo8500_device member to avoid seeing an error
message. This is not a good idea.

>
> I don't want to see that warning. Either you can downgrade that error to
> a debug message, in which case it might silently fail when it should
> have warned, or you special case so that this code isn't run.

We should work on this instead. We can make the error message more
clear to really let users know what happened. I would like to hear
Srinivas opinion on this.

>
>>  Then, all IRQ handling is done only if client->irq >= 0 and
>> you should be safe.
>>
>> >>
>> >> Signed-off-by: Bastien Nocera <hadess@hadess.net>
>> > Looks fine to me, but I'd ideally like an ack / review from Srinivas as it's his
>> > driver... (and/or Daniel)
>> >>
>> >> ---
>>
>> Do not add scissor line by hand.
>>
>> >>
>> >> Changes from v1:
>> >> - Rebase after driver changes
>> >> - Stop checking for IRQ when not supported
>> >>
>> >> Changes from v2:
>> >> - Fixed the space before the opening bracket
>> >> - Added Sob line
>> >> - Add version to the patch subject line ;)
>> >>
>> >> ---
>>
>> Add change history here instead.
>
> Sure. Need me to send it again for that?

No need for the moment. Just for future patches.

>
>> >>  drivers/iio/accel/kxcjk-1013.c | 13 +++++++++++--
>> >>  1 file changed, 11 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>> >> index 98909a9..3e966c2 100644
>> >> --- a/drivers/iio/accel/kxcjk-1013.c
>> >> +++ b/drivers/iio/accel/kxcjk-1013.c
>> >> @@ -108,6 +108,7 @@ struct kxcjk1013_data {
>> >>       bool motion_trigger_on;
>> >>       int64_t timestamp;
>> >>       enum kx_chipset chipset;
>> >> +     bool is_smo8500_device;
>> >>  };
>> >>
>> >>  enum kxcjk1013_axis {
>> >> @@ -1129,12 +1130,15 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
>> >>  }
>> >>
>> >>  static const char *kxcjk1013_match_acpi_device(struct device *dev,
>> >> -                                            enum kx_chipset *chipset)
>> >> +                                            enum kx_chipset *chipset,
>> >> +                                            bool *is_smo8500_device)
>> >>  {
>> >>       const struct acpi_device_id *id;
>> >>       id = acpi_match_device(dev->driver->acpi_match_table, dev);
>> >>       if (!id)
>> >>               return NULL;
>> >> +     if (strcmp(id->id, "SMO8500") == 0)
>> >> +             *is_smo8500_device = true;
>> >>       *chipset = (enum kx_chipset)id->driver_data;
>> >>
>> >>       return dev_name(dev);
>> >> @@ -1149,6 +1153,8 @@ static int kxcjk1013_gpio_probe(struct i2c_client *client,
>> >>
>> >>       if (!client)
>> >>               return -EINVAL;
>> >> +     if (data->is_smo8500_device)
>> >> +             return -ENOTSUPP;
>> >>
>> >>       dev = &client->dev;
>> >>
>> >> @@ -1198,7 +1204,8 @@ static int kxcjk1013_probe(struct i2c_client *client,
>> >>               name = id->name;
>> >>       } else if (ACPI_HANDLE(&client->dev)) {
>> >>               name = kxcjk1013_match_acpi_device(&client->dev,
>> >> -                                                &data->chipset);
>> >> +                                                &data->chipset,
>> >> +                                                &data->is_smo8500_device);
>> >>       } else
>> >>               return -ENODEV;
>> >>
>> >> @@ -1397,6 +1404,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
>> >>       {"KXCJ1013", KXCJK1013},
>> >>       {"KXCJ1008", KXCJ91008},
>> >>       {"KXTJ1009", KXTJ21009},
>> >> +     {"SMO8500",  KXCJK1013},
>>
>> Commit message says that your accel is KXCJ9, but here you use the index
>> for KXCJK1013. Which one is true?

What about this?
