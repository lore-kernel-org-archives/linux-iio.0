Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46944 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758019Ab3AOWeH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Jan 2013 17:34:07 -0500
Message-ID: <50F5D957.6010603@kernel.org>
Date: Tue, 15 Jan 2013 22:33:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: iio: STMicroelectronics iio drivers
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358238660-14929-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/15/2013 08:30 AM, Denis CIOCCA wrote:
> Hi Jonathan,
> 
> I sent to you the new patches to fix the u8 casting and a little bugfix in the header files (functions within #ifdef).
> Thanks,
> 
> Denis
>  
> 
Denis,

Just been running some build tests on this.  You need to
do a lot more testing of the various possible combinations
I think. Right now I can't build and so far I'm not entirely
sure why.

  CHECK   drivers/iio/accel/st_accel_i2c.c
drivers/iio/accel/st_accel_i2c.c:38:9: error: undefined identifier 'st_sensors_i2c_configure'
  CC [M]  drivers/iio/accel/st_accel_i2c.o
drivers/iio/accel/st_accel_i2c.c: In function 'st_accel_i2c_probe':
drivers/iio/accel/st_accel_i2c.c:38:2: error: implicit declaration of function 'st_sensors_i2c_configure'
make[3]: *** [drivers/iio/accel/st_accel_i2c.o] Error 1
make[2]: *** [drivers/iio/accel] Error 2
make[1]: *** [drivers/iio] Error 2
make: *** [drivers] Error 2

For reasons that aren't immediately clear ifdef CONFIG statements don't
seem to be working...

I also suspect we have too many complex build options in here in the first
place. It's probably not unreasonable for instance to build in buffered support
if buffering is enabled in general for IIO rather than explicitly.

Jonathan
