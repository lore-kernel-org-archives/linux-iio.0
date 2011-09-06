Return-Path: <greg@kroah.com>
Date: Tue, 6 Sep 2011 16:05:33 -0700
From: Greg KH <greg@kroah.com>
To: Grant Grundler <grundler@google.com>,
	Jonathan Cameron <jic23@cam.ac.uk>, devel@linuxdriverproject.org,
	linux-iio@vger.kernel.org, bfreed@chromium.org,
	grundler@chromium.org
Subject: Re: [PATCH] STAGING:iio:light: V2 fix out of bounds reg_cache[]
 access
Message-ID: <20110906230533.GA5882@kroah.com>
References: <20110830235546.3135B208185@grundler.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110830235546.3135B208185@grundler.mtv.corp.google.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 30, 2011 at 04:55:46PM -0700, Grant Grundler wrote:
> V2 Fix out-of-bounds reference to reg_cache[]
> 
> Simple fix is to just not cache REG_TEST (offset 8).
> Cache doesn't help REG_TEST anyway since we write all 8 bits exactly once
> (at resume/init time).
> 
> Also fix an "off-by-one" allocation of reg_cache[] array size that
> was in the original code before I touched it.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Jonathan, this no longer applies after your other patches, so could you
queue this up in your tree and resend it in a format that applies?

thanks,

greg k-h
