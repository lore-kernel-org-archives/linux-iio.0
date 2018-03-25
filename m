Return-Path: <SRS0=wR/q=GP=gmail.com=john3909@kernel.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180324151829.7d03ad15@archlinux>
Date: Sun, 25 Mar 2018 01:29:41 -0700
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 devel@driverdev.osuosl.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com,
 Mark Brown <broonie@kernel.org>
Message-Id: <6490BA61-EF6F-4407-A5A2-26B7E86B0629@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
 <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
 <20180317203037.1093cc11@archlinux>
 <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
 <20180318122312.0d395367@archlinux>
 <F6FE75D3-5289-4675-9345-F46CABEFA99E@gmail.com>
 <20180324151829.7d03ad15@archlinux>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I was speaking with Rodrigo and here is what I think must be done to =
move ADE7878 out of staging

Here are the steps as I see them:

1) Define the IIO Attributes so they are consistent with the IIO ABI. =
This should be pretty simple given agreement on the naming convention.=20=

2) Map the ADE7854 interrupt status to IIO events. This requires an =
interrupt processing section.
3) Add DeviceTree support.
4) Create DeviceTree overlay for the ADE7854.
5) Update ADE7854 probe to read in the DeviceTree register settings.
6) Add support for power modes (PM1, PM2).
7) Not sure if we will support measurement streaming on the ADE7854. The =
problem is ADE7854 is designed as an SPI master, which means it controls =
the SPI clock, so the driver must support SPI slave mode. However, the =
Linux Kernel does not currently support SPI slave mode. We have three =
choices to make this work and they are all a lot of work: 1) Add support =
for SPI Slave mode to the kernel,  2) Use hardware to convert SPI =
signals to I2S signals and with the use of a custom codec, use the ALSA =
framework to stream the samples (this is an approach I used, but I =
don=E2=80=99t like it), 3) Move the I2S driver out of the sound =
subsystem and use it together with DMA to stream samples directly into =
the ADE7854 driver (my preferred solutions). Perhaps Mark Brown has some =
ideas on how to make this work.=20

The ADE9000 will be much easier because it uses an SPI Slave interface.=20=


I hope I have captured everything, but let me know if I have missed =
anything.

Regards,
John
