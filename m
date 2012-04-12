Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 12 Apr 2012 10:35:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: jic23@cam.ac.uk, gregkh@linuxfoundation.org, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, jbrenner@taosinc.com, rklein@nvidia.com,
        max@stro.at, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] staging: iio: add driver for isl29028
Message-ID: <20120412073554.GA6498@mwanda>
References: <1334214492-23044-1-git-send-email-ldewangan@nvidia.com>
 <1334214492-23044-2-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334214492-23044-2-git-send-email-ldewangan@nvidia.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 12, 2012 at 12:38:11PM +0530, Laxman Dewangan wrote:
> Intersil's ISL29028 is concurrent Ambient Light and
> Proximity Sensor device.
> Add driver to access the light and IR intensity and
> proximity value via iio interface.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Taken care of all review comment from Dan.

Looks nice.  You went above and beyond and cleaned up a couple
things I didn't mention.  Thanks.

regards,
dan carpenter
