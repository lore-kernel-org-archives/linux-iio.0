Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C7F59D9.8050606@iis.fraunhofer.de>
Date: Thu, 02 Sep 2010 10:01:29 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/9] staging:iio: unecessary header removal and kernel
 doc clean up
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk> <1283353083-31313-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-4-git-send-email-jic23@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------050207000900010403040105"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050207000900010403040105
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id KAA06356

See one comment below.

Am 01.09.2010 16:57, schrieb Jonathan Cameron:
> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
> ---
>   drivers/staging/iio/industrialio-ring.c |   11 ++---
>   drivers/staging/iio/ring_generic.h      |   69 ++++++++++++++++++++++=
+++++----
>   2 files changed, 65 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/=
iio/industrialio-ring.c
> index f3c87ed..8c2f3fa 100644
> --- a/drivers/staging/iio/industrialio-ring.c
> +++ b/drivers/staging/iio/industrialio-ring.c
> @@ -15,10 +15,8 @@
>    */
>   #include<linux/kernel.h>
>   #include<linux/device.h>
> -#include<linux/interrupt.h>
>   #include<linux/fs.h>
>   #include<linux/poll.h>
> -#include<linux/module.h>
>   #include<linux/cdev.h>
>   #include<linux/slab.h>
>
> @@ -53,7 +51,7 @@ int iio_push_or_escallate_ring_event(struct iio_ring_=
buffer *ring_buf,
>   EXPORT_SYMBOL(iio_push_or_escallate_ring_event);
>
>   /**
> - * iio_ring_open() chrdev file open for ring buffer access
> + * iio_ring_open() - chrdev file open for ring buffer access
>    *
>    * This function relies on all ring buffer implementations having an
>    * iio_ring_buffer as their first element.
> @@ -72,7 +70,7 @@ static int iio_ring_open(struct inode *inode, struct =
file *filp)
>   }
>
>   /**
> - * iio_ring_release() -chrdev file close ring buffer access
> + * iio_ring_release() - chrdev file close ring buffer access
>    *
>    * This function relies on all ring buffer implementations having an
>    * iio_ring_buffer as their first element.
> @@ -91,7 +89,7 @@ static int iio_ring_release(struct inode *inode, stru=
ct file *filp)
>   }
>
>   /**
> - * iio_ring_rip_outer() chrdev read for ring buffer access
> + * iio_ring_rip_outer() - chrdev read for ring buffer access
>    *
>    * This function relies on all ring buffer implementations having an
>    * iio_ring _bufer as their first element.
> @@ -136,8 +134,9 @@ static const struct file_operations iio_ring_fileop=
s =3D {
>   };
>
>   /**
> - * __iio_request_ring_buffer_event_chrdev() allocate ring event chrdev
> + * __iio_request_ring_buffer_event_chrdev() - allocate ring event chrd=
ev
>    * @buf:	ring buffer whose event chrdev we are allocating
> + * @id:		id of this ring buffer (typically 0)
>    * @owner:	the module who owns the ring buffer (for ref counting)
>    * @dev:	device with which the chrdev is associated
>    **/
> diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/r=
ing_generic.h
> index 6124353..af355d8 100644
> --- a/drivers/staging/iio/ring_generic.h
> +++ b/drivers/staging/iio/ring_generic.h
> @@ -13,9 +13,7 @@
>
>   #ifdef CONFIG_IIO_RING_BUFFER
>
> -struct iio_handler;
>   struct iio_ring_buffer;
> -struct iio_dev;
>
>   /**
>    * iio_push_ring_event() - ring buffer specific push to event chrdev
> @@ -52,8 +50,8 @@ int iio_push_or_escallate_ring_event(struct iio_ring_=
buffer *ring_buf,
>    *			change.
>    * @request_update:	if a parameter change has been marked, update und=
erlying
>    *			storage.
> - * @get_bytes_per_datum:		get current bytes per datum
> - * @set_bytes_per_datum:		set number of bytes per datum
> + * @get_bytes_per_datum:get current bytes per datum
> + * @set_bytes_per_datum:set number of bytes per datum
>    * @get_length:		get number of datums in ring
>    * @set_length:		set number of datums in ring
>    * @is_enabled:		query if ring is currently being used
> @@ -99,7 +97,7 @@ struct iio_ring_access_funcs {
>    * @id:			unique id number
>    * @access_id:		device id number
>    * @length:		[DEVICE] number of datums in ring
> - * @bytes_per_datum	[DEVICE] size of individual datum including timest=
amp
> + * @bytes_per_datum:	[DEVICE] size of individual datum including times=
tamp
>    * @bpe:		[DEVICE] size of individual channel value
>    * @loopcount:		[INTERN] number of times the ring has looped
>    * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mod=
e
> @@ -143,6 +141,12 @@ struct iio_ring_buffer {
>   	int				(*postdisable)(struct iio_dev *);
>
>   };
> +
> +/**
> + * iio_ring_buffer_init() - Initialize the buffer structure
> + * @ring: buffer to be initialized
> + * @dev_info: the iio device the buffer is assocated with
> + **/
>   void iio_ring_buffer_init(struct iio_ring_buffer *ring,
>   			  struct iio_dev *dev_info);
>
> @@ -201,7 +205,7 @@ struct iio_scan_el {
>   ssize_t iio_scan_el_store(struct device *dev, struct device_attribute=
 *attr,
>   			  const char *buf, size_t len);
>   /**
> - * iio_scal_el_show() -	sysfs interface to query whether a scan elemen=
t is
> + * iio_scan_el_show() -	sysfs interface to query whether a scan elemen=
t is
>    *			is enabled or not
>    * @dev: the target device
>    * @attr: the device attribute that is being processed

Did you change anything here? The 'is' is still doubled.

> @@ -210,9 +214,16 @@ ssize_t iio_scan_el_store(struct device *dev, stru=
ct device_attribute *attr,
>   ssize_t iio_scan_el_show(struct device *dev, struct device_attribute =
*attr,
>   			 char *buf);
>
> +/**
> + * iio_scan_el_ts_store() - sysfs interface to set whether a timestamp=
 is included
> + *			    in the scan.
> + **/
>   ssize_t iio_scan_el_ts_store(struct device *dev, struct device_attrib=
ute *attr,
>   			     const char *buf, size_t len);
> -
> +/**
> + * iio_scan_el_ts_show() - sysfs interface to query if a timestamp is =
included
> + *			   in the scan.
> + **/
>   ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribu=
te *attr,
>   			    char *buf);
>   /**
> @@ -256,6 +267,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, str=
uct device_attribute *attr,
>   	__IIO_SCAN_NAMED_EL_C(_name, _string, _number, _bits, _label, _cf)
>   /**
>    * IIO_SCAN_EL_TIMESTAMP - declare a special scan element for timesta=
mps
> + * @number: specify where in the scan order this is stored.
>    *
>    * Odd one out. Handled slightly differently from other scan elements.
>    **/
> @@ -307,6 +319,11 @@ static inline int iio_scan_mask_query(struct iio_r=
ing_buffer *ring, int bit)
>   	return !!(mask&  (1<<  bit));
>   };
>
> +/**
> + * iio_scan_mask_set() - set particular bit in the scan mask
> + * @ring: the ring buffer whose scan mask we are interested in
> + * @bit: the bit to be set.
> + **/
>   static inline int iio_scan_mask_set(struct iio_ring_buffer *ring, int=
 bit)
>   {
>   	struct iio_dev *dev_info =3D ring->indio_dev;
> @@ -327,6 +344,11 @@ static inline int iio_scan_mask_set(struct iio_rin=
g_buffer *ring, int bit)
>   	return 0;
>   };
>
> +/**
> + * iio_scan_mask_clear() - clear a particular element from the scan ma=
sk
> + * @ring: the ring buffer whose scan mask we are interested in
> + * @bit: the bit to clear
> + **/
>   static inline int iio_scan_mask_clear(struct iio_ring_buffer *ring, i=
nt bit)
>   {
>   	if (bit>  IIO_MAX_SCAN_LENGTH)
> @@ -338,7 +360,7 @@ static inline int iio_scan_mask_clear(struct iio_ri=
ng_buffer *ring, int bit)
>
>   /**
>    * iio_scan_mask_count_to_right() - how many scan elements occur befo=
re here
> - * @dev_info: the iio_device whose scan mode we are querying
> + * @ring: the ring buffer whose scan mask we interested in
>    * @bit: which number scan element is this
>    **/
>   static inline int iio_scan_mask_count_to_right(struct iio_ring_buffer=
 *ring,
> @@ -357,7 +379,10 @@ static inline int iio_scan_mask_count_to_right(str=
uct iio_ring_buffer *ring,
>   	return count;
>   }
>
> -
> +/**
> + * iio_put_ring_buffer() - notify done with buffer
> + * @ring: the buffer we are done with.
> + **/
>   static inline void iio_put_ring_buffer(struct iio_ring_buffer *ring)
>   {
>   	put_device(&ring->dev);
> @@ -367,23 +392,49 @@ static inline void iio_put_ring_buffer(struct iio=
_ring_buffer *ring)
>   	container_of(d, struct iio_ring_buffer, dev)
>   #define access_dev_to_iio_ring_buffer(d)			\
>   	container_of(d, struct iio_ring_buffer, access_dev)
> +
> +/**
> + * iio_ring_buffer_register() - register the buffer with IIO core
> + * @ring: the buffer to be registered
> + * @id: the id of the buffer (typically 0)
> + **/
>   int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id);
> +
> +/**
> + * iio_ring_buffer_unregister() - unregister the buffer from IIO core
> + * @ring: the buffer to be unregistered
> + **/
>   void iio_ring_buffer_unregister(struct iio_ring_buffer *ring);
>
> +/**
> + * iio_read_ring_length() - attr func to get number of datums in the b=
uffer
> + **/
>   ssize_t iio_read_ring_length(struct device *dev,
>   			     struct device_attribute *attr,
>   			     char *buf);
> +/**
> + * iio_write_ring_length() - attr func to set number of datums in the =
buffer
> + **/
>   ssize_t iio_write_ring_length(struct device *dev,
>   			      struct device_attribute *attr,
>   			      const char *buf,
>   			      size_t len);
> +/**
> + * iio_read_ring_bytes_per_datum() - attr for number of bytes in whole=
 datum
> + **/
>   ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
>   			  struct device_attribute *attr,
>   			  char *buf);
> +/**
> + * iio_store_ring_enable() - attr to turn the buffer on
> + **/
>   ssize_t iio_store_ring_enable(struct device *dev,
>   			      struct device_attribute *attr,
>   			      const char *buf,
>   			      size_t len);
> +/**
> + * iio_show_ring_enable() - attr to see if the buffer is on
> + **/
>   ssize_t iio_show_ring_enable(struct device *dev,
>   			     struct device_attribute *attr,
>   			     char *buf);


--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------050207000900010403040105
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------050207000900010403040105--
