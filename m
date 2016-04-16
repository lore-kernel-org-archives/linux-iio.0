Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48109 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbcDPMaI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 08:30:08 -0400
Subject: Re: [PATCH 01/10] iio: light apds9960: fix wrong use of brace
To: Slawomir Stepien <sst@poczta.fm>,
	Matt Ranostay <mranostay@gmail.com>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
 <1460662602-2951-2-git-send-email-sst@poczta.fm>
 <CAKzfze8PtR559e2gjbWnZ=KHqETKr56tYUAyH7kJxwfQi=5tFg@mail.gmail.com>
 <20160415145641.GA19346@x220.localdomain>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5712304B.90709@kernel.org>
Date: Sat, 16 Apr 2016 13:30:03 +0100
MIME-Version: 1.0
In-Reply-To: <20160415145641.GA19346@x220.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/16 15:56, Slawomir Stepien wrote:
> On Apr 14, 2016 16:29, Matt Ranostay wrote:
>> On Thu, Apr 14, 2016 at 12:36 PM, Slawomir Stepien <sst@poczta.fm> wrote:
>>> This fixes the error reported by checkpatch.pl:
>>>
>>> ERROR: that open brace { should be on the previous line
>>>
>>> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
I find it rather hard to care about this, but perhaps it is just a 'tiny' bit
more readable and there are definite advantages in suppressing some of the
output of checkpatch so the 'real' issues are easily spotted!

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
>>> ---
>>>  drivers/iio/light/apds9960.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
>>> index a6af56a..ade18aa 100644
>>> --- a/drivers/iio/light/apds9960.c
>>> +++ b/drivers/iio/light/apds9960.c
>>> @@ -321,8 +321,12 @@ static const struct iio_chan_spec apds9960_channels[] = {
>>>  };
>>>
>>>  /* integration time in us */
>>> -static const int apds9960_int_time[][2] =
>>> -       { {28000, 246}, {100000, 219}, {200000, 182}, {700000, 0} };
>>> +static const int apds9960_int_time[][2] = {
>>> +       { 28000, 246},
>>> +       {100000, 219},
>>> +       {200000, 182},
>>> +       {700000,   0}
>> Extra space between the comma and zero. Or was this intended for alignment?
> 
> Just for alignment. Are you OK with that?
> 

