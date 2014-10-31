Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1414768889.3254.4.camel@spandruv-hsb-test>
Subject: Re: [PATCH 0/1] iio: ak8975: Add AKM0991x support.
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Date: Fri, 31 Oct 2014 08:21:29 -0700
In-Reply-To: <1414620097-6787-1-git-send-email-gwendal@chromium.org>
References: <1414620097-6787-1-git-send-email-gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2014-10-29 at 15:01 -0700, Gwendal Grignou wrote:
> AK09912 is an accelerometer with the same register set as AK09911, but
> same behavior as AK8973, so I was not sure where to add the support.
> I decided to merge all AKM magnetometer support in the same file while
> being as clean as I could.
> 
AK09911 is implemented as a separate driver to have a clean. 
- Register map is different and have different indexes
- AK09911 is a very compact interface with no DRDY pin. So no support
     of interrupt or GPIO poll
- Even for polled mode no mention on ST2 register, which is required in
    ak8975 driver
- mode values are different for fuse access

I didn't get chance to check your merged driver, IMO simple standalone
driver is better if there are two many difference like above, difference
between AK09911 and AK8973.

Thanks,
Srinivas
