Return-Path: <lars@metafoo.de>
Message-ID: <55C4B5CB.9060400@metafoo.de>
Date: Fri, 07 Aug 2015 15:42:35 +0200
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
 cory.tusar@pid1solutions.com, Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v3 4/7] iio: trigger: Add periodic polling to SYSFS trigger
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com> <1438174642-19258-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1438174642-19258-1-git-send-email-vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 07/29/2015 02:57 PM, Vladimir Barinov wrote:
> Add periodic polling functionality to SYSFS trigger

Daniel's hrtimer trigger should be used for this instead of modifying the
sysfs trigger timer. See https://lkml.org/lkml/2015/5/8/367

He said he'll send out a new version shortly.

- Lars
