Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1419110952.2843.8.camel@spandruv-hsb-test>
References: <1418923002-901-1-git-send-email-daniel.baluta@intel.com>
	<5494A3D6.60607@gmx.de>
	<CAEnQRZABxH5MuWEnS=RHmQqGUN0QhFTtXxnM1uyrLxvP2a-Rmg@mail.gmail.com>
	<1419110796.2843.6.camel@spandruv-hsb-test>
	<1419110952.2843.8.camel@spandruv-hsb-test>
Date: Sat, 20 Dec 2014 23:40:18 +0200
Message-ID: <CAEnQRZDwSH7kKygih6Mu32rUdEJ_OA0M0FfOWtUmf8iL7p6+3Q@mail.gmail.com>
Subject: Re: [RFC PATCH] iio: ak8975: Make sure chipset is always initialized
From: Daniel Baluta <daniel.baluta@intel.com>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "Baluta, Daniel" <daniel.baluta@intel.com>, "lars@metafoo.de" <lars@metafoo.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"jic23@kernel.org" <jic23@kernel.org>, "Purdila, Octavian" <octavian.purdila@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Westerberg, Mika" <mika.westerberg@intel.com>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "beomho.seo@samsung.com" <beomho.seo@samsung.com>,
	"gwendal@chromium.org" <gwendal@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

I will have closer look on why acpi_match_device could fail. This patch
was only based on code reading when trying to fix the compiler warning
mentioned in the commit message.

[Sorry for top posting]

On Sat, Dec 20, 2014 at 11:29 PM, Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> +Mika
>
> On Sat, 2014-12-20 at 13:26 -0800, Srinivas Pandruvada wrote:
>> On Sat, 2014-12-20 at 00:25 +0200, Daniel Baluta wrote:
>> > On Sat, Dec 20, 2014 at 12:16 AM, Hartmut Knaack <knaack.h@gmx.de> wro=
te:
>> > > Daniel Baluta schrieb am 18.12.2014 um 18:16:
>> > >> When using ACPI, if acpi_match_device fails then chipset enum will =
be
>> > >> uninitialized and &ak_def_array[chipset] will point to some bad add=
ress.
>> > >>
>> I am missing something. You are enumerated over i2c device, which was
>> created from ACPI PNP resource. There is a valid handle or and the
>> device has an ACPI companion at the least. If this failing, I have to
>> check the code for acpi i2c.
>> Can you check why this check failed? We may have bug in i2c handling.
>>
>> Thanks,
>> Srinivas
>>
>> > >> This fixes the following compilation warning:
>> > >>
>> > >> drivers/iio/magnetometer/ak8975.c: In function =E2=80=98ak8975_prob=
e=E2=80=99:
>> > >> drivers/iio/magnetometer/ak8975.c:788:14: warning: =E2=80=98chipset=
=E2=80=99 may be used
>> > >> uninitialized in this function [-Wmaybe-uninitialized]
>> > >>   data->def =3Dak_def_array[chipset];
>> > >>
>> > >> Reported-by: Octavian Purdila <octavian.purdila@intel.com>
>> > >> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> > >> ---
>> > >> This is a RFC because while I'm pretty sure that chipset should be =
initialized
>> > >> with AK_MAX_TYPE in ak8975_match_acpi_device, I am not sure if we c=
an live with
>> > >> a NULL return value of ak8975_match_acpi_device. Current implementa=
tion ignores
>> > >> return value of ak8975_match_acpi_device.
>> > > This seems to be the actual problem: these _match_acpi_device functi=
ons return
>> > > NULL on failure, and this should be checked for.
>> >
>> > Ok, so this would acceptable?
>> >
>> > diff --git a/drivers/iio/magnetometer/ak8975.c
>> > b/drivers/iio/magnetometer/ak8975.c
>> > index 0d10a4b..68d99e9 100644
>> > --- a/drivers/iio/magnetometer/ak8975.c
>> > +++ b/drivers/iio/magnetometer/ak8975.c
>> > @@ -776,8 +776,9 @@ static int ak8975_probe(struct i2c_client *client,
>> >                 name =3D id->name;
>> >         } else if (ACPI_HANDLE(&client->dev))
>> >                 name =3D ak8975_match_acpi_device(&client->dev, &chips=
et);
>> > -       else
>> > -               return -ENOSYS;
>> > +
>> > +       if (!name)
>> > +               return -ENODEV;
>> >
>> >
>> > I still have some doubts about return code in case of error.
>> >
>> > For ak8975 we use -ENOSYS, but for kxcjk-1013 we use -ENODEV.
>> >
>> > I will send a patch after we clear this out.
>> >
>> > thanks,
>> > Daniel.
>>
>
