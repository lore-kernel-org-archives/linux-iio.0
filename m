Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:56028 "EHLO
	ppsw-6.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab0CBKpj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Mar 2010 05:45:39 -0500
Date: 02 Mar 2010 10:45:35 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Barry Song <21cnbao@gmail.com>
Cc: manuel.stahl@iis.fraunhofer.de,
	uclinux-dist-devel@blackfin.uclinux.org, linux-iio@vger.kernel.org
Subject: Re: IIO ring buffer
Message-ID: <Prayer.1.3.2.1003021045350.17375@hermes-2.csi.cam.ac.uk>
In-Reply-To: <3c17e3571003020157rdd35bdpa6811e25301a646f@mail.gmail.com>
References: <0F1B54C89D5F954D8535DB252AF412FA05A222FC@chinexm1.ad.analog.com>
 <4B82679F.3000807@cam.ac.uk>
 <0F1B54C89D5F954D8535DB252AF412FA05A22824@chinexm1.ad.analog.com>
 <4B83BF9E.9010208@cam.ac.uk>
 <0F1B54C89D5F954D8535DB252AF412FA05A5BE40@chinexm1.ad.analog.com>
 <4B853357.5070500@cam.ac.uk>
 <3c17e3571003020157rdd35bdpa6811e25301a646f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Barry,

>I know you are changing iio ring buffer. Here a problem to discuss
>with you, there are maybe this kind of use cases: the DACs have no
>internal clock and buffer, so we need an external bus with continuous
>DMA to "play" data flow with constant speed. It is very similar with
>alsa driver to play audio by I2S or AC97. ALSA framework is easy to
>implement this kind of drivers. But our DACs are not audio cards. Then
>in the iio ring buffer core, it seems we also need APIs like
>trigger(), pointer(), snd_pcm_period_elapsed()... to get a common
>framework.
I have to admit I'm in general a little unclear on how one even goes about
getting dma to occur at a constant speed.  I'm afraid I haven't had much
time to work on improving the ring buffer (though I will try and get a patch
out for one particular bug sometime today - if you get issues in the init
function with spin locks).   Hence, I suggest that you propose any changes
you would like to see in the core, if possible with some code along side
relevant data sheets so those of us not so familiar with this area can
better understand how this would work.

My short term plans for the buffering is to allow use of the new
implementation of kfifo as it allows dma transfers to occur directly into
the buffer.  Obviously this will involve adding a few new bits to the api.

That internal api is certainly far from locked in stone and as long as we
can mend any driver broken by changes, feel free to propose any changes you
like!
 
> Of course, we can let users to handle blocking in write()
>callback like OSS, but alsa-like APIs should be better. So what's your
>opinion for that?
>If I begin to work on this, I am not sure how much is needed to do to
>merge into your new iio ring buffer codes. So if you have some new
>codes for reference, it should be better.
Sorry, no new code for now.  All changes in my tree are driver based rather
than core (and right now to messy to post publicly)

Looking forward to seeing what you propose in further detail.

Jonathan
