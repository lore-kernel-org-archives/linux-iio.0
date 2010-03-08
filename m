Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4B8FA897.1010303@cam.ac.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
	<4B82679F.3000807@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com>
	<4B83BF9E.9010208@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA05A5BE40@chinexm1.ad.analog.com>
	<4B853357.5070500@cam.ac.uk> <3c17e3571003020157rdd35bdpa6811e25301a646f@mail.gmail.com>
	<Prayer.1.3.2.1003021045350.17375@hermes-2.csi.cam.ac.uk>
	<3c17e3571003021926n506b39d0v480ddc9430dfe104@mail.gmail.com>
	<4B8FA897.1010303@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 8 Mar 2010 11:41:49 +0800
Message-ID: <3c17e3571003071941ief0d56ra20caa2d5a0ec4d2@mail.gmail.com>
Subject: Re: IIO ring buffer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: manuel.stahl@iis.fraunhofer.de, uclinux-dist-devel@blackfin.uclinux.org,
	linux-iio@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 4, 2010 at 8:33 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>
> Hi Barry,
>
> Sorry for the slow reply, been busy with the whole ALS thing
> (see lkml if you are interested) and chasing down some rtc issues.
>
> On 03/03/10 03:26, Barry Song wrote:
> > DACs like AD5624R/5644R/5664R(http://www.analog.com/en/digital-to-analo=
g-converters/da-converters/ad5624r/products/product.html)
> > have no clock input and internal buffer. Some users maybe use it to
> > get discrete analog signals, that means once one data is written to
> > AD5624R, one new analog signal is output, then we don't need ring
> > buffer.
> Makes sense, I guess for these we provide a sysfs type interface.
> > But some other users maybe want the AD5624R to create
> > continuous signals with a fixed frequency, then we need use ring
> > buffer with linked DMA to input data to AD5624R with a constant rate.
> > This case is same with audio play.
> > To implement that, we need
> > 1. Split ring buffer to some little fragments, one fragment is a DMA bl=
ock.
> Makes sense, though we probably need to be a little careful
> as not spi implementations are going to do this via dma.
> > 2. Ring buffer core layer must handle the play pointer and user
> > writing pointer, stop the DMA automatically when user data under-run
> > flows( valid data is less than one fragment in ring buffer)
> Probably a fifo rather than a ring buffer, but it doesn't change your
> point! At the moment I'm not seeing much shared functionality with the
> rest of IIO. =C2=A0Perhaps we treat DAC elements in a similar way to trig=
gers?
> That is a device may register them without registering anything else.
> Will keep matters nice and slim if we have devices such as this one that
> don't have any inputs. =C2=A0The only disadvantage I can see is when we h=
ave
> interesting interactions between the dac's and inputs (such as a feedback
> channel).
It should be a hardware ring buffer because we must have allocated it
by consistent way ahead. The buffer has been ready and DMA link has
been built when we begin any transfer. Sorry, i don't understand
clearly about treating DACs as trigggers you said, here i think we
only need interrupts/callbacks to update playback pointers.
>
> > 3. The DMA interrupt handler in the bottom driver should update the
> > play pointer by a ring buffer core API to notify the play status.
> > 4. The DMA should support =C2=A0linked mode, once one DMA block is
> > finished, another DMA fragment will be enabled by hardware
> > automatically except that it is disabled due to underflow.
> The complexity I can see here is interacting with the underlying bus.
> It may be that we need to propose some changes to the spi infrastructure,
> it order to get the hooks you are referring to. =C2=A0I'm really not keen=
 in
> reinventing the wheel and providing bus interfaces within IIO.
> If we have new buses or new requirements for existing bus subsystems,
> we should propose them separately. They will almost certainly be of use
> elsewhere anyway!
It maybe makes sense too to change current spi drivers. spi async mode
can help if we change blackfin sport spi
driver(http://blackfin.uclinux.org/gf/project/linux-kernel/scmsvn/?action=
=3Dbrowse&path=3D%2Ftrunk%2Fdrivers%2Fspi%2Fbfin_sport_spi.c&view=3Dmarkup&=
revision=3D8051)
to use linked DMA. DAC drivers only call spi_async and use the spi
completion callback to update playback pointer. And sport spi driver
manages the DMA link and keep the spi acccess running if there are
still spi messages.
The performance should be better if current spi can be improved to
support block mode but not manage spi transfer by single spi message.
The same problem will happen to i2c bus if there are similar DACs using i2c=
 bus.
>
> I've cc'd David and Grant to see if they have any initial comments on
> this or are aware of people doing similar stuff. =C2=A0(it's all a bit
> vague at the moment for a post to the spi mailing list). =C2=A0Maybe
> it is possible already to do this? =C2=A0Certainly looks like this is the
> first area to investigate to me.
>
> Thanks,
>
> Jonathan
>
>
> >
> > On Tue, Mar 2, 2010 at 6:45 PM, J.I. Cameron <jic23@cam.ac.uk> wrote:
> >> Hi Barry,
> >>
> >>> I know you are changing iio ring buffer. Here a problem to discuss
> >>> with you, there are maybe this kind of use cases: the DACs have no
> >>> internal clock and buffer, so we need an external bus with continuous
> >>> DMA to "play" data flow with constant speed. It is very similar with
> >>> alsa driver to play audio by I2S or AC97. ALSA framework is easy to
> >>> implement this kind of drivers. But our DACs are not audio cards. The=
n
> >>> in the iio ring buffer core, it seems we also need APIs like
> >>> trigger(), pointer(), snd_pcm_period_elapsed()... to get a common
> >>> framework.
> >>
> >> I have to admit I'm in general a little unclear on how one even goes a=
bout
> >> getting dma to occur at a constant speed. =C2=A0I'm afraid I haven't h=
ad much
> >> time to work on improving the ring buffer (though I will try and get a=
 patch
> >> out for one particular bug sometime today - if you get issues in the i=
nit
> >> function with spin locks). =C2=A0 Hence, I suggest that you propose an=
y changes
> >> you would like to see in the core, if possible with some code along si=
de
> >> relevant data sheets so those of us not so familiar with this area can
> >> better understand how this would work.
> >>
> >> My short term plans for the buffering is to allow use of the new
> >> implementation of kfifo as it allows dma transfers to occur directly i=
nto
> >> the buffer. =C2=A0Obviously this will involve adding a few new bits to=
 the api.
> >>
> >> That internal api is certainly far from locked in stone and as long as=
 we
> >> can mend any driver broken by changes, feel free to propose any change=
s you
> >> like!
> >>
> >>> Of course, we can let users to handle blocking in write()
> >>> callback like OSS, but alsa-like APIs should be better. So what's you=
r
> >>> opinion for that?
> >>> If I begin to work on this, I am not sure how much is needed to do to
> >>> merge into your new iio ring buffer codes. So if you have some new
> >>> codes for reference, it should be better.
> >>
> >> Sorry, no new code for now. =C2=A0All changes in my tree are driver ba=
sed rather
> >> than core (and right now to messy to post publicly)
> >>
> >> Looking forward to seeing what you propose in further detail.
> >>
> >> Jonathan
> >>
>
