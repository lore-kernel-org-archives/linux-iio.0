Return-Path: <SRS0=GN8S=K2=gmail.com=himanshujha199640@kernel.org>
Date: Sat, 11 Aug 2018 15:48:33 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
	eraretuya@gmail.com, dan.carpenter@oracle.com
Subject: Re: [PATCH] iio: adxl345: move null check for i2c id at start of
 probe
Message-ID: <20180811101833.GA5243@himanshu-Vostro-3559>
References: <20180807140605.19156-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180807140605.19156-1-alexandru.ardelean@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 07, 2018 at 05:06:05PM +0300, Alexandru Ardelean wrote:
> Fixes ef89f4b96a2 ("iio: adxl345: Add support for the ADXL375").
> 
> This was found via static checker.
> After looking into the code a bit, it's unlikely that there will be a NULL
> dereference if the `id` object in that specific code path.
> However, it's safe to add a NULL (paranoid) check just to make sure and
> remove any uncertainties.

I would like to know when would that case happen actually ?

Because probe will only be called only when a match occurs either
through DT or id matching. Isn't it ?

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
