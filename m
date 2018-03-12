Return-Path: <committed@heine.so>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 12 Mar 2018 10:08:42 +0100
From: Michael Nosthoff <committed@heine.so>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: st_pressure: st_accel: pass correct platform
 data to init
In-Reply-To: <20180310162906.20364dd8@archlinux>
References: <500bb58a2dc6d70fa096d6a63321dc23@heine.so>
 <20180310162906.20364dd8@archlinux>
Message-ID: <44e159cfa800395fcaee008684aaf669@heine.so>
List-ID: <linux-iio@vger.kernel.org>

On 2018-03-10 17:29, Jonathan Cameron wrote:
> On Fri, 09 Mar 2018 10:02:45 +0100
> Michael Nosthoff <committed@heine.so> wrote:
> 
>> Commit 7383d44b added a pointer pdata which get set to the default
>> platform_data when non was defined in the device. But it did not
>> pass this pointer to the st_sensors_init_sensor call but still
>> used the maybe uninitialized platform_data from dev.
>> 
>> This breaks initialization when no platform_data is given and
>> the optional st,drdy-int-pin devicetree option is not set.
>> 
>> This commit fixes this.
>> 
>> Cc: stable@vger.kernel.org
>> Fixes: 7383d44b ("iio: st_pressure: st_accel: Initialise sensor 
>> platform
>> data properly")
>> Signed-off-by: Michael Nosthoff <committed@heine.so>
> Both patches were corrupted by your email client.  I did the
> revert directly and then manually applied this.
> 

Ah, sorry for that. I redid my setup so I hope my next patches will be 
fine.

> Thanks for tracking down the problem.
> 

Happy to help :)

> Applied to the fixes-togreg branch of iio.git.
> 
> Jonathan
> 

Michael
