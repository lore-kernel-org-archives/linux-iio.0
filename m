Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60888 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbcDWVOS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2016 17:14:18 -0400
Subject: Re: [PATCH v1 1/3] iio:core: mounting matrix support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461170293.git.gregor.boirie@parrot.com>
 <0910cde3dad40284f8aad9148a156c5ef54dacc4.1461170293.git.gregor.boirie@parrot.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Peter Rosin <peda@axentia.se>,
	Leonard Crestez <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <93a306a3-2275-be23-1408-65ff020b922f@kernel.org>
Date: Sat, 23 Apr 2016 22:14:13 +0100
MIME-Version: 1.0
In-Reply-To: <0910cde3dad40284f8aad9148a156c5ef54dacc4.1461170293.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/04/16 18:23, Gregor Boirie wrote:
> Expose a rotation matrix to indicate userspace the chip placement with
> respect to the overall hardware system. This is needed to adjust
> coordinates sampled from a sensor chip when its position deviates from the
> main hardware system.
> 
> Final coordinates computation is delegated to userspace since:
> * computation may involve floating point arithmetics ;
> * it allows an application to combine adjustments with arbitrary
>   transformations.
> 
> This 3 dimentional space rotation matrix is expressed as 3x3 array of
> strings to support floating point numbers. It may be retrieved from a
> "[<dir>_][<type>_]mount_matrix" sysfs attribute file. It is declared into a
> device / driver specific DTS property or platform data.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 51 ++++++++++++++++++++
>  drivers/iio/industrialio-core.c         | 82 +++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h                 | 31 +++++++++++++
>  3 files changed, 164 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f155eff..ba8df69 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1512,3 +1512,54 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled no offset etc.) pH reading of a substance as a negative
>  		base-10 logarithm of hydrodium ions in a litre of water.
> +
> +What:           /sys/bus/iio/devices/iio:deviceX/mount_matrix
> +What:           /sys/bus/iio/devices/iio:deviceX/in_mount_matrix
> +What:           /sys/bus/iio/devices/iio:deviceX/out_mount_matrix
> +KernelVersion:  4.6
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		Mounting matrix for IIO sensors. This is a rotation matrix which
> +		informs userspace about sensor chip's placement relative to the
> +		main hardware it is mounted on.
> +		Main hardware placement is defined according to the local
> +		reference frame related to the physical quantity the sensor
> +		measures.
> +		Given that the rotation matrix is defined in a board specific
> +		way (platform data and / or device-tree), the main hardware
> +		reference frame definition is left to the implementor's choice
> +		(see below for a magnetometer example).
> +		Applications should apply this rotation matrix to samples so
> +		that when main hardware reference frame is aligned onto local
> +		reference frame, then sensor chip reference frame is also
> +		perfectly aligned with it.
> +		Matrix is a 3x3 unitary matrix and typically looks like
> +		[0, 1, 0; 1, 0, 0; 0, 0, -1]. Identity matrix
> +		[1, 0, 0; 0, 1, 0; 0, 0, 1] means sensor chip and main hardware
> +		are perfectly aligned with each other.
> +
> +		For example, a mounting matrix for a magnetometer sensor informs
> +		userspace about sensor chip's ORIENTATION relative to the main
> +		hardware.
> +		More specifically, main hardware orientation is defined with
> +		respect to the LOCAL EARTH GEOMAGNETIC REFERENCE FRAME where :
> +		* Y is in the ground plane and positive towards magnetic North ;
> +		* X is in the ground plane, perpendicular to the North axis and
> +		  positive towards the East ;
> +		* Z is perpendicular to the ground plane and positive upwards.
> +
> +		An implementor might consider that for a hand-held device, a
> +		'natural' orientation would be 'front facing camera at the top'.
> +		The main hardware reference frame could then be described as :
> +		* Y is in the plane of the screen and is positive towards the
> +		  top of the screen ;
> +		* X is in the plane of the screen, perpendicular to Y axis, and
> +		  positive towards the right hand side of the screen ;
> +		* Z is perpendicular to the screen plane and positive out of the
> +		  screen.
> +		Another example for a quadrotor UAV might be :
> +		* Y is in the plane of the propellers and positive towards the
> +		  front-view camera;
> +		* X is in the plane of the propellers, perpendicular to Y axis,
> +		  and positive towards the starboard side of the UAV ;
> +		* Z is perpendicular to propellers plane and positive upwards.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 190a593..e6319a9 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -412,6 +412,88 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(iio_enum_write);
>  
> +static const struct iio_mount_matrix iio_mount_idmatrix = {
> +	.rotation = {
> +		"1", "0", "0",
> +		"0", "1", "0",
> +		"0", "0", "1"
> +	}
> +};
> +
> +static int iio_setup_mount_idmatrix(const struct device *dev,
> +				    struct iio_mount_matrix *matrix)
> +{
> +	*matrix = iio_mount_idmatrix;
> +	dev_info(dev, "mounting matrix not found: using identity...\n");
> +	return 0;
> +}
> +
> +ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
> +			      const struct iio_chan_spec *chan, char *buf)
> +{
> +	const struct iio_mount_matrix *mtx = ((iio_get_mount_matrix_t *)
> +					      priv)(indio_dev, chan);
> +
> +	if (IS_ERR(mtx))
> +		return PTR_ERR(mtx);
> +
> +	if (!mtx)
> +		mtx = &iio_mount_idmatrix;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s, %s, %s; %s, %s, %s; %s, %s, %s\n",
> +			mtx->rotation[0], mtx->rotation[1], mtx->rotation[2],
> +			mtx->rotation[3], mtx->rotation[4], mtx->rotation[5],
> +			mtx->rotation[6], mtx->rotation[7], mtx->rotation[8]);
> +}
> +EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
> +
> +/**
> + * of_iio_read_mount_matrix() - retrieve iio device mounting matrix from
> + *                              device-tree "mount-matrix" property
> + * @dev:	device the mounting matrix property is assigned to
> + * @propname:	device specific mounting matrix property name
> + * @matrix:	where to store retrieved matrix
> + *
> + * If device is assigned no mounting matrix property, a default 3x3 identity
> + * matrix will be filled in.
> + *
> + * Return: 0 if success, or a negative error code on failure.
> + */
> +#ifdef CONFIG_OF
> +int of_iio_read_mount_matrix(const struct device *dev,
> +			     const char *propname,
> +			     struct iio_mount_matrix *matrix)
> +{
> +	if (dev->of_node) {
> +		int err = of_property_read_string_array(dev->of_node,
> +				propname, matrix->rotation,
> +				ARRAY_SIZE(iio_mount_idmatrix.rotation));
> +
> +		if (err == ARRAY_SIZE(iio_mount_idmatrix.rotation))
> +			return 0;
> +
> +		if (err >= 0)
> +			/* Invalid number of matrix entries. */
> +			return -EINVAL;
> +
> +		if (err != -EINVAL)
> +			/* Invalid matrix declaration format. */
> +			return err;
> +	}
> +
> +	/* Matrix was not declared at all: fallback to identity. */
> +	return iio_setup_mount_idmatrix(dev, matrix);
> +}
> +#else
> +int of_iio_read_mount_matrix(const struct device *dev,
> +			     const char *propname,
> +			     struct iio_mount_matrix *matrix)
> +{
> +	return iio_setup_mount_idmatrix(dev, matrix);
> +}
> +#endif
> +EXPORT_SYMBOL(of_iio_read_mount_matrix);
> +
>  /**
>   * iio_format_value() - Formats a IIO value into its string representation
>   * @buf:	The buffer to which the formatted value gets written
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 0b2773a..7c29cb0 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -148,6 +148,37 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>  }
>  
>  /**
> + * struct iio_mount_matrix - iio mounting matrix
> + * @rotation: 3 dimensional space rotation matrix defining sensor alignment with
> + *            main hardware
> + */
> +struct iio_mount_matrix {
> +	const char *rotation[9];
> +};
> +
> +ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
> +			      const struct iio_chan_spec *chan, char *buf);
> +int of_iio_read_mount_matrix(const struct device *dev, const char *propname,
> +			     struct iio_mount_matrix *matrix);
> +
> +typedef const struct iio_mount_matrix *
> +	(iio_get_mount_matrix_t)(const struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan);
> +
> +/**
> + * IIO_MOUNT_MATRIX() - Initialize mount matrix extended channel attribute
> + * @_shared:	Whether the attribute is shared between all channels
> + * @_get:	Pointer to an iio_get_mount_matrix_t accessor
> + */
> +#define IIO_MOUNT_MATRIX(_shared, _get) \
> +{ \
> +	.name = "mount_matrix", \
> +	.shared = (_shared), \
> +	.read = iio_show_mount_matrix, \
> +	.private = (uintptr_t)(_get), \
> +}
> +
> +/**
>   * struct iio_event_spec - specification for a channel event
>   * @type:		    Type of the event
>   * @dir:		    Direction of the event
> 

