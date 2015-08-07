Return-Path: <lars@metafoo.de>
Message-ID: <55C4B66C.1020609@metafoo.de>
Date: Fri, 07 Aug 2015 15:45:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 cory.tusar@pid1solutions.com
Subject: Re: [PATCH v3 5/7] iio: Support triggered events
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com> <1438174648-19296-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1438174648-19296-1-git-send-email-vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 07/29/2015 02:57 PM, Vladimir Barinov wrote:
> Support triggered events.
> 
> This is useful for chips that don't have their own interrupt sources.
> It allows to use generic/standalone iio triggers for those drivers.
> 

Thanks for the patch. Can you describe in more detail how
INDIO_EVENT_TRIGGERED differs from the INDIO_BUFFER_TRIGGERED. By just
looking at the source code I don't understand quite why it is necessary.

Thanks,
- Lars
