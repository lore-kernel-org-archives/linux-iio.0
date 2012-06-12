Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FD73D00.8000700@cam.ac.uk>
Date: Tue, 12 Jun 2012 13:58:40 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: cleanup iio/iio.h
References: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net> <1339504946-16171-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339504946-16171-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/12/2012 1:42 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
> indentation of parameter description,
Normally I'd be anti that bit purely because of the churn
it causes, but with so many valid fixes elsewhere I guess
now is as good a time as any...
> fix parameter name (@dev ->  @indio_dev) in comments,
> IIO device info structure ->  IIO device structure
Dratt, overloaded terms. When those comments were written
we didn't have iio_info.  You are of course correct that
it is now rather confusing!
>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   include/linux/iio/iio.h |   36 ++++++++++++++++++------------------
>   1 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a35aa58..7711b4d 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -131,10 +131,10 @@ struct iio_chan_spec_ext_info {
>
>   /**
>    * struct iio_enum - Enum channel info attribute
> - * @items: An array of strings.
> - * @num_items: Length of the item array.
> - * @set: Set callback function, may be NULL.
> - * @get: Get callback function, may be NULL.
> + * @items:	An array of strings.
> + * @num_items:	Length of the item array.
> + * @set:	Set callback function, may be NULL.
> + * @get:	Get callback function, may be NULL.
>    *
>    * The iio_enum struct can be used to implement enum style channel attributes.
>    * Enum style attributes are those which have a set of strings which map to
> @@ -162,9 +162,9 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>
>   /**
>    * IIO_ENUM() - Initialize enum extended channel attribute
> - * @_name: Attribute name
> - * @_shared: Whether the attribute is shared between all channels
> - * @_e: Pointer to a iio_enum struct
> + * @_name:	Attribute name
> + * @_shared:	Whether the attribute is shared between all channels
> + * @_e:		Pointer to a iio_enum struct
>    *
>    * This should usually be used together with IIO_ENUM_AVAILABLE()
>    */
> @@ -179,8 +179,8 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>
>   /**
>    * IIO_ENUM_AVAILABLE() - Initialize enum available extended channel attribute
> - * @_name: Attribute name ("_available" will be appended to the name)
> - * @_e: Pointer to a iio_enum struct
> + * @_name:	Attribute name ("_available" will be appended to the name)
> + * @_e:		Pointer to a iio_enum struct
>    *
>    * Creates a read only attribute which list all the available enum items in a
>    * space separated list. This should usually be used together with IIO_ENUM()
> @@ -201,7 +201,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>    *			channel then this is it. If modified is set then the
>    *			value here specifies the modifier.
>    * @address:		Driver specific identifier.
> - * @scan_index:	Monotonic index to give ordering in scans when read
> + * @scan_index:		Monotonic index to give ordering in scans when read
>    *			from a buffer.
>    * @scan_type:		Sign:		's' or 'u' to specify signed or unsigned
>    *			realbits:	Number of valid bits of data
> @@ -211,7 +211,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>    *			endianness:	little or big endian
>    * @info_mask:		What information is to be exported about this channel.
>    *			This includes calibbias, scale etc.
> - * @event_mask:	What events can this channel produce.
> + * @event_mask:		What events can this channel produce.
>    * @ext_info:		Array of extended info attributes for this channel.
>    *			The array is NULL terminated, the last element should
>    *			have it's name field set to NULL.
> @@ -482,7 +482,7 @@ extern struct bus_type iio_bus_type;
>
>   /**
>    * iio_device_put() - reference counted deallocation of struct device
> - * @dev: the iio_device containing the device
> + * @indio_dev: 		IIO device structure containing the device
>    **/
>   static inline void iio_device_put(struct iio_dev *indio_dev)
>   {
> @@ -492,7 +492,7 @@ static inline void iio_device_put(struct iio_dev *indio_dev)
>
>   /**
>    * dev_to_iio_dev() - Get IIO device struct from a device struct
> - * @dev: The device embedded in the IIO device
> + * @dev: 		The device embedded in the IIO device
>    *
>    * Note: The device must be a IIO device, otherwise the result is undefined.
>    */
> @@ -503,7 +503,7 @@ static inline struct iio_dev *dev_to_iio_dev(struct device *dev)
>
>   /**
>    * iio_device_get() - increment reference count for the device
> - * @indio_dev: IIO device structure
> + * @indio_dev: 		IIO device structure
>    *
>    * Returns: The passed IIO device
>    **/
> @@ -516,7 +516,7 @@ static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
>   #define IIO_ALIGN L1_CACHE_BYTES
>   /**
>    * iio_device_alloc() - allocate an iio_dev from a driver
> - * @sizeof_priv: Space to allocate for private structure.
> + * @sizeof_priv: 	Space to allocate for private structure.
>    **/
>   struct iio_dev *iio_device_alloc(int sizeof_priv);
>
> @@ -533,13 +533,13 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
>
>   /**
>    * iio_device_free() - free an iio_dev from a driver
> - * @dev: the iio_dev associated with the device
> + * @indio_dev: 		the iio_dev associated with the device
>    **/
>   void iio_device_free(struct iio_dev *indio_dev);
>
>   /**
>    * iio_buffer_enabled() - helper function to test if the buffer is enabled
> - * @indio_dev:		IIO device info structure for device
> + * @indio_dev:		IIO device structure for device
>    **/
>   static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
>   {
> @@ -549,7 +549,7 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
>
>   /**
>    * iio_get_debugfs_dentry() - helper function to get the debugfs_dentry
> - * @indio_dev:		IIO device info structure for device
> + * @indio_dev:		IIO device structure for device
>    **/
>   #if defined(CONFIG_DEBUG_FS)
>   static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
