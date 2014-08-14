Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:46444
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755018AbaHNPLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Aug 2014 11:11:48 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: Allow devices to specify that bits above the MSB
 are fully defined
Date: Thu, 14 Aug 2014 15:10:46 +0000
Message-ID: <78F369B105E123488216BDB7B6C397DA8BD7FCA4@NWD2MBX6.ad.analog.com>
References: <1407919628-14409-1-git-send-email-lars@metafoo.de>
 <53ECCADA.7000202@kernel.org>
In-Reply-To: <53ECCADA.7000202@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>I'm a little unsure of whether this extra interface is worthwhile...

Setting realbits == storagebits sounds obvious, however important information user space may utilize is lost. 
In our particular case user space evaluates realbits to scale an FFT to full-scale (dbFS).
Per sample sign extension is a costly operation within libiio.
We rather prefer to avoid this unnecessary step.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, William A. Martin, Margaret Seif

 

-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org] 
Sent: Donnerstag, 14. August 2014 16:43
To: Lars-Peter Clausen; Hennerich, Michael
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Allow devices to specify that bits above the MSB are fully defined

On 13/08/14 09:47, Lars-Peter Clausen wrote:
> Some devices which have less significant bits than the number of 
> storage bits (e.g. 14-bit data in a 16-bit word) still properly 
> initialize the bits above the MSB. For unsigned data this means the 
> bits will be set to 0 and for signed data the bits will be set to the 
> extended sign bit. Having this information allows userspace 
> applications to skip the step of having to perform a manual sign 
> extension or masking of the upper bits. Especially when processing 
> larger quantities of data this can improve performance. This patch 
> introduces two new sign specifiers for the scan element type to allow 
> drivers to describe this behavior. A uppercase 'S' will be used for fully defined signed words and a uppercase 'U' will be used for fully defined unsigned words.
>
Hmm. From a purely interfacing point of view, the obvious thing to do would be to simply set realbits == storagebits.
I guess the point here is that userspace might be infering more than simply how to grab the data when it reads the buffer description.  It would prevent userspace from performing minimal packing for example.

I'm a little unsure of whether this extra interface is worthwhile...

Will let this sit for a little while to gather more opinions...

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 38 
> ++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio 
> b/Documentation/ABI/testing/sysfs-bus-iio
> index d760b02..f104ef8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -885,23 +885,27 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Description of the scan element data storage within the buffer
>  		and hence the form in which it is read from user-space.
> -		Form is [be|le]:[s|u]bits/storagebits[>>shift].
> -		be or le specifies big or little endian. s or u specifies if
> -		signed (2's complement) or unsigned. bits is the number of bits
> -		of data and storagebits is the space (after padding) that it
> -		occupies in the buffer. shift if specified, is the shift that
> -		needs to be applied prior to masking out unused bits. Some
> -		devices put their data in the middle of the transferred elements
> -		with additional information on both sides.  Note that some
> -		devices will have additional information in the unused bits
> -		so to get a clean value, the bits value must be used to mask
> -		the buffer output value appropriately.  The storagebits value
> -		also specifies the data alignment.  So s48/64>>2 will be a
> -		signed 48 bit integer stored in a 64 bit location aligned to
> -		a 64 bit boundary. To obtain the clean value, shift right 2
> -		and apply a mask to zero the top 16 bits of the result.
> -		For other storage combinations this attribute will be extended
> -		appropriately.
> +		Form is [be|le]:[s|S|u|U]bits/storagebits[>>shift].
> +		be or le specifies big or little endian. s/S u/U specifies if
> +		signed (2's complement) or unsigned. If the letter is lower case
> +		(s or u) this means that the bits above the MSB in the word as
> +		it is stored in memory are undefined and some devices may store
> +		additional information in these bits. A application processing
> +		such data should make sure to mask the upper bits out for
> +		unsigned data and do proper sign extension for signed data. If
> +		the letter is upper case (S or U) the bits above the MSB in the
> +		word are fully defined. For unsigned data the upper bits are
> +		guaranteed to be 0, for signed data they will contain the
> +		extended sign bit. In both cases bits below the the LSB will be
> +		undefined. bits is the number of bits of data and storagebits is
> +		the space (after padding) that it occupies in the buffer. shift
> +		if specified, is the shift that needs to be applied prior to
> +		masking out unused bits. The storagebits value also specifies
> +		the data alignment. So s48/64>>2 will be a signed 48 bit integer
> +		stored in a 64 bit location aligned to a 64 bit boundary. To
> +		obtain the clean value, shift right 2 and apply a mask to zero
> +		the top 16 bits of the result. For other storage combinations
> +		this attribute will be extended appropriately.
>  
>  What:		/sys/.../iio:deviceX/scan_elements/in_accel_type_available
>  KernelVersion:	2.6.37
> 
