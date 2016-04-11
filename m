Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 11 Apr 2016 09:56:57 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PULL] First round of new device support, features and cleanups
 for IIO in the 4.7 cycle.
Message-ID: <20160411165657.GA27572@kroah.com>
References: <57018AAA.8070800@kernel.org>
 <57018BBB.7040106@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57018BBB.7040106@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 03, 2016 at 10:31:39PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> Note there is a merge conflict with one of the patches in the second lot of fixes
> I sent early today.  This is because the change got queued up here first then
> we noticed and issue which it fixed by accident.
> 
> Anyhow, conflict is in bmg160-core.c and you want the 'short option'.
> For comparison, the code is pretty much identical to bmc150-accel-core.c.
> 
> Otherwise, various automerged corners that seem to be fine. My build tests
> failed on a random thermal driver which I'll assume has long since been fixed,
> but otherwise seemed fine.

I've done the merge now, can you verify I got it correct?

thanks,

greg k-h
