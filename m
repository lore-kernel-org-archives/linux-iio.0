Return-Path: <SRS0=T1uy=45=cogentembedded.com=nikita.yoush@kernel.org>
Subject: Re: [PATCH 4/4] iio: hi8435: cleanup reset gpio
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Ranostay <mranostay@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
 <18fc343b-d7a4-c5b8-84e6-702af6e94e44@cogentembedded.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeff White <Jeff.White@zii.aero>, Chris Healy <Chris.Healy@zii.aero>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <4ba5a0ce-d443-bdf0-bb23-9941b7db59a4@cogentembedded.com>
Date: Tue, 23 May 2017 11:18:26 +0300
MIME-Version: 1.0
In-Reply-To: <18fc343b-d7a4-c5b8-84e6-702af6e94e44@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

>> Reset GPIO is active low.
>>
>> Currently driver uses gpiod_set_value(1) to clean reset, which depends
>> on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.
>>
>> This fixes driver to use _raw version of gpiod_set_value() to enforce
>> active-low semantics despite of what's written in device tree. Allowing
>> device tree to override that only opens possibility for errors and does
>> not add any value.
>>
>> Additionally, use _cansleep version to make things work with i2c-gpio
>> and other sleeping gpio drivers.
> 
> The reset gpio comes from platform hence it should be handled by DTS.
> 
> In driver the gpio should not be raw.
> 
> Even the hi8435 is active low but platform may invert signal (f.e. by
> adding trigger on the circuit path).

I see.  However - isn't this pure theoretic?  Does such case exist?

In vast majority of cases, GPIO polarity is chip-specific, not
chip-use-specific.  Thus this knowlege belongs to driver and not to
device tree describing particular chip usage.  Having this always
defined at usage side is IMO major source of errors.

In this particular case, we already have device trees in the wild with
polarity set to active_high.  If we now change that to require
active_low, we break existing setups.  Not sure this is acceptable.

I'm unsure what is good way forward here. I believe it is at gpiolib
level, which perhaps should change how "logical value" is defined, such
that knowledge of chip-specific information is not forced to chip usage
scope.

Nikita
