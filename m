Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34597 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273AbbKRQP7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 11:15:59 -0500
MIME-Version: 1.0
In-Reply-To: <564CA201.3060601@baylibre.com>
References: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
	<1447857515-23935-6-git-send-email-mtitinger@baylibre.com>
	<CAKv63uutrH=sZ4iu2-kgsgDmnmykwAWw0CGVCb2WWPcS5hZWdA@mail.gmail.com>
	<564CA201.3060601@baylibre.com>
Date: Wed, 18 Nov 2015 18:15:57 +0200
Message-ID: <CAEnQRZAGyT33jTHDZHYYo_k4-4NX=XzGAuJXMOzhQzGyUQx+7Q@mail.gmail.com>
Subject: Re: [RFC 5/9] iio: Documentation: Add IIO configfs documentation
From: Daniel Baluta <daniel.baluta@intel.com>
To: Marc Titinger <mtitinger@baylibre.com>
Cc: Crt Mori <cmo@melexis.com>,
	Johnathan Iain Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 18, 2015 at 6:06 PM, Marc Titinger <mtitinger@baylibre.com> wrote:
> On 18/11/2015 16:38, Crt Mori wrote:
>>
>> This has my acked-by, yet it is missing a commit message? Can we get that
>> and the removed From: as I think this is a new patch and not resend of
>> Daniel's?
>> Also it would need your signed-off-by in that case
>
>
> You've lost me: I think the commit message is the brief line only.
> The patch is as-is from Daniel's series.

Hi Marc, Crt,

Configfs patches should soon be merged into linux-next tree, so there is
no need for them to be resent here.

Not sure how/when/where they'll be pulled back to linux-iio tree.

Daniel.
