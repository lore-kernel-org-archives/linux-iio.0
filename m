Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35767 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbbFAVQ5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:57 -0400
Message-ID: <556C0AC5.6080005@kernel.org>
Date: Mon, 01 Jun 2015 08:33:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 23/32] tools:iio:iio_utils: add missing documentation
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de> <242d25655065086a6526899a21a0c10b65c5b3a1.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <242d25655065086a6526899a21a0c10b65c5b3a1.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> Fully document public functions and elements.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_utils.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++----
>  tools/iio/iio_utils.h |  5 ++-
>  2 files changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index e1828d0..5d5831d 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -29,6 +29,8 @@ static char * const iio_direction[] = {
>   * iioutils_break_up_name() - extract generic name from full channel name
>   * @full_name: the full channel name
>   * @generic_name: the output generic channel name
> + *
> + * Returns 0 on success, or a negative error code if string extraction failed.
>   **/
>  int iioutils_break_up_name(const char *full_name,
>  				  char **generic_name)
> @@ -76,11 +78,15 @@ int iioutils_break_up_name(const char *full_name,
>   * iioutils_get_type() - find and process _type attribute data
>   * @is_signed: output whether channel is signed
>   * @bytes: output how many bytes the channel storage occupies
> + * @bits_used: output number of valid bits of data
> + * @shift: output amount of bits to shift right data before applying bit mask
>   * @mask: output a bit mask for the raw data
> - * @be: big endian
> - * @device_dir: the iio device directory
> + * @be: output if data in big endian
> + * @device_dir: the IIO device directory
>   * @name: the channel name
>   * @generic_name: the channel type name
> + *
> + * Returns a value >= 0 on success, otherwise a negative error code.
>   **/
>  int iioutils_get_type(unsigned *is_signed,
>  			     unsigned *bytes,
> @@ -200,6 +206,16 @@ error_ret:
>  	return ret;
>  }
>  
> +/**
> + * iioutils_get_param_float() - read a float value from a channel parameter
> + * @output: output the float value
> + * @param_name: the parameter name to read
> + * @device_dir: the IIO device directory in sysfs
> + * @name: the channel name
> + * @generic_name: the channel type name
> + *
> + * Returns a value >= 0 on success, otherwise a negative error code.
> + **/
>  int iioutils_get_param_float(float *output,
>  				    const char *param_name,
>  				    const char *device_dir,
> @@ -266,8 +282,9 @@ error_ret:
>  }
>  
>  /**
> - * bsort_channel_array_by_index() - reorder so that the array is in index order
> - *
> + * bsort_channel_array_by_index() - sort the array in index order
> + * @ci_array: the iio_channel_info array to be sorted
> + * @cnt: the amount of array elements
>   **/
>  
>  void bsort_channel_array_by_index(struct iio_channel_info **ci_array,
> @@ -289,7 +306,10 @@ void bsort_channel_array_by_index(struct iio_channel_info **ci_array,
>  /**
>   * build_channel_array() - function to figure out what channels are present
>   * @device_dir: the IIO device directory in sysfs
> - * @
> + * @ci_array: output the resulting array of iio_channel_info
> + * @counter: output the amount of array elements
> + *
> + * Returns 0 on success, otherwise a negative error code.
>   **/
>  int build_channel_array(const char *device_dir,
>  			      struct iio_channel_info **ci_array,
> @@ -525,8 +545,10 @@ int calc_digits(int num)
>  /**
>   * find_type_by_name() - function to match top level types by name
>   * @name: top level type instance name
> - * @type: the type of top level instance being sort
> + * @type: the type of top level instance being searched
>   *
> + * Returns the device number of a matched IIO device on success, otherwise a
> + * negative error code.
>   * Typical types this is used for are device and trigger.
>   **/
>  int find_type_by_name(const char *name, const char *type)
> @@ -684,11 +706,28 @@ error_free:
>  	return ret;
>  }
>  
> +/**
> + * write_sysfs_int() - write an integer value to a sysfs file
> + * @filename: name of the file to write to
> + * @basedir: the sysfs directory in which the file is to be found
> + * @val: integer value to write to file
> + *
> + * Returns a value >= 0 on success, otherwise a negative error code.
> + **/
>  int write_sysfs_int(char *filename, char *basedir, int val)
>  {
>  	return _write_sysfs_int(filename, basedir, val, 0);
>  }
>  
> +/**
> + * write_sysfs_int_and_verify() - write an integer value to a sysfs file
> + *				  and verify
> + * @filename: name of the file to write to
> + * @basedir: the sysfs directory in which the file is to be found
> + * @val: integer value to write to file
> + *
> + * Returns a value >= 0 on success, otherwise a negative error code.
> + **/
>  int write_sysfs_int_and_verify(char *filename, char *basedir, int val)
>  {
>  	return _write_sysfs_int(filename, basedir, val, 1);
> @@ -770,17 +809,35 @@ error_free:
>   * @filename: name of file to write to
>   * @basedir: the sysfs directory in which the file is to be found
>   * @val: the string to write
> + *
> + * Returns a value >= 0 on success, otherwise a negative error code.
>   **/
>  int write_sysfs_string_and_verify(char *filename, char *basedir, char *val)
>  {
>  	return _write_sysfs_string(filename, basedir, val, 1);
>  }
>  
> +/**
> + * write_sysfs_string() - write string to a sysfs file
> + * @filename: name of file to write to
> + * @basedir: the sysfs directory in which the file is to be found
> + * @val: the string to write
> + *
> + * Returns a value >= 0 on success, otherwise a negative error code.
> + **/
>  int write_sysfs_string(char *filename, char *basedir, char *val)
>  {
>  	return _write_sysfs_string(filename, basedir, val, 0);
>  }
>  
> +/**
> + * read_sysfs_posint() - read an integer value from file
> + * @filename: name of file to read from
> + * @basedir: the sysfs directory in which the file is to be found
> + *
> + * Returns the read integer value >= 0 on success, otherwise a negative error
> + * code.
> + **/
>  int read_sysfs_posint(char *filename, char *basedir)
>  {
>  	int ret;
> @@ -817,6 +874,14 @@ error_free:
>  	return ret;
>  }
>  
> +/**
> + * read_sysfs_float() - read a float value from file
> + * @filename: name of file to read from
> + * @basedir: the sysfs directory in which the file is to be found
> + * @val: output the read float value
> + *
> + * Returns a value >= 0 on success, otherwise a negative error code.
> + **/
>  int read_sysfs_float(char *filename, char *basedir, float *val)
>  {
>  	int ret = 0;
> @@ -853,6 +918,14 @@ error_free:
>  	return ret;
>  }
>  
> +/**
> + * read_sysfs_string() - read a string from file
> + * @filename: name of file to read from
> + * @basedir: the sysfs directory in which the file is to be found
> + * @str: output the read string
> + *
> + * Returns a value >= 0 on success, otherwise a negative error code.
> + **/
>  int read_sysfs_string(const char *filename, const char *basedir, char *str)
>  {
>  	int ret = 0;
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 1bc837b..e5eb46a 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -28,9 +28,12 @@ extern const char *iio_dir;
>   * @offset: offset to be applied for conversion to si units
>   * @index: the channel index in the buffer output
>   * @bytes: number of bytes occupied in buffer output
> + * @bits_used: number of valid bits of data
> + * @shift: amount of bits to shift right data before applying bit mask
>   * @mask: a bit mask for the raw output
> + * @be: flag if data is big endian
>   * @is_signed: is the raw value stored signed
> - * @enabled: is this channel enabled
> + * @location: data offset for this channel inside the buffer (in bytes)
>   **/
>  struct iio_channel_info {
>  	char *name;
> 

