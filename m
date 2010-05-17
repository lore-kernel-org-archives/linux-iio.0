Return-Path: <Sonic.Zhang@analog.com>
From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Cc: "Song, Barry" <Barry.Song@analog.com>,
	<linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Manuel Stahl" <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: IIO driver merge plans (for next merge window)
Date: Mon, 17 May 2010 14:18:19 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA0620F10A@chinexm1.ad.analog.com>
In-Reply-To: <4BE18CAD.5090506@cam.ac.uk>
References: <4BD5F4A8.7020309@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA048553F4@chinexm1.ad.analog.com> 	<4BD6ADFA.4050500@cam.ac.uk> <i2g3c17e3571005050037qbcc3ebc8h47aaa087913bf15d@mail.gmail.com> <4BE18CAD.5090506@cam.ac.uk>
To: "Jonathan Cameron" <jic23@cam.ac.uk>,
	"Barry Song" <21cnbao@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Yes, we can send the driver patches to linux-iio after it passes
debugging in local SVN. But, since the kernel version and iio tree base
in our SVN are different from yours, we have to port the patches before
posting. And we don't ensure the new patches still run without problem
in your tree, until your tree is merged into mainline and updated to our
local SVN.


Sonic


>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@cam.ac.uk]=20
>Sent: Wednesday, May 05, 2010 11:20 PM
>To: Barry Song
>Cc: Song, Barry; linux-iio@vger.kernel.org; Zhang, Sonic;=20
>Hennerich, Michael; Manuel Stahl
>Subject: Re: IIO driver merge plans (for next merge window)
>
>On 05/05/10 08:37, Barry Song wrote:
>> Just note adis16209 is in the tested list too:
>> drivers/staging/iio/accel/
>
>Cool, I've done a quick import on top of Greg's tree and it=20
>all seems good.
>(required half a dozen name changes and some addition=20
>dependencies in Kconfig).
>
>How do you guys want to handle mainlining drivers from now on.=20
> I know Michael has requested a merge of the iio changes from=20
>Greg's tree into yours so as to fix everything up in one go. =20
>Do you want to wait for that and then send them on, or if not=20
>I can keep doing quick merges of necessary change and=20
>forwarding to Greg as you tell me they are tested?
>
>The best option to me, would be if you guys started by=20
>initially posting the drivers to linux-iio so we can clean any=20
>big issues up before they hit the tree.
>Then either after making any requested changes or getting a=20
>few positive responses (or a lack of response for a few days -=20
>which is acceptable here given we are still in staging!) send=20
>them on to Greg KH for the actual merge.  For this one I will=20
>start the ball rolling by posting this particular driver to=20
>linux-iio (and commenting on it myself later today).
>
>Jonathan
>>=20
>> On Tue, Apr 27, 2010 at 5:27 PM, Jonathan Cameron=20
><jic23@cam.ac.uk> wrote:
>>> On 04/27/10 04:20, Song, Barry wrote:
>>>> Drivers that passed debugging and testing on hardware can=20
>be pushed=20
>>>> to mainline. By now, ADIS16300 and ADIS16400 drivers are on the=20
>>>> list. But the problem is they are based on old abi, will=20
>you change=20
>>>> codes to match new abi? If no, we can update codes after you merge=20
>>>> the new abi into mainline.
>>>
>>> Sure.  I'll take a look at those and see what the best merge=20
>>> technique is.  Hopefully we can tack those on to the end of the abi=20
>>> patch series and do it in two stages.
>>>
>>> Jonathan
>>>> Thanks
>>>> Barry
>>>>
>>>> -----Original Message-----
>>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>>> Sent: Tue 4/27/2010 4:16 AM
>>>> To: linux-iio@vger.kernel.org
>>>> Cc: Song, Barry; Zhang, Sonic; Hennerich, Michael; Manuel Stahl
>>>> Subject: IIO driver merge plans (for next merge window)
>>>>
>>>> Hi All,
>>>>
>>>> It is getting to that point of the kernel development=20
>cycle where we=20
>>>> want to start thinking about which drivers to push out to Greg in=20
>>>> plenty of time for the next merge window.  If possible I'd like to=20
>>>> see some of them moving over to the new abi.  However,=20
>given we are=20
>>>> in staging anyway, we can always merge them first and change them=20
>>>> later!  Obviously the question of whether the abi changes merge in=20
>>>> time is down to what feedback they generate so that may further=20
>>>> complicate things.
>>>>
>>>> I see there are loads from Analog in the blackfin tree and=20
>based on=20
>>>> a quick glance at the source they are all in pretty good=20
>state.  The=20
>>>> only holes I can see are possibly in documentation and that is=20
>>>> probably more a case of adding things to the abi docs (in=20
>my latest=20
>>>> patch set) than anything else.
>>>>
>>>> Barry, Sonic, Michael, what are your current plans for mainlining?
>>>> (as much as staging is mainline anyway)
>>>>
>>>> I see you guys have started adding ring support.  How are you=20
>>>> finding that element?  I'm still far from sure we have gotten that=20
>>>> bit right yet!  I'm going to have a play with the new FIFO=20
>>>> implementation and see if that provides at the very least=20
>and easier=20
>>>> to review alternative to the current buffer.
>>>>
>>>> Would also be great to start merging DAC and DDS support from your=20
>>>> tree and finally justify the output element of IIO.
>>>>
>>>> I know Manuel has a couple of drivers as well. Sorry to anyone I=20
>>>> have forgotten.  Please post your drivers!
>>>>
>>>> If people want assistance with moving over to the new abi,=20
>then I'm=20
>>>> happy to convert drivers, but obviously would need people to test=20
>>>> that I haven't broken anything in the process.
>>>>
>>>> With a bit of luck I'll clean up a few half written drivers I have=20
>>>> and perhaps look at pulling in the other light sensors now=20
>that ALS=20
>>>> has bitten the dust.
>>>>
>>>> Looking forward to seeing lots of drivers!
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>>>
>>>> p.s. If anyone has a chance to glance over the latest patch set,=20
>>>> that would be great.
>>>>
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe=20
>linux-iio"=20
>>> in the body of a message to majordomo@vger.kernel.org More=20
>majordomo=20
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>=20
>
>
