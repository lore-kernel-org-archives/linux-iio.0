Return-Path: <lars@metafoo.de>
Message-ID: <50B88C20.4080402@metafoo.de>
Date: Fri, 30 Nov 2012 11:36:16 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Denis Ciocca <denis.ciocca@gmail.com>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Pavel Machek <pavel@denx.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics gyroscopes driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com> <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com> <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com> <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com> <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com> <508E5AD5.1040907@metafoo.de> <50914366.4090000@st.com> <5091546D.9000601@metafoo.de> <CAEE_umoKvv9ciBfUSahDqsmcbHi9W=93o5YSpE-vxUduCmqWSQ@mail.gmail.com> <50982F71.3060606@kernel.org> <5098F065.1090009@st.com> <50A12D8C.6040207@st.com> <50A14485.2060902@kernel.org> <50A26967.4050102@st.com> <50A8E083.1050908@kernel.org> <50AFA000.3040906@st.com> <50B0F495.6040409@kernel.org> <50B4DDEC.9030903@st.com> <50B73017.8080706@metafoo.de> <F8B002B1B3BA5342BA0E4153603A884DDEBE245AE0@SAFEX1MAIL1.st.com>
In-Reply-To: <F8B002B1B3BA5342BA0E4153603A884DDEBE245AE0@SAFEX1MAIL1.st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/30/2012 10:13 AM, Denis CIOCCA wrote:
> Hi Lars,
> 
> yes you have right, the main difference between accelerometers driver and this driver is the "find and replace". :)
> Yes, for now it is possible use the same driver for both devices, but in the next patch I will add some functionality, for example the FIFO hardware used in the gyro, ecc.
> What do you suggest?
> 
> In the future I will write also the drivers for the magnetometers and pressure sensors, I think the magnetometers driver is very similar to the accelerometers and magnetometers drivers, you suggest me to use the same code?
> How it is possible to do this?

If the different device categories share some common bits and add custom
bits on top of it, it may make sense to have a common base library module
which implements the common bits and than have one driver per device type
which uses the common library and implements the device type specific bits
on top of it.

- Lars

> We can add a STMicroelectronics folder in the IIO tree to support all sensors?
> 
> Thanks
> Best Regards,
> 
> Denis
> 
> 
> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de] 
> Sent: Thursday, November 29, 2012 10:51 AM
> To: Denis CIOCCA
> Cc: Jonathan Cameron; Denis Ciocca; Jonathan Cameron; Pavel Machek; linux-iio@vger.kernel.org; burman.yan@gmail.com
> Subject: Re: STMicroelectronics gyroscopes driver.
> 
> On 11/27/2012 04:36 PM, Denis CIOCCA wrote:
>> Hi guys,
>>
>> based on the driver for accelerometers, I wrote the driver for all our 
>> last mems gyroscopes.
>> Best regards,
>>
>> Denis
>>
> 
> How different are the gyros from the accelerometers? On a first quick glance the looks as if you took the accelerometer driver and did a search and replace on "accel" with "gyro". Can both be supported by the same driver?
> 
> - Lars
