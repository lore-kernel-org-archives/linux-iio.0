Return-Path: <SRS0=SvrG=YY=gmail.com=k.matthias12@kernel.org>
MIME-Version: 1.0
Sender: k.matthias12@gmail.com
In-Reply-To: <CAKNHny-OvwLC9c3tvyiyd7F+89QUAtkYEk2Va0JHEzgGGjPVWg@mail.gmail.com>
References: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com>
 <alpine.DEB.2.02.1612201144140.4422@pmeerw.net> <CAKNHny_yV-FV9smGfrX2wR-T7M5uCk9WWG4xNGBMXrAuwVy2ZA@mail.gmail.com>
 <alpine.DEB.2.02.1612201720550.9386@pmeerw.net> <CAKNHny9M4uQvk_Xg1f0JL5Ob=PzUBFi8=0G1XVwqdkhR1f4P=g@mail.gmail.com>
 <fa3259c5-d76b-bc93-e517-054ef249a861@kernel.org> <CAKNHny-OvwLC9c3tvyiyd7F+89QUAtkYEk2Va0JHEzgGGjPVWg@mail.gmail.com>
From: Matthias Klumpp <matthias@tenstral.net>
Date: Tue, 10 Jan 2017 14:29:23 +0100
Message-ID: <CAKNHny9saYXafENh0EcAvCw8fVtfK5LoiwusSpUMiCh0Fkh_ng@mail.gmail.com>
Subject: Re: Problems with using IIO buffers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi!

The iio_dummy test module works now with the iio_generic_buffer test
program :-) (libiio still doesn't do what I want though).
My own driver does recognize the trigger call but does not acquire
data, likely due to a mask that is set to something I don't implement
yet (maybe checking for IIO_CHAN_INFO_RAW was not enough).

In any case, it looks like I need to continuously trigger the
(software) trigger to move data into the buffer - is there any way to
automate that, i.e. by saying "give me X samples" or "acquire data for
3ms"? Or do I always need to trigger from userspace or use a hardware
trigger?

Regards,
    Matthias
