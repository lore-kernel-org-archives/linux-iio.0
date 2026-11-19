Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057077;
	b=ogpCP4AB8VGuftCIvtLiDv5Fa9nhN9LiKrVdDW7ws2U4wsBcWIzHYke4gFi3xS9yjFQq
	 ILbL5WsAyVtTFnKJWHtmaxjZamCQisG10YbnEhSnEk8sgtTXbPVVlk0HBOsDqksR0pUtb
	 CVnWkS4kyAha2kn7ppRzUwiL+GUlEyqwNcnUSgKYdQxtc4fG1BLWzOsKlnaMduc2nkHuV
	 J6ggaeXvuI0myQvzvFuH+7kPaOP4qf5LjCDwEeK/y1NWTABifzfxbzUembR0QbFYy4msb
	 Gcm1brld4ecGvRwnDscO81C8vJSMQsqRBd/V57KXHVHfT8mJQUn1ZG74EygtwuPYPTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057077;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dU1UN6hq17AplRr197Yt2kF1Z8sztPL4e2+ENhGHKe4=;
	b=lRNANrYv0XxDgXdN4Xa9/6GgSDD6ekSA6Cm2LgoTB0akEGhF4+9k1itf/sd+Ai+TgFDh
	 eUtiLcuvq0rG75hJRZM7o2+A7kRZnICfpyI6MGDybOnyVyLu2xqxeR6tjGf3n0Cnb1TeT
	 7+r8RKDBt6G4SZfo5AmVC9gzPkvzNXiGYxbtapTefinP1QLDMdr/hhJvsebnjbFPXPbNQ
	 EMcxXtHqq6xNiOOKt3k73iRauocygdg7AI/3ilVCvfxWhyB2u/6/SvtQ5N0YW9HAAwpRb
	 mGXGApow+AGa/kG9dYuMOqidr2tV81hFNEcYy8mt6JTLVr1FYtOsAoinUpIgyv7gLsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBrKJHMc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50349606A320;
	Thu, 19 Nov 2026 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kBrKJHMc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533391F000C7;
	Thu, 19 Nov 2026 02:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795057077;
	bh=dU1UN6hq17AplRr197Yt2kF1Z8sztPL4e2+ENhGHKe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kBrKJHMcIJhU3y1dW3uvJsZiwYgdKrb2D24uyRFVia+7xRt2FID5xaOi6kDvFkDWS
	 FuFAmmhW0R8WvegpWDdlXIZiKY28UMoGCRUHMioFYbz/xI7h6fbtedKh5Pct4BQoI9
	 Arkmbyx01pr62KJblpRdrk83P3Nvc3YAMGa9JMashnKabgEm3La5S7gsqZpKYAx5qY
	 u0QSeFQqdHJdt9xZ43gHtx01uuWuxDnoFbcFyoYV923ttuAbFvUD6h/1E7yxnnOnZP
	 YsohGbfxw0OlbSy09UEkTQ6UdnjRSsCAT5muxlev98VeU6QEH3HzP5ANOdiB3xs1Cd
	 FtMXFH1caDAqA==
Date: Thu, 19 Nov 2026 02:57:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux@analog.com>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 1/5] iio: backend: Add calibration source interface
Message-ID: <20261119025747.53b30ba4@jic23-hlaptop>
In-Reply-To: <67582938820d6f206006b16de71ad6bcdacfa863.1795003864.git.marcelo.schmitt@analog.com>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
	<67582938820d6f206006b16de71ad6bcdacfa863.1795003864.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 10:03:17 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Some ADC front-ends send data over a configurable number of LVDS serial
> lanes and may also need to have the data frame calibrated before capture
> can start.
> 
> Add a backend operation for selecting the calibration source (data lane or
> data frame) so that device drivers can perform the calibration of both the
> data frame and data lanes.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 23 +++++++++++++++++++++++
>  include/linux/iio/backend.h        | 22 ++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index fbf5c39d7655..682d5f735071 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -869,6 +869,29 @@ int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us)
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_interface_data_align, "IIO_BACKEND");
>  
> +/**
> + * iio_backend_calibration_source_set - Select the monitored error source
> + * @back: Backend device
> + * @source: Error source to monitor.
> + * @lane: Data lane to monitor. Only meaningful for
> + *	  %IIO_BACKEND_CALIB_SOURCE_DATA_LANE.
> + *
> + * Restrict the error reported through iio_backend_chan_status() to a single
> + * source of the digital interface so that each lane can be calibrated
> + * independently. Backends are expected to report every error source again
> + * once %IIO_BACKEND_CALIB_SOURCE_NONE is selected.

I don't follow this description at all. If there is more than one how
does it report 'every' error source? 

Add some explanation, probably to the commit message on how the
flow using this works.  We might need more info here as well.

> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_calibration_source_set(struct iio_backend *back,
> +				       enum iio_backend_calib_source source,
> +				       unsigned int lane)
> +{
> +	return iio_backend_op_call(back, calibration_source_set, source, lane);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_calibration_source_set, "IIO_BACKEND");
> +
>  /**
>   * iio_backend_num_lanes_set - Number of lanes enabled.
>   * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 9c16b695a602..6f28e2d016f7 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -76,6 +76,20 @@ enum iio_backend_interface_type {
>  	IIO_BACKEND_INTERFACE_MAX
>  };
>  
> +/**
> + * enum iio_backend_calib_source - Digital interface error source
> + * @IIO_BACKEND_CALIB_SOURCE_NONE: Report every error source.
> + * @IIO_BACKEND_CALIB_SOURCE_DATA_LANE: Report errors of a single data lane.
> + * @IIO_BACKEND_CALIB_SOURCE_FRAME: Report errors of the frame signal.
> + * @IIO_BACKEND_CALIB_SOURCE_MAX: Number of error sources.
> + */
> +enum iio_backend_calib_source {
> +	IIO_BACKEND_CALIB_SOURCE_NONE,
> +	IIO_BACKEND_CALIB_SOURCE_DATA_LANE,
> +	IIO_BACKEND_CALIB_SOURCE_FRAME,
> +	IIO_BACKEND_CALIB_SOURCE_MAX
> +};
> +
>  enum iio_backend_filter_type {
>  	IIO_BACKEND_FILTER_TYPE_DISABLED,
>  	IIO_BACKEND_FILTER_TYPE_SINC1,
> @@ -132,6 +146,8 @@ enum iio_backend_capabilities {
>   * @debugfs_reg_access: Read or write register value of backend.
>   * @filter_type_set: Set filter type.
>   * @interface_data_align: Perform the data alignment process.
> + * @calibration_source_set: Select the error source monitored during
> + *			    interface calibration.
>   * @num_lanes_set: Set the number of lanes enabled.
>   * @crc_enable: Enable direction-specific CRC handling.
>   * @crc_disable: Disable direction-specific CRC handling.
> @@ -190,6 +206,9 @@ struct iio_backend_ops {
>  	int (*filter_type_set)(struct iio_backend *back,
>  			       enum iio_backend_filter_type type);
>  	int (*interface_data_align)(struct iio_backend *back, u32 timeout_us);
> +	int (*calibration_source_set)(struct iio_backend *back,
> +				      enum iio_backend_calib_source source,
> +				      unsigned int lane);
>  	int (*num_lanes_set)(struct iio_backend *back, unsigned int num_lanes);
>  	int (*crc_enable)(struct iio_backend *back);
>  	int (*crc_disable)(struct iio_backend *back);
> @@ -240,6 +259,9 @@ int devm_iio_backend_request_buffer(struct device *dev,
>  int iio_backend_filter_type_set(struct iio_backend *back,
>  				enum iio_backend_filter_type type);
>  int iio_backend_interface_data_align(struct iio_backend *back, u32 timeout_us);
> +int iio_backend_calibration_source_set(struct iio_backend *back,
> +				       enum iio_backend_calib_source source,
> +				       unsigned int lane);
>  int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int num_lanes);
>  int iio_backend_crc_enable(struct iio_backend *back);
>  int iio_backend_crc_disable(struct iio_backend *back);

