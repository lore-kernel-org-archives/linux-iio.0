Return-Path: <Sonic.Zhang@analog.com>
From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Cc: "Song, Barry" <Barry.Song@analog.com>,
	<linux-iio@vger.kernel.org>,
	"Manuel Stahl" <manuel.stahl@iis.fraunhofer.de>,
	"Frysinger, Michael" <Michael.Frysinger@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: IIO driver merge plans (for next merge window)
Date: Mon, 17 May 2010 16:06:00 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA0620F2DC@chinexm1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E568FC168@LIMKCMBX1.ad.analog.com>
References: <4BD5F4A8.7020309@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA048553F4@chinexm1.ad.analog.com> 	<4BD6ADFA.4050500@cam.ac.uk> <i2g3c17e3571005050037qbcc3ebc8h47aaa087913bf15d@mail.gmail.com> <4BE18CAD.5090506@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA0620F10A@chinexm1.ad.analog.com> <544AC56F16B56944AEC3BD4E3D5917712E568FC168@LIMKCMBX1.ad.analog.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Jonathan Cameron" <jic23@cam.ac.uk>,
	"Barry Song" <21cnbao@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

=20

>-----Original Message-----
>From: Hennerich, Michael=20
>Sent: Monday, May 17, 2010 3:48 PM
>To: Zhang, Sonic; Jonathan Cameron; Barry Song
>Cc: Song, Barry; linux-iio@vger.kernel.org; Manuel Stahl;=20
>Frysinger, Michael
>Subject: RE: IIO driver merge plans (for next merge window)
>
>Zhang, Sonic wrote on 2010-05-17:
>> Hi Jonathan,
>>=20
>> Yes, we can send the driver patches to linux-iio after it passes=20
>> debugging in local SVN. But, since the kernel version and iio tree=20
>> base in our SVN are different from yours, we have to port=20
>the patches=20
>> before posting. And we don't ensure the new patches still=20
>run without=20
>> problem in your tree, until your tree is merged into mainline and=20
>> updated to our local SVN.
>
>Sonic,
>
>How about we merge Greg's staging iio folder into our svn right now?
>This way we can do the API fixes to our drivers and send them=20
>also to Greg for inclusion without greater delays.
>

It is OK to merge the IIO patches if they don't care about kernel
version difference between Greg's tree and our SVN tree. Our's is
2.6.33.4, while Greg's is 2.6.34-rc6



Sonic


>-Michael=20
>
>>=20
>>=20
>> Sonic
>>=20
>>=20
>>> -----Original Message-----
>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>> Sent: Wednesday, May 05, 2010 11:20 PM
>>> To: Barry Song
>>> Cc: Song, Barry; linux-iio@vger.kernel.org; Zhang, Sonic;=20
>Hennerich,=20
>>> Michael; Manuel Stahl
>>> Subject: Re: IIO driver merge plans (for next merge window)
>>>=20
>>> On 05/05/10 08:37, Barry Song wrote:
>>>> Just note adis16209 is in the tested list too:
>>>> drivers/staging/iio/accel/
>>>=20
>>> Cool, I've done a quick import on top of Greg's tree and it=20
>all seems=20
>>> good.
>>> (required half a dozen name changes and some addition=20
>dependencies in=20
>>> Kconfig).
>>>=20
>>> How do you guys want to handle mainlining drivers from now on.
>>> I know Michael has requested a merge of the iio changes from Greg's=20
>>> tree into yours so as to fix everything up in one go.
>>> Do you want to wait for that and then send them on, or if not I can=20
>>> keep doing quick merges of necessary change and forwarding=20
>to Greg as=20
>>> you tell me they are tested?
>>>=20
>>> The best option to me, would be if you guys started by initially=20
>>> posting the drivers to linux-iio so we can clean any big issues up=20
>>> before they hit the tree. Then either after making any requested=20
>>> changes or getting a few positive responses (or a lack of response=20
>>> for a few days - which is acceptable here given we are still in=20
>>> staging!) send them on to Greg KH for the actual merge. =20
>For this one=20
>>> I will start the ball rolling by posting this particular driver to=20
>>> linux-iio (and commenting on it myself later today).
>>>=20
>>> Jonathan
>>>>=20
>>>> On Tue, Apr 27, 2010 at 5:27 PM, Jonathan Cameron
>>> <jic23@cam.ac.uk> wrote:
>>>>> On 04/27/10 04:20, Song, Barry wrote:
>>>>>> Drivers that passed debugging and testing on hardware can be=20
>>>>>> pushed to mainline. By now, ADIS16300 and ADIS16400=20
>drivers are on=20
>>>>>> the list. But the problem is they are based on old abi, will you=20
>>>>>> change codes to match new abi? If no, we can update codes after=20
>>>>>> you merge the new abi into mainline.
>>>>>=20
>>>>> Sure.  I'll take a look at those and see what the best merge=20
>>>>> technique is.  Hopefully we can tack those on to the end=20
>of the abi=20
>>>>> patch series and do it in two stages.
>>>>>=20
>>>>> Jonathan
>>>>>> Thanks
>>>>>> Barry
>>>>>>=20
>>>>>> -----Original Message-----
>>>>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>>>>> Sent: Tue 4/27/2010 4:16 AM
>>>>>> To: linux-iio@vger.kernel.org
>>>>>> Cc: Song, Barry; Zhang, Sonic; Hennerich, Michael; Manuel Stahl
>>>>>> Subject: IIO driver merge plans (for next merge window)
>>>>>>=20
>>>>>> Hi All,
>>>>>>=20
>>>>>> It is getting to that point of the kernel development=20
>cycle where=20
>>>>>> we want to start thinking about which drivers to push=20
>out to Greg=20
>>>>>> in plenty of time for the next merge window.  If=20
>possible I'd like=20
>>>>>> to see some of them moving over to the new abi. =20
>However, given we=20
>>>>>> are in staging anyway, we can always merge them first and change=20
>>>>>> them later!  Obviously the question of whether the abi changes=20
>>>>>> merge in time is down to what feedback they generate so that may=20
>>>>>> further complicate things.
>>>>>>=20
>>>>>> I see there are loads from Analog in the blackfin tree and based=20
>>>>>> on a quick glance at the source they are all in pretty=20
>good state. =20
>>>>>> The only holes I can see are possibly in documentation=20
>and that is=20
>>>>>> probably more a case of adding things to the abi docs (in my=20
>>>>>> latest patch set) than anything else.
>>>>>>=20
>>>>>> Barry, Sonic, Michael, what are your current plans for=20
>mainlining?
>>>>>> (as much as staging is mainline anyway)
>>>>>>=20
>>>>>> I see you guys have started adding ring support.  How are you=20
>>>>>> finding that element?  I'm still far from sure we have=20
>gotten that=20
>>>>>> bit right yet!  I'm going to have a play with the new FIFO=20
>>>>>> implementation and see if that provides at the very least and=20
>>>>>> easier to review alternative to the current buffer.
>>>>>>=20
>>>>>> Would also be great to start merging DAC and DDS support=20
>from your=20
>>>>>> tree and finally justify the output element of IIO.
>>>>>>=20
>>>>>> I know Manuel has a couple of drivers as well. Sorry to anyone I=20
>>>>>> have forgotten.  Please post your drivers!
>>>>>>=20
>>>>>> If people want assistance with moving over to the new abi, then=20
>>>>>> I'm happy to convert drivers, but obviously would need people to=20
>>>>>> test that I haven't broken anything in the process.
>>>>>>=20
>>>>>> With a bit of luck I'll clean up a few half written=20
>drivers I have=20
>>>>>> and perhaps look at pulling in the other light sensors now that=20
>>>>>> ALS has bitten the dust.
>>>>>>=20
>>>>>> Looking forward to seeing lots of drivers!
>>>>>>=20
>>>>>> Thanks,
>>>>>>=20
>>>>>> Jonathan
>>>>>>=20
>>>>>> p.s. If anyone has a chance to glance over the latest patch set,=20
>>>>>> that would be great.
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> -- To unsubscribe from this list: send the line "unsubscribe=20
>>>>> linux-iio" in the body of a message to majordomo@vger.kernel.org=20
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>=20
>>>>=20
>>>=20
>>>
>
>Greetings,
>Michael
>
>Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
>Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB=20
>4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
>
>
