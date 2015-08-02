Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45312 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbbHBRTc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:19:32 -0400
Subject: Re: [PATCH 1/2] iio: magn: bmc150_magn: add locking comment for
 runtime resume
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org
References: <1437671702-20994-1-git-send-email-irina.tirdea@intel.com>
 <1437671702-20994-2-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5122.2060405@kernel.org>
Date: Sun, 2 Aug 2015 18:19:30 +0100
MIME-Version: 1.0
In-Reply-To: <1437671702-20994-2-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/07/15 18:15, Irina Tirdea wrote:
> Runtime resume function is called with the data->mutex lock held.
> Add a comment to indicate this.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Sensible follow up to Hartmut's patches.  

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 074a99d..d66f8cf 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -1043,6 +1043,9 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> +/*
> + * Should be called with data->mutex held.
> + */
>  static int bmc150_magn_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> 

