Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48250 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbbLVRFa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2015 12:05:30 -0500
Subject: Re: [PATCH v3 1/5] iio: Make IIO value formating function globally
 available.
To: "Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1450132561-5245-1-git-send-email-afd@ti.com>
 <1450132561-5245-2-git-send-email-afd@ti.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <567982D4.2060502@kernel.org>
Date: Tue, 22 Dec 2015 17:05:24 +0000
MIME-Version: 1.0
In-Reply-To: <1450132561-5245-2-git-send-email-afd@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/12/15 22:35, Andrew F. Davis wrote:
> Make IIO value formating function globally available to allow IIO drivers
> to output values as the core does.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/linux/iio/iio.h         | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 208358f..eb5909d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -470,6 +470,7 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
>  		return 0;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(iio_format_value);
>  
>  static ssize_t iio_read_channel_info(struct device *dev,
>  				     struct device_attribute *attr,
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 19c94c9..b589411 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -636,6 +636,8 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
>  }
>  #endif
>  
> +ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
> +
>  int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
>  	int *fract);
>  
> 

