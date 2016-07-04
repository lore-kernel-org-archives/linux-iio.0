Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <cover.1467023672.git.gregor.boirie@parrot.com>
References: <cover.1467023672.git.gregor.boirie@parrot.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Jul 2016 10:15:31 +0200
Message-ID: <CACRpkda4EHpH-TtqEZgFN28gEw463HCX-7BdR=-i74fSs-4ByQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] iio:st_pressure: improvements
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan Leonard <leonard.crestez@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

I pulled in the version from Gregor on
https://github.com/grgbr/linux-iio/tree/iio-togreg-lps22hb

And then cherry-picked some fixes etc to get the Ux500 up
properly. Results:

:/ lsiio
(...)
Device 005: lps001wp

cd /sys/bus/iio/devices/iio\:device5/
$ cat in_pressure_raw && cat in_temp_raw
15658
1673

OK looks reasonable, but it is unscaled so let's run generic
buffer:

Using an HRtimer trigger foo:

$ generic_buffer -a -c10 -n lps001wp
iio device number being used is 5
Failed to find the trigger lps001wp-trigger
root@Ux500:/ generic_buffer -a -c10 -n lps001wp -t foo
iio device number being used is 5
iio trigger number being used is 3
No channels are enabled, enabling all channels
Enabling: in_temp_en
Enabling: in_pressure_en
Enabling: in_timestamp_en
/sys/bus/iio/devices/iio:device5 foo
97.849998 26140.625000 946685067925048828
97.849998 26140.625000 946685067935028076
97.849998 26140.625000 946685067945465087
97.849998 26500.000000 946685067955474853
97.849998 26500.000000 946685067965332031
97.849998 26500.000000 946685067975311279
97.849998 26500.000000 946685067985351562
97.849998 26500.000000 946685067995117187
97.849998 26500.000000 946685068005340576
97.849998 26500.000000 946685068015319824
Disabling: in_temp_en
Disabling: in_pressure_en
Disabling: in_timestamp_en

97.8 kPa
26.5 degrees celsius

The pressure is way too low but it is a known problem with this
particular sensor (same issue before patches, I guess it needs
recalibration). Patches seem ready to go!

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
