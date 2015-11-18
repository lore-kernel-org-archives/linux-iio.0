Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43538 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbbKRRca (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 12:32:30 -0500
In-Reply-To: <CAEnQRZAGyT33jTHDZHYYo_k4-4NX=XzGAuJXMOzhQzGyUQx+7Q@mail.gmail.com>
References: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com> <1447857515-23935-6-git-send-email-mtitinger@baylibre.com> <CAKv63uutrH=sZ4iu2-kgsgDmnmykwAWw0CGVCb2WWPcS5hZWdA@mail.gmail.com> <564CA201.3060601@baylibre.com> <CAEnQRZAGyT33jTHDZHYYo_k4-4NX=XzGAuJXMOzhQzGyUQx+7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC 5/9] iio: Documentation: Add IIO configfs documentation
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 18 Nov 2015 17:32:14 +0000
To: Daniel Baluta <daniel.baluta@intel.com>,
	Marc Titinger <mtitinger@baylibre.com>
CC: Crt Mori <cmo@melexis.com>,
	Johnathan Iain Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <2993100F-2532-4BF4-B3D0-5F6C9530725E@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 18 November 2015 16:15:57 GMT+00:00, Daniel Baluta <daniel.baluta@intel.com> wrote:
>On Wed, Nov 18, 2015 at 6:06 PM, Marc Titinger <mtitinger@baylibre.com>
>wrote:
>> On 18/11/2015 16:38, Crt Mori wrote:
>>>
>>> This has my acked-by, yet it is missing a commit message? Can we get
>that
>>> and the removed From: as I think this is a new patch and not resend
>of
>>> Daniel's?
>>> Also it would need your signed-off-by in that case
>>
>>
>> You've lost me: I think the commit message is the brief line only.
>> The patch is as-is from Daniel's series.
>
>Hi Marc, Crt,
>
>Configfs patches should soon be merged into linux-next tree, so there
>is
>no need for them to be resent here.
>
>Not sure how/when/where they'll be pulled back to linux-iio tree.
>
>Daniel.
It got a little complex as Christoph wanted the configfs change to hit
 mainline asap.

Andrew Morton will be sending Linus the change to configfs sometime in the next
 week. The other patches might show in Linux next after that via Andrew's tree.
Once I fast forward to a version of Greg's
 tree which has picked up the configfs change I will apply the patches to the IIO
 tree and send Greg a pull request sharpish to get them into Linux next.
 Andrew will then drop them from his tree and all will be lined up for the next merge
 window.

Simple :)

At a guess we are talking 2 to 3 weeks, maybe more, unfortunately but we'll
 before the next merge window.

Jonathan
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
