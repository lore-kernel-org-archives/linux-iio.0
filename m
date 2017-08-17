Return-Path: <SRS0=qZBe=7T=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170817155932.2feab01a@archlinux>
References: <20170816191316.11469-1-lorenzo.bianconi@st.com>
 <20170816191316.11469-2-lorenzo.bianconi@st.com> <20170817155932.2feab01a@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Thu, 17 Aug 2017 17:09:05 +0200
Message-ID: <CAA2SeN+dXMOsV9Q1oL_DD7By3SNT9RbRgXfZo+QOB7gWNODvOA@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: st_sensors: decouple irq1 configuration
 parameters from the irq2 ones
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo BIANCONI <lorenzo.bianconi@st.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Wed, 16 Aug 2017 21:13:12 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> Separate data-ready configuration parameters for INT1 and INT2 pins in
>> st_sensor_data_ready_irq data structure. That change will be use to
>> properly support LIS2DW12 accel sensor.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>
> One oddity which was there already that you've kept.
>
> I'd clean it up whilst we are here rather than doubling it ;)
>
> Jonathan
>
>> @@ -336,7 +341,12 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>>                       .mask = 0x04,
>>               },
>>               .drdy_irq = {
>> -                     .addr = 0,
>> +                     .int1 = {
>> +                             .addr = 0x00,
>> +                     },
>> +                     .int2 = {
>> +                             .addr = 0x00,
>> +                     },
> This is presumably for a device which doesn't support data ready.
> Why not rely on the default value of 0 and scrap this explicit entry?
>>               },
>>               .multi_read_bit = true,
>>               .bootime = 2,

Right :). Will do in v2.
Regards,
Lorenzo


-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
