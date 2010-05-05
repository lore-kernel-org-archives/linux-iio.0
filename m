Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4BD6ADFA.4050500@cam.ac.uk>
References: <4BD5F4A8.7020309@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA048553F4@chinexm1.ad.analog.com>
	<4BD6ADFA.4050500@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 5 May 2010 15:37:08 +0800
Message-ID: <i2g3c17e3571005050037qbcc3ebc8h47aaa087913bf15d@mail.gmail.com>
Subject: Re: IIO driver merge plans (for next merge window)
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
	"Zhang, Sonic" <Sonic.Zhang@analog.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Just note adis16209 is in the tested list too:
drivers/staging/iio/accel/

On Tue, Apr 27, 2010 at 5:27 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 04/27/10 04:20, Song, Barry wrote:
>> Drivers that passed debugging and testing on hardware can be pushed
>> to mainline. By now, ADIS16300 and ADIS16400 drivers are on the
>> list. But the problem is they are based on old abi, will you change
>> codes to match new abi? If no, we can update codes after you merge
>> the new abi into mainline.
>
> Sure. =C2=A0I'll take a look at those and see what the best merge techniq=
ue
> is. =C2=A0Hopefully we can tack those on to the end of the abi patch seri=
es
> and do it in two stages.
>
> Jonathan
>> Thanks
>> Barry
>>
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>> Sent: Tue 4/27/2010 4:16 AM
>> To: linux-iio@vger.kernel.org
>> Cc: Song, Barry; Zhang, Sonic; Hennerich, Michael; Manuel Stahl
>> Subject: IIO driver merge plans (for next merge window)
>>
>> Hi All,
>>
>> It is getting to that point of the kernel development cycle where we
>> want to start thinking about which drivers to push out to Greg in
>> plenty of time for the next merge window. =C2=A0If possible I'd like to
>> see some of them moving over to the new abi. =C2=A0However, given we are
>> in staging anyway, we can always merge them first and change them
>> later! =C2=A0Obviously the question of whether the abi changes merge
>> in time is down to what feedback they generate so that may further
>> complicate things.
>>
>> I see there are loads from Analog in the blackfin tree and based on
>> a quick glance at the source they are all in pretty good state. =C2=A0Th=
e
>> only holes I can see are possibly in documentation and that is probably
>> more a case of adding things to the abi docs (in my latest patch set)
>> than anything else.
>>
>> Barry, Sonic, Michael, what are your current plans for mainlining?
>> (as much as staging is mainline anyway)
>>
>> I see you guys have started adding ring support. =C2=A0How are you findi=
ng
>> that element? =C2=A0I'm still far from sure we have gotten that bit righ=
t
>> yet! =C2=A0I'm going to have a play with the new FIFO implementation and
>> see if that provides at the very least and easier to review alternative
>> to the current buffer.
>>
>> Would also be great to start merging DAC and DDS support from your tree =
and
>> finally justify the output element of IIO.
>>
>> I know Manuel has a couple of drivers as well. Sorry to anyone I have
>> forgotten. =C2=A0Please post your drivers!
>>
>> If people want assistance with moving over to the new abi, then I'm happ=
y
>> to convert drivers, but obviously would need people to test that I haven=
't
>> broken anything in the process.
>>
>> With a bit of luck I'll clean up a few half written drivers I have
>> and perhaps look at pulling in the other light sensors now that ALS
>> has bitten the dust.
>>
>> Looking forward to seeing lots of drivers!
>>
>> Thanks,
>>
>> Jonathan
>>
>> p.s. If anyone has a chance to glance over the latest patch set, that wo=
uld
>> be great.
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
