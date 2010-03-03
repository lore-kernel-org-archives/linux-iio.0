Return-Path: <Sonic.Zhang@analog.com>
From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [Uclinux-dist-devel] IIO ring buffer
Date: Wed, 3 Mar 2010 13:59:49 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA05AD877E@chinexm1.ad.analog.com>
In-Reply-To: <3c17e3571003021926n506b39d0v480ddc9430dfe104@mail.gmail.com>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com> <4B82679F.3000807@cam.ac.uk><0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com><4B83BF9E.9010208@cam.ac.uk><0F1B54C89D5F954D8535DB252AF412FA05A5BE40@chinexm1.ad.analog.com><4B853357.5070500@cam.ac.uk><3c17e3571003020157rdd35bdpa6811e25301a646f@mail.gmail.com> <Prayer.1.3.2.1003021045350.17375@hermes-2.csi.cam.ac.uk> <3c17e3571003021926n506b39d0v480ddc9430dfe104@mail.gmail.com>
To: "Barry Song" <21cnbao@gmail.com>,
	"J.I. Cameron" <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>,
	<uclinux-dist-devel@blackfin.uclinux.org>,
	<manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

I think Barry forgot to mention that this DAC is connect to the CPU via =
a 3 PIN serial port with SYNC clock enabled. This serial port controller =
has DMA master capability and output data at a given clock. The ring =
buffer slots and size is better to be configurable and its API should be =
able to trigger output start/stop to IIO driver based on data left in =
the ring.


Sonic=20

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org=20
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On=20
>Behalf Of Barry Song
>Sent: Wednesday, March 03, 2010 11:26 AM
>To: J.I. Cameron
>Cc: linux-iio@vger.kernel.org;=20
>uclinux-dist-devel@blackfin.uclinux.org; manuel.stahl@iis.fraunhofer.de
>Subject: Re: [Uclinux-dist-devel] IIO ring buffer
>
>DACs like=20
>AD5624R/5644R/5664R(http://www.analog.com/en/digital-to-analog-
>converters/da-converters/ad5624r/products/product.html)
>have no clock input and internal buffer. Some users maybe use=20
>it to get discrete analog signals, that means once one data is=20
>written to AD5624R, one new analog signal is output, then we=20
>don't need ring buffer. But some other users maybe want the=20
>AD5624R to create continuous signals with a fixed frequency,=20
>then we need use ring buffer with linked DMA to input data to=20
>AD5624R with a constant rate.
>This case is same with audio play.
>To implement that, we need
>1. Split ring buffer to some little fragments, one fragment is=20
>a DMA block.
>2. Ring buffer core layer must handle the play pointer and=20
>user writing pointer, stop the DMA automatically when user=20
>data under-run flows( valid data is less than one fragment in=20
>ring buffer) 3. The DMA interrupt handler in the bottom driver=20
>should update the play pointer by a ring buffer core API to=20
>notify the play status.
>4. The DMA should support  linked mode, once one DMA block is=20
>finished, another DMA fragment will be enabled by hardware=20
>automatically except that it is disabled due to underflow.
>Thanks
>Barry
>
>On Tue, Mar 2, 2010 at 6:45 PM, J.I. Cameron <jic23@cam.ac.uk> wrote:
>> Hi Barry,
>>
>>> I know you are changing iio ring buffer. Here a problem to discuss=20
>>> with you, there are maybe this kind of use cases: the DACs have no=20
>>> internal clock and buffer, so we need an external bus with=20
>continuous=20
>>> DMA to "play" data flow with constant speed. It is very=20
>similar with=20
>>> alsa driver to play audio by I2S or AC97. ALSA framework is easy to=20
>>> implement this kind of drivers. But our DACs are not audio cards.=20
>>> Then in the iio ring buffer core, it seems we also need APIs like=20
>>> trigger(), pointer(), snd_pcm_period_elapsed()... to get a common=20
>>> framework.
>>
>> I have to admit I'm in general a little unclear on how one even goes=20
>> about getting dma to occur at a constant speed. =A0I'm afraid=20
>I haven't=20
>> had much time to work on improving the ring buffer (though I=20
>will try=20
>> and get a patch out for one particular bug sometime today -=20
>if you get=20
>> issues in the init function with spin locks). =A0 Hence, I=20
>suggest that=20
>> you propose any changes you would like to see in the core,=20
>if possible=20
>> with some code along side relevant data sheets so those of us not so=20
>> familiar with this area can better understand how this would work.
>>
>> My short term plans for the buffering is to allow use of the new=20
>> implementation of kfifo as it allows dma transfers to occur directly=20
>> into the buffer. =A0Obviously this will involve adding a few=20
>new bits to the api.
>>
>> That internal api is certainly far from locked in stone and=20
>as long as=20
>> we can mend any driver broken by changes, feel free to propose any=20
>> changes you like!
>>
>>> Of course, we can let users to handle blocking in write() callback=20
>>> like OSS, but alsa-like APIs should be better. So what's=20
>your opinion=20
>>> for that?
>>> If I begin to work on this, I am not sure how much is=20
>needed to do to=20
>>> merge into your new iio ring buffer codes. So if you have some new=20
>>> codes for reference, it should be better.
>>
>> Sorry, no new code for now. =A0All changes in my tree are driver =
based=20
>> rather than core (and right now to messy to post publicly)
>>
>> Looking forward to seeing what you propose in further detail.
>>
>> Jonathan
>>
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
