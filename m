Return-Path: <akinobu.mita@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170821210044.q2czi5gpkwx2ex5u@lenoch>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
 <1500564267-8613-7-git-send-email-akinobu.mita@gmail.com> <20170723123618.3895caea@kernel.org>
 <20170820115730.61d0d3bc@archlinux> <20170821210044.q2czi5gpkwx2ex5u@lenoch>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 22 Aug 2017 19:03:12 +0900
Message-ID: <CAC5umygwstJv0aeWELWz5OL04zdS3T=zRZkVjPYxZ2iTerU=Ww@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] iio: adc: ti-ads1015: add adequate wait time to
 get correct conversion
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, linux-iio@vger.kernel.org,
	Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-08-22 6:00 GMT+09:00 Ladislav Michl <ladis@linux-mips.org>:
> On Sun, Aug 20, 2017 at 11:57:30AM +0100, Jonathan Cameron wrote:
>> On Sun, 23 Jul 2017 12:36:18 +0100
>> Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> > On Fri, 21 Jul 2017 00:24:22 +0900
>> > Akinobu Mita <akinobu.mita@gmail.com> wrote:
>> >
>> > > This driver assumes that the device is operating in the continuous
>> > > conversion mode which performs the conversion continuously.  So this=
 driver
>> > > inserts a wait time before reading the conversion register if the
>> > > configuration is changed from a previous request.
>> > >
>> > > Currently, the wait time is only the period required for a single
>> > > conversion that is calculated as the reciprocal of the sampling freq=
uency.
>> > > However we also need to wait for the the previous conversion to comp=
lete.
>> > > Otherwise we probably get the conversion result for the previous
>> > > configuration when the sampling frequency is lower.
>> > >
>> > > Cc: Daniel Baluta <daniel.baluta@gmail.com>
>> > > Cc: Jonathan Cameron <jic23@kernel.org>
>> > > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> > Assuming Daniel is happy with these, I propose to take these
>> > first 6 through the fixes-togreg branch and mark them all for stable.
>>
>> I changed my mind on this given the late staging in the cycle and
>> am pushing them all through the togreg branch.  The fixes can then
>> be picked up by stable post merge window which may be the quickest
>> route at the moment!
>
> Tested this patch serie and something is still odd, see bellow...
> Once sorted out, proper patches will be generated.
>
>>
>> Thanks,
>>
>> Jonathan
>> >
>> > The rest may well have to wait on those patches coming back
>> > around and into the togreg branch of iio.git.
>> >
>> > Hence it may be at least a few weeks.
>> >
>> > Jonathan
>> > > ---
>> > >  drivers/iio/adc/ti-ads1015.c | 31 +++++++++++++++++++------------
>> > >  1 file changed, 19 insertions(+), 12 deletions(-)
>> > >
>> > > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads10=
15.c
>> > > index 1c475e2..9c501e5 100644
>> > > --- a/drivers/iio/adc/ti-ads1015.c
>> > > +++ b/drivers/iio/adc/ti-ads1015.c
>> > > @@ -242,27 +242,34 @@ static
>> > >  int ads1015_get_adc_result(struct ads1015_data *data, int chan, int=
 *val)
>> > >  {
>> > >   int ret, pga, dr, conv_time;
>> > > - bool change;
>> > > + unsigned int old, mask, cfg;
>> > >
>> > >   if (chan < 0 || chan >=3D ADS1015_CHANNELS)
>> > >           return -EINVAL;
>> > >
>> > > + ret =3D regmap_read(data->regmap, ADS1015_CFG_REG, &old);
>> > > + if (ret)
>> > > +         return ret;
>> > > +
>> > >   pga =3D data->channel_data[chan].pga;
>> > >   dr =3D data->channel_data[chan].data_rate;
>> > > + mask =3D ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
>> > > +         ADS1015_CFG_DR_MASK;
>> > > + cfg =3D chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHI=
FT |
>> > > +         dr << ADS1015_CFG_DR_SHIFT;
>> > >
>> > > - ret =3D regmap_update_bits_check(data->regmap, ADS1015_CFG_REG,
>> > > -                                ADS1015_CFG_MUX_MASK |
>> > > -                                ADS1015_CFG_PGA_MASK |
>> > > -                                ADS1015_CFG_DR_MASK,
>> > > -                                chan << ADS1015_CFG_MUX_SHIFT |
>> > > -                                pga << ADS1015_CFG_PGA_SHIFT |
>> > > -                                dr << ADS1015_CFG_DR_SHIFT,
>> > > -                                &change);
>> > > - if (ret < 0)
>> > > + cfg =3D (old & ~mask) | (cfg & mask);
>> > > +
>> > > + ret =3D regmap_write(data->regmap, ADS1015_CFG_REG, cfg);
>> > > + if (ret)
>> > >           return ret;
>> > >
>> > > - if (change || data->conv_invalid) {
>> > > -         conv_time =3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[d=
r]);
>> > > + if (old !=3D cfg || data->conv_invalid) {
>> > > +         int dr_old =3D (old & ADS1015_CFG_DR_MASK) >>
>> > > +                         ADS1015_CFG_DR_SHIFT;
>> > > +
>> > > +         conv_time =3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[d=
r_old]);
>> > > +         conv_time +=3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[=
dr]);
>> > >           usleep_range(conv_time, conv_time + 1);
>> > >           data->conv_invalid =3D false;
>> > >   }
>
> Btw, this could be optimized futher this way:
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -240,7 +240,7 @@ static int ads1015_set_power_state(struct ads1015_dat=
a *data, bool on)
>  static
>  int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val=
)
>  {
> -       int ret, pga, dr, conv_time;
> +       int ret, pga, dr, dr_old, conv_time;
>         unsigned int old, mask, cfg;
>
>         if (chan < 0 || chan >=3D ADS1015_CHANNELS)
> @@ -256,17 +256,14 @@ int ads1015_get_adc_result(struct ads1015_data *dat=
a, int chan, int *val)
>                 ADS1015_CFG_DR_MASK;
>         cfg =3D chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SH=
IFT |
>                 dr << ADS1015_CFG_DR_SHIFT;
> -
>         cfg =3D (old & ~mask) | (cfg & mask);
>
> -       ret =3D regmap_write(data->regmap, ADS1015_CFG_REG, cfg);
> -       if (ret)
> -               return ret;
> -
>         if (old !=3D cfg || data->conv_invalid) {
> -               int dr_old =3D (old & ADS1015_CFG_DR_MASK) >>
> -                               ADS1015_CFG_DR_SHIFT;
> +               ret =3D regmap_write(data->regmap, ADS1015_CFG_REG, cfg);
> +               if (ret)
> +                       return ret;

You can also skip config register write in the case old =3D=3D cfg &&
data->conv_invalid.

> +               dr_old =3D (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_=
SHIFT;
>                 conv_time =3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[=
dr_old]);
>                 conv_time +=3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate=
[dr]);
>                 usleep_range(conv_time, conv_time + 1);
>
>
> Now that conv_time is too picky, at first "ADS1015EVM, ADS1115EVM,
> ADS1015EVM-PDK, ADS1115EVM-PDK User Guide (Rev. B)" [*] states at page 16=
:
> "Note that both the ADS1115 and ADS1015 have internal clocks with a =C2=
=B110%
> accuracy. If performing FFT tests, frequencies may appear to be incorrect
> as a result of this tolerance range.", so we should add at least those 10=
%
> and at second conv_time + 1 is too precise, increasing number of undesire=
d
> interrupts, so adding min(dr_period, dr_old_period) instead of 1 should d=
o
> the trick.

Can we just simply do like below?

        conv_time =3D conv_time * 11 / 10

or

        conv_time +=3D conv_time / 10;

> But the real showstopper is increasing probability of reading stale resul=
t
> with lowering sample frequency, to debug this following dirty modificatio=
n
> was made to driver:
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -269,6 +269,11 @@ int ads1015_get_adc_result(struct ads1015_data *data=
, int chan, int *val)
>
>                 conv_time =3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[=
dr_old]);
>                 conv_time +=3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate=
[dr]);
> +               for (ret =3D 0; ret < 20; ret++) {
> +                       regmap_read(data->regmap, ADS1015_CONV_REG, val);
> +                       printk("%d -> %d\n", ret, *val);
> +                       usleep_range(conv_time, conv_time + 1);
> +               }
>                 usleep_range(conv_time, conv_time + 1);
>                 data->conv_invalid =3D false;
>         }
>
> With ADS1015 and sampling frequency set to 128 SPS this leads to:
> $ cat in_voltage0_raw && cat in_voltage1_raw
> [285276.998382] mode 0
> [285277.005096] cfg 4003
> [285277.015380] 0 -> 13713
> [285277.037109] 1 -> 13713
> [285277.058898] 2 -> 13713
> [285277.080291] 3 -> 13713
> [285277.101715] 4 -> 13713
> [285277.123291] 5 -> 13713
> [285277.144836] 6 -> 13704
> [285277.166503] 7 -> 13704
> [285277.188262] 8 -> 13704
> [285277.210083] 9 -> 13704
> [285277.231811] 10 -> 13704
> [285277.253570] 11 -> 13704
> [285277.275390] 12 -> 3083
> [285277.296936] 13 -> 3083
> [285277.318023] 14 -> 3083
> [285277.339172] 15 -> 3083
> [285277.360076] 16 -> 3083
> [285277.381164] 17 -> 3083
> [285277.402252] 18 -> 3076
> [285277.423339] 19 -> 3076
> 192
> [285277.463623] cfg 5003
> [285277.468933] 0 -> 3076
> [285277.489746] 1 -> 3076
> [285277.510955] 2 -> 3074
> [285277.531585] 3 -> 3074
> [285277.552612] 4 -> 3074
> [285277.573272] 5 -> 3074
> [285277.594207] 6 -> 3074
> [285277.615173] 7 -> 3074
> [285277.636016] 8 -> 13702
> [285277.657073] 9 -> 13702
> [285277.678131] 10 -> 13702
> [285277.699493] 11 -> 13702
> [285277.721374] 12 -> 13702
> [285277.742492] 13 -> 13702
> [285277.763702] 14 -> 13701
> [285277.784820] 15 -> 13701
> [285277.806030] 16 -> 13701
> [285277.827178] 17 -> 13701
> [285277.848480] 18 -> 13701
> [285277.869689] 19 -> 13701
> 856
>
> As you can see, it took way longer to switch channel than sampling prerio=
d.
> Anyone has a clue what is going on here?

Looks like your device is ADS1115 but you use it as ADS1015.

The slowest sampling rate is 128 SPS for ads1015 and 8 SPS for ads1115
when DR field in config register is set to zero.  According to the kernel
debug log message that you have added, the device is working with 8 SPS.

> Thank you,
>         ladis
>
> [*] http://www.ti.com/lit/ug/sbau157b/sbau157b.pdf
