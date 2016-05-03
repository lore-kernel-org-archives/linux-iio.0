Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35465 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933401AbcECQUj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2016 12:20:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so2489847pfr.2
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2016 09:20:39 -0700 (PDT)
Subject: Re: [RFC PATCH v1 4/9] iio:st_sensors: align on storagebits
 boundaries
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <6b0ff9259418de8dacf125f642f2737ffcb62065.1461056711.git.gregor.boirie@parrot.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Crestez Dan Leonard <cdleonard@gmail.com>
Message-ID: <5728CFD8.4030706@gmail.com>
Date: Tue, 3 May 2016 19:20:40 +0300
MIME-Version: 1.0
In-Reply-To: <6b0ff9259418de8dacf125f642f2737ffcb62065.1461056711.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/19/2016 12:18 PM, Gregor Boirie wrote:
> Triggered buffering memory accesses are not aligned on per channel
> storagebits boundaries. Fix this by reading each channel individually to
> ensure proper alignment.
> Note that this patch drops the earlier optimisation that packs multiple
> channels reading into a single data block transaction when their
> respective I2C register addresses are contiguous.
> 
Both the 'before' and 'after' versions seem to be doing one bus
transaction for each active channel in the scan mask. The optimization
you're mentioning was dropped in an older patch:

    iio: st_sensors: read each channel individually

At most it makes that optimization harder to restore, right?

-- 
Regards,
Leonard
