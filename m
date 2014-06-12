Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 12 Jun 2014 09:10:50 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jimmy P <jimmyp11f155@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: fix coding style
Message-ID: <20140612161050.GA12586@kroah.com>
References: <1402566163-9860-1-git-send-email-jimmyp11f155@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402566163-9860-1-git-send-email-jimmyp11f155@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 12, 2014 at 05:42:43PM +0800, Jimmy P wrote:
> This patch fixes coding style errors reported by checkpatch.pl for
> lines that was over 80 chars long. The macro value shoud be put in () as
> well.
> 
> Signed-off-by: Jimmy P <jimmyp11f155@gmail.com>

We need a "real" or "full" name here for the signed-off-by: line, please
read Documentation/SubmittingPatches for the full details as to what
this line means and why we need that.

Also, this patch does multiple things, please break it up into different
patches, each only doing one specific thing.

thanks,

greg k-h
