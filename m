Return-Path: <jic23@cam.ac.uk>
References: <1323684545-11188-1-git-send-email-lars@metafoo.de> <20111213004659.GB11553@kroah.com> <8847cb76-be5b-41d3-b893-968bb9cb937a@email.android.com> <20111213073831.GB20154@suse.de> <Prayer.1.3.4.1112130848080.6245@hermes-2.csi.cam.ac.uk> <20111214000043.GA23927@suse.de>
In-Reply-To: <20111214000043.GA23927@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging:iio: Setup buffer access functions when allocating the buffer
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 14 Dec 2011 07:21:55 +0000
To: Greg KH <gregkh@suse.de>
CC: Greg KH <greg@kroah.com>,Lars-Peter Clausen <lars@metafoo.de>,Jonathan Cameron <jic23@kernel.org>,devel@driverdev.osuosl.org,linux-iio@vger.kernel.org
Message-ID: <1e63bef0-bd4c-4118-9c74-bd5049c00e0c@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Greg KH <gregkh@suse.de> wrote:

>On Tue, Dec 13, 2011 at 08:48:08AM +000=
0, J.I. Cameron wrote:
>> >>>Make a decision, don't force someone else to m=
ake it for you...
>> >>Defaults are sensible. Preventing other peoples use =
cases are not.
>> >
>> >Ok, but you do agree that this patch is broken as-i=
s, right?
>> Not sure I do.  I admit it isn't a patch I really cared about =
either
>way,
>> but it is just providing a trivial bit of boiler plate remo=
val.
>> The buffer allocation and access functions are always pared and all=
 I
>see
>> here is moving the access funcs bit inside the allocation call?
=
>> 
>> Perhaps I have missunderstood what you don't like?
>
>I don't like a=
nything that forces the builder of the kernel to choose
>the buffer type, t=
hat should be done by the driver, or it should be
>dynamic and changable, a=
nd you need to provide documentation as to why
>you would want to change th=
e buffer type.

Can make it dynamic easily enough . Does indeed need more d=
ocs on the different buffer types. I will get to that at somepoint...
>
>gr=
eg k-h

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my bre=
vity.
