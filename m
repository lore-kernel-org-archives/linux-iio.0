Return-Path: <SRS0=SnZD=L4=gmail.com=himanshujha199640@kernel.org>
Date: Fri, 14 Sep 2018 17:39:51 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Qiang <songqiang.1304521@gmail.com>
Subject: Re: [PATCH] iio: proximity: lidar-v2: replace i2c block access
 method with the one already implemented.
Message-ID: <20180914120950.GB6465@himanshu-Vostro-3559>
References: <20180913035145.28056-1-songqiang.1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180913035145.28056-1-songqiang.1304521@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 13, 2018 at 11:51:45AM +0800, Song Qiang wrote:
> This driver tries to access a block of data on a i2c bus and it tries
> to manually make a device command frame and a consecutively read frame,
> then uses i2c_transfer() to read data. But this has already been
> implemented in i2c_smbus_read_i2c_block_data().
> Sorry for not having this device by my hand, which is a little expansive
> for me, but I have another i2c device and tested with both i2c_transfer()
> and i2c_smbus_read_i2c_block_data() and they all ends the same.
> I'm not familiar with the SMBus, don't know if the lidar_smbus_xfer()
> function is the same as i2c_smbus_read_block_data()? The original code
> is commented with something I'm not sure, but I think if it's a standard
> SMBus, it should be able to use in here.
> Hoping for someone to explain.

This is not how you write a commit message.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> ---

Your doubts/suggestions/rants all should be here just below
the `---` line, so that if maintainer applies the patch
then your queries doesn't get included in the commit
message.

And no need to reply an explicit "thanks".
That is implicit ;)

We already have a ~30k email traffic on LKML...
https://marc.info/?l=linux-kernel&r=1&w=2



Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
