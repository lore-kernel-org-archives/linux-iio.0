Return-Path: <SRS0=HNOD=OR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E23BC04EB8
	for <linux-iio@archiver.kernel.org>; Sat,  8 Dec 2018 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7AB20672
	for <linux-iio@archiver.kernel.org>; Sat,  8 Dec 2018 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544266829;
	bh=RVUrI+QxImd+0DBH9U6dxRXzFVrJWchl/w+3kHHvhFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=G/s4n6vBjU0e87ic8+n5NJ2NNSkT1LC9ooLhmPzZHEtZT9GZEVApki8Tv1VzTqAJk
	 lqFqg82iMHvSyHuhMUkBScpojbDfNWuambO5MQzTJPxb3wEeDmksB9FYdY0aGgWRN8
	 2EZG76xlTTuZ9wT9xZYgetP8soNIWmCpfOAzC3sI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7AB20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLHLA2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:00:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLHLA2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Dec 2018 06:00:28 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6B12064D;
        Sat,  8 Dec 2018 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544266826;
        bh=RVUrI+QxImd+0DBH9U6dxRXzFVrJWchl/w+3kHHvhFM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x6SQAAjVn5auhtbGi9z2dTZXv+qhSm+33tF24GlPJ1Zv35aSyajSo2cu67Tp9MnFN
         fm/QRXRNiYqMQ8kTJQ60EcNxirRCoF1uUPhI8EIc3dVhXUc1Yn92Z2AdDqf3lxVTDD
         Oy50pGR4/qFZGKlQkgSltaRB1Avl78QJW9gi8srk=
Date:   Sat, 8 Dec 2018 11:00:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     linux-iio@vger.kernel.org, denis.ciocca@st.com, hadess@hadess.net,
        linux@endlessm.com, hdegoede@redhat.com,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH] Re: Inconsistent SMO8840 accelerometer data between
 Windows and Linux
Message-ID: <20181208110022.3d433321@archlinux>
In-Reply-To: <20181203065707.3428-1-drake@endlessm.com>
References: <20181201162852.7007d1c9@archlinux>
        <20181203065707.3428-1-drake@endlessm.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Dec 2018 14:57:07 +0800
Daniel Drake <drake@endlessm.com> wrote:

> Jonathan Cameron wrote:
> > If we want to support their ONT we'll need to do this first, then
> > apply ONT on top of that by forming the relevant mount matrix and
> > outputting that to userspace.
> > If you fancy having a go it would be good to have this support!  
> 
> Cool, I didn't realise that there was a way to export mount matrices.
> It looks like iio-sensor-proxy doesn't read that attribute yet, I will
> submit a patch for that.
> 
> For the kernel changes, here is my initial attempt, comments welcome.
> I had to drop the const typing from iio_mount_matrix otherwise it's
> difficult to dynamically construct it.
> 
> Also I'm not sure whether we should apply this "default_ont" like Windows
> does even when _ONT is not present?
> 
> I would also love to hear from ST about how this situation happened and
> if this is the right way forward.
> 
> Regarding other devices with _ONT, the only other device we found
> is Asus P4540UQ, a system that we worked on 2 years ago and no longer
> have access to. I don't think we tested the accelerometer. The ACPI data
> indicates SMO8820, with Y and Z axis values requiring sign flip.
> 
> Thanks
> Daniel
Code looks good to me.  Hopefully we'll get some info on where this came from
and whether there is any standardization around it at all!

Jonathan
> ---
>  drivers/iio/accel/st_accel_core.c     | 161 +++++++++++++++++++++++++-
>  include/linux/iio/common/st_sensors.h |   1 +
>  include/linux/iio/iio.h               |   2 +-
>  3 files changed, 162 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 3e6fd5a8ac5b..3eb4e4b55596 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/acpi.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> @@ -917,12 +918,157 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>  
> +static const struct iio_mount_matrix *
> +get_mount_matrix(const struct iio_dev *indio_dev,
> +		 const struct iio_chan_spec *chan)
> +{
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +
> +	return adata->mount_matrix;
> +}
> +
> +static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
> +	{ },
> +};
> +
> +/* Read ST-specific _ONT orientation data from ACPI and generate an
> + * appropriate mount matrix.
> + */
> +static int apply_acpi_orientation(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec *channels)
> +{
> +	struct st_sensor_data *adata = iio_priv(indio_dev);
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_device *adev;
> +	union acpi_object *ont;
> +	union acpi_object *elements;
> +	acpi_status status;
> +	int ret = -EINVAL;
> +	unsigned int val;
> +	int i, j;
> +	int final_ont[3][3] = { 0 };
> +
> +	/* For some reason, ST's _ONT translation does not apply directly
> +	 * to the data read from the sensor. Another translation must be
> +	 * performed first, as described by the matrix below. Perhaps
> +	 * ST required this specific translation for the first product
> +	 * where the device was mounted?
> +	 */
> +	const int default_ont[3][3] = {
> +		{  0,  1,  0 },
> +		{ -1,  0,  0 },
> +		{  0,  0, -1 },
> +	};
> +
> +
> +	adev = ACPI_COMPANION(adata->dev);
> +	if (!adev)
> +		return 0;
> +
> +	/* Read _ONT data, which should be a package of 6 integers. */
> +	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		ret = status;
> +		goto out;
> +	}
> +
> +	ont = buffer.pointer;
> +	if (ont->type != ACPI_TYPE_PACKAGE || ont->package.count != 6)
> +		goto out;
> +
> +	/* The first 3 integers provide axis order information.
> +	 * e.g. 0 1 2 would indicate normal X,Y,Z ordering.
> +	 * e.g. 1 0 2 indicates that data arrives in order Y,X,Z.
> +	 */
> +	elements = ont->package.elements;
> +	for (i = 0; i < 3; i++) {
> +		if (elements[i].type != ACPI_TYPE_INTEGER)
> +			goto out;
> +
> +		val = elements[i].integer.value;
> +		if (val < 0 || val > 2)
> +			goto out;
> +
> +		/* Avoiding full matrix multiplication, we simply reorder the
> +		 * columns in the default_ont matrix according to the
> +		 * ordering provided by _ONT.
> +		 */
> +		final_ont[0][i] = default_ont[0][val];
> +		final_ont[1][i] = default_ont[1][val];
> +		final_ont[2][i] = default_ont[2][val];
> +	}
> +
> +	/* The final 3 integers provide sign flip information.
> +	 * 0 means no change, 1 means flip.
> +	 * e.g. 0 0 1 means that Z data should be sign-flipped.
> +	 * This is applied after the axis reordering from above.
> +	 */
> +	elements += 3;
> +	for (i = 0; i < 3; i++) {
> +		if (elements[i].type != ACPI_TYPE_INTEGER)
> +			goto out;
> +
> +		val = elements[i].integer.value;
> +		if (val != 0 && val != 1)
> +			goto out;
> +		if (!val)
> +			continue;
> +
> +		/* Flip the values in the indicated column */
> +		final_ont[0][i] *= -1;
> +		final_ont[1][i] *= -1;
> +		final_ont[2][i] *= -1;
> +	}
> +
> +	/* Convert our integer matrix to a string-based iio_mount_matrix */
> +	adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
> +					   sizeof(*adata->mount_matrix),
> +					   GFP_KERNEL);
> +	if (!adata->mount_matrix)
> +		goto out;
> +
> +	for (i = 0; i < 3; i++) {
> +		for (j = 0; j < 3; j++) {
> +			int matrix_val = final_ont[i][j];
> +			char *str_value;
> +
> +			switch (matrix_val) {
> +			case -1:
> +				str_value = "-1";
> +				break;
> +			case 0:
> +				str_value = "0";
> +				break;
> +			case 1:
> +				str_value = "1";
> +				break;
> +			default:
> +				goto out;
> +			}
> +			adata->mount_matrix->rotation[i * 3 + j] = str_value;
> +		}
> +	}
> +
> +	/* Expose the mount matrix via ext_info */
> +	for (i = 0; i < indio_dev->num_channels; i++)
> +		channels[i].ext_info = mount_matrix_ext_info;
> +
> +	ret = 0;
> +
> +out:
> +	kfree(buffer.pointer);
> +	return ret;
> +}
> +
>  int st_accel_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	struct st_sensors_platform_data *pdata =
>  		(struct st_sensors_platform_data *)adata->dev->platform_data;
>  	int irq = adata->get_irq_data_ready(indio_dev);
> +	struct iio_chan_spec *channels;
> +	size_t channels_size;
>  	int err;
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -941,9 +1087,22 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  
>  	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
>  	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
> -	indio_dev->channels = adata->sensor_settings->ch;
>  	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
>  
> +	channels_size = indio_dev->num_channels * sizeof(struct iio_chan_spec);
> +	channels = devm_kmemdup(&indio_dev->dev,
> +				adata->sensor_settings->ch,
> +				channels_size, GFP_KERNEL);
> +	if (!channels) {
> +		err = -ENOMEM;
> +		goto st_accel_power_off;
> +	}
> +
> +	err = apply_acpi_orientation(indio_dev, channels);
> +	if (err < 0)
> +		goto st_accel_power_off;
> +
> +	indio_dev->channels = channels;
>  	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
>  					&adata->sensor_settings->fs.fs_avl[0];
>  	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index f9bd6e8ab138..fe15694128ac 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -260,6 +260,7 @@ struct st_sensor_settings {
>  struct st_sensor_data {
>  	struct device *dev;
>  	struct iio_trigger *trig;
> +	struct iio_mount_matrix *mount_matrix;
>  	struct st_sensor_settings *sensor_settings;
>  	struct st_sensor_fullscale_avl *current_fullscale;
>  	struct regulator *vdd;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a74cb177dc6f..d3094ffeb9da 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -125,7 +125,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>   *            main hardware
>   */
>  struct iio_mount_matrix {
> -	const char *rotation[9];
> +	char *rotation[9];
>  };
>  
>  ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,

