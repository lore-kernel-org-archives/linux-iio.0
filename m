Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH v4 0/3] iio: generic_buffer: Select device/trigger by
 number
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1464610998.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <5fb8d31b-3458-cb1b-0ce1-131bbb1d1aa3@intel.com>
Date: Fri, 3 Jun 2016 21:54:39 +0300
MIME-Version: 1.0
In-Reply-To: <cover.1464610998.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/30/2016 06:19 PM, Crestez Dan Leonard wrote:
> This patch series adds support for selecting iio devices/triggers by numeric id
> rather than just name. This is useful because the names are not actually
> guaranteed to be unique.
> 
> Changes since v3:
> * Rebase on top of latest jic23/testing
> * Fix handling of --trigger-num 0. Initialize trig_num to -1 and check if >= 0
> for valid id.
> 
> Jonathan: you replied to v3 saying that they were applied but I don't see those
> patches on any branch from your repo:
>     https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

I see v3 made it's way into jic23/testing anyway:

https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=7c7e9dad7017ff5b5f0524ea6d85dcda3c62431e

Ignore this series, I'll send a fix instead.

-- 
Regards,
Leonard
