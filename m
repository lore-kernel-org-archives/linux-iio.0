Return-Path: <mfuzzey@parkeon.com>
Message-ID: <53D67210.3060906@parkeon.com>
Date: Mon, 28 Jul 2014 17:53:52 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/8] iio: mma8452: Initialise before activating
References: <20140723171719.22067.79447.stgit@localhost> <20140723171721.22067.93513.stgit@localhost> <alpine.DEB.2.01.1407232002160.21518@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1407232002160.21518@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Peter,

On 23/07/14 20:05, Peter Meerwald wrote:
> Hello Martin,
>
>> Many of the hardware configuration registers may only be modified while the
>> device is inactive.
> so this means that writing INFO_SAMP_FREQ or INFO_SCALE won't work without
> deactivating / reactivating the device?
>   
> I'm pretty sure I tried this...

I've tried it and it doesn't work.

Applying this (demo only, not for merging) patch on top of my series to 
make the debugfs code not deactivate / reactivate on writes:

@@ -608,7 +608,7 @@ static int mma8452_reg_access_dbg(struct iio_dev 
*indio_dev,
                 return -EINVAL;

         if (readval == NULL) {
-               ret = mma8452_change_config(data, reg, writeval);
+               ret = i2c_smbus_write_byte_data(data->client, reg, 
writeval);
         } else {
                 ret = i2c_smbus_read_byte_data(data->client, reg);
                 if (ret < 0)


Then:

# cd /sys/kernel/debug/iio/iio:device0
# echo 0x0e > direct_reg_access
# cat direct_reg_access
0x0
# echo 0x0e 0x01 >direct_reg_access
# cat direct_reg_access
0x0

So the write is not changing anything.

Removing the demo patch so that mma8452_change_config() is used causes 
it to work as expected:

# echo 0x0e 0x01 > direct_reg_access
# cat direct_reg_access
0x1
