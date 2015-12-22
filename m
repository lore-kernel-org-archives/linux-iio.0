Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48625 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933148AbbLVSNH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2015 13:13:07 -0500
Subject: Re: [PATCH] iio: add ad5761 DAC driver
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
References: <1450272464-13992-1-git-send-email-ricardo.ribalda@gmail.com>
 <5675865F.6050306@kernel.org>
 <CAPybu_0mp339amnPqbOddMVJ9VRqw7cWLEscyWNi7TTOYbBZTQ@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <567992B0.5050801@kernel.org>
Date: Tue, 22 Dec 2015 18:13:04 +0000
MIME-Version: 1.0
In-Reply-To: <CAPybu_0mp339amnPqbOddMVJ9VRqw7cWLEscyWNi7TTOYbBZTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/12/15 11:19, Ricardo Ribalda Delgado wrote:
> Hello Jonthan
> 
> Thanks for your comments, I have fixed all the style problems in v2,
> so we can focus in the range parameter.
> 
> On Sat, Dec 19, 2015 at 5:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> Range isn't actually specified in the ABI docs.
>> Documenation\ABI\testing\sysfs-bus-iio*
>> The control interface for this is normally scale rather than range
>> (we had to pick one of the two and that is the way it fell out)  Usually
>> hardware designers care about range, but userspace programs are often
>> most directly interested in scale factors that need to be applied.
>> (and that was my most rediculously over generalized statement for the day ;)
> 
> What about a first version of the driver where the range is set via
> pdata and is not userland configurable?
> That way the four chips will be supported and we can have more
> feedback from other users about the range issue.
That would be fine.  Generally I'd imagine a given board will only want to
have one sensible choice anyway! (other than devkits at least)
> 
>>
>> I can see this is rather complex here given the random looking collection
>> of associated scales and offsets.  You would have to have _available
>> attributes to say what offsets are available at a given scale I think.
>> Also we'd have to then define a precedence order in the docs for the
>> two attributes (worth doing to make it obvious what to do when this
>> sort of setup arises).
> 
> The problem with that approach is that there will be two operations to
> set the range: one  to change the scale, and another for the offset.  The output
> voltage will change twice in this process and may have an intermediate value
> that can damage a circuit.
Fair point - I had not thought of that.  Hmm.. Could add a commit type attribute
but that's ugly too.

Even if we do allow changing the range ultimately, I think
it would need some hard restrictions in platform data on what is 'safe' for a
particular board.
> 
> I also believe that my approach with a text description is more user friendly
> (but problably because I programmed it :P)
> 
> In any case, I will implement whatever we agree ;)
For now, pdata sounds like the best plan and revisit this at a later date.

Jonathan
> 
> Best regards!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

