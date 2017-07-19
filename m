Return-Path: <SRS0=fOpU=6W=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 19 Jul 2017 13:51:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaya Durga <rjdurga@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	singhalsimran0@gmail.com, eraretuya@gmail.com,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Staging: iio: light: tsl2x7x_core.c: Replace
 symbolic permission with octal permission
Message-ID: <20170719115113.GB16281@kroah.com>
References: <1500362603-31924-1-git-send-email-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500362603-31924-1-git-send-email-rjdurga@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 18, 2017 at 12:53:23PM +0530, Jaya Durga wrote:
> Replace symbolic permissions with their
> octect representation to fix checkpatch warnings.
> 
> Signed-off-by: Jaya Durga <rjdurga@gmail.com>
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Where is patch 1 of this series?

Again, please fix and resend.

thanks,

greg k-h
