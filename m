Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] IIO: arm: Add LRADC to i.MX28 dts
Date: Sun, 19 Aug 2012 17:30:31 +0200
Cc: Shawn Guo <shawn.guo@linaro.org>,
 linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 "Lars-Peter Clausen" <lars@metafoo.de>
References: <1344784918-32352-1-git-send-email-marex@denx.de> <201208170457.03686.marex@denx.de> <CAAQ0ZWROobdtFkzn9Sr7v5B29zYTQ5YEUZV59kkNE_yv6qbmgQ@mail.gmail.com>
In-Reply-To: <CAAQ0ZWROobdtFkzn9Sr7v5B29zYTQ5YEUZV59kkNE_yv6qbmgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201208191730.31969.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Shawn Guo,

> On 17 August 2012 10:57, Marek Vasut <marex@denx.de> wrote:
> > Thanks ... still, is there some key for those tags? Or do you invent them
> > at random and then let people guess what's right? Some git grep on
> > Documentation directory gets me nothing.
> 
> There is no official document for this.

Hm, maybe such document can be introduced?

> But generally, each subsystem
> has a convention on the subject prefix, so that the output of git
> commands like git pull, git shortlog looks consistent on the patch
> subject, and more importantly people can easily know subsystem the
> patch touches.
> 
> The convention for patches touching arch/arm is "ARM: ".
> 
> Regards,
> Shawn

Best regards,
Marek Vasut
