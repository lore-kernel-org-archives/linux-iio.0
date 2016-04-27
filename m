Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:10892 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbcD0NHT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 Apr 2016 09:07:19 -0400
Message-ID: <5720B9DA.1000409@parrot.com>
Date: Wed, 27 Apr 2016 15:08:42 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>
Subject: Re: [RFC PATCH v1 0/9] iio:st_sensors: fixes and lps22hb pressure
 sensor
References: <cover.1461056711.git.gregor.boirie@parrot.com>	<CACRpkdZxE4Z6f_0uVV0sD5EUxEigzbMvWRD+MTDWNZbuauVweg@mail.gmail.com> <CACRpkdZ=DSEKi6dOBuxA23ivsQYsoigvG_cC11HR-66aN_BUpQ@mail.gmail.com>
In-Reply-To: <CACRpkdZ=DSEKi6dOBuxA23ivsQYsoigvG_cC11HR-66aN_BUpQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Many thanks for taking time to test this. ~95 kPa seems rather a small 
value to me.

For reference, it seems 950 hPa at sea level would be found under a... 
hurricane !
(may vary with location)

Does it match with your local weather forecast / report ?
grégor

On 04/27/2016 02:02 PM, Linus Walleij wrote:
> On Wed, Apr 27, 2016 at 1:26 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> After the patch:
>>
>> $ cat in_pressure_raw && cat in_temp_raw
>> 15232
>> 1652
>> $ cat in_pressure_raw && cat in_temp_raw
>> 15233
>> 1656
>> $ cat in_pressure_raw && cat in_temp_raw
>> 15234
>> 1657
> And now I also have in_pressure_scale and in_temp_scale,
> which yields these values if I multiply each tuple with the
> scale factor:
>
> 95.2
> 25812.5
> 95.2
> 25875
> 95.2
> 25890
>
> So ~95 kPa, 25.8 degrees celsius.
> Seems like my office environment.
> An atmosphere is ~100 kPa IIRC.
>
> Yours,
> Linus Walleij

