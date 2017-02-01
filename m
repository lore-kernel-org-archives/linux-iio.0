Return-Path: <SRS0=GBpQ=ZO=axentia.se=peda@kernel.org>
Subject: Re: kernel 4.10-rcx iio helper question
To: Ken.Lin <ken.lin@advantech.com>, "jic23@kernel.org" <jic23@kernel.org>
References: <03B5A3CA1724CE4EAC32B27E39292A677FC7512D3A@AUSMAIL1.AUS.ADVANTECH.CORP>
 <WM!0e191e8021de721ce26bb7af83b55064556944dd1ba4a4c5ffd0cf5fa2a60dcb49d0a6722934d893c1817b0383068e28!@dgg.advantech.com>
 <273c851c-4623-652e-097b-5a3827205ebc@axentia.se>
 <WM!c988294410704f5fdb6034485f95e283ba8a11561dded8460b8f9f4c302e8d9d3b5dfd6fbd89ee21c83838f1af88f482!@dg.advantech.com>
 <03B5A3CA1724CE4EAC32B27E39292A677FC7512E85@AUSMAIL1.AUS.ADVANTECH.CORP>
 <WM!da6c96198354db7af9f225c848a09d5c6e064c622dbfcc6b4670fb1c3db17e0cc67ee54b34600a69dd8059b643e30774!@dg.advantech.com>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Akshay Bhat
	<akshay.bhat@timesys.com>, Peter.Stretz <peter.stretz@advantech.com>,
	Peter.Chiang <peter.chiang@advantech.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <28916f18-da40-cf0a-5bfa-2c8d53a7d83c@axentia.se>
Date: Wed, 1 Feb 2017 06:50:12 +0100
MIME-Version: 1.0
In-Reply-To: <WM!da6c96198354db7af9f225c848a09d5c6e064c622dbfcc6b4670fb1c3db17e0cc67ee54b34600a69dd8059b643e30774!@dg.advantech.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2017-02-01 01:42, Ken.Lin wrote:
> 
> 
>> -----Original Message-----
>> From: Peter Rosin [mailto:peda@axentia.se]
>> Sent: Tuesday, January 31, 2017 1:10 PM
>> To: Ken.Lin; jic23@kernel.org
>> Cc: knaack.h@gmx.de; pmeerw@pmeerw.net; linux-iio@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Akshay Bhat; Peter.Stretz; Peter.Chiang
>> Subject: Re: kernel 4.10-rcx iio helper question
>>
>> On 2017-01-31 19:19, Ken.Lin wrote:
>>> Hi,
>>>
>>> I find the latest kernel introduces new iio sys attributes.
>>> https://patchwork.kernel.org/patch/9391771/
>>> https://patchwork.kernel.org/patch/9391259/
>>>
>>> Is there anyone has some ideas about how the new iio sys attribute -
>> in_pressure_scale_available works?
>>> I'm not sure if it's the regression issue or it's just the usage issue or something
>> when I tried to read in_pressure_scale_available attribute.
>>
>>> # cat /sys/bus/iio/devices/iio\:device1/in_pressure_scale_available
>>> Segmentation fault
>>
>> What driver is providing iio:device1?
>>
>>> [ 3785.077014] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000000 [ 3785.085138] pgd = ecc3c000 [ 3785.087929]
>>> [00000000] *pgd=87f91831 [ 3785.091563] Internal error: Oops: 80000007
>>> [#1] SMP ARM [ 3785.096806] Modules linked in:
>>> [ 3785.099892] CPU: 1 PID: 1051 Comm: cat Not tainted
>>> 4.10.0-rc5-00009-gffd8858-dirty #3
>>
>> Looks like you have a couple of local changes? What are those?
>>
> 
> I didn't make any changes to the iio drivers locally and MPL3115A2 pressure/temperature sensor driver (drivers/iio/pressure/mpl3115.c) is the driver which provides iio:device1.
> 
>> My WAG is that you added the IIO_CHAN_INFO_SCALE bit to one of the
>> .info_mask_*_available fields in the channel spec but failed to provide a
>> .read_avail operation in the driver. Am I close?
>>
> 
> I could read iio:device0/in_accel_scale and device0/in_accel_available, which are provided by NXP 3-axis accelerometers driver (drivers/iio/accel/mma8452.c).
> The attribute iio:/device1/in_pressure_scale is missing unless I reverted the commits.
> https://patchwork.kernel.org/patch/9391771/
> https://patchwork.kernel.org/patch/9391259/

Whoops, sorry for suggesting you did something wrong...

Can you try this patch?

Cheers,
peda

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 73f2f0c46e62..8f2bce213248 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -137,6 +137,7 @@ static const struct iio_chan_spec mpl115_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type =
 			BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index cc3f84139157..525644a7442d 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -190,7 +190,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 	{
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -203,7 +203,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
