Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <Prayer.1.3.2.1003021045350.17375@hermes-2.csi.cam.ac.uk>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
	<4B82679F.3000807@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com>
	<4B83BF9E.9010208@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA05A5BE40@chinexm1.ad.analog.com>
	<4B853357.5070500@cam.ac.uk> <3c17e3571003020157rdd35bdpa6811e25301a646f@mail.gmail.com>
	<Prayer.1.3.2.1003021045350.17375@hermes-2.csi.cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Mar 2010 11:26:15 +0800
Message-ID: <3c17e3571003021926n506b39d0v480ddc9430dfe104@mail.gmail.com>
Subject: Re: IIO ring buffer
To: "J.I. Cameron" <jic23@cam.ac.uk>
Cc: manuel.stahl@iis.fraunhofer.de, uclinux-dist-devel@blackfin.uclinux.org,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

DACs like AD5624R/5644R/5664R(http://www.analog.com/en/digital-to-analog-co=
nverters/da-converters/ad5624r/products/product.html)
have no clock input and internal buffer. Some users maybe use it to
get discrete analog signals, that means once one data is written to
AD5624R, one new analog signal is output, then we don't need ring
buffer. But some other users maybe want the AD5624R to create
continuous signals with a fixed frequency, then we need use ring
buffer with linked DMA to input data to AD5624R with a constant rate.
This case is same with audio play.
To implement that, we need
1. Split ring buffer to some little fragments, one fragment is a DMA block.
2. Ring buffer core layer must handle the play pointer and user
writing pointer, stop the DMA automatically when user data under-run
flows( valid data is less than one fragment in ring buffer)
3. The DMA interrupt handler in the bottom driver should update the
play pointer by a ring buffer core API to notify the play status.
4. The DMA should support  linked mode, once one DMA block is
finished, another DMA fragment will be enabled by hardware
automatically except that it is disabled due to underflow.
Thanks
Barry

On Tue, Mar 2, 2010 at 6:45 PM, J.I. Cameron <jic23@cam.ac.uk> wrote:
> Hi Barry,
>
>> I know you are changing iio ring buffer. Here a problem to discuss
>> with you, there are maybe this kind of use cases: the DACs have no
>> internal clock and buffer, so we need an external bus with continuous
>> DMA to "play" data flow with constant speed. It is very similar with
>> alsa driver to play audio by I2S or AC97. ALSA framework is easy to
>> implement this kind of drivers. But our DACs are not audio cards. Then
>> in the iio ring buffer core, it seems we also need APIs like
>> trigger(), pointer(), snd_pcm_period_elapsed()... to get a common
>> framework.
>
> I have to admit I'm in general a little unclear on how one even goes abou=
t
> getting dma to occur at a constant speed. =C2=A0I'm afraid I haven't had =
much
> time to work on improving the ring buffer (though I will try and get a pa=
tch
> out for one particular bug sometime today - if you get issues in the init
> function with spin locks). =C2=A0 Hence, I suggest that you propose any c=
hanges
> you would like to see in the core, if possible with some code along side
> relevant data sheets so those of us not so familiar with this area can
> better understand how this would work.
>
> My short term plans for the buffering is to allow use of the new
> implementation of kfifo as it allows dma transfers to occur directly into
> the buffer. =C2=A0Obviously this will involve adding a few new bits to th=
e api.
>
> That internal api is certainly far from locked in stone and as long as we
> can mend any driver broken by changes, feel free to propose any changes y=
ou
> like!
>
>> Of course, we can let users to handle blocking in write()
>> callback like OSS, but alsa-like APIs should be better. So what's your
>> opinion for that?
>> If I begin to work on this, I am not sure how much is needed to do to
>> merge into your new iio ring buffer codes. So if you have some new
>> codes for reference, it should be better.
>
> Sorry, no new code for now. =C2=A0All changes in my tree are driver based=
 rather
> than core (and right now to messy to post publicly)
>
> Looking forward to seeing what you propose in further detail.
>
> Jonathan
>
