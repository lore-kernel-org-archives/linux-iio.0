Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55887 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033166AbdAJOSz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 09:18:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 10 Jan 2017 14:18:53 +0000
From: jic23@kernel.org
To: Matthias Klumpp <matthias@tenstral.net>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, k.matthias12@gmail.com
Subject: Re: Problems with using IIO buffers
In-Reply-To: <CAKNHny9saYXafENh0EcAvCw8fVtfK5LoiwusSpUMiCh0Fkh_ng@mail.gmail.com>
References: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com>
 <alpine.DEB.2.02.1612201144140.4422@pmeerw.net>
 <CAKNHny_yV-FV9smGfrX2wR-T7M5uCk9WWG4xNGBMXrAuwVy2ZA@mail.gmail.com>
 <alpine.DEB.2.02.1612201720550.9386@pmeerw.net>
 <CAKNHny9M4uQvk_Xg1f0JL5Ob=PzUBFi8=0G1XVwqdkhR1f4P=g@mail.gmail.com>
 <fa3259c5-d76b-bc93-e517-054ef249a861@kernel.org>
 <CAKNHny-OvwLC9c3tvyiyd7F+89QUAtkYEk2Va0JHEzgGGjPVWg@mail.gmail.com>
 <CAKNHny9saYXafENh0EcAvCw8fVtfK5LoiwusSpUMiCh0Fkh_ng@mail.gmail.com>
Message-ID: <dae3336326d2fe54d0a9773bf24f76d6@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10.01.2017 13:29, Matthias Klumpp wrote:
> Hi!
> 
> The iio_dummy test module works now with the iio_generic_buffer test
> program :-) (libiio still doesn't do what I want though).
> My own driver does recognize the trigger call but does not acquire
> data, likely due to a mask that is set to something I don't implement
> yet (maybe checking for IIO_CHAN_INFO_RAW was not enough).
> 
> In any case, it looks like I need to continuously trigger the
> (software) trigger to move data into the buffer - is there any way to
> automate that, i.e. by saying "give me X samples" or "acquire data for
> 3ms"? Or do I always need to trigger from userspace or use a hardware
> trigger?
> 
> Regards,
>     Matthias
Hi Matthias,

At the moment we have no oscilloscope style triggering.  It's been a 
topic
of discussion recently in the form of trees of triggers (one trigger 
starts
another firing on say a high resolution timer), but no code exists yet.

One easy option is to use a high resolution timer trigger in conjunction
with setting the watermark on a given buffer.   Thus it might capture 
more
data but it will at least come back to userspace only when there is 
'enough'
data.

The triggering is really about synchronising multiple sensor streams so
has to be a one trigger per one sample scan (set of samples from across
a number of channels).

Jonathan
