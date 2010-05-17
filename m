Return-Path: <Michael.Hennerich@analog.com>
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>, Jonathan Cameron
	<jic23@cam.ac.uk>, Barry Song <21cnbao@gmail.com>
Cc: "Song, Barry" <Barry.Song@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Manuel Stahl
	<manuel.stahl@iis.fraunhofer.de>, "Frysinger, Michael"
	<Michael.Frysinger@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Date: Mon, 17 May 2010 09:08:34 +0100
Subject: RE: IIO driver merge plans (for next merge window)
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E568FC17D@LIMKCMBX1.ad.analog.com>
References: <4BD5F4A8.7020309@cam.ac.uk>
 <0F1B54C89D5F954D8535DB252AF412FA048553F4@chinexm1.ad.analog.com>
 	<4BD6ADFA.4050500@cam.ac.uk>
 <i2g3c17e3571005050037qbcc3ebc8h47aaa087913bf15d@mail.gmail.com>
 <4BE18CAD.5090506@cam.ac.uk>
 <0F1B54C89D5F954D8535DB252AF412FA0620F10A@chinexm1.ad.analog.com>
 <544AC56F16B56944AEC3BD4E3D5917712E568FC168@LIMKCMBX1.ad.analog.com>
 <0F1B54C89D5F954D8535DB252AF412FA0620F2DC@chinexm1.ad.analog.com>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA0620F2DC@chinexm1.ad.analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Zhang, Sonic wrote on 2010-05-17:
>
>
>> -----Original Message-----
>> From: Hennerich, Michael
>> Sent: Monday, May 17, 2010 3:48 PM
>> To: Zhang, Sonic; Jonathan Cameron; Barry Song
>> Cc: Song, Barry; linux-iio@vger.kernel.org; Manuel Stahl; Frysinger,
>> Michael
>> Subject: RE: IIO driver merge plans (for next merge window)
>>
>> Zhang, Sonic wrote on 2010-05-17:
>>> Hi Jonathan,
>>>
>>> Yes, we can send the driver patches to linux-iio after it passes
>>> debugging in local SVN. But, since the kernel version and iio tree
>>> base in our SVN are different from yours, we have to port the patches
>>> before posting. And we don't ensure the new patches still run without
>>> problem in your tree, until your tree is merged into mainline and
>>> updated to our local SVN.
>>
>> Sonic,
>>
>> How about we merge Greg's staging iio folder into our svn right now?
>> This way we can do the API fixes to our drivers and send them also to
>> Greg for inclusion without greater delays.
>>
>
> It is OK to merge the IIO patches if they don't care about kernel
> version difference between Greg's tree and our SVN tree. Our's is
> 2.6.33.4, while Greg's is 2.6.34-rc6

staging-iio is pretty much self contained.
As far I can tell it doesn't depend on anything that has been changed
between 2.6.33 and 2.6.34.

-Michael

>
>
>
> Sonic
>
>
>> -Michael
>>
>>>
>>>
>>> Sonic
>>>
>>>
>>>> -----Original Message----- From: Jonathan Cameron
>>>> [mailto:jic23@cam.ac.uk] Sent: Wednesday, May 05, 2010 11:20 PM To:
>>>> Barry Song Cc: Song, Barry; linux-iio@vger.kernel.org; Zhang, Sonic;
>>>> Hennerich, Michael; Manuel Stahl Subject: Re: IIO driver merge plans
>>>> (for next merge window)
>>>>
>>>> On 05/05/10 08:37, Barry Song wrote:
>>>>> Just note adis16209 is in the tested list too:
>>>>> drivers/staging/iio/accel/
>>>>
>>>> Cool, I've done a quick import on top of Greg's tree and it all seems
>>>> good. (required half a dozen name changes and some addition
>>>> dependencies in Kconfig).
>>>>
>>>> How do you guys want to handle mainlining drivers from now on. I know
>>>> Michael has requested a merge of the iio changes from Greg's tree
>>>> into yours so as to fix everything up in one go. Do you want to wait
>>>> for that and then send them on, or if not I can keep doing quick
>>>> merges of necessary change and forwarding to Greg as you tell me they
>>>> are tested?
>>>>
>>>> The best option to me, would be if you guys started by initially
>>>> posting the drivers to linux-iio so we can clean any big issues up
>>>> before they hit the tree. Then either after making any requested
>>>> changes or getting a few positive responses (or a lack of response
>>>> for a few days - which is acceptable here given we are still in
>>>> staging!) send them on to Greg KH for the actual merge. For this one
>>>> I will start the ball rolling by posting this particular driver to
>>>> linux-iio (and commenting on it myself later today).
>>>>
>>>> Jonathan
>>>>>
>>>>> On Tue, Apr 27, 2010 at 5:27 PM, Jonathan Cameron
>>>> <jic23@cam.ac.uk> wrote:
>>>>>> On 04/27/10 04:20, Song, Barry wrote:
>>>>>>> Drivers that passed debugging and testing on hardware can be
>>>>>>> pushed to mainline. By now, ADIS16300 and ADIS16400 drivers are on
>>>>>>> the list. But the problem is they are based on old abi, will you
>>>>>>> change codes to match new abi? If no, we can update codes after
>>>>>>> you merge the new abi into mainline.
>>>>>>
>>>>>> Sure.  I'll take a look at those and see what the best merge
>>>>>> technique is.  Hopefully we can tack those on to the end of the abi
>>>>>> patch series and do it in two stages.
>>>>>>
>>>>>> Jonathan
>>>>>>> Thanks
>>>>>>> Barry
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>>>>>> Sent: Tue 4/27/2010 4:16 AM
>>>>>>> To: linux-iio@vger.kernel.org
>>>>>>> Cc: Song, Barry; Zhang, Sonic; Hennerich, Michael; Manuel Stahl
>>>>>>> Subject: IIO driver merge plans (for next merge window)
>>>>>>>
>>>>>>> Hi All,
>>>>>>>
>>>>>>> It is getting to that point of the kernel development cycle where
>>>>>>> we want to start thinking about which drivers to push out to Greg
>>>>>>> in plenty of time for the next merge window.  If possible I'd like
>>>>>>> to see some of them moving over to the new abi. However, given we
>>>>>>> are in staging anyway, we can always merge them first and change
>>>>>>> them later!  Obviously the question of whether the abi changes
>>>>>>> merge in time is down to what feedback they generate so that may
>>>>>>> further complicate things.
>>>>>>>
>>>>>>> I see there are loads from Analog in the blackfin tree and based
>>>>>>> on a quick glance at the source they are all in pretty good state.
>>>>>>> The only holes I can see are possibly in documentation and that is
>>>>>>> probably more a case of adding things to the abi docs (in my
>>>>>>> latest patch set) than anything else.
>>>>>>>
>>>>>>> Barry, Sonic, Michael, what are your current plans for mainlining?
>>>>>>> (as much as staging is mainline anyway)
>>>>>>>
>>>>>>> I see you guys have started adding ring support.  How are you
>>>>>>> finding that element?  I'm still far from sure we have gotten that
>>>>>>> bit right yet!  I'm going to have a play with the new FIFO
>>>>>>> implementation and see if that provides at the very least and
>>>>>>> easier to review alternative to the current buffer.
>>>>>>>
>>>>>>> Would also be great to start merging DAC and DDS support from your
>>>>>>> tree and finally justify the output element of IIO.
>>>>>>>
>>>>>>> I know Manuel has a couple of drivers as well. Sorry to anyone
>>>>>>> I have forgotten.  Please post your drivers!
>>>>>>>
>>>>>>> If people want assistance with moving over to the new abi, then
>>>>>>> I'm happy to convert drivers, but obviously would need people
>>>>>>> to test that I haven't broken anything in the process.
>>>>>>>
>>>>>>> With a bit of luck I'll clean up a few half written drivers I have
>>>>>>> and perhaps look at pulling in the other light sensors now that
>>>>>>> ALS has bitten the dust.
>>>>>>>
>>>>>>> Looking forward to seeing lots of drivers!
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Jonathan
>>>>>>>
>>>>>>> p.s. If anyone has a chance to glance over the latest patch
>>>>>>> set, that would be great.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> -- To unsubscribe from this list: send the line "unsubscribe
>>>>>> linux-iio" in the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo- info.html
>>>>>>
>>>>>
>>>>
>>>>
>>
>> Greetings,
>> Michael
>>
>> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
>> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB
>> 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret
>> Seif
>>
>>

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
