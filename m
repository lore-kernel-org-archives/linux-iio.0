Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FFADCC2.6080006@cam.ac.uk>
Date: Mon, 09 Jul 2012 14:29:38 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: =?UTF-8?B?TWFydGluIExpxaFrYQ==?= <marxin.liska@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-iio@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>,
 Corentin Chary <corentin.chary@gmail.com>, joeyli <jlee@suse.com>,
 Len Brown <len.brown@intel.com>,
 pavel@denx.de, Jonathan Cameron <jic23@kernel.org>,
 Jon Brenner <jbrenner@taosinc.com>,
 Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: ACPI ambient light sensor
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com> <201207082228.14318.marex@denx.de>
In-Reply-To: <201207082228.14318.marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

cc'd Jon Brenner and Peter Meerwald.
>
>> Hello,
>>     Iconia Tab W500 contains Ambient Light Sensor (hid 0008), I started
>> implementing IIO device drive having following questions:
>>
>>     - chip could offer following variables: illuminance, color chromaticity
>>     and color temperature, how should I connect last 2 vars to any of IIO
>>     CHANNEL types?
Jon's recent proposed additional modifiers cover temperature. 
Chromaticity is a new one I think though?
>>     - I'm not sure how to connect an illuminance mapping to IIO
>>     infrastructure?
When you say mapping, what do you mean? That term tends to get used
for quite a few different things...
>
> See IIO_DEVICE_ATTR() maybe ?
>
>> Thank you,
>> Martin Liška
>
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
