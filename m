Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55805 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbAAMVR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:21:17 -0500
Message-ID: <54A53BBB.20402@kernel.org>
Date: Thu, 01 Jan 2015 12:21:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: dummy: fix compile error when not using
 buffering
References: <1419846616-31441-1-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1419846616-31441-1-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/12/14 09:50, Vlad Dogaru wrote:
> Commit 4ae03019923f ("staging:iio:dummy: Register same channels for
> device and buffer") has changed the number of parameters for
> iio_simple_dummy_configure_buffer() only for the IIO_SIMPLE_DUMMY_BUFFER
> case.  Fix this by also changing the placeholder function declared in
> the header when buffering is not enabled.
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Good catch - clears up an autobuilder warning I'd been meaning to chase down as well.

Thanks,

> ---
>  drivers/staging/iio/iio_simple_dummy.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
> index af70126..34989bf 100644
> --- a/drivers/staging/iio/iio_simple_dummy.h
> +++ b/drivers/staging/iio/iio_simple_dummy.h
> @@ -117,8 +117,7 @@ enum iio_simple_dummy_scan_elements {
>  int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev);
>  void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev);
>  #else
> -static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *channels, unsigned int num_channels)
> +static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
>  {
>  	return 0;
>  };
> 

