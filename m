Return-Path: <SRS0=1+3Y=GU=amlogic.com=Yixun.Lan@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: meson-saradc: squash and share the common
 adc platform data
To: Jonathan Cameron <jic23@kernel.org>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
 <20180326084629.100070-2-yixun.lan@amlogic.com>
 <20180330104813.7dd79bd5@archlinux>
CC: <yixun.lan@amlogic.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Neil Armstrong
	<narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman
	<khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Xingyu Chen
	<xingyu.chen@amlogic.com>, <linux-iio@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <c0dde5a6-c490-c8ea-5652-bcc27ee9f0e7@amlogic.com>
Date: Fri, 30 Mar 2018 18:37:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180330104813.7dd79bd5@archlinux>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 03/30/18 17:48, Jonathan Cameron wrote:
> On Mon, 26 Mar 2018 16:46:27 +0800
> Yixun Lan <yixun.lan@amlogic.com> wrote:
> 
>> Extract and promote common adc platform data into a new structure,
>> to make it better share the info between several SoCs,
>> this will avoid duplicating the code all over the place,
>> Save a few memory and make the code more maintainable.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Hi Jonathan

  Great! Thanks for taking these

Yixun
