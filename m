Return-Path: <SRS0=V98T=A3=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v2 0/2] staging: iio: adc: ad7192: use private driver lock
 to protect hardware changes
To: Aastha Gupta <aastha.gupta4104@gmail.com>,
 outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
 jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org
References: <1506440468-5081-1-git-send-email-aastha.gupta4104@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e4b443c0-7d7f-e353-61c5-32867bfe01eb@metafoo.de>
Date: Tue, 26 Sep 2017 20:15:31 +0200
MIME-Version: 1.0
In-Reply-To: <1506440468-5081-1-git-send-email-aastha.gupta4104@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/26/2017 05:41 PM, Aastha Gupta wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> These patches 
> - replace mlock with private driver lock 
> - add lock where there are hardware state changes 

For this to make sense both changes need to be in the same patch. You are
removing the protection in patch 1 and then adding it back in patch 2. A
patch series shouldn't leave the driver in a broken intermediate state if
only part of the series is applied.
