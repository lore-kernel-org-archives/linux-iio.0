Return-Path: <SRS0=A3nn=2Y=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 15 Mar 2017 13:33:13 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: stable@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: 104-quad-8: Fix off-by-one error when addressing
 flag register
Message-ID: <20170315053313.GA12066@kroah.com>
References: <20170209150341.GA29292@sophia>
 <d89a328a-4873-021e-a92b-f0498cb49d03@kernel.org>
 <20170313133319.GA3607@sophia>
 <d4955577-9524-78b7-9afb-e1ebf1438ef7@kernel.org>
 <20170314150043.GA24126@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314150043.GA24126@sophia>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Mar 14, 2017 at 11:00:43AM -0400, William Breathitt Gray wrote:
> On Mon, Mar 13, 2017 at 09:33:45PM +0000, Jonathan Cameron wrote:
> >On 13/03/17 13:33, William Breathitt Gray wrote:
> >> On Sat, Feb 11, 2017 at 09:37:35AM +0000, Jonathan Cameron wrote:
> >>> On 09/02/17 15:03, William Breathitt Gray wrote:
> >>>> The flag register is offset by 1 from the respective channel data
> >>>> register. This patch fixes an off-by-one error when attempting to read a
> >>>> channel flag register where the base address was not properly offset.
> >>>>
> >>>> Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
> >>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >>> Applied to the fixes-togreg-post-rc1 branch of iio.git
> >>> Clue to when this will go upstream is in the name ;)
> >>>
> >>> Thanks,
> >>>
> >>> Jonathan
> >> 
> >> Hi Jonathan,
> >> 
> >> I see that this fix made it into 4.11-rc1 but not the 4.10.2 release.
> >> Is this patch on track to appear in stable, or should I explicitly CC
> >> stable@vger.kernel.org to pick this up?
> >I was half asleep and failed to tag this in the first place.
> >
> >Send an email to stable@vger.kernel.org with the commit ID and a request
> >that it is picked up.  Cc me.
> >
> >Jonathan
> >> 
> >> Thanks,
> >> 
> >> William Breathitt Gray
> >> 
> 
> Hello,
> 
> This patch was merged into Linus' tree as commit ca8d8e03b4c9 ("iio:
> 104-quad-8: Fix off-by-one error when addressing flag register"). This
> fix should be merged into the 4.10 stable tree as well to fix an
> off-by-one error which causes garbage data to be read as count values --
> effectively preventing proper usage of the driver.
> 
> This patch fixes commit 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support
> for the ACCES 104-QUAD-8").

Now queued up, thanks.

greg k-h
