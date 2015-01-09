Return-Path: <gregkh@linuxfoundation.org>
Date: Thu, 8 Jan 2015 18:22:28 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] First round of new IIO drivers, features and cleanups for
 the 3.20 cycle
Message-ID: <20150109022228.GA12876@kroah.com>
References: <54AAF235.5000209@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <54AAF235.5000209@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jan 05, 2015 at 08:21:09PM +0000, Jonathan Cameron wrote:
> The following changes since commit 5e62863aea463c9bf24538315327d0922be35d64:
> 
>   staging: comedi: das800: use comedi_async 'scans_done' to detect EOA (2014-11-05 14:59:48 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.20a

This breaks the build for me:

drivers/iio/imu/kmx61.c:1563:21: error: ‘kmx61_runtime_suspend’ undeclared here (not in a function)
  SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
                     ^
include/linux/pm.h:347:21: note: in definition of macro ‘SET_RUNTIME_PM_OPS’
  .runtime_suspend = suspend_fn, \
                     ^
drivers/iio/imu/kmx61.c:1563:44: error: ‘kmx61_runtime_resume’ undeclared here (not in a function)
  SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
                                            ^
include/linux/pm.h:348:20: note: in definition of macro ‘SET_RUNTIME_PM_OPS’
  .runtime_resume = resume_fn, \
                    ^

So I don't want to pull it :(

thanks,

greg k-h
